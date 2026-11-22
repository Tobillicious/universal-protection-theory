"""Exact telescoping counterexample to omitting uniform switched decay."""
from pathlib import Path
import sympy as s

n = s.symbols("n", integer=True, nonnegative=True)
q = (n + 2) / (2 * (n + 1))
k = 1 - 1 / (n + 2)**2
assert s.simplify(q.subs(n, n + 1) - q * k) == 0
assert q.subs(n, 0) == 1
assert s.limit(q, n, s.oo) == s.Rational(1, 2)
assert s.simplify(k - (n + 1)*(n + 3)/(n + 2)**2) == 0
report = (
    "Exact switched-contraction product recurrence: PASS\n"
    "Initial product q(0)=1: PASS\n"
    "Product limit = 1/2: PASS\n"
    "Every individual factor lies strictly between 0 and 1 for n>=0.\n"
    "This tests the general switching claim, not Complete Koru physics.\n"
)
Path(__file__).with_name("switched-contraction-receipt.txt").write_text(report)
print(report, end="")

