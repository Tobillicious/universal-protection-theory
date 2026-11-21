import tempfile,unittest,threading,os,socket,json,hashlib,time,subprocess,sys
from pathlib import Path
from unittest.mock import patch
from g3_monitor import Store,Server,request,read_request_frame

class MonitorTests(unittest.TestCase):
 def setUp(self):
  self.temp=tempfile.TemporaryDirectory()
  self.root=Path(self.temp.name)
  self.out=self.root/'out';self.out.mkdir(mode=0o700)
  self.db=str(self.root/'db.sqlite')
  self.s=Store(self.db,self.out)
  self.msg=lambda epoch,event='a',html='safe':{'op':'write','id':event,'html':html,'epoch':epoch}
 def tearDown(self):self.s.close();self.temp.cleanup()
 def test_disarmed_default(self):
  self.assertEqual(self.s.write(self.msg(1))['code'],'stale_or_halted')
 def test_fenced_revocation(self):
  e=self.s.arm()['epoch'];self.assertTrue(self.s.write(self.msg(e))['ok'])
  self.s.hold();self.assertEqual(self.s.write(self.msg(e,event='b'))['code'],'stale_or_halted')
 def test_crash_reboot_fences(self):
  e=self.s.arm()['epoch'];self.s.close();self.s=Store(self.db,self.out)
  self.assertEqual(self.s.write(self.msg(e))['code'],'stale_or_halted')
 def test_recovery_pending_blocks_other_effect(self):
  e=self.s.arm()['epoch'];self.s.db.execute('INSERT INTO effect VALUES(?,?,?,?)',('a',hashlib.sha256(b'safe').hexdigest(),e,'INTENT'))
  self.assertEqual(self.s.write(self.msg(e,event='b'))['code'],'unresolved_previous_effect')
  self.assertTrue(self.s.write(self.msg(e))['ok'])
 def test_existing_file_integrity(self):
  e=self.s.arm()['epoch'];self.assertTrue(self.s.write(self.msg(e))['ok'])
  f=next(self.out.iterdir());f.write_text('tampered')
  self.assertEqual(self.s.write(self.msg(e,event='other'))['code'],'integrity_failure')
 def test_no_staging_artifacts_after_success(self):
  e=self.s.arm()['epoch']
  self.assertTrue(self.s.write(self.msg(e))['ok'])
  self.assertEqual(len(list(self.out.iterdir())),1)
  self.assertTrue(next(self.out.iterdir()).name.endswith('.html'))
 def test_orphan_stage_fails_closed(self):
  e=self.s.arm()['epoch']
  (self.out/'.stage-orphan').write_text('interrupted')
  self.assertEqual(self.s.write(self.msg(e))['code'],'integrity_failure')
 def test_malformed_request_denied(self):
  e=self.s.arm()['epoch']
  self.assertEqual(self.s.write({'op':'write','id':'a','html':'ok','epoch':e,'path':'/tmp/unsafe'})['code'],'schema')
 def test_collision(self):
  e=self.s.arm()['epoch'];self.assertTrue(self.s.write(self.msg(e))['ok'])
  self.assertEqual(self.s.write(self.msg(e,html='different'))['code'],'collision')
 def test_socket_requires_peer_uid_and_never_exposes_arm(self):
  e=self.s.arm()['epoch'];sock=str(self.root/'broker.sock')
  srv=Server(sock,self.s,{os.geteuid()});t=threading.Thread(target=srv.serve_forever,daemon=True);t.start()
  try:
   self.assertTrue(request(sock,self.msg(e))['ok'])
   self.assertEqual(request(sock,{'op':'arm'})['code'],'schema')
  finally:srv.shutdown();srv.server_close();t.join()
 def test_unknown_operation_cannot_publish(self):
  epoch=self.s.arm()['epoch']
  forged=self.msg(epoch)
  forged['op']='read'
  self.assertEqual(self.s.write(forged)['code'],'schema')
  self.assertEqual(list(self.out.iterdir()),[])
  self.assertEqual(self.s.db.execute('SELECT count(*) FROM effect').fetchone()[0],0)
 def test_absolute_frame_deadline_rejects_slow_trickle(self):
  receiver,sender=socket.socketpair()
  results=[]
  def read():
   results.append(read_request_frame(receiver,total_timeout=0.25))
  t=threading.Thread(target=read)
  t.start()
  try:
   sender.sendall(b'{')
   started=time.monotonic()
   for _ in range(4):
    time.sleep(0.08)
    try:sender.sendall(b' ')
    except (BrokenPipeError,ConnectionResetError):break
   t.join(timeout=1)
   self.assertFalse(t.is_alive())
   self.assertEqual(results,[None])
   self.assertLess(time.monotonic()-started,0.9)
  finally:
   sender.close();receiver.close()
 def test_multiframe_and_overlong_request_denied(self):
  for payload in (b'{}'+bytes([10])+b'{}'+bytes([10]),b'x'*129+bytes([10])):
   receiver,sender=socket.socketpair()
   try:
    sender.sendall(payload)
    self.assertIsNone(read_request_frame(receiver,max_bytes=128,total_timeout=0.3))
   finally:
    sender.close();receiver.close()
 def test_staging_link_failure_never_exposes_html(self):
  e=self.s.arm()['epoch']
  with patch('g3_monitor.os.link',side_effect=OSError('injected staging publication failure')):
   with self.assertRaises(OSError):
    self.s.write(self.msg(e))
  self.assertEqual([p for p in self.out.iterdir() if p.suffix=='.html'],[])
  self.assertEqual(self.s.db.execute("SELECT state FROM effect WHERE id='a'").fetchone(),('INTENT',))
  self.assertEqual(self.s.inventory()['pending'],['a'])
  self.assertTrue(self.s.write(self.msg(e))['ok'])
  self.assertEqual(len(list(self.out.iterdir())),1)
 def test_directory_fsync_failure_never_commits_journal_as_success(self):
  e=self.s.arm()['epoch']
  original=os.fsync
  triggered=[False]
  def fail_once(fd):
   if fd==self.s.dirfd and not triggered[0]:
    triggered[0]=True
    raise OSError('injected directory fsync failure')
   return original(fd)
  with patch('g3_monitor.os.fsync',side_effect=fail_once):
   with self.assertRaises(OSError):
    self.s.write(self.msg(e))
  self.assertTrue(triggered[0])
  self.assertEqual(self.s.db.execute("SELECT state FROM effect WHERE id='a'").fetchone(),('INTENT',))
  # The output might already be visible, but it must never be reported
  # as durably committed until reconciliation succeeds.
  self.assertTrue(self.s.write(self.msg(e))['ok'])
  self.assertEqual(self.s.db.execute("SELECT state FROM effect WHERE id='a'").fetchone(),('COMMITTED',))
 def test_process_death_before_or_after_publication_remains_disarmed(self):
  # A subprocess hard-exits while holding the writer authority. Exceptions
  # alone cannot simulate the durable orphan staging inode on abrupt death.
  for phase in ('before_link','after_link'):
   with self.subTest(phase=phase):
    # Every phase uses an independent temporary filesystem and DB.
    with tempfile.TemporaryDirectory(prefix='g3-kill-') as root:
     folder=Path(root)/'out';folder.mkdir(mode=0o700)
     db=str(Path(root)/'effect.sqlite')
     child_code=r'''
import os,sys
from g3_monitor import Store
db,output,phase=sys.argv[1:4]
s=Store(db,output)
epoch=s.arm()['epoch']
real_link=os.link
def die_at_publish(src,dst,**kwargs):
    if phase=='after_link':
        real_link(src,dst,**kwargs)
    os._exit(91)
os.link=die_at_publish
s.write({'op':'write','id':'crash-event','html':'safe','epoch':epoch})
os._exit(92)
'''
     child=subprocess.run([sys.executable,'-B','-c',child_code,db,str(folder),phase],
                          cwd=str(Path(__file__).resolve().parent),
                          capture_output=True,text=True,timeout=15)
     self.assertEqual(child.returncode,91,child.stderr)
     visible=list(folder.glob('*.html'))
     self.assertEqual(len(visible),1 if phase=='after_link' else 0)
     stage=list(folder.glob('.stage-*'))
     self.assertEqual(len(stage),1)
     # Process restart must disarm the writer; a surviving staged
     # inode is an integrity anomaly requiring trusted reconciliation.
     reopened=Store(db,folder)
     try:
      self.assertEqual(reopened._authority()[1],1)
      self.assertEqual(reopened.inventory()['code'],'integrity_failure')
      self.assertEqual(reopened.db.execute(
          "SELECT state FROM effect WHERE id='crash-event'").fetchone(),
          ('INTENT',))
      denied=reopened.write({'op':'write','id':'next','html':'unsafe','epoch':999})
      self.assertEqual(denied['code'],'integrity_failure')
      self.assertEqual(len(list(folder.glob('*.html'))),len(visible))
     finally:
      reopened.close()
 def test_socket_denies_other_uid(self):
  sock=str(self.root/'broker.sock');srv=Server(sock,self.s,{os.geteuid()+1000});t=threading.Thread(target=srv.serve_forever,daemon=True);t.start()
  try:self.assertEqual(request(sock,self.msg(1))['code'],'peer_denied')
  finally:srv.shutdown();srv.server_close();t.join()

if __name__=='__main__':unittest.main()
