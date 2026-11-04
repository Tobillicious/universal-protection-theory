// Lean compiler output
// Module: PhysicalBridges.IRTypedTraceChecker
// Imports: public import Init public meta import Init public import PhysicalBridges.IREnergyReplenishment
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
lean_object* lean_nat_to_int(lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
uint8_t lean_int_dec_le(lean_object*, lean_object*);
lean_object* lean_int_add(lean_object*, lean_object*);
lean_object* lean_int_sub(lean_object*, lean_object*);
uint8_t lean_int_dec_eq(lean_object*, lean_object*);
lean_object* l_Nat_reprFast(lean_object*);
lean_object* lean_string_length(lean_object*);
uint8_t lean_int_dec_lt(lean_object*, lean_object*);
lean_object* l_Int_repr(lean_object*);
lean_object* l_Repr_addAppParen(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "{ "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 10, .m_capacity = 10, .m_length = 9, .m_data = "timestamp"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__1_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__2_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__2_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__3_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = " := "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__4 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__4_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__4_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__5_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__3_value),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__6_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__7;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = " }"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__8 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__8_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__9_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__9;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__10_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__10;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__11 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__11_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__12_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__8_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__12 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__12_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__13_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = ","};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__13 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__13_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__14_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__13_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__14 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__14_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__15_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 10, .m_capacity = 10, .m_length = 9, .m_data = "drainRate"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__15 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__15_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__16_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__15_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__16 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__16_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__18_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 11, .m_capacity = 11, .m_length = 10, .m_data = "powerInput"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__18 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__18_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__19_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__18_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__19 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__19_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__20_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__20;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__21_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 15, .m_capacity = 15, .m_length = 14, .m_data = "measuredEnergy"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__21 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__21_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__22_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__21_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__22 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__22_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__23_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__23;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__24_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 14, .m_capacity = 14, .m_length = 13, .m_data = "measuredValue"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__24 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__24_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__25_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__24_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__25 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__25_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__26_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__26;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord___closed__0_value;
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqTelemetryRecord_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqTelemetryRecord_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqTelemetryRecord(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqTelemetryRecord___boxed(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = "reserve"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__0_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__1_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__2_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__2_value),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__3_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__4_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__4;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 6, .m_capacity = 6, .m_length = 5, .m_data = "kappa"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__5_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__6_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__7;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig___closed__0_value;
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqCheckConfig_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqCheckConfig_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqCheckConfig(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqCheckConfig___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableInitialValid(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableInitialValid___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableStepValid(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableStepValid___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_checkStep(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_checkStep___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_checkSegments(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_checkSegments___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_verifyTraceData(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_verifyTraceData___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRTypedTraceChecker_0__PhysicalBridges_IRTypedTraceChecker_CheckSegments_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRTypedTraceChecker_0__PhysicalBridges_IRTypedTraceChecker_CheckSegments_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*);
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__0;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__1;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__2;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__0;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__1;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__2;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__0;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__1;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__2;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__3_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__3;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird___closed__0;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird___closed__1;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__0;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__1_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__1;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__2_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__2;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_badInitial___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_badInitial___closed__0;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_badInitial;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_insufficientSupplyRecord___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_insufficientSupplyRecord___closed__0;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_insufficientSupplyRecord;
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__7(void){
_start:
{
lean_object* v___x_14_; lean_object* v___x_15_; 
v___x_14_ = lean_unsigned_to_nat(13u);
v___x_15_ = lean_nat_to_int(v___x_14_);
return v___x_15_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__9(void){
_start:
{
lean_object* v___x_17_; lean_object* v___x_18_; 
v___x_17_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__0));
v___x_18_ = lean_string_length(v___x_17_);
return v___x_18_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__10(void){
_start:
{
lean_object* v___x_19_; lean_object* v___x_20_; 
v___x_19_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__9, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__9_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__9);
v___x_20_ = lean_nat_to_int(v___x_19_);
return v___x_20_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17(void){
_start:
{
lean_object* v___x_31_; lean_object* v___x_32_; 
v___x_31_ = lean_unsigned_to_nat(0u);
v___x_32_ = lean_nat_to_int(v___x_31_);
return v___x_32_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__20(void){
_start:
{
lean_object* v___x_36_; lean_object* v___x_37_; 
v___x_36_ = lean_unsigned_to_nat(14u);
v___x_37_ = lean_nat_to_int(v___x_36_);
return v___x_37_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__23(void){
_start:
{
lean_object* v___x_41_; lean_object* v___x_42_; 
v___x_41_ = lean_unsigned_to_nat(18u);
v___x_42_ = lean_nat_to_int(v___x_41_);
return v___x_42_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__26(void){
_start:
{
lean_object* v___x_46_; lean_object* v___x_47_; 
v___x_46_ = lean_unsigned_to_nat(17u);
v___x_47_ = lean_nat_to_int(v___x_46_);
return v___x_47_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg(lean_object* v_x_48_){
_start:
{
lean_object* v_timestamp_49_; lean_object* v_measuredEnergy_50_; lean_object* v_measuredValue_51_; lean_object* v_powerInput_52_; lean_object* v_drainRate_53_; lean_object* v___x_54_; lean_object* v___x_55_; lean_object* v___x_56_; lean_object* v___x_57_; lean_object* v___x_58_; lean_object* v___x_59_; uint8_t v___x_60_; lean_object* v___y_62_; lean_object* v___y_63_; lean_object* v___x_74_; lean_object* v___x_75_; lean_object* v___x_76_; lean_object* v___x_77_; lean_object* v___x_78_; lean_object* v___y_80_; lean_object* v___y_81_; lean_object* v___y_82_; lean_object* v___y_100_; lean_object* v___y_101_; lean_object* v___y_102_; lean_object* v___x_120_; lean_object* v___x_121_; lean_object* v___x_122_; lean_object* v___x_123_; lean_object* v___x_124_; lean_object* v___y_126_; lean_object* v___x_144_; lean_object* v___x_145_; uint8_t v___x_146_; 
v_timestamp_49_ = lean_ctor_get(v_x_48_, 0);
lean_inc(v_timestamp_49_);
v_measuredEnergy_50_ = lean_ctor_get(v_x_48_, 1);
lean_inc(v_measuredEnergy_50_);
v_measuredValue_51_ = lean_ctor_get(v_x_48_, 2);
lean_inc(v_measuredValue_51_);
v_powerInput_52_ = lean_ctor_get(v_x_48_, 3);
lean_inc(v_powerInput_52_);
v_drainRate_53_ = lean_ctor_get(v_x_48_, 4);
lean_inc(v_drainRate_53_);
lean_dec_ref(v_x_48_);
v___x_54_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__5));
v___x_55_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__6));
v___x_56_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__7, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__7_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__7);
v___x_57_ = l_Nat_reprFast(v_timestamp_49_);
v___x_58_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_58_, 0, v___x_57_);
v___x_59_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_59_, 0, v___x_56_);
lean_ctor_set(v___x_59_, 1, v___x_58_);
v___x_60_ = 0;
v___x_74_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_74_, 0, v___x_59_);
lean_ctor_set_uint8(v___x_74_, sizeof(void*)*1, v___x_60_);
v___x_75_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_75_, 0, v___x_55_);
lean_ctor_set(v___x_75_, 1, v___x_74_);
v___x_76_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__14));
v___x_77_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_77_, 0, v___x_75_);
lean_ctor_set(v___x_77_, 1, v___x_76_);
v___x_78_ = lean_box(1);
v___x_120_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_120_, 0, v___x_77_);
lean_ctor_set(v___x_120_, 1, v___x_78_);
v___x_121_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__22));
v___x_122_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_122_, 0, v___x_120_);
lean_ctor_set(v___x_122_, 1, v___x_121_);
v___x_123_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_123_, 0, v___x_122_);
lean_ctor_set(v___x_123_, 1, v___x_54_);
v___x_124_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__23, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__23_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__23);
v___x_144_ = lean_unsigned_to_nat(0u);
v___x_145_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17);
v___x_146_ = lean_int_dec_lt(v_measuredEnergy_50_, v___x_145_);
if (v___x_146_ == 0)
{
lean_object* v___x_147_; lean_object* v___x_148_; 
v___x_147_ = l_Int_repr(v_measuredEnergy_50_);
lean_dec(v_measuredEnergy_50_);
v___x_148_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_148_, 0, v___x_147_);
v___y_126_ = v___x_148_;
goto v___jp_125_;
}
else
{
lean_object* v___x_149_; lean_object* v___x_150_; lean_object* v___x_151_; 
v___x_149_ = l_Int_repr(v_measuredEnergy_50_);
lean_dec(v_measuredEnergy_50_);
v___x_150_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_150_, 0, v___x_149_);
v___x_151_ = l_Repr_addAppParen(v___x_150_, v___x_144_);
v___y_126_ = v___x_151_;
goto v___jp_125_;
}
v___jp_61_:
{
lean_object* v___x_64_; lean_object* v___x_65_; lean_object* v___x_66_; lean_object* v___x_67_; lean_object* v___x_68_; lean_object* v___x_69_; lean_object* v___x_70_; lean_object* v___x_71_; lean_object* v___x_72_; lean_object* v___x_73_; 
v___x_64_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_64_, 0, v___x_56_);
lean_ctor_set(v___x_64_, 1, v___y_63_);
v___x_65_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_65_, 0, v___x_64_);
lean_ctor_set_uint8(v___x_65_, sizeof(void*)*1, v___x_60_);
v___x_66_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_66_, 0, v___y_62_);
lean_ctor_set(v___x_66_, 1, v___x_65_);
v___x_67_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__10, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__10_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__10);
v___x_68_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__11));
v___x_69_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_69_, 0, v___x_68_);
lean_ctor_set(v___x_69_, 1, v___x_66_);
v___x_70_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__12));
v___x_71_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_71_, 0, v___x_69_);
lean_ctor_set(v___x_71_, 1, v___x_70_);
v___x_72_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_72_, 0, v___x_67_);
lean_ctor_set(v___x_72_, 1, v___x_71_);
v___x_73_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_73_, 0, v___x_72_);
lean_ctor_set_uint8(v___x_73_, sizeof(void*)*1, v___x_60_);
return v___x_73_;
}
v___jp_79_:
{
lean_object* v___x_83_; lean_object* v___x_84_; lean_object* v___x_85_; lean_object* v___x_86_; lean_object* v___x_87_; lean_object* v___x_88_; lean_object* v___x_89_; lean_object* v___x_90_; lean_object* v___x_91_; lean_object* v___x_92_; uint8_t v___x_93_; 
lean_inc(v___y_80_);
v___x_83_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_83_, 0, v___y_80_);
lean_ctor_set(v___x_83_, 1, v___y_82_);
v___x_84_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_84_, 0, v___x_83_);
lean_ctor_set_uint8(v___x_84_, sizeof(void*)*1, v___x_60_);
v___x_85_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_85_, 0, v___y_81_);
lean_ctor_set(v___x_85_, 1, v___x_84_);
v___x_86_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_86_, 0, v___x_85_);
lean_ctor_set(v___x_86_, 1, v___x_76_);
v___x_87_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_87_, 0, v___x_86_);
lean_ctor_set(v___x_87_, 1, v___x_78_);
v___x_88_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__16));
v___x_89_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_89_, 0, v___x_87_);
lean_ctor_set(v___x_89_, 1, v___x_88_);
v___x_90_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_90_, 0, v___x_89_);
lean_ctor_set(v___x_90_, 1, v___x_54_);
v___x_91_ = lean_unsigned_to_nat(0u);
v___x_92_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17);
v___x_93_ = lean_int_dec_lt(v_drainRate_53_, v___x_92_);
if (v___x_93_ == 0)
{
lean_object* v___x_94_; lean_object* v___x_95_; 
v___x_94_ = l_Int_repr(v_drainRate_53_);
lean_dec(v_drainRate_53_);
v___x_95_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_95_, 0, v___x_94_);
v___y_62_ = v___x_90_;
v___y_63_ = v___x_95_;
goto v___jp_61_;
}
else
{
lean_object* v___x_96_; lean_object* v___x_97_; lean_object* v___x_98_; 
v___x_96_ = l_Int_repr(v_drainRate_53_);
lean_dec(v_drainRate_53_);
v___x_97_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_97_, 0, v___x_96_);
v___x_98_ = l_Repr_addAppParen(v___x_97_, v___x_91_);
v___y_62_ = v___x_90_;
v___y_63_ = v___x_98_;
goto v___jp_61_;
}
}
v___jp_99_:
{
lean_object* v___x_103_; lean_object* v___x_104_; lean_object* v___x_105_; lean_object* v___x_106_; lean_object* v___x_107_; lean_object* v___x_108_; lean_object* v___x_109_; lean_object* v___x_110_; lean_object* v___x_111_; lean_object* v___x_112_; lean_object* v___x_113_; uint8_t v___x_114_; 
lean_inc(v___y_100_);
v___x_103_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_103_, 0, v___y_100_);
lean_ctor_set(v___x_103_, 1, v___y_102_);
v___x_104_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_104_, 0, v___x_103_);
lean_ctor_set_uint8(v___x_104_, sizeof(void*)*1, v___x_60_);
v___x_105_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_105_, 0, v___y_101_);
lean_ctor_set(v___x_105_, 1, v___x_104_);
v___x_106_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_106_, 0, v___x_105_);
lean_ctor_set(v___x_106_, 1, v___x_76_);
v___x_107_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_107_, 0, v___x_106_);
lean_ctor_set(v___x_107_, 1, v___x_78_);
v___x_108_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__19));
v___x_109_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_109_, 0, v___x_107_);
lean_ctor_set(v___x_109_, 1, v___x_108_);
v___x_110_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_110_, 0, v___x_109_);
lean_ctor_set(v___x_110_, 1, v___x_54_);
v___x_111_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__20, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__20_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__20);
v___x_112_ = lean_unsigned_to_nat(0u);
v___x_113_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17);
v___x_114_ = lean_int_dec_lt(v_powerInput_52_, v___x_113_);
if (v___x_114_ == 0)
{
lean_object* v___x_115_; lean_object* v___x_116_; 
v___x_115_ = l_Int_repr(v_powerInput_52_);
lean_dec(v_powerInput_52_);
v___x_116_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_116_, 0, v___x_115_);
v___y_80_ = v___x_111_;
v___y_81_ = v___x_110_;
v___y_82_ = v___x_116_;
goto v___jp_79_;
}
else
{
lean_object* v___x_117_; lean_object* v___x_118_; lean_object* v___x_119_; 
v___x_117_ = l_Int_repr(v_powerInput_52_);
lean_dec(v_powerInput_52_);
v___x_118_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_118_, 0, v___x_117_);
v___x_119_ = l_Repr_addAppParen(v___x_118_, v___x_112_);
v___y_80_ = v___x_111_;
v___y_81_ = v___x_110_;
v___y_82_ = v___x_119_;
goto v___jp_79_;
}
}
v___jp_125_:
{
lean_object* v___x_127_; lean_object* v___x_128_; lean_object* v___x_129_; lean_object* v___x_130_; lean_object* v___x_131_; lean_object* v___x_132_; lean_object* v___x_133_; lean_object* v___x_134_; lean_object* v___x_135_; lean_object* v___x_136_; lean_object* v___x_137_; uint8_t v___x_138_; 
v___x_127_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_127_, 0, v___x_124_);
lean_ctor_set(v___x_127_, 1, v___y_126_);
v___x_128_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_128_, 0, v___x_127_);
lean_ctor_set_uint8(v___x_128_, sizeof(void*)*1, v___x_60_);
v___x_129_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_129_, 0, v___x_123_);
lean_ctor_set(v___x_129_, 1, v___x_128_);
v___x_130_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_130_, 0, v___x_129_);
lean_ctor_set(v___x_130_, 1, v___x_76_);
v___x_131_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_131_, 0, v___x_130_);
lean_ctor_set(v___x_131_, 1, v___x_78_);
v___x_132_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__25));
v___x_133_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_133_, 0, v___x_131_);
lean_ctor_set(v___x_133_, 1, v___x_132_);
v___x_134_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_134_, 0, v___x_133_);
lean_ctor_set(v___x_134_, 1, v___x_54_);
v___x_135_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__26, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__26_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__26);
v___x_136_ = lean_unsigned_to_nat(0u);
v___x_137_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17);
v___x_138_ = lean_int_dec_lt(v_measuredValue_51_, v___x_137_);
if (v___x_138_ == 0)
{
lean_object* v___x_139_; lean_object* v___x_140_; 
v___x_139_ = l_Int_repr(v_measuredValue_51_);
lean_dec(v_measuredValue_51_);
v___x_140_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_140_, 0, v___x_139_);
v___y_100_ = v___x_135_;
v___y_101_ = v___x_134_;
v___y_102_ = v___x_140_;
goto v___jp_99_;
}
else
{
lean_object* v___x_141_; lean_object* v___x_142_; lean_object* v___x_143_; 
v___x_141_ = l_Int_repr(v_measuredValue_51_);
lean_dec(v_measuredValue_51_);
v___x_142_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_142_, 0, v___x_141_);
v___x_143_ = l_Repr_addAppParen(v___x_142_, v___x_136_);
v___y_100_ = v___x_135_;
v___y_101_ = v___x_134_;
v___y_102_ = v___x_143_;
goto v___jp_99_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr(lean_object* v_x_152_, lean_object* v_prec_153_){
_start:
{
lean_object* v___x_154_; 
v___x_154_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg(v_x_152_);
return v___x_154_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___boxed(lean_object* v_x_155_, lean_object* v_prec_156_){
_start:
{
lean_object* v_res_157_; 
v_res_157_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr(v_x_155_, v_prec_156_);
lean_dec(v_prec_156_);
return v_res_157_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqTelemetryRecord_decEq(lean_object* v_x_160_, lean_object* v_x_161_){
_start:
{
lean_object* v_timestamp_162_; lean_object* v_measuredEnergy_163_; lean_object* v_measuredValue_164_; lean_object* v_powerInput_165_; lean_object* v_drainRate_166_; lean_object* v_timestamp_167_; lean_object* v_measuredEnergy_168_; lean_object* v_measuredValue_169_; lean_object* v_powerInput_170_; lean_object* v_drainRate_171_; uint8_t v___x_172_; 
v_timestamp_162_ = lean_ctor_get(v_x_160_, 0);
v_measuredEnergy_163_ = lean_ctor_get(v_x_160_, 1);
v_measuredValue_164_ = lean_ctor_get(v_x_160_, 2);
v_powerInput_165_ = lean_ctor_get(v_x_160_, 3);
v_drainRate_166_ = lean_ctor_get(v_x_160_, 4);
v_timestamp_167_ = lean_ctor_get(v_x_161_, 0);
v_measuredEnergy_168_ = lean_ctor_get(v_x_161_, 1);
v_measuredValue_169_ = lean_ctor_get(v_x_161_, 2);
v_powerInput_170_ = lean_ctor_get(v_x_161_, 3);
v_drainRate_171_ = lean_ctor_get(v_x_161_, 4);
v___x_172_ = lean_nat_dec_eq(v_timestamp_162_, v_timestamp_167_);
if (v___x_172_ == 0)
{
return v___x_172_;
}
else
{
uint8_t v___x_173_; 
v___x_173_ = lean_int_dec_eq(v_measuredEnergy_163_, v_measuredEnergy_168_);
if (v___x_173_ == 0)
{
return v___x_173_;
}
else
{
uint8_t v___x_174_; 
v___x_174_ = lean_int_dec_eq(v_measuredValue_164_, v_measuredValue_169_);
if (v___x_174_ == 0)
{
return v___x_174_;
}
else
{
uint8_t v___x_175_; 
v___x_175_ = lean_int_dec_eq(v_powerInput_165_, v_powerInput_170_);
if (v___x_175_ == 0)
{
return v___x_175_;
}
else
{
uint8_t v___x_176_; 
v___x_176_ = lean_int_dec_eq(v_drainRate_166_, v_drainRate_171_);
return v___x_176_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqTelemetryRecord_decEq___boxed(lean_object* v_x_177_, lean_object* v_x_178_){
_start:
{
uint8_t v_res_179_; lean_object* v_r_180_; 
v_res_179_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqTelemetryRecord_decEq(v_x_177_, v_x_178_);
lean_dec_ref(v_x_178_);
lean_dec_ref(v_x_177_);
v_r_180_ = lean_box(v_res_179_);
return v_r_180_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqTelemetryRecord(lean_object* v_x_181_, lean_object* v_x_182_){
_start:
{
uint8_t v___x_183_; 
v___x_183_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqTelemetryRecord_decEq(v_x_181_, v_x_182_);
return v___x_183_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqTelemetryRecord___boxed(lean_object* v_x_184_, lean_object* v_x_185_){
_start:
{
uint8_t v_res_186_; lean_object* v_r_187_; 
v_res_186_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqTelemetryRecord(v_x_184_, v_x_185_);
lean_dec_ref(v_x_185_);
lean_dec_ref(v_x_184_);
v_r_187_ = lean_box(v_res_186_);
return v_r_187_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__4(void){
_start:
{
lean_object* v___x_197_; lean_object* v___x_198_; 
v___x_197_ = lean_unsigned_to_nat(11u);
v___x_198_ = lean_nat_to_int(v___x_197_);
return v___x_198_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__7(void){
_start:
{
lean_object* v___x_202_; lean_object* v___x_203_; 
v___x_202_ = lean_unsigned_to_nat(9u);
v___x_203_ = lean_nat_to_int(v___x_202_);
return v___x_203_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg(lean_object* v_x_204_){
_start:
{
lean_object* v_reserve_205_; lean_object* v_kappa_206_; lean_object* v___x_208_; uint8_t v_isShared_209_; uint8_t v_isSharedCheck_260_; 
v_reserve_205_ = lean_ctor_get(v_x_204_, 0);
v_kappa_206_ = lean_ctor_get(v_x_204_, 1);
v_isSharedCheck_260_ = !lean_is_exclusive(v_x_204_);
if (v_isSharedCheck_260_ == 0)
{
v___x_208_ = v_x_204_;
v_isShared_209_ = v_isSharedCheck_260_;
goto v_resetjp_207_;
}
else
{
lean_inc(v_kappa_206_);
lean_inc(v_reserve_205_);
lean_dec(v_x_204_);
v___x_208_ = lean_box(0);
v_isShared_209_ = v_isSharedCheck_260_;
goto v_resetjp_207_;
}
v_resetjp_207_:
{
uint8_t v___y_211_; lean_object* v___y_212_; lean_object* v___y_213_; lean_object* v___y_214_; lean_object* v___x_227_; lean_object* v___x_228_; lean_object* v___x_229_; lean_object* v___y_231_; lean_object* v___x_252_; lean_object* v___x_253_; uint8_t v___x_254_; 
v___x_227_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__5));
v___x_228_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__3));
v___x_229_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__4, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__4_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__4);
v___x_252_ = lean_unsigned_to_nat(0u);
v___x_253_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17);
v___x_254_ = lean_int_dec_lt(v_reserve_205_, v___x_253_);
if (v___x_254_ == 0)
{
lean_object* v___x_255_; lean_object* v___x_256_; 
v___x_255_ = l_Int_repr(v_reserve_205_);
lean_dec(v_reserve_205_);
v___x_256_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_256_, 0, v___x_255_);
v___y_231_ = v___x_256_;
goto v___jp_230_;
}
else
{
lean_object* v___x_257_; lean_object* v___x_258_; lean_object* v___x_259_; 
v___x_257_ = l_Int_repr(v_reserve_205_);
lean_dec(v_reserve_205_);
v___x_258_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_258_, 0, v___x_257_);
v___x_259_ = l_Repr_addAppParen(v___x_258_, v___x_252_);
v___y_231_ = v___x_259_;
goto v___jp_230_;
}
v___jp_210_:
{
lean_object* v___x_216_; 
lean_inc(v___y_213_);
if (v_isShared_209_ == 0)
{
lean_ctor_set_tag(v___x_208_, 4);
lean_ctor_set(v___x_208_, 1, v___y_214_);
lean_ctor_set(v___x_208_, 0, v___y_213_);
v___x_216_ = v___x_208_;
goto v_reusejp_215_;
}
else
{
lean_object* v_reuseFailAlloc_226_; 
v_reuseFailAlloc_226_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v_reuseFailAlloc_226_, 0, v___y_213_);
lean_ctor_set(v_reuseFailAlloc_226_, 1, v___y_214_);
v___x_216_ = v_reuseFailAlloc_226_;
goto v_reusejp_215_;
}
v_reusejp_215_:
{
lean_object* v___x_217_; lean_object* v___x_218_; lean_object* v___x_219_; lean_object* v___x_220_; lean_object* v___x_221_; lean_object* v___x_222_; lean_object* v___x_223_; lean_object* v___x_224_; lean_object* v___x_225_; 
v___x_217_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_217_, 0, v___x_216_);
lean_ctor_set_uint8(v___x_217_, sizeof(void*)*1, v___y_211_);
v___x_218_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_218_, 0, v___y_212_);
lean_ctor_set(v___x_218_, 1, v___x_217_);
v___x_219_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__10, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__10_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__10);
v___x_220_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__11));
v___x_221_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_221_, 0, v___x_220_);
lean_ctor_set(v___x_221_, 1, v___x_218_);
v___x_222_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__12));
v___x_223_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_223_, 0, v___x_221_);
lean_ctor_set(v___x_223_, 1, v___x_222_);
v___x_224_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_224_, 0, v___x_219_);
lean_ctor_set(v___x_224_, 1, v___x_223_);
v___x_225_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_225_, 0, v___x_224_);
lean_ctor_set_uint8(v___x_225_, sizeof(void*)*1, v___y_211_);
return v___x_225_;
}
}
v___jp_230_:
{
lean_object* v___x_232_; uint8_t v___x_233_; lean_object* v___x_234_; lean_object* v___x_235_; lean_object* v___x_236_; lean_object* v___x_237_; lean_object* v___x_238_; lean_object* v___x_239_; lean_object* v___x_240_; lean_object* v___x_241_; lean_object* v___x_242_; lean_object* v___x_243_; lean_object* v___x_244_; lean_object* v___x_245_; uint8_t v___x_246_; 
v___x_232_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_232_, 0, v___x_229_);
lean_ctor_set(v___x_232_, 1, v___y_231_);
v___x_233_ = 0;
v___x_234_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_234_, 0, v___x_232_);
lean_ctor_set_uint8(v___x_234_, sizeof(void*)*1, v___x_233_);
v___x_235_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_235_, 0, v___x_228_);
lean_ctor_set(v___x_235_, 1, v___x_234_);
v___x_236_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__14));
v___x_237_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_237_, 0, v___x_235_);
lean_ctor_set(v___x_237_, 1, v___x_236_);
v___x_238_ = lean_box(1);
v___x_239_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_239_, 0, v___x_237_);
lean_ctor_set(v___x_239_, 1, v___x_238_);
v___x_240_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__6));
v___x_241_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_241_, 0, v___x_239_);
lean_ctor_set(v___x_241_, 1, v___x_240_);
v___x_242_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_242_, 0, v___x_241_);
lean_ctor_set(v___x_242_, 1, v___x_227_);
v___x_243_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__7, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__7_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__7);
v___x_244_ = lean_unsigned_to_nat(0u);
v___x_245_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17);
v___x_246_ = lean_int_dec_lt(v_kappa_206_, v___x_245_);
if (v___x_246_ == 0)
{
lean_object* v___x_247_; lean_object* v___x_248_; 
v___x_247_ = l_Int_repr(v_kappa_206_);
lean_dec(v_kappa_206_);
v___x_248_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_248_, 0, v___x_247_);
v___y_211_ = v___x_233_;
v___y_212_ = v___x_242_;
v___y_213_ = v___x_243_;
v___y_214_ = v___x_248_;
goto v___jp_210_;
}
else
{
lean_object* v___x_249_; lean_object* v___x_250_; lean_object* v___x_251_; 
v___x_249_ = l_Int_repr(v_kappa_206_);
lean_dec(v_kappa_206_);
v___x_250_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_250_, 0, v___x_249_);
v___x_251_ = l_Repr_addAppParen(v___x_250_, v___x_244_);
v___y_211_ = v___x_233_;
v___y_212_ = v___x_242_;
v___y_213_ = v___x_243_;
v___y_214_ = v___x_251_;
goto v___jp_210_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr(lean_object* v_x_261_, lean_object* v_prec_262_){
_start:
{
lean_object* v___x_263_; 
v___x_263_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg(v_x_261_);
return v___x_263_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___boxed(lean_object* v_x_264_, lean_object* v_prec_265_){
_start:
{
lean_object* v_res_266_; 
v_res_266_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr(v_x_264_, v_prec_265_);
lean_dec(v_prec_265_);
return v_res_266_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqCheckConfig_decEq(lean_object* v_x_269_, lean_object* v_x_270_){
_start:
{
lean_object* v_reserve_271_; lean_object* v_kappa_272_; lean_object* v_reserve_273_; lean_object* v_kappa_274_; uint8_t v___x_275_; 
v_reserve_271_ = lean_ctor_get(v_x_269_, 0);
v_kappa_272_ = lean_ctor_get(v_x_269_, 1);
v_reserve_273_ = lean_ctor_get(v_x_270_, 0);
v_kappa_274_ = lean_ctor_get(v_x_270_, 1);
v___x_275_ = lean_int_dec_eq(v_reserve_271_, v_reserve_273_);
if (v___x_275_ == 0)
{
return v___x_275_;
}
else
{
uint8_t v___x_276_; 
v___x_276_ = lean_int_dec_eq(v_kappa_272_, v_kappa_274_);
return v___x_276_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqCheckConfig_decEq___boxed(lean_object* v_x_277_, lean_object* v_x_278_){
_start:
{
uint8_t v_res_279_; lean_object* v_r_280_; 
v_res_279_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqCheckConfig_decEq(v_x_277_, v_x_278_);
lean_dec_ref(v_x_278_);
lean_dec_ref(v_x_277_);
v_r_280_ = lean_box(v_res_279_);
return v_r_280_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqCheckConfig(lean_object* v_x_281_, lean_object* v_x_282_){
_start:
{
uint8_t v___x_283_; 
v___x_283_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqCheckConfig_decEq(v_x_281_, v_x_282_);
return v___x_283_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqCheckConfig___boxed(lean_object* v_x_284_, lean_object* v_x_285_){
_start:
{
uint8_t v_res_286_; lean_object* v_r_287_; 
v_res_286_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableEqCheckConfig(v_x_284_, v_x_285_);
lean_dec_ref(v_x_285_);
lean_dec_ref(v_x_284_);
v_r_287_ = lean_box(v_res_286_);
return v_r_287_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableInitialValid(lean_object* v_cfg_288_, lean_object* v_r_289_){
_start:
{
lean_object* v_timestamp_290_; lean_object* v_measuredEnergy_291_; lean_object* v_powerInput_292_; lean_object* v_drainRate_293_; lean_object* v___x_294_; uint8_t v___x_295_; 
v_timestamp_290_ = lean_ctor_get(v_r_289_, 0);
v_measuredEnergy_291_ = lean_ctor_get(v_r_289_, 1);
v_powerInput_292_ = lean_ctor_get(v_r_289_, 3);
v_drainRate_293_ = lean_ctor_get(v_r_289_, 4);
v___x_294_ = lean_unsigned_to_nat(0u);
v___x_295_ = lean_nat_dec_eq(v_timestamp_290_, v___x_294_);
if (v___x_295_ == 0)
{
return v___x_295_;
}
else
{
lean_object* v___x_296_; uint8_t v___x_297_; 
v___x_296_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17);
v___x_297_ = lean_int_dec_eq(v_powerInput_292_, v___x_296_);
if (v___x_297_ == 0)
{
return v___x_297_;
}
else
{
uint8_t v___x_298_; 
v___x_298_ = lean_int_dec_eq(v_drainRate_293_, v___x_296_);
if (v___x_298_ == 0)
{
return v___x_298_;
}
else
{
lean_object* v_reserve_299_; uint8_t v___x_300_; 
v_reserve_299_ = lean_ctor_get(v_cfg_288_, 0);
v___x_300_ = lean_int_dec_le(v_reserve_299_, v_measuredEnergy_291_);
return v___x_300_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableInitialValid___boxed(lean_object* v_cfg_301_, lean_object* v_r_302_){
_start:
{
uint8_t v_res_303_; lean_object* v_r_304_; 
v_res_303_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableInitialValid(v_cfg_301_, v_r_302_);
lean_dec_ref(v_r_302_);
lean_dec_ref(v_cfg_301_);
v_r_304_ = lean_box(v_res_303_);
return v_r_304_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableStepValid(lean_object* v_cfg_305_, lean_object* v_prev_306_, lean_object* v_curr_307_){
_start:
{
lean_object* v_timestamp_308_; lean_object* v_measuredEnergy_309_; lean_object* v_measuredValue_310_; lean_object* v_powerInput_311_; lean_object* v_drainRate_312_; lean_object* v_timestamp_313_; lean_object* v_measuredEnergy_314_; lean_object* v_measuredValue_315_; lean_object* v___x_316_; lean_object* v___x_317_; uint8_t v___x_318_; 
v_timestamp_308_ = lean_ctor_get(v_curr_307_, 0);
v_measuredEnergy_309_ = lean_ctor_get(v_curr_307_, 1);
v_measuredValue_310_ = lean_ctor_get(v_curr_307_, 2);
v_powerInput_311_ = lean_ctor_get(v_curr_307_, 3);
v_drainRate_312_ = lean_ctor_get(v_curr_307_, 4);
v_timestamp_313_ = lean_ctor_get(v_prev_306_, 0);
v_measuredEnergy_314_ = lean_ctor_get(v_prev_306_, 1);
v_measuredValue_315_ = lean_ctor_get(v_prev_306_, 2);
v___x_316_ = lean_unsigned_to_nat(1u);
v___x_317_ = lean_nat_add(v_timestamp_313_, v___x_316_);
v___x_318_ = lean_nat_dec_eq(v_timestamp_308_, v___x_317_);
lean_dec(v___x_317_);
if (v___x_318_ == 0)
{
return v___x_318_;
}
else
{
lean_object* v___x_319_; uint8_t v___x_320_; 
v___x_319_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17);
v___x_320_ = lean_int_dec_le(v___x_319_, v_powerInput_311_);
if (v___x_320_ == 0)
{
return v___x_320_;
}
else
{
uint8_t v___x_321_; 
v___x_321_ = lean_int_dec_le(v___x_319_, v_drainRate_312_);
if (v___x_321_ == 0)
{
return v___x_321_;
}
else
{
uint8_t v___x_322_; 
v___x_322_ = lean_int_dec_le(v_drainRate_312_, v_powerInput_311_);
if (v___x_322_ == 0)
{
return v___x_322_;
}
else
{
lean_object* v___x_323_; lean_object* v___x_324_; uint8_t v___x_325_; 
v___x_323_ = lean_int_add(v_measuredEnergy_314_, v_powerInput_311_);
v___x_324_ = lean_int_sub(v___x_323_, v_drainRate_312_);
lean_dec(v___x_323_);
v___x_325_ = lean_int_dec_eq(v_measuredEnergy_309_, v___x_324_);
lean_dec(v___x_324_);
if (v___x_325_ == 0)
{
return v___x_325_;
}
else
{
lean_object* v_reserve_326_; lean_object* v_kappa_327_; uint8_t v___x_328_; 
v_reserve_326_ = lean_ctor_get(v_cfg_305_, 0);
v_kappa_327_ = lean_ctor_get(v_cfg_305_, 1);
v___x_328_ = lean_int_dec_le(v_reserve_326_, v_measuredEnergy_309_);
if (v___x_328_ == 0)
{
return v___x_328_;
}
else
{
lean_object* v___x_329_; uint8_t v___x_330_; 
v___x_329_ = lean_int_sub(v_measuredValue_315_, v_kappa_327_);
v___x_330_ = lean_int_dec_le(v___x_329_, v_measuredValue_310_);
lean_dec(v___x_329_);
return v___x_330_;
}
}
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableStepValid___boxed(lean_object* v_cfg_331_, lean_object* v_prev_332_, lean_object* v_curr_333_){
_start:
{
uint8_t v_res_334_; lean_object* v_r_335_; 
v_res_334_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableStepValid(v_cfg_331_, v_prev_332_, v_curr_333_);
lean_dec_ref(v_curr_333_);
lean_dec_ref(v_prev_332_);
lean_dec_ref(v_cfg_331_);
v_r_335_ = lean_box(v_res_334_);
return v_r_335_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_checkStep(lean_object* v_cfg_336_, lean_object* v_prev_337_, lean_object* v_curr_338_){
_start:
{
uint8_t v___x_339_; 
v___x_339_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableStepValid(v_cfg_336_, v_prev_337_, v_curr_338_);
return v___x_339_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_checkStep___boxed(lean_object* v_cfg_340_, lean_object* v_prev_341_, lean_object* v_curr_342_){
_start:
{
uint8_t v_res_343_; lean_object* v_r_344_; 
v_res_343_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_checkStep(v_cfg_340_, v_prev_341_, v_curr_342_);
lean_dec_ref(v_curr_342_);
lean_dec_ref(v_prev_341_);
lean_dec_ref(v_cfg_340_);
v_r_344_ = lean_box(v_res_343_);
return v_r_344_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_checkSegments(lean_object* v_cfg_345_, lean_object* v_prev_346_, lean_object* v_x_347_){
_start:
{
if (lean_obj_tag(v_x_347_) == 0)
{
uint8_t v___x_348_; 
v___x_348_ = 1;
return v___x_348_;
}
else
{
lean_object* v_head_349_; lean_object* v_tail_350_; uint8_t v___x_351_; 
v_head_349_ = lean_ctor_get(v_x_347_, 0);
v_tail_350_ = lean_ctor_get(v_x_347_, 1);
v___x_351_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableStepValid(v_cfg_345_, v_prev_346_, v_head_349_);
if (v___x_351_ == 0)
{
return v___x_351_;
}
else
{
v_prev_346_ = v_head_349_;
v_x_347_ = v_tail_350_;
goto _start;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_checkSegments___boxed(lean_object* v_cfg_353_, lean_object* v_prev_354_, lean_object* v_x_355_){
_start:
{
uint8_t v_res_356_; lean_object* v_r_357_; 
v_res_356_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_checkSegments(v_cfg_353_, v_prev_354_, v_x_355_);
lean_dec(v_x_355_);
lean_dec_ref(v_prev_354_);
lean_dec_ref(v_cfg_353_);
v_r_357_ = lean_box(v_res_356_);
return v_r_357_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_verifyTraceData(lean_object* v_cfg_358_, lean_object* v_x_359_){
_start:
{
if (lean_obj_tag(v_x_359_) == 0)
{
uint8_t v___x_360_; 
v___x_360_ = 0;
return v___x_360_;
}
else
{
lean_object* v_head_361_; lean_object* v_tail_362_; lean_object* v_reserve_363_; lean_object* v_kappa_364_; lean_object* v___x_365_; uint8_t v___x_366_; 
v_head_361_ = lean_ctor_get(v_x_359_, 0);
v_tail_362_ = lean_ctor_get(v_x_359_, 1);
v_reserve_363_ = lean_ctor_get(v_cfg_358_, 0);
v_kappa_364_ = lean_ctor_get(v_cfg_358_, 1);
v___x_365_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17);
v___x_366_ = lean_int_dec_le(v___x_365_, v_reserve_363_);
if (v___x_366_ == 0)
{
return v___x_366_;
}
else
{
uint8_t v___x_367_; 
v___x_367_ = lean_int_dec_le(v___x_365_, v_kappa_364_);
if (v___x_367_ == 0)
{
return v___x_367_;
}
else
{
uint8_t v___x_368_; 
v___x_368_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instDecidableInitialValid(v_cfg_358_, v_head_361_);
if (v___x_368_ == 0)
{
return v___x_368_;
}
else
{
uint8_t v___x_369_; 
v___x_369_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_checkSegments(v_cfg_358_, v_head_361_, v_tail_362_);
return v___x_369_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_verifyTraceData___boxed(lean_object* v_cfg_370_, lean_object* v_x_371_){
_start:
{
uint8_t v_res_372_; lean_object* v_r_373_; 
v_res_372_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_verifyTraceData(v_cfg_370_, v_x_371_);
lean_dec(v_x_371_);
lean_dec_ref(v_cfg_370_);
v_r_373_ = lean_box(v_res_372_);
return v_r_373_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRTypedTraceChecker_0__PhysicalBridges_IRTypedTraceChecker_CheckSegments_match__1_splitter___redArg(lean_object* v_x_374_, lean_object* v_h__1_375_, lean_object* v_h__2_376_){
_start:
{
if (lean_obj_tag(v_x_374_) == 0)
{
lean_object* v___x_377_; lean_object* v___x_378_; 
lean_dec(v_h__2_376_);
v___x_377_ = lean_box(0);
v___x_378_ = lean_apply_1(v_h__1_375_, v___x_377_);
return v___x_378_;
}
else
{
lean_object* v_head_379_; lean_object* v_tail_380_; lean_object* v___x_381_; 
lean_dec(v_h__1_375_);
v_head_379_ = lean_ctor_get(v_x_374_, 0);
lean_inc(v_head_379_);
v_tail_380_ = lean_ctor_get(v_x_374_, 1);
lean_inc(v_tail_380_);
lean_dec_ref_known(v_x_374_, 2);
v___x_381_ = lean_apply_2(v_h__2_376_, v_head_379_, v_tail_380_);
return v___x_381_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRTypedTraceChecker_0__PhysicalBridges_IRTypedTraceChecker_CheckSegments_match__1_splitter(lean_object* v_motive_382_, lean_object* v_x_383_, lean_object* v_h__1_384_, lean_object* v_h__2_385_){
_start:
{
if (lean_obj_tag(v_x_383_) == 0)
{
lean_object* v___x_386_; lean_object* v___x_387_; 
lean_dec(v_h__2_385_);
v___x_386_ = lean_box(0);
v___x_387_ = lean_apply_1(v_h__1_384_, v___x_386_);
return v___x_387_;
}
else
{
lean_object* v_head_388_; lean_object* v_tail_389_; lean_object* v___x_390_; 
lean_dec(v_h__1_384_);
v_head_388_ = lean_ctor_get(v_x_383_, 0);
lean_inc(v_head_388_);
v_tail_389_ = lean_ctor_get(v_x_383_, 1);
lean_inc(v_tail_389_);
lean_dec_ref_known(v_x_383_, 2);
v___x_390_ = lean_apply_2(v_h__2_385_, v_head_388_, v_tail_389_);
return v___x_390_;
}
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__0(void){
_start:
{
lean_object* v___x_391_; lean_object* v___x_392_; 
v___x_391_ = lean_unsigned_to_nat(5u);
v___x_392_ = lean_nat_to_int(v___x_391_);
return v___x_392_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__1(void){
_start:
{
lean_object* v___x_393_; lean_object* v___x_394_; 
v___x_393_ = lean_unsigned_to_nat(1u);
v___x_394_ = lean_nat_to_int(v___x_393_);
return v___x_394_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__2(void){
_start:
{
lean_object* v___x_395_; lean_object* v___x_396_; lean_object* v___x_397_; 
v___x_395_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__1, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__1_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__1);
v___x_396_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__0, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__0_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__0);
v___x_397_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_397_, 0, v___x_396_);
lean_ctor_set(v___x_397_, 1, v___x_395_);
return v___x_397_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig(void){
_start:
{
lean_object* v___x_398_; 
v___x_398_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__2, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__2_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__2);
return v___x_398_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__0(void){
_start:
{
lean_object* v___x_399_; lean_object* v___x_400_; 
v___x_399_ = lean_unsigned_to_nat(10u);
v___x_400_ = lean_nat_to_int(v___x_399_);
return v___x_400_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__1(void){
_start:
{
lean_object* v___x_401_; lean_object* v___x_402_; 
v___x_401_ = lean_unsigned_to_nat(100u);
v___x_402_ = lean_nat_to_int(v___x_401_);
return v___x_402_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__2(void){
_start:
{
lean_object* v___x_403_; lean_object* v___x_404_; lean_object* v___x_405_; lean_object* v___x_406_; lean_object* v___x_407_; 
v___x_403_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17);
v___x_404_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__1, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__1_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__1);
v___x_405_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__0, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__0_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__0);
v___x_406_ = lean_unsigned_to_nat(0u);
v___x_407_ = lean_alloc_ctor(0, 5, 0);
lean_ctor_set(v___x_407_, 0, v___x_406_);
lean_ctor_set(v___x_407_, 1, v___x_405_);
lean_ctor_set(v___x_407_, 2, v___x_404_);
lean_ctor_set(v___x_407_, 3, v___x_403_);
lean_ctor_set(v___x_407_, 4, v___x_403_);
return v___x_407_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial(void){
_start:
{
lean_object* v___x_408_; 
v___x_408_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__2, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__2_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__2);
return v___x_408_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__0(void){
_start:
{
lean_object* v___x_409_; lean_object* v___x_410_; 
v___x_409_ = lean_unsigned_to_nat(99u);
v___x_410_ = lean_nat_to_int(v___x_409_);
return v___x_410_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__1(void){
_start:
{
lean_object* v___x_411_; lean_object* v___x_412_; 
v___x_411_ = lean_unsigned_to_nat(3u);
v___x_412_ = lean_nat_to_int(v___x_411_);
return v___x_412_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__2(void){
_start:
{
lean_object* v___x_413_; lean_object* v___x_414_; 
v___x_413_ = lean_unsigned_to_nat(2u);
v___x_414_ = lean_nat_to_int(v___x_413_);
return v___x_414_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__3(void){
_start:
{
lean_object* v___x_415_; lean_object* v___x_416_; lean_object* v___x_417_; lean_object* v___x_418_; lean_object* v___x_419_; lean_object* v___x_420_; 
v___x_415_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__2, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__2_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__2);
v___x_416_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__1, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__1_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__1);
v___x_417_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__0, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__0_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__0);
v___x_418_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__4, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__4_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__4);
v___x_419_ = lean_unsigned_to_nat(1u);
v___x_420_ = lean_alloc_ctor(0, 5, 0);
lean_ctor_set(v___x_420_, 0, v___x_419_);
lean_ctor_set(v___x_420_, 1, v___x_418_);
lean_ctor_set(v___x_420_, 2, v___x_417_);
lean_ctor_set(v___x_420_, 3, v___x_416_);
lean_ctor_set(v___x_420_, 4, v___x_415_);
return v___x_420_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext(void){
_start:
{
lean_object* v___x_421_; 
v___x_421_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__3, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__3_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__3);
return v___x_421_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird___closed__0(void){
_start:
{
lean_object* v___x_422_; lean_object* v___x_423_; 
v___x_422_ = lean_unsigned_to_nat(98u);
v___x_423_ = lean_nat_to_int(v___x_422_);
return v___x_423_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird___closed__1(void){
_start:
{
lean_object* v___x_424_; lean_object* v___x_425_; lean_object* v___x_426_; lean_object* v___x_427_; lean_object* v___x_428_; 
v___x_424_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__2, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__2_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__2);
v___x_425_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird___closed__0, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird___closed__0_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird___closed__0);
v___x_426_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__4, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__4_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__4);
v___x_427_ = lean_unsigned_to_nat(2u);
v___x_428_ = lean_alloc_ctor(0, 5, 0);
lean_ctor_set(v___x_428_, 0, v___x_427_);
lean_ctor_set(v___x_428_, 1, v___x_426_);
lean_ctor_set(v___x_428_, 2, v___x_425_);
lean_ctor_set(v___x_428_, 3, v___x_424_);
lean_ctor_set(v___x_428_, 4, v___x_424_);
return v___x_428_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird(void){
_start:
{
lean_object* v___x_429_; 
v___x_429_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird___closed__1, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird___closed__1_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird___closed__1);
return v___x_429_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__0(void){
_start:
{
lean_object* v___x_430_; lean_object* v___x_431_; lean_object* v___x_432_; 
v___x_430_ = lean_box(0);
v___x_431_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird;
v___x_432_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_432_, 0, v___x_431_);
lean_ctor_set(v___x_432_, 1, v___x_430_);
return v___x_432_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__1(void){
_start:
{
lean_object* v___x_433_; lean_object* v___x_434_; lean_object* v___x_435_; 
v___x_433_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__0, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__0_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__0);
v___x_434_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext;
v___x_435_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_435_, 0, v___x_434_);
lean_ctor_set(v___x_435_, 1, v___x_433_);
return v___x_435_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__2(void){
_start:
{
lean_object* v___x_436_; lean_object* v___x_437_; lean_object* v___x_438_; 
v___x_436_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__1, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__1_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__1);
v___x_437_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial;
v___x_438_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_438_, 0, v___x_437_);
lean_ctor_set(v___x_438_, 1, v___x_436_);
return v___x_438_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace(void){
_start:
{
lean_object* v___x_439_; 
v___x_439_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__2, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__2_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace___closed__2);
return v___x_439_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_badInitial___closed__0(void){
_start:
{
lean_object* v___x_440_; lean_object* v___x_441_; lean_object* v___x_442_; lean_object* v___x_443_; 
v___x_440_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__1, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__1_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial___closed__1);
v___x_441_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg___closed__17);
v___x_442_ = lean_unsigned_to_nat(0u);
v___x_443_ = lean_alloc_ctor(0, 5, 0);
lean_ctor_set(v___x_443_, 0, v___x_442_);
lean_ctor_set(v___x_443_, 1, v___x_441_);
lean_ctor_set(v___x_443_, 2, v___x_440_);
lean_ctor_set(v___x_443_, 3, v___x_441_);
lean_ctor_set(v___x_443_, 4, v___x_441_);
return v___x_443_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_badInitial(void){
_start:
{
lean_object* v___x_444_; 
v___x_444_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_badInitial___closed__0, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_badInitial___closed__0_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_badInitial___closed__0);
return v___x_444_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_insufficientSupplyRecord___closed__0(void){
_start:
{
lean_object* v___x_445_; lean_object* v___x_446_; lean_object* v___x_447_; lean_object* v___x_448_; lean_object* v___x_449_; lean_object* v___x_450_; 
v___x_445_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__2, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__2_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__2);
v___x_446_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__1, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__1_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig___closed__1);
v___x_447_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__0, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__0_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext___closed__0);
v___x_448_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__7, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__7_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg___closed__7);
v___x_449_ = lean_unsigned_to_nat(1u);
v___x_450_ = lean_alloc_ctor(0, 5, 0);
lean_ctor_set(v___x_450_, 0, v___x_449_);
lean_ctor_set(v___x_450_, 1, v___x_448_);
lean_ctor_set(v___x_450_, 2, v___x_447_);
lean_ctor_set(v___x_450_, 3, v___x_446_);
lean_ctor_set(v___x_450_, 4, v___x_445_);
return v___x_450_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_insufficientSupplyRecord(void){
_start:
{
lean_object* v___x_451_; 
v___x_451_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_insufficientSupplyRecord___closed__0, &lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_insufficientSupplyRecord___closed__0_once, _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_insufficientSupplyRecord___closed__0);
return v___x_451_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IREnergyReplenishment(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRTypedTraceChecker(uint8_t builtin) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
lean_initialize_runtime_module();
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_physical__bridges_PhysicalBridges_IREnergyReplenishment(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig = _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig();
lean_mark_persistent(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testConfig);
lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial = _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial();
lean_mark_persistent(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testInitial);
lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext = _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext();
lean_mark_persistent(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testNext);
lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird = _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird();
lean_mark_persistent(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_testThird);
lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace = _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace();
lean_mark_persistent(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_sampleTrace);
lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_badInitial = _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_badInitial();
lean_mark_persistent(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_badInitial);
lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_insufficientSupplyRecord = _init_lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_insufficientSupplyRecord();
lean_mark_persistent(lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_insufficientSupplyRecord);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
