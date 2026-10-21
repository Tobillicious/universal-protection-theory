import sys
from fractions import Fraction as F
import calculate as c
sys.excepthook=lambda typ,value,tb:print(f'{typ.__name__}: {value}',file=sys.stderr)
name=sys.argv[1]
if name=='fresh_ciphertext_is_sparse':
    old_plain=new_plain=[0]*16;old_cipher=[x^0 for x in old_plain];new_cipher=[x^1 for x in new_plain]
    assert old_cipher==new_cipher,'unchanged plaintext does not imply unchanged ciphertext under fresh full-image encryption'
elif name=='duplicate_delta_safe':
    a=c.matrix(2,3);old=[1,2,3];new=[1,9,3];parity,_=c.encode(a,old);wanted,_=c.encode(a,new)
    for _ in range(2):
        for i in range(2):parity[i]^=c.gf(a[i][1],old[1]^new[1])
    assert parity==wanted,'replaying the same XOR delta twice cancels it; versions and deduplication are required'
elif name=='parity_dirtiness_equals_input_fraction':
    d=308;source_fraction=F(1,d);parity_fraction=F(1)
    assert parity_fraction<=source_fraction,'changing one entire data column can dirty every parity page'
elif name=='average_online_budget_proves_cutoff':
    f=c.frontier(92,'online');r=c.incremental(92,f['charged_4KiB_block_updates'],'batch')
    assert r['checks']['background_CPU8_aggregate'],'online average service does not bound a late burst before the checkpoint'
elif name=='next_batch_block_fits':
    f=c.frontier(92,'batch')
    assert c.incremental(92,f['charged_4KiB_block_updates']+1,'batch')['aggregate_bounds_pass'],'next dirty block exceeds the modeled burst CPU budget'
elif name=='next_online_block_fits':
    f=c.frontier(92,'online')
    assert c.incremental(92,f['charged_4KiB_block_updates']+1,'online')['aggregate_bounds_pass'],'next dirty block exceeds the modeled interconnect energy allocation'
elif name=='energy_alone_fixes_full_encoder':
    assert c.full(2)['total_daily_compute_per_host_mean']<=128,'raising the energy allocation leaves the daily CPU failure'
elif name=='one_island_guarantee_covers_two':
    ciphertext_holders={17,211};attacked={17,211}
    assert ciphertext_holders-attacked,'two targeted image-island erasures defeat the single-mirror construction'
else:raise ValueError(name)
