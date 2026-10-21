"""JW2.2 joint compute/collector-site loss candidate; conditional prices.

Derived from frozen JW2.1; passive redundancy, expanded site law and
explicitly changed stock, certificate cap, service reserve and CPU target.
"""
from pathlib import Path
from fractions import Fraction as F
from math import ceil,comb
from functools import lru_cache
import sys
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'inputs/jw19/checks'))
import attested as prior
from rational_bounds import power,upper
b=prior.b
MT,PD,POOL=prior.MT,prior.PD,prior.POOL
DEADLINE=F(19,20)
OFFLINE=78
SPARES=79
STOCK_EXTRA=22144
CERT_LIMIT=4224
JOB_CAP=7
PHYSICAL_P=F(1,500)
GATES=('attestation','sealed_storage','live_transport','freshness_release')
BITS=459
ATTEMPTS=2**31
SERVICE_RESERVED=7*2**28
JOURNAL_MESSAGES=8
ATTEMPT_COMPUTE=F(1,2**24)
LIVE_MULTIPLIER=F(5,4)
COPY_MULTIPLIER=F(5,4)
PROVIDER_EXTRA_COMPUTE=4
PROVIDER_COMPUTE_RATE=144
PROVIDER_WIRE=9
PROVIDER_WIRE_RATE=64
PROVIDER_EXTRA_CAPITAL=16
HOST_EXTRA_MEMORY=48
LEASE_PERIOD=F(3,16)
CLOCK_DRIFT=F(1,1024)
LEASE_BATCHES=32
HOST_COMPUTE_RATE=160
HOST_WIRE_RATE=65536
HOST_EXTRA_CAPITAL=512
SECURITY_PLANT_FIXED_ENERGY=F(1)
ATTEMPT_WIRE=F(1,2**16)
COLLECTORS=79
KEY_BITS=512
FIELDS=4096+b.POP
VERIFICATION_PHASE=F(1,8)


def binomial_mgf_tail(n,p,k):
    if k<=n*p:return F(1)
    if k>n:return F(0)
    if k==n:return F(p)**n
    z=F(k)*(1-p)/(p*(n-k))
    return min(F(1),upper(power(1-p+p*z,n)*power(1/z,k)))


@lru_cache(None)
def committee(h,cap=None,offline=None):
    if cap is None:cap=JOB_CAP
    if offline is None:offline=OFFLINE
    n=h*cap;erased=offline*cap;received=n-erased
    j=(received+1)//2
    accept=binomial_mgf_tail(n,F(1,10),j)
    reject=binomial_mgf_tail(n,F(1,10),received-j+1)
    return {'hosts':h,'jobs':n,'erased_votes':erased,'minimum_received':received,
            'threshold':j,'false_accept_upper':accept,'false_reject_upper':reject,
            'horizon_union':CERT_LIMIT*MT*(accept+reject),'cap_per_host':cap,
            'compute_island':CERT_LIMIT*n*b.JOB_COMPUTE}


def security(bits=None,attempts=None):
    if bits is None:bits=BITS
    if attempts is None:attempts=ATTEMPTS
    per=F(attempts,2**bits)
    total=len(GATES)*MT*per
    return {'effective_bits':bits,'attempts_per_gate_island_epoch':attempts,
            'gates':list(GATES),'total_crypto_union':total,
            'confidentiality_union':2*MT*per,'integrity_and_freshness_union':2*MT*per,
            'per_execution_privacy_exposure_upper':2*per,
            'pairwise_real_view_coupling_upper':4*per,
            'per_date_gates_compute':len(GATES)*attempts*ATTEMPT_COMPUTE,
            'minimum_bits_for_combined_1e_8':next(k for k in range(400,520) if len(GATES)*F(MT*attempts,2**k)<=F(1,10**8))}


