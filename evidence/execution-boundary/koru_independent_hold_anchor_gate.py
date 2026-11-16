"""Bounded effect-time HOLD rollback gate with independently trusted witness.

The authoritative anchor is an injected *independent* trusted source, outside
the local root-floor/controller snapshot rollback domain. Its read() must be
fresh, non-rollbackable, and ordered against effect-time fence transitions.
This module DOES NOT create such a source or solve cross-host atomicity.

The caller MUST use permits() inside the shared effect fence and must not
expose an alternate route directly to the unanchored local floor.
"""
class IndependentlyAnchoredHoldGate:
    def __init__(self, local_floor, trusted_anchor):
        if (local_floor is None or
                not callable(getattr(local_floor, "read", None)) or
                not callable(getattr(local_floor, "permits", None)) or
                trusted_anchor is None or
                not callable(getattr(trusted_anchor, "read", None))):
            raise ValueError("independent trusted anchor and local floor required")
        self._floor = local_floor
        self._anchor = trusted_anchor

    def permits(self, event, controller_snapshot):
        """Never authorize if the witness is absent, held, or disagrees.

        The anchor is not accepted merely because it has a valid-looking
        schema: its origin and freshness are deployment trust assumptions.
        """
        try:
            observed = self._anchor.read()
            if (type(observed) is not dict or
                    set(observed) != {"generation", "held",
                                      "event_id", "authority_ref"} or
                    type(observed["generation"]) is not int or
                    observed["generation"] < 1 or
                    type(observed["held"]) is not bool or
                    observed["held"] or
                    type(observed["event_id"]) is not str or
                    not observed["event_id"] or
                    type(observed["authority_ref"]) is not str or
                    not observed["authority_ref"]):
                return False
            floor_state = self._floor.read()
            if (type(event) is not dict or
                    any(floor_state.get(field) != observed[field] or
                        event.get(field) != observed[field]
                        for field in ("generation", "event_id",
                                      "authority_ref")) or
                    floor_state.get("held") is not False):
                return False
            return self._floor.permits(event, controller_snapshot)
        except (OSError, ValueError, TypeError, RuntimeError, KeyError,
                AttributeError):
            return False
