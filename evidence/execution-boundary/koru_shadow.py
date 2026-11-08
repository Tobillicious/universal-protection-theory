"""Read-only, synthetic Koru event-envelope verifier (pilot v1).

Not a Lean proof checker, authentic-consent authority, cryptographic attestation,
or target commit gate. Trusted registries are injected by the test operator, not
supplied by a candidate event. This module never writes to targets or registries.
"""
import hashlib
import json

SCHEMA = "koru-shadow-envelope-v1"
VERIFIER = "koru-shadow-v1"
FIELDS = frozenset({
    "schema", "event_id", "idempotency_key", "generation", "transition_kind",
    "context_ref", "context_version", "predecessor_ref", "context_digest",
    "signature_id", "signature_digest", "subject_expr", "action_expr",
    "effect_expr", "subject_role", "action_role", "witness_ref", "authority_ref",
    "scope", "purpose", "provenance_ref", "retention_class",
})
TEXT_FIELDS = FIELDS - {
    "generation", "context_version", "subject_role", "action_role",
    "subject_expr", "action_expr", "effect_expr",
}
OPS = {"anchor_one": 0, "identity": 1, "add": 2, "multiply": 2}
MAX_NODES = 96
MAX_DEPTH = 12
MAX_ABS = 10**9


def digest(value):
    """Digest a strictly JSON-serializable fixture, not a proof or signature."""
    raw = json.dumps(value, sort_keys=True, separators=(",", ":"),
                     ensure_ascii=True, allow_nan=False)
    return hashlib.sha256(raw.encode("utf-8")).hexdigest()


class InvalidEvent(Exception):
    def __init__(self, code):
        self.code = code


def _need(ok, code):
    if not ok:
        raise InvalidEvent(code)


def _integer(value):
    return type(value) is int and -MAX_ABS <= value <= MAX_ABS


def _context_positions(ctx):
    """A fully specified synthetic six-position context, not cosmic U."""
    _need(type(ctx) is dict and set(ctx) == {
        "version", "predecessor_ref", "signature_id", "positions"}, "bad_trusted_context")
    positions = ctx["positions"]
    _need(type(positions) is list and len(positions) == 6, "bad_trusted_context")
    result = {}
    for i, p in enumerate(positions):
        _need(type(p) is dict and set(p) == {"ref", "value"}, "bad_trusted_context")
        _need(p["ref"] == "p" + str(i) and _integer(p["value"]), "bad_trusted_context")
        result[p["ref"]] = p["value"]
    return result


def _evaluate(expr, positions, count, depth=0):
    _need(depth <= MAX_DEPTH, "expression_too_deep")
    count[0] += 1
    _need(count[0] <= MAX_NODES, "expression_too_large")
    _need(type(expr) is dict, "bad_expression")
    if set(expr) == {"atom"}:
        ref = expr["atom"]
        _need(type(ref) is str and ref in positions, "unknown_atom")
        return positions[ref]
    _need(set(expr) == {"op", "args"}, "bad_expression")
    op, args = expr["op"], expr["args"]
    _need(type(op) is str and op in OPS, "unknown_operator")
    _need(type(args) is list and len(args) == OPS[op], "operator_arity")
    vals = [_evaluate(e, positions, count, depth + 1) for e in args]
    if op == "anchor_one":
        out = 1
    elif op == "identity":
        out = vals[0]
    elif op == "add":
        out = vals[0] + vals[1]
    else:
        out = vals[0] * vals[1]
    _need(_integer(out), "expression_out_of_bounds")
    return out


def _mentions_atom(expr, ref):
    """After bounded parsing, ensure pilot's tracked role occurs in its expression."""
    if "atom" in expr:
        return expr["atom"] == ref
    return any(_mentions_atom(child, ref) for child in expr["args"])