@lru_cache(None)
def resources(h,live_multiplier=LIVE_MULTIPLIER,copy_multiplier=COPY_MULTIPLIER,
              attempt_compute=ATTEMPT_COMPUTE,provider_extra=PROVIDER_EXTRA_COMPUTE):
    extra=h-b.BASE_H;adm=b.BASE_ADM-extra;serving=h-OFFLINE
    c=committee(h);jobs=CERT_LIMIT*c['jobs'];perhost=ceil(F(jobs,serving))
    snapshot_wire=8*(h-1)+b.POP
    placement_wire=8+ceil(F(b.POP,serving))+2+1
    mpc_host=ceil(b.MPC_TOTAL_COMPUTE/serving)
    primary=ceil(F(b.POP,serving));copies=3*primary
    move_wire=2*copies+4
    move_compute=move_wire*b.COPY_COMPUTE*copy_multiplier+F(3*b.POP,serving)*b.JOB_COMPUTE
    gates_compute=len(GATES)*ATTEMPTS*attempt_compute
    # Charge provisioned gate work globally and the worst balanced host share.
    gate_ops_host=ceil(F(len(GATES)*ATTEMPTS,serving))
    gate_cpu_host=gate_ops_host*attempt_compute
    gate_wire_host=gate_ops_host*ATTEMPT_WIRE
    collector_certs=ceil(F(CERT_LIMIT*COLLECTORS,h))
    committee_wire=(JOB_CAP*CERT_LIMIT*(COLLECTORS+1)+collector_certs*c['jobs'])*b.JOB_COMPUTE
    cpu=8*live_multiplier+mpc_host+perhost*b.JOB_COMPUTE+snapshot_wire*b.COPY_COMPUTE*copy_multiplier+move_compute+gate_cpu_host
    wire=ceil(F(SPARES,serving))+snapshot_wire+placement_wire+F(2048*FIELDS,4096)+committee_wire+move_wire+64+gate_wire_host
    key_memory=b.POP*F(1,10**5)*F(KEY_BITS-256,256)
    memory=8+2*b.POP+1024+FIELDS*F(1,10**5)+perhost*b.JOB_COMPUTE+2*copies+HOST_EXTRA_MEMORY+key_memory+CERT_LIMIT*c['jobs']*F(1,10**5)
    care_deadline=F(1,20)+F(1,100)+cpu/HOST_COMPUTE_RATE+wire/HOST_WIRE_RATE+VERIFICATION_PHASE+F(1,20)+F(1,20)+F(228,4096)+LEASE_PERIOD+4*CLOCK_DRIFT
    total_wire=PROVIDER_WIRE*b.N*POOL
    fabric_delay=F(total_wire,2**24)
    provider_compute=20+provider_extra
    phases={'detection':F(1,20),'dispatch_limiter':F(1,10),
            'joint_provider_compute':F(provider_compute,PROVIDER_COMPUTE_RATE),
            'joint_endpoint_wire':F(PROVIDER_WIRE,PROVIDER_WIRE_RATE),
            'pool_switch_and_destination_wire':fabric_delay,'propagation':F(1,20),
            'verification':VERIFICATION_PHASE,'commit':F(1,20),'lease_expiry':LEASE_PERIOD+4*CLOCK_DRIFT}
    response_deadline=sum(phases.values())
    backup=(h*b.POP+2*b.POP+400*h)*b.COPY_COMPUTE*copy_multiplier
    move_total=((6*b.POP+4*serving)*b.COPY_COMPUTE*copy_multiplier+3*b.POP*b.JOB_COMPUTE)
    fabric_energy=1+2*PROVIDER_WIRE*b.N*F(1,10**5)+2*b.N*F(1,10**5)
    gate_wire_total=len(GATES)*ATTEMPTS*ATTEMPT_WIRE
    collector_wire_total=CERT_LIMIT*c['jobs']*(COLLECTORS+1)*b.JOB_COMPUTE
    reserve_use=(backup+move_total)*b.EC+fabric_energy+2*(gate_wire_total+collector_wire_total)*F(1,10**5)
    ledger=b.energy(extra).copy()
    ledger['committee']=c['compute_island']*b.EC
    ledger.update(confidential_live_overhead=b.POP*(live_multiplier-1)*b.EC,
                  security_gate_compute=gates_compute*b.EC,
                  provider_proof_compute=b.N*provider_extra*b.EC,security_plant_fixed=SECURITY_PLANT_FIXED_ENERGY,passive_collector_control=SPARES*b.EC)
    # The original full16 interconnect allocation remains charged. All snapshot,
    # MOVE and fabric costs, including new encryption overhead, must fit inside it.
    flow=(h+SPARES-OFFLINE)*b.FLOW;spent=sum(ledger.values());margin=flow-spent
    refresh_ops=2*24*h*h*FIELDS+h*h*FIELDS+h*24*FIELDS
    renewal=(refresh_ops+h*h*FIELDS)*b.FIELD_COMPUTE
    auth=h*h*FIELDS+2*jobs*COLLECTORS+2*h*b.POP+2**20+2*total_wire//POOL+6*b.POP+JOURNAL_MESSAGES*h*b.POP*LEASE_BATCHES+4*b.POP*LEASE_BATCHES+2*SPARES*LEASE_BATCHES
    fixed=b.infrastructure(extra)
    fixed['new_provider_fabric']=b.N*(32+PROVIDER_EXTRA_CAPITAL)
    fixed['new_host_burst_plant']=h*HOST_EXTRA_CAPITAL
    fixed['passive_collectors']=SPARES*1024
    fixed['other_buffers_keys_cash']+=STOCK_EXTRA-fixed['new_provider_fabric']-fixed['new_host_burst_plant']-fixed['passive_collectors']
    # Protect gates and committee certificates from discretionary floods.
    certs=dict(b.certificate_inventory(h),passive_collector_flow=SPARES,move_batch=1,pool_response_batch=1,security_epoch_batch=1,lease_batches=LEASE_BATCHES,fence_batches=LEASE_BATCHES)
    inequalities={'population':adm>=0 and b.N+h+b.BERTHS+adm==b.POP,
         'slots':serving*8>=b.POP,'committee_spreading':ceil(F(c['jobs'],h))<=JOB_CAP,
         'compute':cpu<=128,'memory':memory<=4096,'network':wire<=16384,
         'care_deadline':care_deadline<=DEADLINE,'response_deadline':response_deadline<=DEADLINE,
         'global_MPC_cap':renewal<=b.MPC_TOTAL_COMPUTE,'interconnect_all_work':reserve_use<=16,
         'authentication_attempts':auth<=ATTEMPTS,
         'protected_service_reserve':auth<=SERVICE_RESERVED<ATTEMPTS,
         'journal_memory':16*b.POP*F(1,10**5)<=HOST_EXTRA_MEMORY,'certificates':sum(certs.values())<=CERT_LIMIT,
         'capital':min(fixed.values())>=0 and sum(fixed.values())==b.INFRA_STOCK+STOCK_EXTRA,'energy':margin>=0,
         'provider_compute':provider_compute<=24,'provider_energy':18+provider_extra*b.EC<=20,
         'provider_network':PROVIDER_WIRE<=16,'quorum_intersection':2*serving-h>0,
         'aggregate_host_burst':h*HOST_WIRE_RATE<=2**24,
         'lease_renewal':F(1,LEASE_BATCHES)+VERIFICATION_PHASE+2*CLOCK_DRIFT<LEASE_PERIOD,
         'collector_survival':COLLECTORS>OFFLINE,
         'committee_phase':F(1,20)+(perhost*b.JOB_COMPUTE+gate_cpu_host)/HOST_COMPUTE_RATE+(committee_wire+gate_wire_host+64)/HOST_WIRE_RATE<=VERIFICATION_PHASE}
    return {'hosts':h,'passive_collectors':SPARES,'sites':h+SPARES,'capital_stock':b.INFRA_STOCK+STOCK_EXTRA,'extra_hosts':extra,'admissions':adm,'serving':serving,
        'committee':c,'compute_host':cpu,'memory_host':memory,'network_host':wire,
        'care_deadline':care_deadline,'response_deadline':response_deadline,
        'response_phases':phases,'ledger':ledger,'flow':flow,'spent':spent,'energy_margin':margin,
        'interconnect_used':reserve_use,'renewal_compute':renewal,'authentication_attempts':auth,'service_reserved_per_gate':SERVICE_RESERVED,
        'untrusted_cap_per_gate':ATTEMPTS-SERVICE_RESERVED,
        'journal_auth_budget':JOURNAL_MESSAGES*h*b.POP*LEASE_BATCHES,
        'journal_memory_reserved':16*b.POP*F(1,10**5),
        'capital':fixed,'certificate_inventory':certs,'inequalities':inequalities,
        'fits':all(inequalities.values()),'live_multiplier':live_multiplier,'copy_multiplier':copy_multiplier,
        'attempt_compute':attempt_compute,'provider_proof_compute':provider_extra,
        'key_storage_extra':key_memory,'gate_compute_island':gates_compute,
        'key_package_bits':KEY_BITS,'renewal_fields':FIELDS,'gate_cpu_host':gate_cpu_host,'gate_wire_host':gate_wire_host,
        'committee_wire_host':committee_wire,'collector_certificates_host':collector_certs,
        'committee_phase_bound':F(1,20)+(perhost*b.JOB_COMPUTE+gate_cpu_host)/HOST_COMPUTE_RATE+(committee_wire+gate_wire_host+64)/HOST_WIRE_RATE,
        'HOST_COMPUTE_RATE':HOST_COMPUTE_RATE,'HOST_WIRE_RATE':HOST_WIRE_RATE,
        'lease_expiry_max':LEASE_PERIOD+4*CLOCK_DRIFT}


