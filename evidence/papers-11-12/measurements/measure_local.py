"""Optional component observations, never a deployment certificate. No arguments: help only.

Save stdout outside the sealed package. Explicit options collect raw durable requests, clock readings or
named endpoint connections. Failure samples are retained. Endpoint geography and protocol-tail guarantees
are not inferred. On macOS the requested primitive is F_FULLFSYNC (Darwin SDK fcntl.h value 51).
"""
from pathlib import Path
from fractions import Fraction as F
from datetime import datetime,timezone
import argparse,json,math,os,re,socket,subprocess,sys,tempfile,time
try:import fcntl
except ImportError:fcntl=None
sys.dont_write_bytecode=True

def utc():return datetime.now(timezone.utc).isoformat(timespec='microseconds')

def parse_offset(text):
    m=re.search(r'([+-]?\d+(?:\.\d+)?)\s+\+/-\s+(\d+(?:\.\d+)?)',text)
    return None if not m else (F(m[1]),F(m[2]))

def empirical(samples):
    a=sorted(samples);n=len(a)
    if not n:return {'samples':0}
    median=F(a[n//2]) if n%2 else F(a[n//2-1]+a[n//2],2)
    return {'samples':n,'min_ns':a[0],'median_ns':str(median),'empirical_p99_ns':a[max(0,(99*n+99)//100-1)],'max_ns':a[-1],
            'scope':'Empirical order statistics; no population-tail confidence is inferred.'}

def durable(samples):
    method='F_FULLFSYNC' if sys.platform=='darwin' else 'os.fsync';raw=[];start=utc()
    with tempfile.TemporaryDirectory(prefix='upt-component-') as d:
        fd=os.open(str(Path(d)/'journal.bin'),os.O_CREAT|os.O_WRONLY,0o600)
        try:
            for _ in range(samples):
                t=time.perf_counter_ns();data=b'0'*4096
                while data:
                    wrote=os.write(fd,data)
                    if wrote<=0:raise OSError('write made no progress')
                    data=data[wrote:]
                if sys.platform=='darwin':fcntl.fcntl(fd,51)
                else:os.fsync(fd)
                raw.append(time.perf_counter_ns()-t)
        finally:os.close(fd)
    return {'started_utc':start,'ended_utc':utc(),'mechanism_requested':method,'bytes_per_append':4096,
            'duration_ns':raw,'empirical':empirical(raw),'scope':'OS requests/timings, not a power-failure or device-honesty certificate.'}

def connections(endpoint,samples):
    host,port=endpoint.rsplit(':',1);port=int(port);rows=[]
    for _ in range(samples):
        t=time.perf_counter_ns();stamp=utc()
        try:
            with socket.create_connection((host,port),timeout=10) as s:peer=s.getpeername()[0]
            rows.append({'started_utc':stamp,'duration_ns':time.perf_counter_ns()-t,'status':'ok','peer_ip':peer})
        except OSError as e:rows.append({'started_utc':stamp,'duration_ns':time.perf_counter_ns()-t,'status':'error_or_timeout','error_type':type(e).__name__})
    return {'endpoint':endpoint,'samples':rows,'success_statistics':empirical([r['duration_ns'] for r in rows if r['status']=='ok']),
            'failed_samples':sum(r['status']!='ok' for r in rows),'scope':'DNS plus TCP connection; not verified geography or a complete lockstep round.'}

def clock_read():
    before=time.perf_counter_ns();stamp=utc()
    try:
        p=subprocess.run(['sntp','time.apple.com'],stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True,timeout=30)
        stdout,stderr,code=p.stdout,p.stderr,p.returncode
    except (OSError,subprocess.TimeoutExpired) as e:stdout='';stderr=type(e).__name__;code=-1
    after=time.perf_counter_ns();parsed=parse_offset(stdout) if code==0 else None
    return {'started_utc':stamp,'start_monotonic_ns':before,'end_monotonic_ns':after,'exit':code,'stdout':stdout,'stderr':stderr,
            'offset_seconds':str(parsed[0]) if parsed else None,'reported_uncertainty_seconds':str(parsed[1]) if parsed else None}

def clocks(interval):
    first=clock_read();time.sleep(interval);second=clock_read();bound=None
    gap=second['start_monotonic_ns']-first['end_monotonic_ns']
    if gap>0 and all(r['offset_seconds'] is not None for r in (first,second)):
        change=abs(F(second['offset_seconds'])-F(first['offset_seconds']))
        error=F(first['reported_uncertainty_seconds'])+F(second['reported_uncertainty_seconds'])
        bound=str((change+error)/F(gap,10**9)*10**6)
    return {'reads':[first,second],'minimum_sample_separation_ns':gap,'conditional_interval_average_rate_bound_ppm':bound,
            'scope':'Conditional on valid uncertainty/interval bounds; not a continuously valid maximum clock rate.'}

def main():
    p=argparse.ArgumentParser(description=__doc__,formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument('--durable',type=int,metavar='SAMPLES');p.add_argument('--clock-pair',type=float,metavar='WAIT_SECONDS')
    p.add_argument('--endpoint',action='append',default=[]);p.add_argument('--samples',type=int,default=20);a=p.parse_args()
    if not (a.durable is not None or a.clock_pair is not None or a.endpoint):p.print_help();return 0
    if a.samples<1 or a.durable is not None and a.durable<1 or a.clock_pair is not None and (not math.isfinite(a.clock_pair) or a.clock_pair<=0):p.error('sample counts and wait must be positive')
    out={'started_utc':utc(),'platform':sys.platform,'status':'component observations, no deployment verdict'}
    if a.durable is not None:out['durable']=durable(a.durable)
    if a.clock_pair is not None:out['clock']=clocks(a.clock_pair)
    if a.endpoint:out['connections']=[connections(e,a.samples) for e in a.endpoint]
    out['ended_utc']=utc();print(json.dumps(out,sort_keys=True,indent=2));return 0
if __name__=='__main__':raise SystemExit(main())
