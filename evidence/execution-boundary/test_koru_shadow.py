"""Synthetic negative controls for the non-enforcing Koru shadow verifier."""
import copy
import unittest
from koru_shadow import OPS, SCHEMA, VERIFIER, ShadowVerifier, digest


def atom(i):
    return {"atom": "p" + str(i)}


def operation(name, *children):
    return {"op": name, "args": list(children)}


def fixtures():
    signature = {"id": "toy-integer-v1", "ops": OPS.copy(), "meaning": "toy-only"}
    context = {
        "version": 4, "predecessor_ref": "prior-73", "signature_id": signature["id"],
        "positions": [{"ref": "p" + str(i), "value": v}
                      for i, v in enumerate((2, 3, 6, 7, 8, 9))],
    }
    event = {
        "schema": SCHEMA, "event_id": "evt-74", "idempotency_key": "idem-74",
        "generation": 3, "transition_kind": "synthetic_refinement",
        "context_ref": "ctx-one", "context_version": context["version"],
        "predecessor_ref": context["predecessor_ref"],
        "context_digest": digest(context), "signature_id": signature["id"],
        "signature_digest": digest(signature),
        "subject_expr": operation("multiply", atom(0), operation("anchor_one")),
        "action_expr": atom(1), "effect_expr": atom(2),
        "subject_role": 0, "action_role": 1, "witness_ref": "witness-74",
        "authority_ref": "auth-lesson", "scope": "publish", "purpose": "lesson",
        "provenance_ref": "source-7", "retention_class": "metadata-only",
    }
    witnesses = {"witness-74": {
        "verifier": VERIFIER, "transition_kind": "synthetic_refinement",
        "event_digest": digest(event), "context_digest": digest(context),
        "signature_digest": digest(signature),
    }}
    contexts = {"ctx-one": context}
    signatures = {signature["id"]: signature}
    authorities = {"auth-lesson": {
        "active": True, "expires_at": 100, "contexts": ["ctx-one"],
        "scopes": ["publish"], "purposes": ["lesson"],
    }}
    provenances = {"source-7": {
        "active": True, "context_ref": "ctx-one",
        "retention_classes": ["metadata-only", "restricted"],
    }}
    return event, dict(contexts=contexts, signatures=signatures, witnesses=witnesses,
                       authorities=authorities, provenances=provenances,
                       minimum_generation=3, applied_ids=set(), applied_keys=set())


class TestShadowVerifier(unittest.TestCase):
    def setUp(self):
        self.event, self.trusted = fixtures()

    def inspect(self, event=None, **changes):
        data = copy.deepcopy(self.trusted)
        data.update(changes)
        before = copy.deepcopy(data)
        verdict = ShadowVerifier(**data).inspect(
            copy.deepcopy(self.event if event is None else event), now=20)
        self.assertEqual(data, before, "shadow verifier mutated trusted data")
        return verdict

    def expect_bad(self, code, event=None, **changes):
        verdict = self.inspect(event, **changes)
        self.assertFalse(verdict["shadow_pass"], verdict)
        self.assertEqual(verdict["code"], code)
        self.assertEqual(set(verdict), {"shadow_pass", "code", "verifier"})

    def test_valid_synthetic_witness(self):
        self.assertEqual(self.inspect()["code"], "synthetic_checks_pass")
        self.assertTrue(self.inspect()["shadow_pass"])

    def test_missing_and_forged_witness(self):
        self.expect_bad("trusted_witness", {**self.event, "witness_ref": "no-witness"})
        self.expect_bad("trusted_witness", self.event, witnesses={})

    def test_changed_operand_order_even_with_same_numeric_result(self):
        event = copy.deepcopy(self.event)
        event["subject_expr"] = operation("multiply", operation("anchor_one"), atom(0))
        # Operand order changes while evaluation (2) and coherence remain unchanged.
        self.expect_bad("trusted_witness", event)

    def test_invalid_operator_and_arity(self):
        event = copy.deepcopy(self.event)
        event["subject_expr"] = operation("invented", atom(0))
        self.expect_bad("unknown_operator", event)
        event["subject_expr"] = operation("multiply", atom(0))
        self.expect_bad("operator_arity", event)
        event["subject_expr"] = operation("anchor_one", atom(0))
        self.expect_bad("operator_arity", event)

    def test_whole_context_difference_with_same_local_triple(self):
        context = copy.deepcopy(self.trusted["contexts"]["ctx-one"])
        context["positions"][5]["value"] = 11  # local subject/action/effect unchanged
        self.expect_bad("whole_context_mismatch", contexts={"ctx-one": context})

    def test_changed_context_version_and_lineage(self):
        self.expect_bad("stale_context", {**self.event, "context_version": 3})
        self.expect_bad("lineage_mismatch", {**self.event, "predecessor_ref": "other"})

    def test_changed_signature_and_wrong_effect(self):
        self.expect_bad("signature_mismatch", {**self.event, "signature_digest": "0" * 64})
        self.expect_bad("toy_coherence", {**self.event, "effect_expr": atom(3)})

    def test_roles_bound_to_structural_expressions(self):
        self.expect_bad("invalid_role", {**self.event, "subject_role": 8})
        self.expect_bad("role_collision", {**self.event, "subject_role": 1})
        self.expect_bad("role_binding", {**self.event, "subject_role": 3})

    def test_revocation_at_inspection_time(self):
        auth = copy.deepcopy(self.trusted["authorities"])
        auth["auth-lesson"]["active"] = False
        self.expect_bad("independent_authority", self.event, authorities=auth)

    def test_expired_and_wrong_scope(self):
        auth = copy.deepcopy(self.trusted["authorities"])
        auth["auth-lesson"]["expires_at"] = 20
        self.expect_bad("independent_authority", self.event, authorities=auth)
        self.expect_bad("independent_authority", {**self.event, "scope": "delete"})
        self.expect_bad("independent_authority", {**self.event, "purpose": "other"})

    def test_provenance_and_retention(self):
        self.expect_bad("independent_provenance", {**self.event, "provenance_ref": "self-claimed"})
        self.expect_bad("independent_provenance", {**self.event, "retention_class": "public-forever"})

    def test_replay_and_fence(self):
        self.expect_bad("replay", applied_ids={"evt-74"})
        self.expect_bad("replay", applied_keys={"idem-74"})
        self.expect_bad("stale_generation", {**self.event, "generation": 2})

    def test_unknown_fields_and_unsupported_transition(self):
        self.expect_bad("envelope_schema", {**self.event, "raw_private_text": "secret"})
        self.expect_bad("unsupported_transition", {**self.event, "transition_kind": "automorphism"})

    def test_malformed_and_oversized_structures(self):
        self.expect_bad("envelope_schema", {})
        event = copy.deepcopy(self.event)
        event["subject_expr"] = {"atom": "unknown"}
        self.expect_bad("unknown_atom", event)
        event["subject_expr"] = operation("identity", atom(0))
        for _ in range(20):
            event["subject_expr"] = operation("identity", event["subject_expr"])
        self.expect_bad("expression_too_deep", event)

    def test_no_verifier_side_effects(self):
        before = copy.deepcopy(self.trusted)
        verdict = self.inspect()
        self.assertTrue(verdict["shadow_pass"])
        self.assertEqual(self.trusted, before)
        self.assertEqual(self.trusted["applied_ids"], set())
        self.assertEqual(self.trusted["applied_keys"], set())


if __name__ == "__main__":
    unittest.main()
