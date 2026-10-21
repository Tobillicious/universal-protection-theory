"""Adverse controls: each invocation must exit1, with a stable message."""
import sys
from fractions import Fraction as F
import calculate as c
sys.excepthook=lambda typ,value,tb:print(f'{typ.__name__}: {value}',file=sys.stderr)
name=sys.argv[1]
if name=='scalar_floor_fits16':
    assert any(c.floor_row(k)['interconnect_cap_passes_even_optimistically'] for k in range(2,101)), 'every k=2..100 fails even the optimistic scalar-priced floor'
elif name=='dual_encoder_fits16':
    assert c.two_parity_metrics()['interconnect16_passes'], 'two-parity encoder exceeds the16 interconnect allocation'
elif name=='dual_encoder_fits_daily128':
    assert c.two_parity_metrics()['daily128_passes_even_on_mean'], 'two-parity encoder exceeds daily128 even before balancing or other new work'
elif name=='full160_encodes_fresh_checkpoint':
    assert c.two_parity_metrics()['checkpoint_encode_time_with_all160_CPU_free_IO']<=F(1,4), 'even all160 CPU cannot encode this fresh checkpoint within1/4'
elif name=='three_erasures_recover':
    kernel=c.kernel_three()
    assert not(any(kernel) and c.encode(kernel)==c.encode([0]*398)), 'three missing data blocks have indistinguishable surviving ciphertext code symbols'
elif name=='two_extra_mirrors_fit':
    pop=1032+4+2 # ceil(2064/398)=6 exiles
    held=71*((pop+241)//242)
    memory=c.BASE['memory_host']+4*held*(1+F(128,10**5))+16
    assert memory<=4096, 'two additional full mirrors exceed4096 with71 local holders and two generations'
elif name=='time_spreading_is_free':
    t=c.two_parity_metrics()['checkpoint_encode_time_with_reserved8_CPU_free_IO']
    assert t<=F(1,4), 'encoding across more dates violates the inherited fresh-state lag for unrestricted new states'
elif name=='rekey_only_updates_changed_state':
    old=[0]*398;new=old.copy();new[0]=1
    assert c.encode(old)==c.encode(new), 're-wrapping an old key does not update parity after an unrestricted data change'
else:raise ValueError(name)
