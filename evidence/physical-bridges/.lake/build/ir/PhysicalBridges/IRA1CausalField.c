// Lean compiler output
// Module: PhysicalBridges.IRA1CausalField
// Imports: public import Init public meta import Init public import PhysicalBridges.IRA1PacketIngress
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
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
uint8_t lp_physical__bridges_PhysicalBridges_IRA1PacketIngress_permit(lean_object*, lean_object*, lean_object*);
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_nat_mul(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketIngress_ingest(lean_object*, lean_object*, lean_object*);
lean_object* lean_nat_to_int(lean_object*);
lean_object* lean_string_length(lean_object*);
lean_object* l_Nat_reprFast(lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "{ "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "sendTick"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__1_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__2_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__2_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__3_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = " := "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__4 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__4_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__4_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__5_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__3_value),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__6_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__7;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = ","};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__8 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__8_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__8_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__9 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__9_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 12, .m_capacity = 12, .m_length = 11, .m_data = "receiveTick"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__10 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__10_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__10_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__11 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__11_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__12_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__12;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__13_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "distance"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__13 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__13_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__14_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__13_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__14 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__14_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__15_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 6, .m_capacity = 6, .m_length = 5, .m_data = "epoch"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__15 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__15_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__16_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__15_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__16 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__16_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__17_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__17;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__18_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = " }"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__18 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__18_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__19_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__19;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__20_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__20;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__21_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__21 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__21_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__22_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__18_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__22 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__22_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit___closed__0_value;
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqTransit_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqTransit_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqTransit(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqTransit___boxed(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 16, .m_capacity = 16, .m_length = 15, .m_data = "maxSpeedPerTick"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__0_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__1_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__2_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__2_value),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__3_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__4_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__4;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 14, .m_capacity = 14, .m_length = 13, .m_data = "maxDelayTicks"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__5_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__6_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__7;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds___closed__0_value;
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqLinkBounds_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqLinkBounds_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqLinkBounds(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqLinkBounds___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableCausallyAdmitted(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableCausallyAdmitted___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_fieldPermit(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_fieldPermit___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_ingestField(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_ingestField___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1CausalField_runField_spec__0(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1CausalField_runField_spec__0___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_runField(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_runField___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_exampleBounds___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 0}, .m_objs = {((lean_object*)(((size_t)(3) << 1) | 1)),((lean_object*)(((size_t)(5) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_exampleBounds___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_exampleBounds___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_exampleBounds = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_exampleBounds___closed__0_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_examplePacket___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*4 + 0, .m_other = 4, .m_tag = 0}, .m_objs = {((lean_object*)(((size_t)(42) << 1) | 1)),((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)(((size_t)(5) << 1) | 1)),((lean_object*)(((size_t)(9) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_examplePacket___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_examplePacket___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_examplePacket = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_examplePacket___closed__0_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_exampleSession___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*3 + 0, .m_other = 3, .m_tag = 0}, .m_objs = {((lean_object*)(((size_t)(42) << 1) | 1)),((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)(((size_t)(0) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_exampleSession___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_exampleSession___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_exampleSession = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_exampleSession___closed__0_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_nominalTransit___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*4 + 0, .m_other = 4, .m_tag = 0}, .m_objs = {((lean_object*)(((size_t)(10) << 1) | 1)),((lean_object*)(((size_t)(12) << 1) | 1)),((lean_object*)(((size_t)(5) << 1) | 1)),((lean_object*)(((size_t)(42) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_nominalTransit___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_nominalTransit___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_nominalTransit = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_nominalTransit___closed__0_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1CausalField_actualUnmodeledTransit___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*4 + 0, .m_other = 4, .m_tag = 0}, .m_objs = {((lean_object*)(((size_t)(10) << 1) | 1)),((lean_object*)(((size_t)(10) << 1) | 1)),((lean_object*)(((size_t)(5) << 1) | 1)),((lean_object*)(((size_t)(42) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_actualUnmodeledTransit___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_actualUnmodeledTransit___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_actualUnmodeledTransit = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1CausalField_actualUnmodeledTransit___closed__0_value;
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__7(void){
_start:
{
lean_object* v___x_14_; lean_object* v___x_15_; 
v___x_14_ = lean_unsigned_to_nat(12u);
v___x_15_ = lean_nat_to_int(v___x_14_);
return v___x_15_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__12(void){
_start:
{
lean_object* v___x_22_; lean_object* v___x_23_; 
v___x_22_ = lean_unsigned_to_nat(15u);
v___x_23_ = lean_nat_to_int(v___x_22_);
return v___x_23_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__17(void){
_start:
{
lean_object* v___x_30_; lean_object* v___x_31_; 
v___x_30_ = lean_unsigned_to_nat(9u);
v___x_31_ = lean_nat_to_int(v___x_30_);
return v___x_31_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__19(void){
_start:
{
lean_object* v___x_33_; lean_object* v___x_34_; 
v___x_33_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__0));
v___x_34_ = lean_string_length(v___x_33_);
return v___x_34_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__20(void){
_start:
{
lean_object* v___x_35_; lean_object* v___x_36_; 
v___x_35_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__19, &lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__19_once, _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__19);
v___x_36_ = lean_nat_to_int(v___x_35_);
return v___x_36_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg(lean_object* v_x_41_){
_start:
{
lean_object* v_sendTick_42_; lean_object* v_receiveTick_43_; lean_object* v_distance_44_; lean_object* v_epoch_45_; lean_object* v___x_46_; lean_object* v___x_47_; lean_object* v___x_48_; lean_object* v___x_49_; lean_object* v___x_50_; lean_object* v___x_51_; uint8_t v___x_52_; lean_object* v___x_53_; lean_object* v___x_54_; lean_object* v___x_55_; lean_object* v___x_56_; lean_object* v___x_57_; lean_object* v___x_58_; lean_object* v___x_59_; lean_object* v___x_60_; lean_object* v___x_61_; lean_object* v___x_62_; lean_object* v___x_63_; lean_object* v___x_64_; lean_object* v___x_65_; lean_object* v___x_66_; lean_object* v___x_67_; lean_object* v___x_68_; lean_object* v___x_69_; lean_object* v___x_70_; lean_object* v___x_71_; lean_object* v___x_72_; lean_object* v___x_73_; lean_object* v___x_74_; lean_object* v___x_75_; lean_object* v___x_76_; lean_object* v___x_77_; lean_object* v___x_78_; lean_object* v___x_79_; lean_object* v___x_80_; lean_object* v___x_81_; lean_object* v___x_82_; lean_object* v___x_83_; lean_object* v___x_84_; lean_object* v___x_85_; lean_object* v___x_86_; lean_object* v___x_87_; lean_object* v___x_88_; lean_object* v___x_89_; lean_object* v___x_90_; lean_object* v___x_91_; lean_object* v___x_92_; lean_object* v___x_93_; lean_object* v___x_94_; lean_object* v___x_95_; 
v_sendTick_42_ = lean_ctor_get(v_x_41_, 0);
lean_inc(v_sendTick_42_);
v_receiveTick_43_ = lean_ctor_get(v_x_41_, 1);
lean_inc(v_receiveTick_43_);
v_distance_44_ = lean_ctor_get(v_x_41_, 2);
lean_inc(v_distance_44_);
v_epoch_45_ = lean_ctor_get(v_x_41_, 3);
lean_inc(v_epoch_45_);
lean_dec_ref(v_x_41_);
v___x_46_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__5));
v___x_47_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__6));
v___x_48_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__7, &lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__7_once, _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__7);
v___x_49_ = l_Nat_reprFast(v_sendTick_42_);
v___x_50_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_50_, 0, v___x_49_);
v___x_51_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_51_, 0, v___x_48_);
lean_ctor_set(v___x_51_, 1, v___x_50_);
v___x_52_ = 0;
v___x_53_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_53_, 0, v___x_51_);
lean_ctor_set_uint8(v___x_53_, sizeof(void*)*1, v___x_52_);
v___x_54_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_54_, 0, v___x_47_);
lean_ctor_set(v___x_54_, 1, v___x_53_);
v___x_55_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__9));
v___x_56_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_56_, 0, v___x_54_);
lean_ctor_set(v___x_56_, 1, v___x_55_);
v___x_57_ = lean_box(1);
v___x_58_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_58_, 0, v___x_56_);
lean_ctor_set(v___x_58_, 1, v___x_57_);
v___x_59_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__11));
v___x_60_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_60_, 0, v___x_58_);
lean_ctor_set(v___x_60_, 1, v___x_59_);
v___x_61_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_61_, 0, v___x_60_);
lean_ctor_set(v___x_61_, 1, v___x_46_);
v___x_62_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__12, &lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__12_once, _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__12);
v___x_63_ = l_Nat_reprFast(v_receiveTick_43_);
v___x_64_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_64_, 0, v___x_63_);
v___x_65_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_65_, 0, v___x_62_);
lean_ctor_set(v___x_65_, 1, v___x_64_);
v___x_66_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_66_, 0, v___x_65_);
lean_ctor_set_uint8(v___x_66_, sizeof(void*)*1, v___x_52_);
v___x_67_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_67_, 0, v___x_61_);
lean_ctor_set(v___x_67_, 1, v___x_66_);
v___x_68_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_68_, 0, v___x_67_);
lean_ctor_set(v___x_68_, 1, v___x_55_);
v___x_69_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_69_, 0, v___x_68_);
lean_ctor_set(v___x_69_, 1, v___x_57_);
v___x_70_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__14));
v___x_71_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_71_, 0, v___x_69_);
lean_ctor_set(v___x_71_, 1, v___x_70_);
v___x_72_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_72_, 0, v___x_71_);
lean_ctor_set(v___x_72_, 1, v___x_46_);
v___x_73_ = l_Nat_reprFast(v_distance_44_);
v___x_74_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_74_, 0, v___x_73_);
v___x_75_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_75_, 0, v___x_48_);
lean_ctor_set(v___x_75_, 1, v___x_74_);
v___x_76_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_76_, 0, v___x_75_);
lean_ctor_set_uint8(v___x_76_, sizeof(void*)*1, v___x_52_);
v___x_77_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_77_, 0, v___x_72_);
lean_ctor_set(v___x_77_, 1, v___x_76_);
v___x_78_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_78_, 0, v___x_77_);
lean_ctor_set(v___x_78_, 1, v___x_55_);
v___x_79_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_79_, 0, v___x_78_);
lean_ctor_set(v___x_79_, 1, v___x_57_);
v___x_80_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__16));
v___x_81_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_81_, 0, v___x_79_);
lean_ctor_set(v___x_81_, 1, v___x_80_);
v___x_82_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_82_, 0, v___x_81_);
lean_ctor_set(v___x_82_, 1, v___x_46_);
v___x_83_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__17, &lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__17_once, _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__17);
v___x_84_ = l_Nat_reprFast(v_epoch_45_);
v___x_85_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_85_, 0, v___x_84_);
v___x_86_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_86_, 0, v___x_83_);
lean_ctor_set(v___x_86_, 1, v___x_85_);
v___x_87_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_87_, 0, v___x_86_);
lean_ctor_set_uint8(v___x_87_, sizeof(void*)*1, v___x_52_);
v___x_88_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_88_, 0, v___x_82_);
lean_ctor_set(v___x_88_, 1, v___x_87_);
v___x_89_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__20, &lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__20_once, _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__20);
v___x_90_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__21));
v___x_91_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_91_, 0, v___x_90_);
lean_ctor_set(v___x_91_, 1, v___x_88_);
v___x_92_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__22));
v___x_93_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_93_, 0, v___x_91_);
lean_ctor_set(v___x_93_, 1, v___x_92_);
v___x_94_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_94_, 0, v___x_89_);
lean_ctor_set(v___x_94_, 1, v___x_93_);
v___x_95_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_95_, 0, v___x_94_);
lean_ctor_set_uint8(v___x_95_, sizeof(void*)*1, v___x_52_);
return v___x_95_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr(lean_object* v_x_96_, lean_object* v_prec_97_){
_start:
{
lean_object* v___x_98_; 
v___x_98_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg(v_x_96_);
return v___x_98_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___boxed(lean_object* v_x_99_, lean_object* v_prec_100_){
_start:
{
lean_object* v_res_101_; 
v_res_101_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr(v_x_99_, v_prec_100_);
lean_dec(v_prec_100_);
return v_res_101_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqTransit_decEq(lean_object* v_x_104_, lean_object* v_x_105_){
_start:
{
lean_object* v_sendTick_106_; lean_object* v_receiveTick_107_; lean_object* v_distance_108_; lean_object* v_epoch_109_; lean_object* v_sendTick_110_; lean_object* v_receiveTick_111_; lean_object* v_distance_112_; lean_object* v_epoch_113_; uint8_t v___x_114_; 
v_sendTick_106_ = lean_ctor_get(v_x_104_, 0);
v_receiveTick_107_ = lean_ctor_get(v_x_104_, 1);
v_distance_108_ = lean_ctor_get(v_x_104_, 2);
v_epoch_109_ = lean_ctor_get(v_x_104_, 3);
v_sendTick_110_ = lean_ctor_get(v_x_105_, 0);
v_receiveTick_111_ = lean_ctor_get(v_x_105_, 1);
v_distance_112_ = lean_ctor_get(v_x_105_, 2);
v_epoch_113_ = lean_ctor_get(v_x_105_, 3);
v___x_114_ = lean_nat_dec_eq(v_sendTick_106_, v_sendTick_110_);
if (v___x_114_ == 0)
{
return v___x_114_;
}
else
{
uint8_t v___x_115_; 
v___x_115_ = lean_nat_dec_eq(v_receiveTick_107_, v_receiveTick_111_);
if (v___x_115_ == 0)
{
return v___x_115_;
}
else
{
uint8_t v___x_116_; 
v___x_116_ = lean_nat_dec_eq(v_distance_108_, v_distance_112_);
if (v___x_116_ == 0)
{
return v___x_116_;
}
else
{
uint8_t v___x_117_; 
v___x_117_ = lean_nat_dec_eq(v_epoch_109_, v_epoch_113_);
return v___x_117_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqTransit_decEq___boxed(lean_object* v_x_118_, lean_object* v_x_119_){
_start:
{
uint8_t v_res_120_; lean_object* v_r_121_; 
v_res_120_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqTransit_decEq(v_x_118_, v_x_119_);
lean_dec_ref(v_x_119_);
lean_dec_ref(v_x_118_);
v_r_121_ = lean_box(v_res_120_);
return v_r_121_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqTransit(lean_object* v_x_122_, lean_object* v_x_123_){
_start:
{
uint8_t v___x_124_; 
v___x_124_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqTransit_decEq(v_x_122_, v_x_123_);
return v___x_124_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqTransit___boxed(lean_object* v_x_125_, lean_object* v_x_126_){
_start:
{
uint8_t v_res_127_; lean_object* v_r_128_; 
v_res_127_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqTransit(v_x_125_, v_x_126_);
lean_dec_ref(v_x_126_);
lean_dec_ref(v_x_125_);
v_r_128_ = lean_box(v_res_127_);
return v_r_128_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__4(void){
_start:
{
lean_object* v___x_138_; lean_object* v___x_139_; 
v___x_138_ = lean_unsigned_to_nat(19u);
v___x_139_ = lean_nat_to_int(v___x_138_);
return v___x_139_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__7(void){
_start:
{
lean_object* v___x_143_; lean_object* v___x_144_; 
v___x_143_ = lean_unsigned_to_nat(17u);
v___x_144_ = lean_nat_to_int(v___x_143_);
return v___x_144_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg(lean_object* v_x_145_){
_start:
{
lean_object* v_maxSpeedPerTick_146_; lean_object* v_maxDelayTicks_147_; lean_object* v___x_149_; uint8_t v_isShared_150_; uint8_t v_isSharedCheck_182_; 
v_maxSpeedPerTick_146_ = lean_ctor_get(v_x_145_, 0);
v_maxDelayTicks_147_ = lean_ctor_get(v_x_145_, 1);
v_isSharedCheck_182_ = !lean_is_exclusive(v_x_145_);
if (v_isSharedCheck_182_ == 0)
{
v___x_149_ = v_x_145_;
v_isShared_150_ = v_isSharedCheck_182_;
goto v_resetjp_148_;
}
else
{
lean_inc(v_maxDelayTicks_147_);
lean_inc(v_maxSpeedPerTick_146_);
lean_dec(v_x_145_);
v___x_149_ = lean_box(0);
v_isShared_150_ = v_isSharedCheck_182_;
goto v_resetjp_148_;
}
v_resetjp_148_:
{
lean_object* v___x_151_; lean_object* v___x_152_; lean_object* v___x_153_; lean_object* v___x_154_; lean_object* v___x_155_; lean_object* v___x_157_; 
v___x_151_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__5));
v___x_152_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__3));
v___x_153_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__4, &lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__4_once, _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__4);
v___x_154_ = l_Nat_reprFast(v_maxSpeedPerTick_146_);
v___x_155_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_155_, 0, v___x_154_);
if (v_isShared_150_ == 0)
{
lean_ctor_set_tag(v___x_149_, 4);
lean_ctor_set(v___x_149_, 1, v___x_155_);
lean_ctor_set(v___x_149_, 0, v___x_153_);
v___x_157_ = v___x_149_;
goto v_reusejp_156_;
}
else
{
lean_object* v_reuseFailAlloc_181_; 
v_reuseFailAlloc_181_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v_reuseFailAlloc_181_, 0, v___x_153_);
lean_ctor_set(v_reuseFailAlloc_181_, 1, v___x_155_);
v___x_157_ = v_reuseFailAlloc_181_;
goto v_reusejp_156_;
}
v_reusejp_156_:
{
uint8_t v___x_158_; lean_object* v___x_159_; lean_object* v___x_160_; lean_object* v___x_161_; lean_object* v___x_162_; lean_object* v___x_163_; lean_object* v___x_164_; lean_object* v___x_165_; lean_object* v___x_166_; lean_object* v___x_167_; lean_object* v___x_168_; lean_object* v___x_169_; lean_object* v___x_170_; lean_object* v___x_171_; lean_object* v___x_172_; lean_object* v___x_173_; lean_object* v___x_174_; lean_object* v___x_175_; lean_object* v___x_176_; lean_object* v___x_177_; lean_object* v___x_178_; lean_object* v___x_179_; lean_object* v___x_180_; 
v___x_158_ = 0;
v___x_159_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_159_, 0, v___x_157_);
lean_ctor_set_uint8(v___x_159_, sizeof(void*)*1, v___x_158_);
v___x_160_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_160_, 0, v___x_152_);
lean_ctor_set(v___x_160_, 1, v___x_159_);
v___x_161_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__9));
v___x_162_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_162_, 0, v___x_160_);
lean_ctor_set(v___x_162_, 1, v___x_161_);
v___x_163_ = lean_box(1);
v___x_164_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_164_, 0, v___x_162_);
lean_ctor_set(v___x_164_, 1, v___x_163_);
v___x_165_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__6));
v___x_166_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_166_, 0, v___x_164_);
lean_ctor_set(v___x_166_, 1, v___x_165_);
v___x_167_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_167_, 0, v___x_166_);
lean_ctor_set(v___x_167_, 1, v___x_151_);
v___x_168_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__7, &lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__7_once, _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg___closed__7);
v___x_169_ = l_Nat_reprFast(v_maxDelayTicks_147_);
v___x_170_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_170_, 0, v___x_169_);
v___x_171_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_171_, 0, v___x_168_);
lean_ctor_set(v___x_171_, 1, v___x_170_);
v___x_172_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_172_, 0, v___x_171_);
lean_ctor_set_uint8(v___x_172_, sizeof(void*)*1, v___x_158_);
v___x_173_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_173_, 0, v___x_167_);
lean_ctor_set(v___x_173_, 1, v___x_172_);
v___x_174_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__20, &lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__20_once, _init_lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__20);
v___x_175_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__21));
v___x_176_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_176_, 0, v___x_175_);
lean_ctor_set(v___x_176_, 1, v___x_173_);
v___x_177_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprTransit_repr___redArg___closed__22));
v___x_178_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_178_, 0, v___x_176_);
lean_ctor_set(v___x_178_, 1, v___x_177_);
v___x_179_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_179_, 0, v___x_174_);
lean_ctor_set(v___x_179_, 1, v___x_178_);
v___x_180_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_180_, 0, v___x_179_);
lean_ctor_set_uint8(v___x_180_, sizeof(void*)*1, v___x_158_);
return v___x_180_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr(lean_object* v_x_183_, lean_object* v_prec_184_){
_start:
{
lean_object* v___x_185_; 
v___x_185_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___redArg(v_x_183_);
return v___x_185_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr___boxed(lean_object* v_x_186_, lean_object* v_prec_187_){
_start:
{
lean_object* v_res_188_; 
v_res_188_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_instReprLinkBounds_repr(v_x_186_, v_prec_187_);
lean_dec(v_prec_187_);
return v_res_188_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqLinkBounds_decEq(lean_object* v_x_191_, lean_object* v_x_192_){
_start:
{
lean_object* v_maxSpeedPerTick_193_; lean_object* v_maxDelayTicks_194_; lean_object* v_maxSpeedPerTick_195_; lean_object* v_maxDelayTicks_196_; uint8_t v___x_197_; 
v_maxSpeedPerTick_193_ = lean_ctor_get(v_x_191_, 0);
v_maxDelayTicks_194_ = lean_ctor_get(v_x_191_, 1);
v_maxSpeedPerTick_195_ = lean_ctor_get(v_x_192_, 0);
v_maxDelayTicks_196_ = lean_ctor_get(v_x_192_, 1);
v___x_197_ = lean_nat_dec_eq(v_maxSpeedPerTick_193_, v_maxSpeedPerTick_195_);
if (v___x_197_ == 0)
{
return v___x_197_;
}
else
{
uint8_t v___x_198_; 
v___x_198_ = lean_nat_dec_eq(v_maxDelayTicks_194_, v_maxDelayTicks_196_);
return v___x_198_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqLinkBounds_decEq___boxed(lean_object* v_x_199_, lean_object* v_x_200_){
_start:
{
uint8_t v_res_201_; lean_object* v_r_202_; 
v_res_201_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqLinkBounds_decEq(v_x_199_, v_x_200_);
lean_dec_ref(v_x_200_);
lean_dec_ref(v_x_199_);
v_r_202_ = lean_box(v_res_201_);
return v_r_202_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqLinkBounds(lean_object* v_x_203_, lean_object* v_x_204_){
_start:
{
uint8_t v___x_205_; 
v___x_205_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqLinkBounds_decEq(v_x_203_, v_x_204_);
return v___x_205_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqLinkBounds___boxed(lean_object* v_x_206_, lean_object* v_x_207_){
_start:
{
uint8_t v_res_208_; lean_object* v_r_209_; 
v_res_208_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableEqLinkBounds(v_x_206_, v_x_207_);
lean_dec_ref(v_x_207_);
lean_dec_ref(v_x_206_);
v_r_209_ = lean_box(v_res_208_);
return v_r_209_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableCausallyAdmitted(lean_object* v_env_210_, lean_object* v_p_211_, lean_object* v_t_212_){
_start:
{
lean_object* v_sendTick_213_; lean_object* v_receiveTick_214_; lean_object* v_distance_215_; lean_object* v_epoch_216_; uint8_t v___x_217_; 
v_sendTick_213_ = lean_ctor_get(v_t_212_, 0);
v_receiveTick_214_ = lean_ctor_get(v_t_212_, 1);
v_distance_215_ = lean_ctor_get(v_t_212_, 2);
v_epoch_216_ = lean_ctor_get(v_t_212_, 3);
v___x_217_ = lean_nat_dec_le(v_sendTick_213_, v_receiveTick_214_);
if (v___x_217_ == 0)
{
return v___x_217_;
}
else
{
lean_object* v_maxSpeedPerTick_218_; lean_object* v_maxDelayTicks_219_; lean_object* v___x_220_; lean_object* v___x_221_; uint8_t v___x_222_; 
v_maxSpeedPerTick_218_ = lean_ctor_get(v_env_210_, 0);
v_maxDelayTicks_219_ = lean_ctor_get(v_env_210_, 1);
v___x_220_ = lean_nat_sub(v_receiveTick_214_, v_sendTick_213_);
v___x_221_ = lean_nat_mul(v_maxSpeedPerTick_218_, v___x_220_);
lean_dec(v___x_220_);
v___x_222_ = lean_nat_dec_le(v_distance_215_, v___x_221_);
lean_dec(v___x_221_);
if (v___x_222_ == 0)
{
return v___x_222_;
}
else
{
lean_object* v___x_223_; uint8_t v___x_224_; 
v___x_223_ = lean_nat_add(v_sendTick_213_, v_maxDelayTicks_219_);
v___x_224_ = lean_nat_dec_le(v_receiveTick_214_, v___x_223_);
lean_dec(v___x_223_);
if (v___x_224_ == 0)
{
return v___x_224_;
}
else
{
lean_object* v_epoch_225_; uint8_t v___x_226_; 
v_epoch_225_ = lean_ctor_get(v_p_211_, 0);
v___x_226_ = lean_nat_dec_eq(v_epoch_216_, v_epoch_225_);
return v___x_226_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableCausallyAdmitted___boxed(lean_object* v_env_227_, lean_object* v_p_228_, lean_object* v_t_229_){
_start:
{
uint8_t v_res_230_; lean_object* v_r_231_; 
v_res_230_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableCausallyAdmitted(v_env_227_, v_p_228_, v_t_229_);
lean_dec_ref(v_t_229_);
lean_dec_ref(v_p_228_);
lean_dec_ref(v_env_227_);
v_r_231_ = lean_box(v_res_230_);
return v_r_231_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_fieldPermit(lean_object* v_authCheck_232_, lean_object* v_env_233_, lean_object* v_session_234_, lean_object* v_packet_235_, lean_object* v_t_236_){
_start:
{
uint8_t v___x_237_; 
lean_inc_ref(v_packet_235_);
v___x_237_ = lp_physical__bridges_PhysicalBridges_IRA1PacketIngress_permit(v_authCheck_232_, v_session_234_, v_packet_235_);
if (v___x_237_ == 0)
{
lean_dec_ref(v_packet_235_);
return v___x_237_;
}
else
{
uint8_t v___x_238_; 
v___x_238_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_instDecidableCausallyAdmitted(v_env_233_, v_packet_235_, v_t_236_);
lean_dec_ref(v_packet_235_);
return v___x_238_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_fieldPermit___boxed(lean_object* v_authCheck_239_, lean_object* v_env_240_, lean_object* v_session_241_, lean_object* v_packet_242_, lean_object* v_t_243_){
_start:
{
uint8_t v_res_244_; lean_object* v_r_245_; 
v_res_244_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_fieldPermit(v_authCheck_239_, v_env_240_, v_session_241_, v_packet_242_, v_t_243_);
lean_dec_ref(v_t_243_);
lean_dec_ref(v_session_241_);
lean_dec_ref(v_env_240_);
v_r_245_ = lean_box(v_res_244_);
return v_r_245_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_ingestField(lean_object* v_authCheck_246_, lean_object* v_env_247_, lean_object* v_session_248_, lean_object* v_packet_249_, lean_object* v_transit_250_){
_start:
{
uint8_t v___x_251_; 
lean_inc_ref(v_packet_249_);
lean_inc_ref(v_authCheck_246_);
v___x_251_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_fieldPermit(v_authCheck_246_, v_env_247_, v_session_248_, v_packet_249_, v_transit_250_);
if (v___x_251_ == 0)
{
lean_dec_ref(v_packet_249_);
lean_dec_ref(v_authCheck_246_);
return v_session_248_;
}
else
{
lean_object* v___x_252_; 
v___x_252_ = lp_physical__bridges_PhysicalBridges_IRA1PacketIngress_ingest(v_authCheck_246_, v_session_248_, v_packet_249_);
return v___x_252_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_ingestField___boxed(lean_object* v_authCheck_253_, lean_object* v_env_254_, lean_object* v_session_255_, lean_object* v_packet_256_, lean_object* v_transit_257_){
_start:
{
lean_object* v_res_258_; 
v_res_258_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_ingestField(v_authCheck_253_, v_env_254_, v_session_255_, v_packet_256_, v_transit_257_);
lean_dec_ref(v_transit_257_);
lean_dec_ref(v_env_254_);
return v_res_258_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1CausalField_runField_spec__0(lean_object* v_authCheck_259_, lean_object* v_env_260_, lean_object* v_x_261_, lean_object* v_x_262_){
_start:
{
if (lean_obj_tag(v_x_262_) == 0)
{
lean_dec_ref(v_authCheck_259_);
return v_x_261_;
}
else
{
lean_object* v_head_263_; lean_object* v_tail_264_; lean_object* v_packet_265_; lean_object* v_transit_266_; lean_object* v___x_267_; 
v_head_263_ = lean_ctor_get(v_x_262_, 0);
lean_inc(v_head_263_);
v_tail_264_ = lean_ctor_get(v_x_262_, 1);
lean_inc(v_tail_264_);
lean_dec_ref_known(v_x_262_, 2);
v_packet_265_ = lean_ctor_get(v_head_263_, 0);
lean_inc_ref(v_packet_265_);
v_transit_266_ = lean_ctor_get(v_head_263_, 1);
lean_inc_ref(v_transit_266_);
lean_dec(v_head_263_);
lean_inc_ref(v_authCheck_259_);
v___x_267_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_ingestField(v_authCheck_259_, v_env_260_, v_x_261_, v_packet_265_, v_transit_266_);
lean_dec_ref(v_transit_266_);
v_x_261_ = v___x_267_;
v_x_262_ = v_tail_264_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1CausalField_runField_spec__0___boxed(lean_object* v_authCheck_269_, lean_object* v_env_270_, lean_object* v_x_271_, lean_object* v_x_272_){
_start:
{
lean_object* v_res_273_; 
v_res_273_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1CausalField_runField_spec__0(v_authCheck_269_, v_env_270_, v_x_271_, v_x_272_);
lean_dec_ref(v_env_270_);
return v_res_273_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_runField(lean_object* v_authCheck_274_, lean_object* v_env_275_, lean_object* v_s_276_, lean_object* v_events_277_){
_start:
{
lean_object* v___x_278_; 
v___x_278_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1CausalField_runField_spec__0(v_authCheck_274_, v_env_275_, v_s_276_, v_events_277_);
return v___x_278_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_runField___boxed(lean_object* v_authCheck_279_, lean_object* v_env_280_, lean_object* v_s_281_, lean_object* v_events_282_){
_start:
{
lean_object* v_res_283_; 
v_res_283_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_runField(v_authCheck_279_, v_env_280_, v_s_281_, v_events_282_);
lean_dec_ref(v_env_280_);
return v_res_283_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRA1PacketIngress(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRA1CausalField(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRA1PacketIngress(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
