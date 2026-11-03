// Lean compiler output
// Module: PhysicalBridges.IR124ClosedWorldCoverageCountermodel
// Imports: public import Init public meta import Init public import PhysicalBridges.IR123RealEventCoverage
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
lean_object* lean_nat_to_int(lean_object*);
lean_object* l_Nat_reprFast(lean_object*);
lean_object* l_Repr_addAppParen(lean_object*, lean_object*);
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
lean_object* lean_string_length(lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorIdx(uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorElim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorElim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorElim(lean_object*, lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_actuator_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_actuator_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_actuator_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_actuator_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_environmental_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_environmental_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_environmental_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_environmental_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_latent_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_latent_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_latent_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_latent_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_bypass_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_bypass_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_bypass_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_bypass_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_unclassified_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_unclassified_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_unclassified_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_unclassified_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ofNat(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ofNat___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCauseKind(uint8_t, uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCauseKind___boxed(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 41, .m_capacity = 41, .m_length = 40, .m_data = "PhysicalBridges.IR124.CauseKind.actuator"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__0_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__1_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 46, .m_capacity = 46, .m_length = 45, .m_data = "PhysicalBridges.IR124.CauseKind.environmental"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__2_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__2_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__3 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__3_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 39, .m_capacity = 39, .m_length = 38, .m_data = "PhysicalBridges.IR124.CauseKind.latent"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__4 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__4_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__4_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__5 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__5_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 39, .m_capacity = 39, .m_length = 38, .m_data = "PhysicalBridges.IR124.CauseKind.bypass"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__6 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__6_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__6_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__7 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__7_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 45, .m_capacity = 45, .m_length = 44, .m_data = "PhysicalBridges.IR124.CauseKind.unclassified"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__8 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__8_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__8_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__9 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__9_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr(uint8_t, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorIdx(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_actuator_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_actuator_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_environmental_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_environmental_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_latent_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_latent_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_bypass_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_bypass_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCause_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCause_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCause(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCause___boxed(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 37, .m_capacity = 37, .m_length = 36, .m_data = "PhysicalBridges.IR124.Cause.actuator"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__0_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__1_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__2_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 42, .m_capacity = 42, .m_length = 41, .m_data = "PhysicalBridges.IR124.Cause.environmental"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__3 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__3_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__3_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__4 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__4_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__4_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__5 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__5_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 35, .m_capacity = 35, .m_length = 34, .m_data = "PhysicalBridges.IR124.Cause.latent"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__6 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__6_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__6_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__7 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__7_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__7_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__8 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__8_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 35, .m_capacity = 35, .m_length = 34, .m_data = "PhysicalBridges.IR124.Cause.bypass"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__9 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__9_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__9_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__10 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__10_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__10_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__11 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__11_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IR124_instReprCause___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprCause___closed__0_value;
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_kind(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_kind___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_impact(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_impact___boxed(lean_object*);
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_channel___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_channel___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_channel___closed__0_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_channel___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 2}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_channel___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_channel___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_channel___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_channel___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_channel___closed__2_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_channel(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_residual(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_residual___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqPlant_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqPlant_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqPlant(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqPlant___boxed(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "{ "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 7, .m_capacity = 7, .m_length = 6, .m_data = "burden"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__1_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__2_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__2_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__3_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = " := "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__4 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__4_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__4_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__5_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__3_value),((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__6_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__7;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = ","};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__8 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__8_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__8_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__9 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__9_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 10, .m_capacity = 10, .m_length = 9, .m_data = "lastCause"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__10 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__10_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__10_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__11 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__11_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__12_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__12;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__13_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = " }"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__13 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__13_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__14_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__14;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__15_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__15;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__16_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__16 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__16_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__17_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__13_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__17 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__17_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IR124_instReprPlant___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_apply(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_apply___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IR124ClosedWorldCoverageCountermodel_0__PhysicalBridges_IR124_instReprCause_repr_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IR124ClosedWorldCoverageCountermodel_0__PhysicalBridges_IR124_instReprCause_repr_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorIdx(uint8_t v_x_1_){
_start:
{
switch(v_x_1_)
{
case 0:
{
lean_object* v___x_2_; 
v___x_2_ = lean_unsigned_to_nat(0u);
return v___x_2_;
}
case 1:
{
lean_object* v___x_3_; 
v___x_3_ = lean_unsigned_to_nat(1u);
return v___x_3_;
}
case 2:
{
lean_object* v___x_4_; 
v___x_4_ = lean_unsigned_to_nat(2u);
return v___x_4_;
}
case 3:
{
lean_object* v___x_5_; 
v___x_5_ = lean_unsigned_to_nat(3u);
return v___x_5_;
}
default: 
{
lean_object* v___x_6_; 
v___x_6_ = lean_unsigned_to_nat(4u);
return v___x_6_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorIdx___boxed(lean_object* v_x_7_){
_start:
{
uint8_t v_x_boxed_8_; lean_object* v_res_9_; 
v_x_boxed_8_ = lean_unbox(v_x_7_);
v_res_9_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorIdx(v_x_boxed_8_);
return v_res_9_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorElim___redArg(lean_object* v_k_10_){
_start:
{
lean_inc(v_k_10_);
return v_k_10_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorElim___redArg___boxed(lean_object* v_k_11_){
_start:
{
lean_object* v_res_12_; 
v_res_12_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorElim___redArg(v_k_11_);
lean_dec(v_k_11_);
return v_res_12_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorElim(lean_object* v_motive_13_, lean_object* v_ctorIdx_14_, uint8_t v_t_15_, lean_object* v_h_16_, lean_object* v_k_17_){
_start:
{
lean_inc(v_k_17_);
return v_k_17_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorElim___boxed(lean_object* v_motive_18_, lean_object* v_ctorIdx_19_, lean_object* v_t_20_, lean_object* v_h_21_, lean_object* v_k_22_){
_start:
{
uint8_t v_t_boxed_23_; lean_object* v_res_24_; 
v_t_boxed_23_ = lean_unbox(v_t_20_);
v_res_24_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorElim(v_motive_18_, v_ctorIdx_19_, v_t_boxed_23_, v_h_21_, v_k_22_);
lean_dec(v_k_22_);
lean_dec(v_ctorIdx_19_);
return v_res_24_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_actuator_elim___redArg(lean_object* v_actuator_25_){
_start:
{
lean_inc(v_actuator_25_);
return v_actuator_25_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_actuator_elim___redArg___boxed(lean_object* v_actuator_26_){
_start:
{
lean_object* v_res_27_; 
v_res_27_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_actuator_elim___redArg(v_actuator_26_);
lean_dec(v_actuator_26_);
return v_res_27_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_actuator_elim(lean_object* v_motive_28_, uint8_t v_t_29_, lean_object* v_h_30_, lean_object* v_actuator_31_){
_start:
{
lean_inc(v_actuator_31_);
return v_actuator_31_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_actuator_elim___boxed(lean_object* v_motive_32_, lean_object* v_t_33_, lean_object* v_h_34_, lean_object* v_actuator_35_){
_start:
{
uint8_t v_t_boxed_36_; lean_object* v_res_37_; 
v_t_boxed_36_ = lean_unbox(v_t_33_);
v_res_37_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_actuator_elim(v_motive_32_, v_t_boxed_36_, v_h_34_, v_actuator_35_);
lean_dec(v_actuator_35_);
return v_res_37_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_environmental_elim___redArg(lean_object* v_environmental_38_){
_start:
{
lean_inc(v_environmental_38_);
return v_environmental_38_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_environmental_elim___redArg___boxed(lean_object* v_environmental_39_){
_start:
{
lean_object* v_res_40_; 
v_res_40_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_environmental_elim___redArg(v_environmental_39_);
lean_dec(v_environmental_39_);
return v_res_40_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_environmental_elim(lean_object* v_motive_41_, uint8_t v_t_42_, lean_object* v_h_43_, lean_object* v_environmental_44_){
_start:
{
lean_inc(v_environmental_44_);
return v_environmental_44_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_environmental_elim___boxed(lean_object* v_motive_45_, lean_object* v_t_46_, lean_object* v_h_47_, lean_object* v_environmental_48_){
_start:
{
uint8_t v_t_boxed_49_; lean_object* v_res_50_; 
v_t_boxed_49_ = lean_unbox(v_t_46_);
v_res_50_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_environmental_elim(v_motive_45_, v_t_boxed_49_, v_h_47_, v_environmental_48_);
lean_dec(v_environmental_48_);
return v_res_50_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_latent_elim___redArg(lean_object* v_latent_51_){
_start:
{
lean_inc(v_latent_51_);
return v_latent_51_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_latent_elim___redArg___boxed(lean_object* v_latent_52_){
_start:
{
lean_object* v_res_53_; 
v_res_53_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_latent_elim___redArg(v_latent_52_);
lean_dec(v_latent_52_);
return v_res_53_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_latent_elim(lean_object* v_motive_54_, uint8_t v_t_55_, lean_object* v_h_56_, lean_object* v_latent_57_){
_start:
{
lean_inc(v_latent_57_);
return v_latent_57_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_latent_elim___boxed(lean_object* v_motive_58_, lean_object* v_t_59_, lean_object* v_h_60_, lean_object* v_latent_61_){
_start:
{
uint8_t v_t_boxed_62_; lean_object* v_res_63_; 
v_t_boxed_62_ = lean_unbox(v_t_59_);
v_res_63_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_latent_elim(v_motive_58_, v_t_boxed_62_, v_h_60_, v_latent_61_);
lean_dec(v_latent_61_);
return v_res_63_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_bypass_elim___redArg(lean_object* v_bypass_64_){
_start:
{
lean_inc(v_bypass_64_);
return v_bypass_64_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_bypass_elim___redArg___boxed(lean_object* v_bypass_65_){
_start:
{
lean_object* v_res_66_; 
v_res_66_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_bypass_elim___redArg(v_bypass_65_);
lean_dec(v_bypass_65_);
return v_res_66_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_bypass_elim(lean_object* v_motive_67_, uint8_t v_t_68_, lean_object* v_h_69_, lean_object* v_bypass_70_){
_start:
{
lean_inc(v_bypass_70_);
return v_bypass_70_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_bypass_elim___boxed(lean_object* v_motive_71_, lean_object* v_t_72_, lean_object* v_h_73_, lean_object* v_bypass_74_){
_start:
{
uint8_t v_t_boxed_75_; lean_object* v_res_76_; 
v_t_boxed_75_ = lean_unbox(v_t_72_);
v_res_76_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_bypass_elim(v_motive_71_, v_t_boxed_75_, v_h_73_, v_bypass_74_);
lean_dec(v_bypass_74_);
return v_res_76_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_unclassified_elim___redArg(lean_object* v_unclassified_77_){
_start:
{
lean_inc(v_unclassified_77_);
return v_unclassified_77_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_unclassified_elim___redArg___boxed(lean_object* v_unclassified_78_){
_start:
{
lean_object* v_res_79_; 
v_res_79_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_unclassified_elim___redArg(v_unclassified_78_);
lean_dec(v_unclassified_78_);
return v_res_79_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_unclassified_elim(lean_object* v_motive_80_, uint8_t v_t_81_, lean_object* v_h_82_, lean_object* v_unclassified_83_){
_start:
{
lean_inc(v_unclassified_83_);
return v_unclassified_83_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_unclassified_elim___boxed(lean_object* v_motive_84_, lean_object* v_t_85_, lean_object* v_h_86_, lean_object* v_unclassified_87_){
_start:
{
uint8_t v_t_boxed_88_; lean_object* v_res_89_; 
v_t_boxed_88_ = lean_unbox(v_t_85_);
v_res_89_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_unclassified_elim(v_motive_84_, v_t_boxed_88_, v_h_86_, v_unclassified_87_);
lean_dec(v_unclassified_87_);
return v_res_89_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ofNat(lean_object* v_n_90_){
_start:
{
lean_object* v___x_91_; uint8_t v___x_92_; 
v___x_91_ = lean_unsigned_to_nat(1u);
v___x_92_ = lean_nat_dec_le(v_n_90_, v___x_91_);
if (v___x_92_ == 0)
{
lean_object* v___x_93_; uint8_t v___x_94_; 
v___x_93_ = lean_unsigned_to_nat(2u);
v___x_94_ = lean_nat_dec_le(v_n_90_, v___x_93_);
if (v___x_94_ == 0)
{
lean_object* v___x_95_; uint8_t v___x_96_; 
v___x_95_ = lean_unsigned_to_nat(3u);
v___x_96_ = lean_nat_dec_le(v_n_90_, v___x_95_);
if (v___x_96_ == 0)
{
uint8_t v___x_97_; 
v___x_97_ = 4;
return v___x_97_;
}
else
{
uint8_t v___x_98_; 
v___x_98_ = 3;
return v___x_98_;
}
}
else
{
uint8_t v___x_99_; 
v___x_99_ = 2;
return v___x_99_;
}
}
else
{
lean_object* v___x_100_; uint8_t v___x_101_; 
v___x_100_ = lean_unsigned_to_nat(0u);
v___x_101_ = lean_nat_dec_le(v_n_90_, v___x_100_);
if (v___x_101_ == 0)
{
uint8_t v___x_102_; 
v___x_102_ = 1;
return v___x_102_;
}
else
{
uint8_t v___x_103_; 
v___x_103_ = 0;
return v___x_103_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ofNat___boxed(lean_object* v_n_104_){
_start:
{
uint8_t v_res_105_; lean_object* v_r_106_; 
v_res_105_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ofNat(v_n_104_);
lean_dec(v_n_104_);
v_r_106_ = lean_box(v_res_105_);
return v_r_106_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCauseKind(uint8_t v_x_107_, uint8_t v_y_108_){
_start:
{
lean_object* v___x_109_; lean_object* v___x_110_; uint8_t v___x_111_; 
v___x_109_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorIdx(v_x_107_);
v___x_110_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorIdx(v_y_108_);
v___x_111_ = lean_nat_dec_eq(v___x_109_, v___x_110_);
lean_dec(v___x_110_);
lean_dec(v___x_109_);
return v___x_111_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCauseKind___boxed(lean_object* v_x_112_, lean_object* v_y_113_){
_start:
{
uint8_t v_x_20__boxed_114_; uint8_t v_y_21__boxed_115_; uint8_t v_res_116_; lean_object* v_r_117_; 
v_x_20__boxed_114_ = lean_unbox(v_x_112_);
v_y_21__boxed_115_ = lean_unbox(v_y_113_);
v_res_116_ = lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCauseKind(v_x_20__boxed_114_, v_y_21__boxed_115_);
v_r_117_ = lean_box(v_res_116_);
return v_r_117_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10(void){
_start:
{
lean_object* v___x_133_; lean_object* v___x_134_; 
v___x_133_ = lean_unsigned_to_nat(2u);
v___x_134_ = lean_nat_to_int(v___x_133_);
return v___x_134_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11(void){
_start:
{
lean_object* v___x_135_; lean_object* v___x_136_; 
v___x_135_ = lean_unsigned_to_nat(1u);
v___x_136_ = lean_nat_to_int(v___x_135_);
return v___x_136_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr(uint8_t v_x_137_, lean_object* v_prec_138_){
_start:
{
lean_object* v___y_140_; lean_object* v___y_147_; lean_object* v___y_154_; lean_object* v___y_161_; lean_object* v___y_168_; 
switch(v_x_137_)
{
case 0:
{
lean_object* v___x_174_; uint8_t v___x_175_; 
v___x_174_ = lean_unsigned_to_nat(1024u);
v___x_175_ = lean_nat_dec_le(v___x_174_, v_prec_138_);
if (v___x_175_ == 0)
{
lean_object* v___x_176_; 
v___x_176_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10);
v___y_140_ = v___x_176_;
goto v___jp_139_;
}
else
{
lean_object* v___x_177_; 
v___x_177_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11);
v___y_140_ = v___x_177_;
goto v___jp_139_;
}
}
case 1:
{
lean_object* v___x_178_; uint8_t v___x_179_; 
v___x_178_ = lean_unsigned_to_nat(1024u);
v___x_179_ = lean_nat_dec_le(v___x_178_, v_prec_138_);
if (v___x_179_ == 0)
{
lean_object* v___x_180_; 
v___x_180_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10);
v___y_147_ = v___x_180_;
goto v___jp_146_;
}
else
{
lean_object* v___x_181_; 
v___x_181_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11);
v___y_147_ = v___x_181_;
goto v___jp_146_;
}
}
case 2:
{
lean_object* v___x_182_; uint8_t v___x_183_; 
v___x_182_ = lean_unsigned_to_nat(1024u);
v___x_183_ = lean_nat_dec_le(v___x_182_, v_prec_138_);
if (v___x_183_ == 0)
{
lean_object* v___x_184_; 
v___x_184_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10);
v___y_154_ = v___x_184_;
goto v___jp_153_;
}
else
{
lean_object* v___x_185_; 
v___x_185_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11);
v___y_154_ = v___x_185_;
goto v___jp_153_;
}
}
case 3:
{
lean_object* v___x_186_; uint8_t v___x_187_; 
v___x_186_ = lean_unsigned_to_nat(1024u);
v___x_187_ = lean_nat_dec_le(v___x_186_, v_prec_138_);
if (v___x_187_ == 0)
{
lean_object* v___x_188_; 
v___x_188_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10);
v___y_161_ = v___x_188_;
goto v___jp_160_;
}
else
{
lean_object* v___x_189_; 
v___x_189_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11);
v___y_161_ = v___x_189_;
goto v___jp_160_;
}
}
default: 
{
lean_object* v___x_190_; uint8_t v___x_191_; 
v___x_190_ = lean_unsigned_to_nat(1024u);
v___x_191_ = lean_nat_dec_le(v___x_190_, v_prec_138_);
if (v___x_191_ == 0)
{
lean_object* v___x_192_; 
v___x_192_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10);
v___y_168_ = v___x_192_;
goto v___jp_167_;
}
else
{
lean_object* v___x_193_; 
v___x_193_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11);
v___y_168_ = v___x_193_;
goto v___jp_167_;
}
}
}
v___jp_139_:
{
lean_object* v___x_141_; lean_object* v___x_142_; uint8_t v___x_143_; lean_object* v___x_144_; lean_object* v___x_145_; 
v___x_141_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__1));
lean_inc(v___y_140_);
v___x_142_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_142_, 0, v___y_140_);
lean_ctor_set(v___x_142_, 1, v___x_141_);
v___x_143_ = 0;
v___x_144_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_144_, 0, v___x_142_);
lean_ctor_set_uint8(v___x_144_, sizeof(void*)*1, v___x_143_);
v___x_145_ = l_Repr_addAppParen(v___x_144_, v_prec_138_);
return v___x_145_;
}
v___jp_146_:
{
lean_object* v___x_148_; lean_object* v___x_149_; uint8_t v___x_150_; lean_object* v___x_151_; lean_object* v___x_152_; 
v___x_148_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__3));
lean_inc(v___y_147_);
v___x_149_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_149_, 0, v___y_147_);
lean_ctor_set(v___x_149_, 1, v___x_148_);
v___x_150_ = 0;
v___x_151_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_151_, 0, v___x_149_);
lean_ctor_set_uint8(v___x_151_, sizeof(void*)*1, v___x_150_);
v___x_152_ = l_Repr_addAppParen(v___x_151_, v_prec_138_);
return v___x_152_;
}
v___jp_153_:
{
lean_object* v___x_155_; lean_object* v___x_156_; uint8_t v___x_157_; lean_object* v___x_158_; lean_object* v___x_159_; 
v___x_155_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__5));
lean_inc(v___y_154_);
v___x_156_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_156_, 0, v___y_154_);
lean_ctor_set(v___x_156_, 1, v___x_155_);
v___x_157_ = 0;
v___x_158_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_158_, 0, v___x_156_);
lean_ctor_set_uint8(v___x_158_, sizeof(void*)*1, v___x_157_);
v___x_159_ = l_Repr_addAppParen(v___x_158_, v_prec_138_);
return v___x_159_;
}
v___jp_160_:
{
lean_object* v___x_162_; lean_object* v___x_163_; uint8_t v___x_164_; lean_object* v___x_165_; lean_object* v___x_166_; 
v___x_162_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__7));
lean_inc(v___y_161_);
v___x_163_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_163_, 0, v___y_161_);
lean_ctor_set(v___x_163_, 1, v___x_162_);
v___x_164_ = 0;
v___x_165_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_165_, 0, v___x_163_);
lean_ctor_set_uint8(v___x_165_, sizeof(void*)*1, v___x_164_);
v___x_166_ = l_Repr_addAppParen(v___x_165_, v_prec_138_);
return v___x_166_;
}
v___jp_167_:
{
lean_object* v___x_169_; lean_object* v___x_170_; uint8_t v___x_171_; lean_object* v___x_172_; lean_object* v___x_173_; 
v___x_169_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__9));
lean_inc(v___y_168_);
v___x_170_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_170_, 0, v___y_168_);
lean_ctor_set(v___x_170_, 1, v___x_169_);
v___x_171_ = 0;
v___x_172_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_172_, 0, v___x_170_);
lean_ctor_set_uint8(v___x_172_, sizeof(void*)*1, v___x_171_);
v___x_173_ = l_Repr_addAppParen(v___x_172_, v_prec_138_);
return v___x_173_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___boxed(lean_object* v_x_194_, lean_object* v_prec_195_){
_start:
{
uint8_t v_x_279__boxed_196_; lean_object* v_res_197_; 
v_x_279__boxed_196_ = lean_unbox(v_x_194_);
v_res_197_ = lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr(v_x_279__boxed_196_, v_prec_195_);
lean_dec(v_prec_195_);
return v_res_197_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorIdx(lean_object* v_x_200_){
_start:
{
switch(lean_obj_tag(v_x_200_))
{
case 0:
{
lean_object* v___x_201_; 
v___x_201_ = lean_unsigned_to_nat(0u);
return v___x_201_;
}
case 1:
{
lean_object* v___x_202_; 
v___x_202_ = lean_unsigned_to_nat(1u);
return v___x_202_;
}
case 2:
{
lean_object* v___x_203_; 
v___x_203_ = lean_unsigned_to_nat(2u);
return v___x_203_;
}
default: 
{
lean_object* v___x_204_; 
v___x_204_ = lean_unsigned_to_nat(3u);
return v___x_204_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorIdx___boxed(lean_object* v_x_205_){
_start:
{
lean_object* v_res_206_; 
v_res_206_ = lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorIdx(v_x_205_);
lean_dec_ref(v_x_205_);
return v_res_206_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim___redArg(lean_object* v_t_207_, lean_object* v_k_208_){
_start:
{
lean_object* v_magnitude_209_; lean_object* v___x_210_; 
v_magnitude_209_ = lean_ctor_get(v_t_207_, 0);
lean_inc(v_magnitude_209_);
lean_dec_ref(v_t_207_);
v___x_210_ = lean_apply_1(v_k_208_, v_magnitude_209_);
return v___x_210_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim(lean_object* v_motive_211_, lean_object* v_ctorIdx_212_, lean_object* v_t_213_, lean_object* v_h_214_, lean_object* v_k_215_){
_start:
{
lean_object* v___x_216_; 
v___x_216_ = lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim___redArg(v_t_213_, v_k_215_);
return v___x_216_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim___boxed(lean_object* v_motive_217_, lean_object* v_ctorIdx_218_, lean_object* v_t_219_, lean_object* v_h_220_, lean_object* v_k_221_){
_start:
{
lean_object* v_res_222_; 
v_res_222_ = lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim(v_motive_217_, v_ctorIdx_218_, v_t_219_, v_h_220_, v_k_221_);
lean_dec(v_ctorIdx_218_);
return v_res_222_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_actuator_elim___redArg(lean_object* v_t_223_, lean_object* v_actuator_224_){
_start:
{
lean_object* v___x_225_; 
v___x_225_ = lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim___redArg(v_t_223_, v_actuator_224_);
return v___x_225_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_actuator_elim(lean_object* v_motive_226_, lean_object* v_t_227_, lean_object* v_h_228_, lean_object* v_actuator_229_){
_start:
{
lean_object* v___x_230_; 
v___x_230_ = lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim___redArg(v_t_227_, v_actuator_229_);
return v___x_230_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_environmental_elim___redArg(lean_object* v_t_231_, lean_object* v_environmental_232_){
_start:
{
lean_object* v___x_233_; 
v___x_233_ = lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim___redArg(v_t_231_, v_environmental_232_);
return v___x_233_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_environmental_elim(lean_object* v_motive_234_, lean_object* v_t_235_, lean_object* v_h_236_, lean_object* v_environmental_237_){
_start:
{
lean_object* v___x_238_; 
v___x_238_ = lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim___redArg(v_t_235_, v_environmental_237_);
return v___x_238_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_latent_elim___redArg(lean_object* v_t_239_, lean_object* v_latent_240_){
_start:
{
lean_object* v___x_241_; 
v___x_241_ = lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim___redArg(v_t_239_, v_latent_240_);
return v___x_241_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_latent_elim(lean_object* v_motive_242_, lean_object* v_t_243_, lean_object* v_h_244_, lean_object* v_latent_245_){
_start:
{
lean_object* v___x_246_; 
v___x_246_ = lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim___redArg(v_t_243_, v_latent_245_);
return v___x_246_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_bypass_elim___redArg(lean_object* v_t_247_, lean_object* v_bypass_248_){
_start:
{
lean_object* v___x_249_; 
v___x_249_ = lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim___redArg(v_t_247_, v_bypass_248_);
return v___x_249_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_Cause_bypass_elim(lean_object* v_motive_250_, lean_object* v_t_251_, lean_object* v_h_252_, lean_object* v_bypass_253_){
_start:
{
lean_object* v___x_254_; 
v___x_254_ = lp_physical__bridges_PhysicalBridges_IR124_Cause_ctorElim___redArg(v_t_251_, v_bypass_253_);
return v___x_254_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCause_decEq(lean_object* v_x_255_, lean_object* v_x_256_){
_start:
{
switch(lean_obj_tag(v_x_255_))
{
case 0:
{
if (lean_obj_tag(v_x_256_) == 0)
{
lean_object* v_magnitude_257_; lean_object* v_magnitude_258_; uint8_t v___x_259_; 
v_magnitude_257_ = lean_ctor_get(v_x_255_, 0);
v_magnitude_258_ = lean_ctor_get(v_x_256_, 0);
v___x_259_ = lean_nat_dec_eq(v_magnitude_257_, v_magnitude_258_);
return v___x_259_;
}
else
{
uint8_t v___x_260_; 
v___x_260_ = 0;
return v___x_260_;
}
}
case 1:
{
if (lean_obj_tag(v_x_256_) == 1)
{
lean_object* v_magnitude_261_; lean_object* v_magnitude_262_; uint8_t v___x_263_; 
v_magnitude_261_ = lean_ctor_get(v_x_255_, 0);
v_magnitude_262_ = lean_ctor_get(v_x_256_, 0);
v___x_263_ = lean_nat_dec_eq(v_magnitude_261_, v_magnitude_262_);
return v___x_263_;
}
else
{
uint8_t v___x_264_; 
v___x_264_ = 0;
return v___x_264_;
}
}
case 2:
{
if (lean_obj_tag(v_x_256_) == 2)
{
lean_object* v_magnitude_265_; lean_object* v_magnitude_266_; uint8_t v___x_267_; 
v_magnitude_265_ = lean_ctor_get(v_x_255_, 0);
v_magnitude_266_ = lean_ctor_get(v_x_256_, 0);
v___x_267_ = lean_nat_dec_eq(v_magnitude_265_, v_magnitude_266_);
return v___x_267_;
}
else
{
uint8_t v___x_268_; 
v___x_268_ = 0;
return v___x_268_;
}
}
default: 
{
if (lean_obj_tag(v_x_256_) == 3)
{
lean_object* v_magnitude_269_; lean_object* v_magnitude_270_; uint8_t v___x_271_; 
v_magnitude_269_ = lean_ctor_get(v_x_255_, 0);
v_magnitude_270_ = lean_ctor_get(v_x_256_, 0);
v___x_271_ = lean_nat_dec_eq(v_magnitude_269_, v_magnitude_270_);
return v___x_271_;
}
else
{
uint8_t v___x_272_; 
v___x_272_ = 0;
return v___x_272_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCause_decEq___boxed(lean_object* v_x_273_, lean_object* v_x_274_){
_start:
{
uint8_t v_res_275_; lean_object* v_r_276_; 
v_res_275_ = lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCause_decEq(v_x_273_, v_x_274_);
lean_dec_ref(v_x_274_);
lean_dec_ref(v_x_273_);
v_r_276_ = lean_box(v_res_275_);
return v_r_276_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCause(lean_object* v_x_277_, lean_object* v_x_278_){
_start:
{
uint8_t v___x_279_; 
v___x_279_ = lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCause_decEq(v_x_277_, v_x_278_);
return v___x_279_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCause___boxed(lean_object* v_x_280_, lean_object* v_x_281_){
_start:
{
uint8_t v_res_282_; lean_object* v_r_283_; 
v_res_282_ = lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqCause(v_x_280_, v_x_281_);
lean_dec_ref(v_x_281_);
lean_dec_ref(v_x_280_);
v_r_283_ = lean_box(v_res_282_);
return v_r_283_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr(lean_object* v_x_308_, lean_object* v_prec_309_){
_start:
{
switch(lean_obj_tag(v_x_308_))
{
case 0:
{
lean_object* v_magnitude_310_; lean_object* v___x_312_; uint8_t v_isShared_313_; uint8_t v_isSharedCheck_330_; 
v_magnitude_310_ = lean_ctor_get(v_x_308_, 0);
v_isSharedCheck_330_ = !lean_is_exclusive(v_x_308_);
if (v_isSharedCheck_330_ == 0)
{
v___x_312_ = v_x_308_;
v_isShared_313_ = v_isSharedCheck_330_;
goto v_resetjp_311_;
}
else
{
lean_inc(v_magnitude_310_);
lean_dec(v_x_308_);
v___x_312_ = lean_box(0);
v_isShared_313_ = v_isSharedCheck_330_;
goto v_resetjp_311_;
}
v_resetjp_311_:
{
lean_object* v___y_315_; lean_object* v___x_326_; uint8_t v___x_327_; 
v___x_326_ = lean_unsigned_to_nat(1024u);
v___x_327_ = lean_nat_dec_le(v___x_326_, v_prec_309_);
if (v___x_327_ == 0)
{
lean_object* v___x_328_; 
v___x_328_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10);
v___y_315_ = v___x_328_;
goto v___jp_314_;
}
else
{
lean_object* v___x_329_; 
v___x_329_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11);
v___y_315_ = v___x_329_;
goto v___jp_314_;
}
v___jp_314_:
{
lean_object* v___x_316_; lean_object* v___x_317_; lean_object* v___x_319_; 
v___x_316_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__2));
v___x_317_ = l_Nat_reprFast(v_magnitude_310_);
if (v_isShared_313_ == 0)
{
lean_ctor_set_tag(v___x_312_, 3);
lean_ctor_set(v___x_312_, 0, v___x_317_);
v___x_319_ = v___x_312_;
goto v_reusejp_318_;
}
else
{
lean_object* v_reuseFailAlloc_325_; 
v_reuseFailAlloc_325_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v_reuseFailAlloc_325_, 0, v___x_317_);
v___x_319_ = v_reuseFailAlloc_325_;
goto v_reusejp_318_;
}
v_reusejp_318_:
{
lean_object* v___x_320_; lean_object* v___x_321_; uint8_t v___x_322_; lean_object* v___x_323_; lean_object* v___x_324_; 
v___x_320_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_320_, 0, v___x_316_);
lean_ctor_set(v___x_320_, 1, v___x_319_);
lean_inc(v___y_315_);
v___x_321_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_321_, 0, v___y_315_);
lean_ctor_set(v___x_321_, 1, v___x_320_);
v___x_322_ = 0;
v___x_323_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_323_, 0, v___x_321_);
lean_ctor_set_uint8(v___x_323_, sizeof(void*)*1, v___x_322_);
v___x_324_ = l_Repr_addAppParen(v___x_323_, v_prec_309_);
return v___x_324_;
}
}
}
}
case 1:
{
lean_object* v_magnitude_331_; lean_object* v___x_333_; uint8_t v_isShared_334_; uint8_t v_isSharedCheck_351_; 
v_magnitude_331_ = lean_ctor_get(v_x_308_, 0);
v_isSharedCheck_351_ = !lean_is_exclusive(v_x_308_);
if (v_isSharedCheck_351_ == 0)
{
v___x_333_ = v_x_308_;
v_isShared_334_ = v_isSharedCheck_351_;
goto v_resetjp_332_;
}
else
{
lean_inc(v_magnitude_331_);
lean_dec(v_x_308_);
v___x_333_ = lean_box(0);
v_isShared_334_ = v_isSharedCheck_351_;
goto v_resetjp_332_;
}
v_resetjp_332_:
{
lean_object* v___y_336_; lean_object* v___x_347_; uint8_t v___x_348_; 
v___x_347_ = lean_unsigned_to_nat(1024u);
v___x_348_ = lean_nat_dec_le(v___x_347_, v_prec_309_);
if (v___x_348_ == 0)
{
lean_object* v___x_349_; 
v___x_349_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10);
v___y_336_ = v___x_349_;
goto v___jp_335_;
}
else
{
lean_object* v___x_350_; 
v___x_350_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11);
v___y_336_ = v___x_350_;
goto v___jp_335_;
}
v___jp_335_:
{
lean_object* v___x_337_; lean_object* v___x_338_; lean_object* v___x_340_; 
v___x_337_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__5));
v___x_338_ = l_Nat_reprFast(v_magnitude_331_);
if (v_isShared_334_ == 0)
{
lean_ctor_set_tag(v___x_333_, 3);
lean_ctor_set(v___x_333_, 0, v___x_338_);
v___x_340_ = v___x_333_;
goto v_reusejp_339_;
}
else
{
lean_object* v_reuseFailAlloc_346_; 
v_reuseFailAlloc_346_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v_reuseFailAlloc_346_, 0, v___x_338_);
v___x_340_ = v_reuseFailAlloc_346_;
goto v_reusejp_339_;
}
v_reusejp_339_:
{
lean_object* v___x_341_; lean_object* v___x_342_; uint8_t v___x_343_; lean_object* v___x_344_; lean_object* v___x_345_; 
v___x_341_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_341_, 0, v___x_337_);
lean_ctor_set(v___x_341_, 1, v___x_340_);
lean_inc(v___y_336_);
v___x_342_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_342_, 0, v___y_336_);
lean_ctor_set(v___x_342_, 1, v___x_341_);
v___x_343_ = 0;
v___x_344_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_344_, 0, v___x_342_);
lean_ctor_set_uint8(v___x_344_, sizeof(void*)*1, v___x_343_);
v___x_345_ = l_Repr_addAppParen(v___x_344_, v_prec_309_);
return v___x_345_;
}
}
}
}
case 2:
{
lean_object* v_magnitude_352_; lean_object* v___x_354_; uint8_t v_isShared_355_; uint8_t v_isSharedCheck_372_; 
v_magnitude_352_ = lean_ctor_get(v_x_308_, 0);
v_isSharedCheck_372_ = !lean_is_exclusive(v_x_308_);
if (v_isSharedCheck_372_ == 0)
{
v___x_354_ = v_x_308_;
v_isShared_355_ = v_isSharedCheck_372_;
goto v_resetjp_353_;
}
else
{
lean_inc(v_magnitude_352_);
lean_dec(v_x_308_);
v___x_354_ = lean_box(0);
v_isShared_355_ = v_isSharedCheck_372_;
goto v_resetjp_353_;
}
v_resetjp_353_:
{
lean_object* v___y_357_; lean_object* v___x_368_; uint8_t v___x_369_; 
v___x_368_ = lean_unsigned_to_nat(1024u);
v___x_369_ = lean_nat_dec_le(v___x_368_, v_prec_309_);
if (v___x_369_ == 0)
{
lean_object* v___x_370_; 
v___x_370_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10);
v___y_357_ = v___x_370_;
goto v___jp_356_;
}
else
{
lean_object* v___x_371_; 
v___x_371_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11);
v___y_357_ = v___x_371_;
goto v___jp_356_;
}
v___jp_356_:
{
lean_object* v___x_358_; lean_object* v___x_359_; lean_object* v___x_361_; 
v___x_358_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__8));
v___x_359_ = l_Nat_reprFast(v_magnitude_352_);
if (v_isShared_355_ == 0)
{
lean_ctor_set_tag(v___x_354_, 3);
lean_ctor_set(v___x_354_, 0, v___x_359_);
v___x_361_ = v___x_354_;
goto v_reusejp_360_;
}
else
{
lean_object* v_reuseFailAlloc_367_; 
v_reuseFailAlloc_367_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v_reuseFailAlloc_367_, 0, v___x_359_);
v___x_361_ = v_reuseFailAlloc_367_;
goto v_reusejp_360_;
}
v_reusejp_360_:
{
lean_object* v___x_362_; lean_object* v___x_363_; uint8_t v___x_364_; lean_object* v___x_365_; lean_object* v___x_366_; 
v___x_362_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_362_, 0, v___x_358_);
lean_ctor_set(v___x_362_, 1, v___x_361_);
lean_inc(v___y_357_);
v___x_363_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_363_, 0, v___y_357_);
lean_ctor_set(v___x_363_, 1, v___x_362_);
v___x_364_ = 0;
v___x_365_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_365_, 0, v___x_363_);
lean_ctor_set_uint8(v___x_365_, sizeof(void*)*1, v___x_364_);
v___x_366_ = l_Repr_addAppParen(v___x_365_, v_prec_309_);
return v___x_366_;
}
}
}
}
default: 
{
lean_object* v_magnitude_373_; lean_object* v___x_375_; uint8_t v_isShared_376_; uint8_t v_isSharedCheck_393_; 
v_magnitude_373_ = lean_ctor_get(v_x_308_, 0);
v_isSharedCheck_393_ = !lean_is_exclusive(v_x_308_);
if (v_isSharedCheck_393_ == 0)
{
v___x_375_ = v_x_308_;
v_isShared_376_ = v_isSharedCheck_393_;
goto v_resetjp_374_;
}
else
{
lean_inc(v_magnitude_373_);
lean_dec(v_x_308_);
v___x_375_ = lean_box(0);
v_isShared_376_ = v_isSharedCheck_393_;
goto v_resetjp_374_;
}
v_resetjp_374_:
{
lean_object* v___y_378_; lean_object* v___x_389_; uint8_t v___x_390_; 
v___x_389_ = lean_unsigned_to_nat(1024u);
v___x_390_ = lean_nat_dec_le(v___x_389_, v_prec_309_);
if (v___x_390_ == 0)
{
lean_object* v___x_391_; 
v___x_391_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__10);
v___y_378_ = v___x_391_;
goto v___jp_377_;
}
else
{
lean_object* v___x_392_; 
v___x_392_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11, &lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr___closed__11);
v___y_378_ = v___x_392_;
goto v___jp_377_;
}
v___jp_377_:
{
lean_object* v___x_379_; lean_object* v___x_380_; lean_object* v___x_382_; 
v___x_379_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___closed__11));
v___x_380_ = l_Nat_reprFast(v_magnitude_373_);
if (v_isShared_376_ == 0)
{
lean_ctor_set(v___x_375_, 0, v___x_380_);
v___x_382_ = v___x_375_;
goto v_reusejp_381_;
}
else
{
lean_object* v_reuseFailAlloc_388_; 
v_reuseFailAlloc_388_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v_reuseFailAlloc_388_, 0, v___x_380_);
v___x_382_ = v_reuseFailAlloc_388_;
goto v_reusejp_381_;
}
v_reusejp_381_:
{
lean_object* v___x_383_; lean_object* v___x_384_; uint8_t v___x_385_; lean_object* v___x_386_; lean_object* v___x_387_; 
v___x_383_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_383_, 0, v___x_379_);
lean_ctor_set(v___x_383_, 1, v___x_382_);
lean_inc(v___y_378_);
v___x_384_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_384_, 0, v___y_378_);
lean_ctor_set(v___x_384_, 1, v___x_383_);
v___x_385_ = 0;
v___x_386_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_386_, 0, v___x_384_);
lean_ctor_set_uint8(v___x_386_, sizeof(void*)*1, v___x_385_);
v___x_387_ = l_Repr_addAppParen(v___x_386_, v_prec_309_);
return v___x_387_;
}
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr___boxed(lean_object* v_x_394_, lean_object* v_prec_395_){
_start:
{
lean_object* v_res_396_; 
v_res_396_ = lp_physical__bridges_PhysicalBridges_IR124_instReprCause_repr(v_x_394_, v_prec_395_);
lean_dec(v_prec_395_);
return v_res_396_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_kind(lean_object* v_x_399_){
_start:
{
switch(lean_obj_tag(v_x_399_))
{
case 0:
{
uint8_t v___x_400_; 
v___x_400_ = 0;
return v___x_400_;
}
case 1:
{
uint8_t v___x_401_; 
v___x_401_ = 1;
return v___x_401_;
}
case 2:
{
uint8_t v___x_402_; 
v___x_402_ = 2;
return v___x_402_;
}
default: 
{
uint8_t v___x_403_; 
v___x_403_ = 3;
return v___x_403_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_kind___boxed(lean_object* v_x_404_){
_start:
{
uint8_t v_res_405_; lean_object* v_r_406_; 
v_res_405_ = lp_physical__bridges_PhysicalBridges_IR124_kind(v_x_404_);
lean_dec_ref(v_x_404_);
v_r_406_ = lean_box(v_res_405_);
return v_r_406_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_impact(lean_object* v_x_407_){
_start:
{
lean_object* v_magnitude_408_; 
v_magnitude_408_ = lean_ctor_get(v_x_407_, 0);
lean_inc(v_magnitude_408_);
return v_magnitude_408_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_impact___boxed(lean_object* v_x_409_){
_start:
{
lean_object* v_res_410_; 
v_res_410_ = lp_physical__bridges_PhysicalBridges_IR124_impact(v_x_409_);
lean_dec_ref(v_x_409_);
return v_res_410_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_channel(lean_object* v_x_417_){
_start:
{
switch(lean_obj_tag(v_x_417_))
{
case 0:
{
lean_object* v_magnitude_418_; lean_object* v___x_420_; uint8_t v_isShared_421_; uint8_t v_isSharedCheck_425_; 
v_magnitude_418_ = lean_ctor_get(v_x_417_, 0);
v_isSharedCheck_425_ = !lean_is_exclusive(v_x_417_);
if (v_isSharedCheck_425_ == 0)
{
v___x_420_ = v_x_417_;
v_isShared_421_ = v_isSharedCheck_425_;
goto v_resetjp_419_;
}
else
{
lean_inc(v_magnitude_418_);
lean_dec(v_x_417_);
v___x_420_ = lean_box(0);
v_isShared_421_ = v_isSharedCheck_425_;
goto v_resetjp_419_;
}
v_resetjp_419_:
{
lean_object* v___x_423_; 
if (v_isShared_421_ == 0)
{
v___x_423_ = v___x_420_;
goto v_reusejp_422_;
}
else
{
lean_object* v_reuseFailAlloc_424_; 
v_reuseFailAlloc_424_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_424_, 0, v_magnitude_418_);
v___x_423_ = v_reuseFailAlloc_424_;
goto v_reusejp_422_;
}
v_reusejp_422_:
{
return v___x_423_;
}
}
}
case 1:
{
lean_object* v___x_426_; 
lean_dec_ref_known(v_x_417_, 1);
v___x_426_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_channel___closed__0));
return v___x_426_;
}
case 2:
{
lean_object* v___x_427_; 
lean_dec_ref_known(v_x_417_, 1);
v___x_427_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_channel___closed__1));
return v___x_427_;
}
default: 
{
lean_object* v___x_428_; 
lean_dec_ref_known(v_x_417_, 1);
v___x_428_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_channel___closed__2));
return v___x_428_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_residual(lean_object* v_x_429_){
_start:
{
if (lean_obj_tag(v_x_429_) == 0)
{
lean_object* v___x_430_; 
v___x_430_ = lean_unsigned_to_nat(0u);
return v___x_430_;
}
else
{
lean_object* v_magnitude_431_; 
v_magnitude_431_ = lean_ctor_get(v_x_429_, 0);
lean_inc(v_magnitude_431_);
return v_magnitude_431_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_residual___boxed(lean_object* v_x_432_){
_start:
{
lean_object* v_res_433_; 
v_res_433_ = lp_physical__bridges_PhysicalBridges_IR124_residual(v_x_432_);
lean_dec_ref(v_x_432_);
return v_res_433_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqPlant_decEq(lean_object* v_x_434_, lean_object* v_x_435_){
_start:
{
lean_object* v_burden_436_; uint8_t v_lastCause_437_; lean_object* v_burden_438_; uint8_t v_lastCause_439_; uint8_t v___x_440_; 
v_burden_436_ = lean_ctor_get(v_x_434_, 0);
v_lastCause_437_ = lean_ctor_get_uint8(v_x_434_, sizeof(void*)*1);
v_burden_438_ = lean_ctor_get(v_x_435_, 0);
v_lastCause_439_ = lean_ctor_get_uint8(v_x_435_, sizeof(void*)*1);
v___x_440_ = lean_nat_dec_eq(v_burden_436_, v_burden_438_);
if (v___x_440_ == 0)
{
return v___x_440_;
}
else
{
lean_object* v___x_441_; lean_object* v___x_442_; uint8_t v___x_443_; 
v___x_441_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorIdx(v_lastCause_437_);
v___x_442_ = lp_physical__bridges_PhysicalBridges_IR124_CauseKind_ctorIdx(v_lastCause_439_);
v___x_443_ = lean_nat_dec_eq(v___x_441_, v___x_442_);
lean_dec(v___x_442_);
lean_dec(v___x_441_);
return v___x_443_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqPlant_decEq___boxed(lean_object* v_x_444_, lean_object* v_x_445_){
_start:
{
uint8_t v_res_446_; lean_object* v_r_447_; 
v_res_446_ = lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqPlant_decEq(v_x_444_, v_x_445_);
lean_dec_ref(v_x_445_);
lean_dec_ref(v_x_444_);
v_r_447_ = lean_box(v_res_446_);
return v_r_447_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqPlant(lean_object* v_x_448_, lean_object* v_x_449_){
_start:
{
uint8_t v___x_450_; 
v___x_450_ = lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqPlant_decEq(v_x_448_, v_x_449_);
return v___x_450_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqPlant___boxed(lean_object* v_x_451_, lean_object* v_x_452_){
_start:
{
uint8_t v_res_453_; lean_object* v_r_454_; 
v_res_453_ = lp_physical__bridges_PhysicalBridges_IR124_instDecidableEqPlant(v_x_451_, v_x_452_);
lean_dec_ref(v_x_452_);
lean_dec_ref(v_x_451_);
v_r_454_ = lean_box(v_res_453_);
return v_r_454_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__7(void){
_start:
{
lean_object* v___x_468_; lean_object* v___x_469_; 
v___x_468_ = lean_unsigned_to_nat(10u);
v___x_469_ = lean_nat_to_int(v___x_468_);
return v___x_469_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__12(void){
_start:
{
lean_object* v___x_476_; lean_object* v___x_477_; 
v___x_476_ = lean_unsigned_to_nat(13u);
v___x_477_ = lean_nat_to_int(v___x_476_);
return v___x_477_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__14(void){
_start:
{
lean_object* v___x_479_; lean_object* v___x_480_; 
v___x_479_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__0));
v___x_480_ = lean_string_length(v___x_479_);
return v___x_480_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__15(void){
_start:
{
lean_object* v___x_481_; lean_object* v___x_482_; 
v___x_481_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__14, &lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__14_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__14);
v___x_482_ = lean_nat_to_int(v___x_481_);
return v___x_482_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg(lean_object* v_x_487_){
_start:
{
lean_object* v_burden_488_; uint8_t v_lastCause_489_; lean_object* v___x_491_; uint8_t v_isShared_492_; uint8_t v_isSharedCheck_524_; 
v_burden_488_ = lean_ctor_get(v_x_487_, 0);
v_lastCause_489_ = lean_ctor_get_uint8(v_x_487_, sizeof(void*)*1);
v_isSharedCheck_524_ = !lean_is_exclusive(v_x_487_);
if (v_isSharedCheck_524_ == 0)
{
v___x_491_ = v_x_487_;
v_isShared_492_ = v_isSharedCheck_524_;
goto v_resetjp_490_;
}
else
{
lean_inc(v_burden_488_);
lean_dec(v_x_487_);
v___x_491_ = lean_box(0);
v_isShared_492_ = v_isSharedCheck_524_;
goto v_resetjp_490_;
}
v_resetjp_490_:
{
lean_object* v___x_493_; lean_object* v___x_494_; lean_object* v___x_495_; lean_object* v___x_496_; lean_object* v___x_497_; lean_object* v___x_498_; uint8_t v___x_499_; lean_object* v___x_501_; 
v___x_493_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__5));
v___x_494_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__6));
v___x_495_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__7, &lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__7_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__7);
v___x_496_ = l_Nat_reprFast(v_burden_488_);
v___x_497_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_497_, 0, v___x_496_);
v___x_498_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_498_, 0, v___x_495_);
lean_ctor_set(v___x_498_, 1, v___x_497_);
v___x_499_ = 0;
if (v_isShared_492_ == 0)
{
lean_ctor_set_tag(v___x_491_, 6);
lean_ctor_set(v___x_491_, 0, v___x_498_);
v___x_501_ = v___x_491_;
goto v_reusejp_500_;
}
else
{
lean_object* v_reuseFailAlloc_523_; 
v_reuseFailAlloc_523_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v_reuseFailAlloc_523_, 0, v___x_498_);
v___x_501_ = v_reuseFailAlloc_523_;
goto v_reusejp_500_;
}
v_reusejp_500_:
{
lean_object* v___x_502_; lean_object* v___x_503_; lean_object* v___x_504_; lean_object* v___x_505_; lean_object* v___x_506_; lean_object* v___x_507_; lean_object* v___x_508_; lean_object* v___x_509_; lean_object* v___x_510_; lean_object* v___x_511_; lean_object* v___x_512_; lean_object* v___x_513_; lean_object* v___x_514_; lean_object* v___x_515_; lean_object* v___x_516_; lean_object* v___x_517_; lean_object* v___x_518_; lean_object* v___x_519_; lean_object* v___x_520_; lean_object* v___x_521_; lean_object* v___x_522_; 
lean_ctor_set_uint8(v___x_501_, sizeof(void*)*1, v___x_499_);
v___x_502_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_502_, 0, v___x_494_);
lean_ctor_set(v___x_502_, 1, v___x_501_);
v___x_503_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__9));
v___x_504_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_504_, 0, v___x_502_);
lean_ctor_set(v___x_504_, 1, v___x_503_);
v___x_505_ = lean_box(1);
v___x_506_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_506_, 0, v___x_504_);
lean_ctor_set(v___x_506_, 1, v___x_505_);
v___x_507_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__11));
v___x_508_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_508_, 0, v___x_506_);
lean_ctor_set(v___x_508_, 1, v___x_507_);
v___x_509_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_509_, 0, v___x_508_);
lean_ctor_set(v___x_509_, 1, v___x_493_);
v___x_510_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__12, &lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__12_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__12);
v___x_511_ = lean_unsigned_to_nat(0u);
v___x_512_ = lp_physical__bridges_PhysicalBridges_IR124_instReprCauseKind_repr(v_lastCause_489_, v___x_511_);
v___x_513_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_513_, 0, v___x_510_);
lean_ctor_set(v___x_513_, 1, v___x_512_);
v___x_514_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_514_, 0, v___x_513_);
lean_ctor_set_uint8(v___x_514_, sizeof(void*)*1, v___x_499_);
v___x_515_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_515_, 0, v___x_509_);
lean_ctor_set(v___x_515_, 1, v___x_514_);
v___x_516_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__15, &lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__15_once, _init_lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__15);
v___x_517_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__16));
v___x_518_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_518_, 0, v___x_517_);
lean_ctor_set(v___x_518_, 1, v___x_515_);
v___x_519_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg___closed__17));
v___x_520_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_520_, 0, v___x_518_);
lean_ctor_set(v___x_520_, 1, v___x_519_);
v___x_521_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_521_, 0, v___x_516_);
lean_ctor_set(v___x_521_, 1, v___x_520_);
v___x_522_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_522_, 0, v___x_521_);
lean_ctor_set_uint8(v___x_522_, sizeof(void*)*1, v___x_499_);
return v___x_522_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr(lean_object* v_x_525_, lean_object* v_prec_526_){
_start:
{
lean_object* v___x_527_; 
v___x_527_ = lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___redArg(v_x_525_);
return v___x_527_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr___boxed(lean_object* v_x_528_, lean_object* v_prec_529_){
_start:
{
lean_object* v_res_530_; 
v_res_530_ = lp_physical__bridges_PhysicalBridges_IR124_instReprPlant_repr(v_x_528_, v_prec_529_);
lean_dec(v_prec_529_);
return v_res_530_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_apply(lean_object* v_s_533_, lean_object* v_e_534_){
_start:
{
lean_object* v_burden_535_; lean_object* v___x_537_; uint8_t v_isShared_538_; uint8_t v_isSharedCheck_547_; 
v_burden_535_ = lean_ctor_get(v_s_533_, 0);
v_isSharedCheck_547_ = !lean_is_exclusive(v_s_533_);
if (v_isSharedCheck_547_ == 0)
{
v___x_537_ = v_s_533_;
v_isShared_538_ = v_isSharedCheck_547_;
goto v_resetjp_536_;
}
else
{
lean_inc(v_burden_535_);
lean_dec(v_s_533_);
v___x_537_ = lean_box(0);
v_isShared_538_ = v_isSharedCheck_547_;
goto v_resetjp_536_;
}
v_resetjp_536_:
{
lean_object* v___y_540_; lean_object* v_magnitude_546_; 
v_magnitude_546_ = lean_ctor_get(v_e_534_, 0);
v___y_540_ = v_magnitude_546_;
goto v___jp_539_;
v___jp_539_:
{
lean_object* v___x_541_; uint8_t v___x_542_; lean_object* v___x_544_; 
v___x_541_ = lean_nat_add(v_burden_535_, v___y_540_);
lean_dec(v_burden_535_);
v___x_542_ = lp_physical__bridges_PhysicalBridges_IR124_kind(v_e_534_);
if (v_isShared_538_ == 0)
{
lean_ctor_set(v___x_537_, 0, v___x_541_);
v___x_544_ = v___x_537_;
goto v_reusejp_543_;
}
else
{
lean_object* v_reuseFailAlloc_545_; 
v_reuseFailAlloc_545_ = lean_alloc_ctor(0, 1, 1);
lean_ctor_set(v_reuseFailAlloc_545_, 0, v___x_541_);
v___x_544_ = v_reuseFailAlloc_545_;
goto v_reusejp_543_;
}
v_reusejp_543_:
{
lean_ctor_set_uint8(v___x_544_, sizeof(void*)*1, v___x_542_);
return v___x_544_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR124_apply___boxed(lean_object* v_s_548_, lean_object* v_e_549_){
_start:
{
lean_object* v_res_550_; 
v_res_550_ = lp_physical__bridges_PhysicalBridges_IR124_apply(v_s_548_, v_e_549_);
lean_dec_ref(v_e_549_);
return v_res_550_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IR124ClosedWorldCoverageCountermodel_0__PhysicalBridges_IR124_instReprCause_repr_match__1_splitter___redArg(lean_object* v_x_551_, lean_object* v_h__1_552_, lean_object* v_h__2_553_, lean_object* v_h__3_554_, lean_object* v_h__4_555_){
_start:
{
switch(lean_obj_tag(v_x_551_))
{
case 0:
{
lean_object* v_magnitude_556_; lean_object* v___x_557_; 
lean_dec(v_h__4_555_);
lean_dec(v_h__3_554_);
lean_dec(v_h__2_553_);
v_magnitude_556_ = lean_ctor_get(v_x_551_, 0);
lean_inc(v_magnitude_556_);
lean_dec_ref_known(v_x_551_, 1);
v___x_557_ = lean_apply_1(v_h__1_552_, v_magnitude_556_);
return v___x_557_;
}
case 1:
{
lean_object* v_magnitude_558_; lean_object* v___x_559_; 
lean_dec(v_h__4_555_);
lean_dec(v_h__3_554_);
lean_dec(v_h__1_552_);
v_magnitude_558_ = lean_ctor_get(v_x_551_, 0);
lean_inc(v_magnitude_558_);
lean_dec_ref_known(v_x_551_, 1);
v___x_559_ = lean_apply_1(v_h__2_553_, v_magnitude_558_);
return v___x_559_;
}
case 2:
{
lean_object* v_magnitude_560_; lean_object* v___x_561_; 
lean_dec(v_h__4_555_);
lean_dec(v_h__2_553_);
lean_dec(v_h__1_552_);
v_magnitude_560_ = lean_ctor_get(v_x_551_, 0);
lean_inc(v_magnitude_560_);
lean_dec_ref_known(v_x_551_, 1);
v___x_561_ = lean_apply_1(v_h__3_554_, v_magnitude_560_);
return v___x_561_;
}
default: 
{
lean_object* v_magnitude_562_; lean_object* v___x_563_; 
lean_dec(v_h__3_554_);
lean_dec(v_h__2_553_);
lean_dec(v_h__1_552_);
v_magnitude_562_ = lean_ctor_get(v_x_551_, 0);
lean_inc(v_magnitude_562_);
lean_dec_ref_known(v_x_551_, 1);
v___x_563_ = lean_apply_1(v_h__4_555_, v_magnitude_562_);
return v___x_563_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IR124ClosedWorldCoverageCountermodel_0__PhysicalBridges_IR124_instReprCause_repr_match__1_splitter(lean_object* v_motive_564_, lean_object* v_x_565_, lean_object* v_h__1_566_, lean_object* v_h__2_567_, lean_object* v_h__3_568_, lean_object* v_h__4_569_){
_start:
{
switch(lean_obj_tag(v_x_565_))
{
case 0:
{
lean_object* v_magnitude_570_; lean_object* v___x_571_; 
lean_dec(v_h__4_569_);
lean_dec(v_h__3_568_);
lean_dec(v_h__2_567_);
v_magnitude_570_ = lean_ctor_get(v_x_565_, 0);
lean_inc(v_magnitude_570_);
lean_dec_ref_known(v_x_565_, 1);
v___x_571_ = lean_apply_1(v_h__1_566_, v_magnitude_570_);
return v___x_571_;
}
case 1:
{
lean_object* v_magnitude_572_; lean_object* v___x_573_; 
lean_dec(v_h__4_569_);
lean_dec(v_h__3_568_);
lean_dec(v_h__1_566_);
v_magnitude_572_ = lean_ctor_get(v_x_565_, 0);
lean_inc(v_magnitude_572_);
lean_dec_ref_known(v_x_565_, 1);
v___x_573_ = lean_apply_1(v_h__2_567_, v_magnitude_572_);
return v___x_573_;
}
case 2:
{
lean_object* v_magnitude_574_; lean_object* v___x_575_; 
lean_dec(v_h__4_569_);
lean_dec(v_h__2_567_);
lean_dec(v_h__1_566_);
v_magnitude_574_ = lean_ctor_get(v_x_565_, 0);
lean_inc(v_magnitude_574_);
lean_dec_ref_known(v_x_565_, 1);
v___x_575_ = lean_apply_1(v_h__3_568_, v_magnitude_574_);
return v___x_575_;
}
default: 
{
lean_object* v_magnitude_576_; lean_object* v___x_577_; 
lean_dec(v_h__3_568_);
lean_dec(v_h__2_567_);
lean_dec(v_h__1_566_);
v_magnitude_576_ = lean_ctor_get(v_x_565_, 0);
lean_inc(v_magnitude_576_);
lean_dec_ref_known(v_x_565_, 1);
v___x_577_ = lean_apply_1(v_h__4_569_, v_magnitude_576_);
return v___x_577_;
}
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IR123RealEventCoverage(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IR124ClosedWorldCoverageCountermodel(uint8_t builtin) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
lean_initialize();
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_physical__bridges_PhysicalBridges_IR123RealEventCoverage(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
