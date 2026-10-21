import sys
from fractions import Fraction as F
from math import comb
import calculate as c
sys.excepthook=lambda typ,value,tb:print(f'{typ.__name__}: {value}',file=sys.stderr)
name=sys.argv[1]
if name=='three_islands':
    assert {0,1,2}-{0,1,2},'three relevant island losses erase every ciphertext image'
elif name=='two_of_four_hides_two':
    gf,inv=c.prior.gf,c.prior.inv;s,a=0x1234,0x6789
    v1=s^gf(a,1);v2=s^gf(a,2)
    recovered=v1^gf(gf(v1^v2,inv(1^2)),1)
    assert recovered!=s,'two captured shares reconstruct a2-of4 secret'
elif name=='local70_copies':
    assert set(range(70))-set(range(70)),'70 local failures erase a70-holder image'
elif name=='pool_quorum201':
    bad={0,1};a=bad|set(range(2,201));b=bad|set(range(201,400))
    assert len(a)==len(b)==201
    assert (a&b)-bad,'two201 quorums can intersect only in the two bad islands'
elif name=='memory4096':
    c.MEM_CAP=4096;assert c.quantities()['checks']['memory'],'old memory cap fails after mirrors,keys and migrant primary versions'
elif name=='burst165':
    c.BG_CPU=13;assert c.quantities()['checks']['checkpoint_lag'],'burst165 leaves only13 background CPU and misses the clock-padded checkpoint lag'
elif name=='old_host_wire':
    c.BG_WIRE=2048;assert c.quantities()['checks']['background_wire'],'two full mirror streams already exceed background2048'
elif name=='old_pool_wire':
    assert 4*400*1038*c.RATE+4096<=2**21,'ordinary checkpoints alone exceed old pool background rate'
elif name=='interconnect23':
    c.INTER=F(23);assert c.quantities()['checks']['interconnect'],'full post-outage and repair activity exceeds23'
elif name=='passive79':
    c.PASSIVE=79;assert c.quantities()['checks']['energy'],'79 passives cannot fund this upgraded plant after78 total losses'
elif name=='unthrottled_reseed':
    c.RESEED_ENDPOINT_QUOTA=2*(1032*242+2*1032*72)
    assert c.quantities()['checks']['interconnect'],'one-date full local reseeding exceeds the local energy allocation'
elif name=='power_on_clears_outage':
    #0 returned empty;1 remains down;2 is now attacked. Counting only current
    #power outages gives2, while every originally allocated image is absent.
    current_power_losses={1,2};available_images=set()
    assert len(current_power_losses)==2
    assert available_images,'power return without reseeding cannot clear a loss'
elif name=='binomial_from_subset_moments':
    p=F(1,500);q=F(comb(242,71))*p**71
    assert all(q*F(comb(242-j,71-j),comb(242,71))<=p**j for j in range(72))
    assert c.old.bin_tail(242,p,71)>=q,'valid subset-moment distribution exceeds the independent-binomial tail'
elif name=='source_seven_reads':
    assert 7*172>=2*1032,'seven reads per host cannot export both lost home groups'
elif name=='serial_audit':
    assert c.quantities()['care_deadline']+F(1,8)<=F(19,20),'a second serial audit breaks the care deadline'
elif name=='stale_primary_image':
    assert F(5,4)+F(19,20)<=F(39,20),'an ordinary daily snapshot with quarter-date export misses the1.95 continuity bound'
else:raise ValueError(name)
