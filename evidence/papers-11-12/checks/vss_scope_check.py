"""Independent row-extension/one-view checks over fields 5 and 7; not a full VSS network implementation."""
from itertools import combinations,product
from collections import Counter
import json,sys
sys.dont_write_bytecode=True

def vss_rows(p):
    ids=(1,2,3,4);lines=tuple(product(range(p),repeat=2))
    ev=lambda line,x:(line[0]+line[1]*x)%p
    pairs=passes=thirds=extensions=0
    for i,j in combinations(ids,2):
        for ri,rj in product(lines,repeat=2):
            pairs+=1
            if ev(ri,j)!=ev(rj,i):continue
            passes+=1
            c=(rj[1]-ri[1])*pow((j-i)%p,-1,p)%p
            b=(ri[1]-c*i)%p;s=(ri[0]-b*i)%p
            row=lambda k:((s+b*k)%p,(b+c*k)%p)
            assert row(i)==ri and row(j)==rj
            for k in ids:
                if k in (i,j):continue
                allowed=[]
                for rk in lines:
                    thirds+=1
                    if ev(rk,i)==ev(ri,k) and ev(rk,j)==ev(rj,k):allowed.append(rk)
                assert allowed==[row(k)];extensions+=1
    for i in ids:
        for s in range(p):
            views=Counter(((s+b*i)%p,(b+c*i)%p) for b,c in product(range(p),repeat=2))
            assert len(views)==p*p and set(views.values())=={1}
    return {'prime':p,'row_pairs':pairs,'passing_pairs':passes,'candidate_third_rows':thirds,'unique_extensions':extensions,
            'single_view_uniform_for_every_secret':True}

if __name__=="__main__":
    print(json.dumps({"degree":1,"receivers":4,"fields":[vss_rows(p) for p in (5,7)],"scope":"Pair-consistent rows uniquely extend the symmetric bivariate primitive; authenticated messages, complaint resolution and common acceptance/recovery remain full-protocol contracts."},sort_keys=True,indent=2))