def gamma(q=F(1,2),bits=None):
    if bits is None:bits=BITS
    # Requires the sequential Mode C coupling functionality. A global ordinary
    # encryption advantage by itself does not establish this conditional bound.
    return 4*F(ATTEMPTS,2**bits)*(prior.prior.old.REWARD+q)/(1-prior.prior.BETA)**2


def full(h,q=F(1,2),W=0,physical_p=PHYSICAL_P):
    sec=security();comm=committee(h);rows={}
    av=MT*b.subset(h+SPARES,physical_p,OFFLINE+1)
    care=MT*b.subset(h,physical_p,h-132)
    for rd in prior.prior.old.READINGS:
        for r in prior.prior.old.RESPONSES:
            x=prior.capacity_channels(q,r,W,rd)
            ph,pr=x['holding'],x['rescue'];rho=ph+pr+b.PHYS+2*b.ARRIVAL_HAZARD_LIMIT
            pc,cost,_=b.scenario(r,rd)
            adm=b.BASE_ADM-(h-b.BASE_H)
            own=((h+SPARES)*8+adm*F(2,127))/(1-prior.prior.BETA)+b.N*16+adm*b.W*b.ESCROW_UNIT+b.INFRA_STOCK+STOCK_EXTRA
            span=prior.prior.old.REWARD/(1-prior.prior.BETA)+POOL*own
            gap=prior.prior.old.VALUE*b.DIV*F(1,2)*(pc-b.PC['D'])*(1-rho-ph-pr)-cost-(ph+pr)*span-gamma(q)
            alpha=ph+pr
            exgap=prior.prior.old.VALUE*b.DIV*F(1,2)*pc*(1-rho-ph-pr)-cost-alpha*q/(1-prior.prior.BETA)-(alpha+ph+pr)*span-gamma(q)
            if min(gap,exgap)<=0:continue
            acc=b.static_accounts().copy()
            acc.update(quorum_liveness=MT*b.subset(h,F(1,10),h-48),committee_good_editions=comm['horizon_union'],care_mpc_unavailability=av,
                quorum_abuse_original=F(0),edition_accumulated_corruption=F(0),
                ordinary_holding_channel=MT*ph,ordinary_rescue_channel=MT*pr,
                physical_geometry=MT*b.PHYS,coordinated_load_channels=MT*(ph+pr),
                domain_fault_vacancy_exit=PD*prior.prior.old.down_tail(x['d_cut']+1,prior.prior.old.VACANCY_CAPS[r]),
                background_episode_overflow=av,dormant_broadcast_reservoir_overflow=F(0),recruitment_family_R25=F(0),
                confidentiality_ModeC=sec['confidentiality_union'],
                integrity_attestation_freshness=sec['integrity_and_freshness_union'],
                care_slots_and_spreading=care)
            rows[rd+':'+str(r)]={'r':r,'reading':rd,'accounts':acc,'sum':sum(acc.values()),'IC_gap_lower':gap,'IC_extraction_gap_lower':exgap,'wealth_span':span}
    if not rows:return None
    worst=max(rows,key=lambda k:rows[k]['sum']);eta=b.ETA_BASE+comm['horizon_union']
    return {'rows':rows,'worst':worst,'sum':rows[worst]['sum'],'eta_cert':eta,
            'ceiling':F(1,10**6)-eta,'fits':rows[worst]['sum']+eta<=F(1,10**6),
            'q':q,'hosts':h,'availability':'physical_epoch_union',
            'physical_epoch_p':physical_p,'erasure_allowance':OFFLINE,'W':W}