class ShadowVerifier:
    """Pure verdict, never an authorization grant or application operation."""

    def __init__(self, *, contexts, signatures, witnesses, authorities,
                 provenances, minimum_generation=1, applied_ids=(), applied_keys=()):
        self.contexts = contexts
        self.signatures = signatures
        self.witnesses = witnesses
        self.authorities = authorities
        self.provenances = provenances
        self.minimum_generation = minimum_generation
        self.applied_ids = applied_ids
        self.applied_keys = applied_keys

    def inspect(self, event, *, now):
        """Return only a code and verdict; never persist raw event contents."""
        try:
            self._inspect(event, now)
        except InvalidEvent as exc:
            return {"shadow_pass": False, "code": exc.code, "verifier": VERIFIER}
        except (TypeError, ValueError, KeyError, OverflowError, RecursionError):
            return {"shadow_pass": False, "code": "malformed_data", "verifier": VERIFIER}
        return {"shadow_pass": True, "code": "synthetic_checks_pass", "verifier": VERIFIER}

    def _inspect(self, event, now):
        _need(type(event) is dict and set(event) == FIELDS, "envelope_schema")
        _need(all(type(event[k]) is str and 0 < len(event[k]) <= 160
                  for k in TEXT_FIELDS), "envelope_field")
        _need(event["schema"] == SCHEMA, "schema_version")
        _need(event["transition_kind"] == "synthetic_refinement", "unsupported_transition")
        _need(type(now) is int, "bad_trusted_time")
        _need(type(event["generation"]) is int and event["generation"] >=
              self.minimum_generation, "stale_generation")
        _need(event["event_id"] not in self.applied_ids and
              event["idempotency_key"] not in self.applied_keys, "replay")

        ctx = self.contexts.get(event["context_ref"])
        _need(ctx is not None, "unknown_context")
        pos = _context_positions(ctx)
        _need(type(event["context_version"]) is int and
              event["context_version"] == ctx["version"], "stale_context")
        _need(event["predecessor_ref"] == ctx["predecessor_ref"], "lineage_mismatch")
        _need(event["context_digest"] == digest(ctx), "whole_context_mismatch")
        _need(event["signature_id"] == ctx["signature_id"], "wrong_signature")
        sig = self.signatures.get(event["signature_id"])
        _need(type(sig) is dict and sig == {
            "id": "toy-integer-v1", "ops": OPS, "meaning": "toy-only"},
            "untrusted_signature")
        _need(event["signature_digest"] == digest(sig), "signature_mismatch")

        for role in (event["subject_role"], event["action_role"]):
            _need(type(role) is int and 0 <= role < 6, "invalid_role")
        _need(event["subject_role"] != event["action_role"], "role_collision")
        count = [0]
        subject = _evaluate(event["subject_expr"], pos, count)
        action = _evaluate(event["action_expr"], pos, count)
        effect = _evaluate(event["effect_expr"], pos, count)
        _need(_mentions_atom(event["subject_expr"], "p" + str(event["subject_role"])) and
              _mentions_atom(event["action_expr"], "p" + str(event["action_role"])),
              "role_binding")
        _need(effect == action * subject, "toy_coherence")

        auth = self.authorities.get(event["authority_ref"])
        _need(type(auth) is dict and auth.get("active") is True and
              type(auth.get("expires_at")) is int and now < auth["expires_at"] and
              event["context_ref"] in auth.get("contexts", ()) and
              event["scope"] in auth.get("scopes", ()) and
              event["purpose"] in auth.get("purposes", ()), "independent_authority")
        provenance = self.provenances.get(event["provenance_ref"])
        _need(type(provenance) is dict and provenance.get("active") is True and
              provenance.get("context_ref") == event["context_ref"] and
              event["retention_class"] in provenance.get("retention_classes", ()),
              "independent_provenance")

        witness = self.witnesses.get(event["witness_ref"])
        _need(type(witness) is dict and witness.get("verifier") == VERIFIER and
              witness.get("transition_kind") == "synthetic_refinement" and
              witness.get("event_digest") == digest(event) and
              witness.get("context_digest") == digest(ctx) and
              witness.get("signature_digest") == digest(sig), "trusted_witness")
