"""Read-only comparison with the captured source; controlled in-memory removal of its IC row filter.

The independent kernel does not import this module. This oracle is used only to test term-level agreement
and exhibit the obsolete preference filter. Every source global changed here is restored in finally.
"""
from pathlib import Path
from fractions import Fraction as F
import ast,importlib.util,inspect
ROOT=Path(__file__).resolve().parents[2]
FROZEN=ROOT/'paper-11/rung4-gates/frozen/upt-rung4a'
spec=importlib.util.spec_from_file_location('rung5_captured_common',FROZEN/'checks/common.py')
common=importlib.util.module_from_spec(spec);spec.loader.exec_module(common)
c,j,(BASE_ACCOUNTS,BASE_QUANTITIES)=common.baseline()
m=j.m;b=m.b;old=m.prior.prior.old
source=inspect.getsource(m.full);tree=ast.parse(source);fn=tree.body[0];assert isinstance(fn,ast.FunctionDef)
fn.name='unfiltered_full'
class RemoveFilter(ast.NodeTransformer):
    removed=0
    def visit_If(self,node):
        if len(node.body)==1 and isinstance(node.body[0],ast.Continue) and 'gap' in ast.unparse(node.test):
            self.removed+=1;return None
        return self.generic_visit(node)
remove=RemoveFilter();remove.visit(tree);assert remove.removed==1
ast.fix_missing_locations(tree);namespace={};exec(compile(tree,'captured_filter_removed','exec'),m.__dict__,namespace)
unfiltered_full=namespace['unfiltered_full']

def cuts():return {r:old.down_cut(old.VACANCY_CAPS[r]) for r in old.RESPONSES}

def rows(k,pc=None,valuation=None,cost=None,legacy_filter=False,mutate_account=False):
    assert k in (2,3)
    saved=(m.SPARES,m.STOCK_EXTRA,m.CERT_LIMIT,b.scenario,old.VALUE,b.VALUE,b.COST)
    try:
        m.SPARES=80 if k==2 else 90
        m.STOCK_EXTRA=saved[1]+j.STOCK_ADD+(0 if k==2 else 242*2048+10*1024+8192)
        m.CERT_LIMIT=4224 if k==2 else 4288
        if pc is not None:
            original=saved[3]
            b.scenario=lambda r,reading:(pc,original(r,reading)[1],original(r,reading)[2])
        if valuation is not None:old.VALUE=b.VALUE=valuation
        if cost is not None:b.COST=cost
        m.committee.cache_clear();m.prior.capacity_channels.cache_clear()
        result=(m.full if legacy_filter else unfiltered_full)(242,W=42800)
        if result is None:return None
        out={}
        for name,row in result['rows'].items():
            a=row['accounts'].copy()
            if k==3:
                av=m.MT*b.subset(332,F(1,500),80)
                a['care_mpc_unavailability']=av;a['background_episode_overflow']=av
            a['quorum_liveness']+=m.MT*b.subset(242,F(1,500),71 if k==2 else 72)
            if mutate_account:a['ordinary_rescue_channel']+=old.VALUE*F(1,10**8)
            out[name]={'accounts':a,'reserve':result['eta_cert'],'with_reserve':sum(a.values())+result['eta_cert'],
              'gap':row['IC_gap_lower'],'r':row['r'],'reading':row['reading']}
        return out
    finally:
        m.SPARES,m.STOCK_EXTRA,m.CERT_LIMIT,b.scenario,old.VALUE,b.VALUE,b.COST=saved
        m.committee.cache_clear();m.prior.capacity_channels.cache_clear()

# Separate oracle: the source conditions on the number of shocked hosts; the independent implementation
# convolves host polynomials with integer coefficients. Only these three pure definitions are compiled.
_task=FROZEN/'inputs/upt-v01710/inputs/upt-jw27/checks/tasks37.py'
_task_tree=ast.parse(_task.read_text())
_names={'tail_numerator','shock_weights','exact_committee'}
_nodes=[n for n in _task_tree.body if isinstance(n,ast.FunctionDef) and n.name in _names]
assert {n.name for n in _nodes}==_names
from functools import lru_cache
from math import comb
_pure={'F':F,'comb':comb,'lru_cache':lru_cache}
exec(compile(ast.Module(body=_nodes,type_ignores=[]),'captured_shock_count_formula','exec'),_pure)

def exact_mixed_committee(q,certificates=4224):return _pure['exact_committee'](q)*F(certificates,4224)

def mixed_rows(rows,k,q):
    value=exact_mixed_committee(q,4224 if k==2 else 4288)
    adjustment=m.MT*(b.subset(242,F(1,10)+F(9,10)*q,194)-b.subset(242,F(1,10),194))
    out={}
    for name,row in rows.items():
        a=row['accounts'].copy();a['committee_good_editions']=value;a['quorum_liveness']+=adjustment
        reserve=F(1,10**7)+value
        out[name]=dict(row,accounts=a,reserve=reserve,with_reserve=sum(a.values())+reserve)
    return out
