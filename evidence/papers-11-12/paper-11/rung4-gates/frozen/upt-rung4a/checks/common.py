from pathlib import Path
from fractions import Fraction as F
from decimal import Decimal, localcontext, ROUND_FLOOR
import hashlib,json,sys
sys.dont_write_bytecode=True
ROOT=Path(__file__).resolve().parents[1]
BANNED=('score','verify','review-','known-seams','handoff')

def safe(p):
    p=Path(p)
    assert p.is_absolute() and '..' not in p.parts
    for q in (p,*p.parents):
        assert not q.is_symlink(),str(q)
        assert not q.name.lower().startswith('calibration-')
        assert not any(s in q.name.lower() for s in BANNED),str(q)
    return p

def sha(p):return hashlib.sha256(safe(p).read_bytes()).hexdigest()

def encode(x):
    if isinstance(x,F):
        with localcontext() as c:
            c.prec=18;c.rounding=ROUND_FLOOR
            d=str(Decimal(x.numerator)/Decimal(x.denominator))
        return {'exact':str(x),'decimal_floor':d}
    if isinstance(x,dict):return {k:encode(v) for k,v in x.items()}
    if isinstance(x,(list,tuple)):return [encode(v) for v in x]
    assert x is None or isinstance(x,(str,int,bool))
    return x

def baseline():
    path=ROOT/'inputs/upt-v01710/inputs/upt-jw27/checks'
    safe(path);sys.path.insert(0,str(path))
    import calculate as c
    return c,c.j,c.baseline()

def inputs(originals=False):
    d=json.loads(safe(ROOT/'INPUTS.json').read_text())
    p=ROOT/d['copy'];assert sha(p/'SHA256SUMS')==d['manifest_sha256']
    rows=safe(p/'SHA256SUMS').read_text().splitlines();assert len(rows)==453
    for row in rows:
        h,rel=row.split('  ',1)
        assert not Path(rel).is_absolute() and '..' not in Path(rel).parts
        assert sha(p/rel)==h
        if originals:assert sha(Path(d['source'])/rel)==h
    a=d['attachment'];assert sha(ROOT/a['copy'])==a['sha256']
    if originals:
        assert sha(Path(d['source'])/'SHA256SUMS')==d['manifest_sha256']
        assert sha(Path(a['source']))==a['sha256']
    return 453
