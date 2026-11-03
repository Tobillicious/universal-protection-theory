// Lean compiler output
// Module: PhysicalBridges.IRStoredEnergyCommonMode
// Imports: public import Init public meta import Init public import PhysicalBridges.IRWatchdogLatencyEffects public import PhysicalBridges.IRInterSampleEnvelope
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
lean_object* lean_nat_to_int(lean_object*);
lean_object* lean_nat_mul(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* lean_string_length(lean_object*);
lean_object* l_Nat_reprFast(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_twiceInductiveEnergy(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_twiceInductiveEnergy___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_totalStoredTwice(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_totalStoredTwice___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "{ "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 11, .m_capacity = 11, .m_length = 10, .m_data = "inductance"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__1_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__2_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__2_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__3_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = " := "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__4 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__4_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__4_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__5_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__3_value),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__6_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__7;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = ","};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__8 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__8_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__8_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__9 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__9_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = "current"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__10 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__10_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__10_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__11 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__11_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__12_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__12;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__13_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 13, .m_capacity = 13, .m_length = 12, .m_data = "kineticTwice"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__13 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__13_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__14_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__13_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__14 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__14_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__15_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__15;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__16_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 11, .m_capacity = 11, .m_length = 10, .m_data = "otherTwice"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__16 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__16_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__17_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__16_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__17 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__17_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__18_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 14, .m_capacity = 14, .m_length = 13, .m_data = "absorbedTwice"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__18 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__18_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__19_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__18_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__19 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__19_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__20_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__20;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__21_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 13, .m_capacity = 13, .m_length = 12, .m_data = "escapedTwice"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__21 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__21_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__22_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__21_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__22 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__22_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__23_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 15, .m_capacity = 15, .m_length = 14, .m_data = "remainingTwice"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__23 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__23_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__24_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__23_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__24 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__24_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__25_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__25;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__26_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 19, .m_capacity = 19, .m_length = 18, .m_data = "clampCapacityTwice"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__26 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__26_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__27_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__26_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__27 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__27_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__28_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__28;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__29_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = " }"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__29 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__29_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__30_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__30;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__31_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__31;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__32_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__32 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__32_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__33_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__29_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__33 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__33_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger___closed__0_value;
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instDecidableEqDischargeLedger_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instDecidableEqDischargeLedger_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instDecidableEqDischargeLedger(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instDecidableEqDischargeLedger___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_dualDomainPermit(uint8_t, uint8_t, uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_dualDomainPermit___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_twiceInductiveEnergy(lean_object* v_inductance_1_, lean_object* v_current_2_){
_start:
{
lean_object* v___x_3_; lean_object* v___x_4_; 
v___x_3_ = lean_nat_mul(v_inductance_1_, v_current_2_);
v___x_4_ = lean_nat_mul(v___x_3_, v_current_2_);
lean_dec(v___x_3_);
return v___x_4_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_twiceInductiveEnergy___boxed(lean_object* v_inductance_5_, lean_object* v_current_6_){
_start:
{
lean_object* v_res_7_; 
v_res_7_ = lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_twiceInductiveEnergy(v_inductance_5_, v_current_6_);
lean_dec(v_current_6_);
lean_dec(v_inductance_5_);
return v_res_7_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_totalStoredTwice(lean_object* v_inductance_8_, lean_object* v_current_9_, lean_object* v_kineticTwice_10_, lean_object* v_otherTwice_11_){
_start:
{
lean_object* v___x_12_; lean_object* v___x_13_; lean_object* v___x_14_; 
v___x_12_ = lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_twiceInductiveEnergy(v_inductance_8_, v_current_9_);
v___x_13_ = lean_nat_add(v___x_12_, v_kineticTwice_10_);
lean_dec(v___x_12_);
v___x_14_ = lean_nat_add(v___x_13_, v_otherTwice_11_);
lean_dec(v___x_13_);
return v___x_14_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_totalStoredTwice___boxed(lean_object* v_inductance_15_, lean_object* v_current_16_, lean_object* v_kineticTwice_17_, lean_object* v_otherTwice_18_){
_start:
{
lean_object* v_res_19_; 
v_res_19_ = lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_totalStoredTwice(v_inductance_15_, v_current_16_, v_kineticTwice_17_, v_otherTwice_18_);
lean_dec(v_otherTwice_18_);
lean_dec(v_kineticTwice_17_);
lean_dec(v_current_16_);
lean_dec(v_inductance_15_);
return v_res_19_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__7(void){
_start:
{
lean_object* v___x_33_; lean_object* v___x_34_; 
v___x_33_ = lean_unsigned_to_nat(14u);
v___x_34_ = lean_nat_to_int(v___x_33_);
return v___x_34_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__12(void){
_start:
{
lean_object* v___x_41_; lean_object* v___x_42_; 
v___x_41_ = lean_unsigned_to_nat(11u);
v___x_42_ = lean_nat_to_int(v___x_41_);
return v___x_42_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__15(void){
_start:
{
lean_object* v___x_46_; lean_object* v___x_47_; 
v___x_46_ = lean_unsigned_to_nat(16u);
v___x_47_ = lean_nat_to_int(v___x_46_);
return v___x_47_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__20(void){
_start:
{
lean_object* v___x_54_; lean_object* v___x_55_; 
v___x_54_ = lean_unsigned_to_nat(17u);
v___x_55_ = lean_nat_to_int(v___x_54_);
return v___x_55_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__25(void){
_start:
{
lean_object* v___x_62_; lean_object* v___x_63_; 
v___x_62_ = lean_unsigned_to_nat(18u);
v___x_63_ = lean_nat_to_int(v___x_62_);
return v___x_63_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__28(void){
_start:
{
lean_object* v___x_67_; lean_object* v___x_68_; 
v___x_67_ = lean_unsigned_to_nat(22u);
v___x_68_ = lean_nat_to_int(v___x_67_);
return v___x_68_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__30(void){
_start:
{
lean_object* v___x_70_; lean_object* v___x_71_; 
v___x_70_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__0));
v___x_71_ = lean_string_length(v___x_70_);
return v___x_71_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__31(void){
_start:
{
lean_object* v___x_72_; lean_object* v___x_73_; 
v___x_72_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__30, &lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__30_once, _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__30);
v___x_73_ = lean_nat_to_int(v___x_72_);
return v___x_73_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg(lean_object* v_x_78_){
_start:
{
lean_object* v_inductance_79_; lean_object* v_current_80_; lean_object* v_kineticTwice_81_; lean_object* v_otherTwice_82_; lean_object* v_absorbedTwice_83_; lean_object* v_escapedTwice_84_; lean_object* v_remainingTwice_85_; lean_object* v_clampCapacityTwice_86_; lean_object* v___x_87_; lean_object* v___x_88_; lean_object* v___x_89_; lean_object* v___x_90_; lean_object* v___x_91_; lean_object* v___x_92_; uint8_t v___x_93_; lean_object* v___x_94_; lean_object* v___x_95_; lean_object* v___x_96_; lean_object* v___x_97_; lean_object* v___x_98_; lean_object* v___x_99_; lean_object* v___x_100_; lean_object* v___x_101_; lean_object* v___x_102_; lean_object* v___x_103_; lean_object* v___x_104_; lean_object* v___x_105_; lean_object* v___x_106_; lean_object* v___x_107_; lean_object* v___x_108_; lean_object* v___x_109_; lean_object* v___x_110_; lean_object* v___x_111_; lean_object* v___x_112_; lean_object* v___x_113_; lean_object* v___x_114_; lean_object* v___x_115_; lean_object* v___x_116_; lean_object* v___x_117_; lean_object* v___x_118_; lean_object* v___x_119_; lean_object* v___x_120_; lean_object* v___x_121_; lean_object* v___x_122_; lean_object* v___x_123_; lean_object* v___x_124_; lean_object* v___x_125_; lean_object* v___x_126_; lean_object* v___x_127_; lean_object* v___x_128_; lean_object* v___x_129_; lean_object* v___x_130_; lean_object* v___x_131_; lean_object* v___x_132_; lean_object* v___x_133_; lean_object* v___x_134_; lean_object* v___x_135_; lean_object* v___x_136_; lean_object* v___x_137_; lean_object* v___x_138_; lean_object* v___x_139_; lean_object* v___x_140_; lean_object* v___x_141_; lean_object* v___x_142_; lean_object* v___x_143_; lean_object* v___x_144_; lean_object* v___x_145_; lean_object* v___x_146_; lean_object* v___x_147_; lean_object* v___x_148_; lean_object* v___x_149_; lean_object* v___x_150_; lean_object* v___x_151_; lean_object* v___x_152_; lean_object* v___x_153_; lean_object* v___x_154_; lean_object* v___x_155_; lean_object* v___x_156_; lean_object* v___x_157_; lean_object* v___x_158_; lean_object* v___x_159_; lean_object* v___x_160_; lean_object* v___x_161_; lean_object* v___x_162_; lean_object* v___x_163_; lean_object* v___x_164_; lean_object* v___x_165_; lean_object* v___x_166_; lean_object* v___x_167_; lean_object* v___x_168_; lean_object* v___x_169_; lean_object* v___x_170_; lean_object* v___x_171_; lean_object* v___x_172_; lean_object* v___x_173_; lean_object* v___x_174_; lean_object* v___x_175_; lean_object* v___x_176_; lean_object* v___x_177_; lean_object* v___x_178_; lean_object* v___x_179_; 
v_inductance_79_ = lean_ctor_get(v_x_78_, 0);
lean_inc(v_inductance_79_);
v_current_80_ = lean_ctor_get(v_x_78_, 1);
lean_inc(v_current_80_);
v_kineticTwice_81_ = lean_ctor_get(v_x_78_, 2);
lean_inc(v_kineticTwice_81_);
v_otherTwice_82_ = lean_ctor_get(v_x_78_, 3);
lean_inc(v_otherTwice_82_);
v_absorbedTwice_83_ = lean_ctor_get(v_x_78_, 4);
lean_inc(v_absorbedTwice_83_);
v_escapedTwice_84_ = lean_ctor_get(v_x_78_, 5);
lean_inc(v_escapedTwice_84_);
v_remainingTwice_85_ = lean_ctor_get(v_x_78_, 6);
lean_inc(v_remainingTwice_85_);
v_clampCapacityTwice_86_ = lean_ctor_get(v_x_78_, 7);
lean_inc(v_clampCapacityTwice_86_);
lean_dec_ref(v_x_78_);
v___x_87_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__5));
v___x_88_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__6));
v___x_89_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__7, &lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__7_once, _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__7);
v___x_90_ = l_Nat_reprFast(v_inductance_79_);
v___x_91_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_91_, 0, v___x_90_);
v___x_92_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_92_, 0, v___x_89_);
lean_ctor_set(v___x_92_, 1, v___x_91_);
v___x_93_ = 0;
v___x_94_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_94_, 0, v___x_92_);
lean_ctor_set_uint8(v___x_94_, sizeof(void*)*1, v___x_93_);
v___x_95_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_95_, 0, v___x_88_);
lean_ctor_set(v___x_95_, 1, v___x_94_);
v___x_96_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__9));
v___x_97_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_97_, 0, v___x_95_);
lean_ctor_set(v___x_97_, 1, v___x_96_);
v___x_98_ = lean_box(1);
v___x_99_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_99_, 0, v___x_97_);
lean_ctor_set(v___x_99_, 1, v___x_98_);
v___x_100_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__11));
v___x_101_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_101_, 0, v___x_99_);
lean_ctor_set(v___x_101_, 1, v___x_100_);
v___x_102_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_102_, 0, v___x_101_);
lean_ctor_set(v___x_102_, 1, v___x_87_);
v___x_103_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__12, &lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__12_once, _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__12);
v___x_104_ = l_Nat_reprFast(v_current_80_);
v___x_105_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_105_, 0, v___x_104_);
v___x_106_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_106_, 0, v___x_103_);
lean_ctor_set(v___x_106_, 1, v___x_105_);
v___x_107_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_107_, 0, v___x_106_);
lean_ctor_set_uint8(v___x_107_, sizeof(void*)*1, v___x_93_);
v___x_108_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_108_, 0, v___x_102_);
lean_ctor_set(v___x_108_, 1, v___x_107_);
v___x_109_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_109_, 0, v___x_108_);
lean_ctor_set(v___x_109_, 1, v___x_96_);
v___x_110_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_110_, 0, v___x_109_);
lean_ctor_set(v___x_110_, 1, v___x_98_);
v___x_111_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__14));
v___x_112_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_112_, 0, v___x_110_);
lean_ctor_set(v___x_112_, 1, v___x_111_);
v___x_113_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_113_, 0, v___x_112_);
lean_ctor_set(v___x_113_, 1, v___x_87_);
v___x_114_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__15, &lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__15_once, _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__15);
v___x_115_ = l_Nat_reprFast(v_kineticTwice_81_);
v___x_116_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_116_, 0, v___x_115_);
v___x_117_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_117_, 0, v___x_114_);
lean_ctor_set(v___x_117_, 1, v___x_116_);
v___x_118_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_118_, 0, v___x_117_);
lean_ctor_set_uint8(v___x_118_, sizeof(void*)*1, v___x_93_);
v___x_119_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_119_, 0, v___x_113_);
lean_ctor_set(v___x_119_, 1, v___x_118_);
v___x_120_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_120_, 0, v___x_119_);
lean_ctor_set(v___x_120_, 1, v___x_96_);
v___x_121_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_121_, 0, v___x_120_);
lean_ctor_set(v___x_121_, 1, v___x_98_);
v___x_122_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__17));
v___x_123_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_123_, 0, v___x_121_);
lean_ctor_set(v___x_123_, 1, v___x_122_);
v___x_124_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_124_, 0, v___x_123_);
lean_ctor_set(v___x_124_, 1, v___x_87_);
v___x_125_ = l_Nat_reprFast(v_otherTwice_82_);
v___x_126_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_126_, 0, v___x_125_);
v___x_127_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_127_, 0, v___x_89_);
lean_ctor_set(v___x_127_, 1, v___x_126_);
v___x_128_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_128_, 0, v___x_127_);
lean_ctor_set_uint8(v___x_128_, sizeof(void*)*1, v___x_93_);
v___x_129_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_129_, 0, v___x_124_);
lean_ctor_set(v___x_129_, 1, v___x_128_);
v___x_130_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_130_, 0, v___x_129_);
lean_ctor_set(v___x_130_, 1, v___x_96_);
v___x_131_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_131_, 0, v___x_130_);
lean_ctor_set(v___x_131_, 1, v___x_98_);
v___x_132_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__19));
v___x_133_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_133_, 0, v___x_131_);
lean_ctor_set(v___x_133_, 1, v___x_132_);
v___x_134_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_134_, 0, v___x_133_);
lean_ctor_set(v___x_134_, 1, v___x_87_);
v___x_135_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__20, &lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__20_once, _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__20);
v___x_136_ = l_Nat_reprFast(v_absorbedTwice_83_);
v___x_137_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_137_, 0, v___x_136_);
v___x_138_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_138_, 0, v___x_135_);
lean_ctor_set(v___x_138_, 1, v___x_137_);
v___x_139_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_139_, 0, v___x_138_);
lean_ctor_set_uint8(v___x_139_, sizeof(void*)*1, v___x_93_);
v___x_140_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_140_, 0, v___x_134_);
lean_ctor_set(v___x_140_, 1, v___x_139_);
v___x_141_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_141_, 0, v___x_140_);
lean_ctor_set(v___x_141_, 1, v___x_96_);
v___x_142_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_142_, 0, v___x_141_);
lean_ctor_set(v___x_142_, 1, v___x_98_);
v___x_143_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__22));
v___x_144_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_144_, 0, v___x_142_);
lean_ctor_set(v___x_144_, 1, v___x_143_);
v___x_145_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_145_, 0, v___x_144_);
lean_ctor_set(v___x_145_, 1, v___x_87_);
v___x_146_ = l_Nat_reprFast(v_escapedTwice_84_);
v___x_147_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_147_, 0, v___x_146_);
v___x_148_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_148_, 0, v___x_114_);
lean_ctor_set(v___x_148_, 1, v___x_147_);
v___x_149_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_149_, 0, v___x_148_);
lean_ctor_set_uint8(v___x_149_, sizeof(void*)*1, v___x_93_);
v___x_150_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_150_, 0, v___x_145_);
lean_ctor_set(v___x_150_, 1, v___x_149_);
v___x_151_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_151_, 0, v___x_150_);
lean_ctor_set(v___x_151_, 1, v___x_96_);
v___x_152_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_152_, 0, v___x_151_);
lean_ctor_set(v___x_152_, 1, v___x_98_);
v___x_153_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__24));
v___x_154_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_154_, 0, v___x_152_);
lean_ctor_set(v___x_154_, 1, v___x_153_);
v___x_155_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_155_, 0, v___x_154_);
lean_ctor_set(v___x_155_, 1, v___x_87_);
v___x_156_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__25, &lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__25_once, _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__25);
v___x_157_ = l_Nat_reprFast(v_remainingTwice_85_);
v___x_158_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_158_, 0, v___x_157_);
v___x_159_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_159_, 0, v___x_156_);
lean_ctor_set(v___x_159_, 1, v___x_158_);
v___x_160_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_160_, 0, v___x_159_);
lean_ctor_set_uint8(v___x_160_, sizeof(void*)*1, v___x_93_);
v___x_161_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_161_, 0, v___x_155_);
lean_ctor_set(v___x_161_, 1, v___x_160_);
v___x_162_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_162_, 0, v___x_161_);
lean_ctor_set(v___x_162_, 1, v___x_96_);
v___x_163_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_163_, 0, v___x_162_);
lean_ctor_set(v___x_163_, 1, v___x_98_);
v___x_164_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__27));
v___x_165_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_165_, 0, v___x_163_);
lean_ctor_set(v___x_165_, 1, v___x_164_);
v___x_166_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_166_, 0, v___x_165_);
lean_ctor_set(v___x_166_, 1, v___x_87_);
v___x_167_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__28, &lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__28_once, _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__28);
v___x_168_ = l_Nat_reprFast(v_clampCapacityTwice_86_);
v___x_169_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_169_, 0, v___x_168_);
v___x_170_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_170_, 0, v___x_167_);
lean_ctor_set(v___x_170_, 1, v___x_169_);
v___x_171_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_171_, 0, v___x_170_);
lean_ctor_set_uint8(v___x_171_, sizeof(void*)*1, v___x_93_);
v___x_172_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_172_, 0, v___x_166_);
lean_ctor_set(v___x_172_, 1, v___x_171_);
v___x_173_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__31, &lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__31_once, _init_lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__31);
v___x_174_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__32));
v___x_175_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_175_, 0, v___x_174_);
lean_ctor_set(v___x_175_, 1, v___x_172_);
v___x_176_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg___closed__33));
v___x_177_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_177_, 0, v___x_175_);
lean_ctor_set(v___x_177_, 1, v___x_176_);
v___x_178_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_178_, 0, v___x_173_);
lean_ctor_set(v___x_178_, 1, v___x_177_);
v___x_179_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_179_, 0, v___x_178_);
lean_ctor_set_uint8(v___x_179_, sizeof(void*)*1, v___x_93_);
return v___x_179_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr(lean_object* v_x_180_, lean_object* v_prec_181_){
_start:
{
lean_object* v___x_182_; 
v___x_182_ = lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___redArg(v_x_180_);
return v___x_182_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr___boxed(lean_object* v_x_183_, lean_object* v_prec_184_){
_start:
{
lean_object* v_res_185_; 
v_res_185_ = lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instReprDischargeLedger_repr(v_x_183_, v_prec_184_);
lean_dec(v_prec_184_);
return v_res_185_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instDecidableEqDischargeLedger_decEq(lean_object* v_x_188_, lean_object* v_x_189_){
_start:
{
lean_object* v_inductance_190_; lean_object* v_current_191_; lean_object* v_kineticTwice_192_; lean_object* v_otherTwice_193_; lean_object* v_absorbedTwice_194_; lean_object* v_escapedTwice_195_; lean_object* v_remainingTwice_196_; lean_object* v_clampCapacityTwice_197_; lean_object* v_inductance_198_; lean_object* v_current_199_; lean_object* v_kineticTwice_200_; lean_object* v_otherTwice_201_; lean_object* v_absorbedTwice_202_; lean_object* v_escapedTwice_203_; lean_object* v_remainingTwice_204_; lean_object* v_clampCapacityTwice_205_; uint8_t v___x_206_; 
v_inductance_190_ = lean_ctor_get(v_x_188_, 0);
v_current_191_ = lean_ctor_get(v_x_188_, 1);
v_kineticTwice_192_ = lean_ctor_get(v_x_188_, 2);
v_otherTwice_193_ = lean_ctor_get(v_x_188_, 3);
v_absorbedTwice_194_ = lean_ctor_get(v_x_188_, 4);
v_escapedTwice_195_ = lean_ctor_get(v_x_188_, 5);
v_remainingTwice_196_ = lean_ctor_get(v_x_188_, 6);
v_clampCapacityTwice_197_ = lean_ctor_get(v_x_188_, 7);
v_inductance_198_ = lean_ctor_get(v_x_189_, 0);
v_current_199_ = lean_ctor_get(v_x_189_, 1);
v_kineticTwice_200_ = lean_ctor_get(v_x_189_, 2);
v_otherTwice_201_ = lean_ctor_get(v_x_189_, 3);
v_absorbedTwice_202_ = lean_ctor_get(v_x_189_, 4);
v_escapedTwice_203_ = lean_ctor_get(v_x_189_, 5);
v_remainingTwice_204_ = lean_ctor_get(v_x_189_, 6);
v_clampCapacityTwice_205_ = lean_ctor_get(v_x_189_, 7);
v___x_206_ = lean_nat_dec_eq(v_inductance_190_, v_inductance_198_);
if (v___x_206_ == 0)
{
return v___x_206_;
}
else
{
uint8_t v___x_207_; 
v___x_207_ = lean_nat_dec_eq(v_current_191_, v_current_199_);
if (v___x_207_ == 0)
{
return v___x_207_;
}
else
{
uint8_t v___x_208_; 
v___x_208_ = lean_nat_dec_eq(v_kineticTwice_192_, v_kineticTwice_200_);
if (v___x_208_ == 0)
{
return v___x_208_;
}
else
{
uint8_t v___x_209_; 
v___x_209_ = lean_nat_dec_eq(v_otherTwice_193_, v_otherTwice_201_);
if (v___x_209_ == 0)
{
return v___x_209_;
}
else
{
uint8_t v___x_210_; 
v___x_210_ = lean_nat_dec_eq(v_absorbedTwice_194_, v_absorbedTwice_202_);
if (v___x_210_ == 0)
{
return v___x_210_;
}
else
{
uint8_t v___x_211_; 
v___x_211_ = lean_nat_dec_eq(v_escapedTwice_195_, v_escapedTwice_203_);
if (v___x_211_ == 0)
{
return v___x_211_;
}
else
{
uint8_t v___x_212_; 
v___x_212_ = lean_nat_dec_eq(v_remainingTwice_196_, v_remainingTwice_204_);
if (v___x_212_ == 0)
{
return v___x_212_;
}
else
{
uint8_t v___x_213_; 
v___x_213_ = lean_nat_dec_eq(v_clampCapacityTwice_197_, v_clampCapacityTwice_205_);
return v___x_213_;
}
}
}
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instDecidableEqDischargeLedger_decEq___boxed(lean_object* v_x_214_, lean_object* v_x_215_){
_start:
{
uint8_t v_res_216_; lean_object* v_r_217_; 
v_res_216_ = lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instDecidableEqDischargeLedger_decEq(v_x_214_, v_x_215_);
lean_dec_ref(v_x_215_);
lean_dec_ref(v_x_214_);
v_r_217_ = lean_box(v_res_216_);
return v_r_217_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instDecidableEqDischargeLedger(lean_object* v_x_218_, lean_object* v_x_219_){
_start:
{
uint8_t v___x_220_; 
v___x_220_ = lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instDecidableEqDischargeLedger_decEq(v_x_218_, v_x_219_);
return v___x_220_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instDecidableEqDischargeLedger___boxed(lean_object* v_x_221_, lean_object* v_x_222_){
_start:
{
uint8_t v_res_223_; lean_object* v_r_224_; 
v_res_223_ = lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_instDecidableEqDischargeLedger(v_x_221_, v_x_222_);
lean_dec_ref(v_x_222_);
lean_dec_ref(v_x_221_);
v_r_224_ = lean_box(v_res_223_);
return v_r_224_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_dualDomainPermit(uint8_t v_telemetryPass_225_, uint8_t v_analogWatchdogOK_226_, uint8_t v_physicalFenceOK_227_){
_start:
{
if (v_telemetryPass_225_ == 0)
{
return v_telemetryPass_225_;
}
else
{
if (v_analogWatchdogOK_226_ == 0)
{
return v_analogWatchdogOK_226_;
}
else
{
return v_physicalFenceOK_227_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_dualDomainPermit___boxed(lean_object* v_telemetryPass_228_, lean_object* v_analogWatchdogOK_229_, lean_object* v_physicalFenceOK_230_){
_start:
{
uint8_t v_telemetryPass_boxed_231_; uint8_t v_analogWatchdogOK_boxed_232_; uint8_t v_physicalFenceOK_boxed_233_; uint8_t v_res_234_; lean_object* v_r_235_; 
v_telemetryPass_boxed_231_ = lean_unbox(v_telemetryPass_228_);
v_analogWatchdogOK_boxed_232_ = lean_unbox(v_analogWatchdogOK_229_);
v_physicalFenceOK_boxed_233_ = lean_unbox(v_physicalFenceOK_230_);
v_res_234_ = lp_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode_dualDomainPermit(v_telemetryPass_boxed_231_, v_analogWatchdogOK_boxed_232_, v_physicalFenceOK_boxed_233_);
v_r_235_ = lean_box(v_res_234_);
return v_r_235_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRInterSampleEnvelope(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRStoredEnergyCommonMode(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_physical__bridges_PhysicalBridges_IRInterSampleEnvelope(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
