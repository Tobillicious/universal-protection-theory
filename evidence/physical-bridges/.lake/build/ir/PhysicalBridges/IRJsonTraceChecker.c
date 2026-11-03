// Lean compiler output
// Module: PhysicalBridges.IRJsonTraceChecker
// Imports: public import Init public meta import Init public import Lean public import PhysicalBridges.IRTypedTraceChecker
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
lean_object* l_Lean_Json_getObjVal_x3f(lean_object*, lean_object*);
lean_object* l_Lean_Json_getStr_x3f(lean_object*);
lean_object* lean_nat_to_int(lean_object*);
lean_object* l_Lean_Json_getInt_x3f(lean_object*);
lean_object* l_List_reverse___redArg(lean_object*);
lean_object* l_Lean_Json_getNat_x3f(lean_object*);
lean_object* l_Lean_Json_parse(lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
uint8_t lean_string_dec_eq(lean_object*, lean_object*);
lean_object* lean_string_utf8_byte_size(lean_object*);
lean_object* l_Lean_Json_getArr_x3f(lean_object*);
lean_object* lean_array_to_list(lean_object*);
uint8_t lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_verifyTraceData(lean_object*, lean_object*);
lean_object* lean_string_length(lean_object*);
lean_object* l_Nat_reprFast(lean_object*);
lean_object* l_String_quote(lean_object*);
lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg(lean_object*);
lean_object* lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0_spec__0_spec__1_spec__2(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0_spec__0_spec__1(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_Std_Format_joinSep___at___00List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0_spec__0(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "[]"};
static const lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__0_value;
static const lean_ctor_object lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__1_value;
static const lean_string_object lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = "["};
static const lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__2_value;
static const lean_string_object lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = ","};
static const lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__3_value;
static const lean_ctor_object lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__3_value)}};
static const lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__4 = (const lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__4_value;
static const lean_ctor_object lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__4_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__5_value;
static const lean_string_object lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = "]"};
static const lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__6_value;
static lean_once_cell_t lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__7;
static lean_once_cell_t lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__8_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__8;
static const lean_ctor_object lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__2_value)}};
static const lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__9 = (const lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__9_value;
static const lean_ctor_object lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__6_value)}};
static const lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__10 = (const lean_object*)&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__10_value;
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg(lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "{ "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 14, .m_capacity = 14, .m_length = 13, .m_data = "schemaVersion"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__1_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__2_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__2_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__3_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = " := "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__4 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__4_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__4_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__5_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__3_value),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__6_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__7;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 13, .m_capacity = 13, .m_length = 12, .m_data = "instrumentId"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__8 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__8_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__8_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__9 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__9_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__10_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__10;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 11, .m_capacity = 11, .m_length = 10, .m_data = "energyUnit"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__11 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__11_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__12_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__11_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__12 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__12_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__13_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__13;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__14_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 10, .m_capacity = 10, .m_length = 9, .m_data = "valueUnit"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__14 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__14_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__15_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__14_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__15 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__15_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__16_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__16;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__17_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 15, .m_capacity = 15, .m_length = 14, .m_data = "samplePeriodNs"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__17 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__17_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__18_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__17_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__18 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__18_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__19_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__19;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__20_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 4, .m_capacity = 4, .m_length = 3, .m_data = "cfg"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__20 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__20_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__21_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__20_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__21 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__21_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__22_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__22;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__23_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = "records"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__23 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__23_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__24_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__23_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__24 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__24_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__25_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__25;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__26_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = " }"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__26 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__26_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__27_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__27;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__28_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__28;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__29_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__29 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__29_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__30_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__26_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__30 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__30_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objNat(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objNat___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objInt(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objInt___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objStr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objStr___boxed(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 10, .m_capacity = 10, .m_length = 9, .m_data = "timestamp"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 15, .m_capacity = 15, .m_length = 14, .m_data = "measuredEnergy"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__1_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 14, .m_capacity = 14, .m_length = 13, .m_data = "measuredValue"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__2_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 11, .m_capacity = 11, .m_length = 10, .m_data = "powerInput"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__3 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__3_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 10, .m_capacity = 10, .m_length = 9, .m_data = "drainRate"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__4 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__4_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord(lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeConfig___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = "reserve"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeConfig___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeConfig___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeConfig___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 6, .m_capacity = 6, .m_length = 5, .m_data = "kappa"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeConfig___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeConfig___closed__1_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeConfig(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_mapM_loop___at___00PhysicalBridges_IRJsonTraceChecker_decodeTraceJson_spec__0(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 15, .m_capacity = 15, .m_length = 14, .m_data = "schema_version"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 27, .m_capacity = 27, .m_length = 26, .m_data = "unsupported schema_version"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 0}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__1_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__2_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 12, .m_capacity = 12, .m_length = 11, .m_data = "energy_unit"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__3 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__3_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 11, .m_capacity = 11, .m_length = 10, .m_data = "microjoule"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__4 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__4_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 24, .m_capacity = 24, .m_length = 23, .m_data = "unsupported energy_unit"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__5 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__5_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 0}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__5_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__6 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__6_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 11, .m_capacity = 11, .m_length = 10, .m_data = "value_unit"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__7 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__7_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 14, .m_capacity = 14, .m_length = 13, .m_data = "scaled-scalar"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__8 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__8_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 23, .m_capacity = 23, .m_length = 22, .m_data = "unsupported value_unit"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__9 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__9_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 0}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__9_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__10 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__10_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 17, .m_capacity = 17, .m_length = 16, .m_data = "sample_period_ns"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__11 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__11_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__12_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 14, .m_capacity = 14, .m_length = 13, .m_data = "instrument_id"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__12 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__12_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__13_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 7, .m_capacity = 7, .m_length = 6, .m_data = "config"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__13 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__13_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__14_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 20, .m_capacity = 20, .m_length = 19, .m_data = "empty instrument_id"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__14 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__14_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__15_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 0}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__14_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__15 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__15_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__16_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 22, .m_capacity = 22, .m_length = 21, .m_data = "zero sample_period_ns"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__16 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__16_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__17_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 0}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__16_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__17 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__17_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_verifyJsonText(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_verifyJsonText___boxed(lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_goodJson___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 440, .m_capacity = 440, .m_length = 439, .m_data = "{\"schema_version\":1,\"energy_unit\":\"microjoule\",\"value_unit\":\"scaled-scalar\",\"sample_period_ns\":1000000,\"instrument_id\":\"synthetic-ir78-demo\",\"config\":{\"reserve\":5,\"kappa\":1},\"records\":[{\"timestamp\":0,\"measuredEnergy\":10,\"measuredValue\":100,\"powerInput\":0,\"drainRate\":0},{\"timestamp\":1,\"measuredEnergy\":11,\"measuredValue\":99,\"powerInput\":3,\"drainRate\":2},{\"timestamp\":2,\"measuredEnergy\":11,\"measuredValue\":98,\"powerInput\":2,\"drainRate\":2}]}"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_goodJson___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_goodJson___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_goodJson = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_goodJson___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_missing__field__json___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 258, .m_capacity = 258, .m_length = 257, .m_data = "{\"schema_version\":1,\"energy_unit\":\"microjoule\",\"value_unit\":\"scaled-scalar\",\"sample_period_ns\":1000000,\"instrument_id\":\"synthetic-ir78-demo\",\"config\":{\"reserve\":5,\"kappa\":1},\"records\":[{\"timestamp\":0,\"measuredEnergy\":10,\"measuredValue\":100,\"powerInput\":0}]}"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_missing__field__json___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_missing__field__json___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_missing__field__json = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_missing__field__json___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_mistyped__timestamp__json___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 274, .m_capacity = 274, .m_length = 273, .m_data = "{\"schema_version\":1,\"energy_unit\":\"microjoule\",\"value_unit\":\"scaled-scalar\",\"sample_period_ns\":1000000,\"instrument_id\":\"synthetic-ir78-demo\",\"config\":{\"reserve\":5,\"kappa\":1},\"records\":[{\"timestamp\":\"0\",\"measuredEnergy\":10,\"measuredValue\":100,\"powerInput\":0,\"drainRate\":0}]}"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_mistyped__timestamp__json___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_mistyped__timestamp__json___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_mistyped__timestamp__json = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_mistyped__timestamp__json___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_unsupported__unit__json___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 435, .m_capacity = 435, .m_length = 434, .m_data = "{\"schema_version\":1,\"energy_unit\":\"joule\",\"value_unit\":\"scaled-scalar\",\"sample_period_ns\":1000000,\"instrument_id\":\"synthetic-ir78-demo\",\"config\":{\"reserve\":5,\"kappa\":1},\"records\":[{\"timestamp\":0,\"measuredEnergy\":10,\"measuredValue\":100,\"powerInput\":0,\"drainRate\":0},{\"timestamp\":1,\"measuredEnergy\":11,\"measuredValue\":99,\"powerInput\":3,\"drainRate\":2},{\"timestamp\":2,\"measuredEnergy\":11,\"measuredValue\":98,\"powerInput\":2,\"drainRate\":2}]}"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_unsupported__unit__json___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_unsupported__unit__json___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_unsupported__unit__json = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_unsupported__unit__json___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_invalid__step__json___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 356, .m_capacity = 356, .m_length = 355, .m_data = "{\"schema_version\":1,\"energy_unit\":\"microjoule\",\"value_unit\":\"scaled-scalar\",\"sample_period_ns\":1000000,\"instrument_id\":\"synthetic-ir78-demo\",\"config\":{\"reserve\":5,\"kappa\":1},\"records\":[{\"timestamp\":0,\"measuredEnergy\":10,\"measuredValue\":100,\"powerInput\":0,\"drainRate\":0},{\"timestamp\":9,\"measuredEnergy\":11,\"measuredValue\":99,\"powerInput\":3,\"drainRate\":2}]}"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_invalid__step__json___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_invalid__step__json___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_invalid__step__json = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_invalid__step__json___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0_spec__0_spec__1_spec__2(lean_object* v_x_1_, lean_object* v_x_2_, lean_object* v_x_3_){
_start:
{
if (lean_obj_tag(v_x_3_) == 0)
{
lean_dec(v_x_1_);
return v_x_2_;
}
else
{
lean_object* v_head_4_; lean_object* v_tail_5_; lean_object* v___x_7_; uint8_t v_isShared_8_; uint8_t v_isSharedCheck_15_; 
v_head_4_ = lean_ctor_get(v_x_3_, 0);
v_tail_5_ = lean_ctor_get(v_x_3_, 1);
v_isSharedCheck_15_ = !lean_is_exclusive(v_x_3_);
if (v_isSharedCheck_15_ == 0)
{
v___x_7_ = v_x_3_;
v_isShared_8_ = v_isSharedCheck_15_;
goto v_resetjp_6_;
}
else
{
lean_inc(v_tail_5_);
lean_inc(v_head_4_);
lean_dec(v_x_3_);
v___x_7_ = lean_box(0);
v_isShared_8_ = v_isSharedCheck_15_;
goto v_resetjp_6_;
}
v_resetjp_6_:
{
lean_object* v___x_10_; 
lean_inc(v_x_1_);
if (v_isShared_8_ == 0)
{
lean_ctor_set_tag(v___x_7_, 5);
lean_ctor_set(v___x_7_, 1, v_x_1_);
lean_ctor_set(v___x_7_, 0, v_x_2_);
v___x_10_ = v___x_7_;
goto v_reusejp_9_;
}
else
{
lean_object* v_reuseFailAlloc_14_; 
v_reuseFailAlloc_14_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v_reuseFailAlloc_14_, 0, v_x_2_);
lean_ctor_set(v_reuseFailAlloc_14_, 1, v_x_1_);
v___x_10_ = v_reuseFailAlloc_14_;
goto v_reusejp_9_;
}
v_reusejp_9_:
{
lean_object* v___x_11_; lean_object* v___x_12_; 
v___x_11_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg(v_head_4_);
v___x_12_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_12_, 0, v___x_10_);
lean_ctor_set(v___x_12_, 1, v___x_11_);
v_x_2_ = v___x_12_;
v_x_3_ = v_tail_5_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0_spec__0_spec__1(lean_object* v_x_16_, lean_object* v_x_17_, lean_object* v_x_18_){
_start:
{
if (lean_obj_tag(v_x_18_) == 0)
{
lean_dec(v_x_16_);
return v_x_17_;
}
else
{
lean_object* v_head_19_; lean_object* v_tail_20_; lean_object* v___x_22_; uint8_t v_isShared_23_; uint8_t v_isSharedCheck_30_; 
v_head_19_ = lean_ctor_get(v_x_18_, 0);
v_tail_20_ = lean_ctor_get(v_x_18_, 1);
v_isSharedCheck_30_ = !lean_is_exclusive(v_x_18_);
if (v_isSharedCheck_30_ == 0)
{
v___x_22_ = v_x_18_;
v_isShared_23_ = v_isSharedCheck_30_;
goto v_resetjp_21_;
}
else
{
lean_inc(v_tail_20_);
lean_inc(v_head_19_);
lean_dec(v_x_18_);
v___x_22_ = lean_box(0);
v_isShared_23_ = v_isSharedCheck_30_;
goto v_resetjp_21_;
}
v_resetjp_21_:
{
lean_object* v___x_25_; 
lean_inc(v_x_16_);
if (v_isShared_23_ == 0)
{
lean_ctor_set_tag(v___x_22_, 5);
lean_ctor_set(v___x_22_, 1, v_x_16_);
lean_ctor_set(v___x_22_, 0, v_x_17_);
v___x_25_ = v___x_22_;
goto v_reusejp_24_;
}
else
{
lean_object* v_reuseFailAlloc_29_; 
v_reuseFailAlloc_29_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v_reuseFailAlloc_29_, 0, v_x_17_);
lean_ctor_set(v_reuseFailAlloc_29_, 1, v_x_16_);
v___x_25_ = v_reuseFailAlloc_29_;
goto v_reusejp_24_;
}
v_reusejp_24_:
{
lean_object* v___x_26_; lean_object* v___x_27_; lean_object* v___x_28_; 
v___x_26_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg(v_head_19_);
v___x_27_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_27_, 0, v___x_25_);
lean_ctor_set(v___x_27_, 1, v___x_26_);
v___x_28_ = lp_physical__bridges_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0_spec__0_spec__1_spec__2(v_x_16_, v___x_27_, v_tail_20_);
return v___x_28_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_Std_Format_joinSep___at___00List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0_spec__0(lean_object* v_x_31_, lean_object* v_x_32_){
_start:
{
if (lean_obj_tag(v_x_31_) == 0)
{
lean_object* v___x_33_; 
lean_dec(v_x_32_);
v___x_33_ = lean_box(0);
return v___x_33_;
}
else
{
lean_object* v_tail_34_; 
v_tail_34_ = lean_ctor_get(v_x_31_, 1);
if (lean_obj_tag(v_tail_34_) == 0)
{
lean_object* v_head_35_; lean_object* v___x_36_; 
lean_dec(v_x_32_);
v_head_35_ = lean_ctor_get(v_x_31_, 0);
lean_inc(v_head_35_);
lean_dec_ref_known(v_x_31_, 2);
v___x_36_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg(v_head_35_);
return v___x_36_;
}
else
{
lean_object* v_head_37_; lean_object* v___x_38_; lean_object* v___x_39_; 
lean_inc(v_tail_34_);
v_head_37_ = lean_ctor_get(v_x_31_, 0);
lean_inc(v_head_37_);
lean_dec_ref_known(v_x_31_, 2);
v___x_38_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprTelemetryRecord_repr___redArg(v_head_37_);
v___x_39_ = lp_physical__bridges_List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0_spec__0_spec__1(v_x_32_, v___x_38_, v_tail_34_);
return v___x_39_;
}
}
}
}
static lean_object* _init_lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__7(void){
_start:
{
lean_object* v___x_51_; lean_object* v___x_52_; 
v___x_51_ = ((lean_object*)(lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__2));
v___x_52_ = lean_string_length(v___x_51_);
return v___x_52_;
}
}
static lean_object* _init_lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__8(void){
_start:
{
lean_object* v___x_53_; lean_object* v___x_54_; 
v___x_53_ = lean_obj_once(&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__7, &lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__7_once, _init_lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__7);
v___x_54_ = lean_nat_to_int(v___x_53_);
return v___x_54_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg(lean_object* v_a_59_){
_start:
{
if (lean_obj_tag(v_a_59_) == 0)
{
lean_object* v___x_60_; 
v___x_60_ = ((lean_object*)(lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__1));
return v___x_60_;
}
else
{
lean_object* v___x_61_; lean_object* v___x_62_; lean_object* v___x_63_; lean_object* v___x_64_; lean_object* v___x_65_; lean_object* v___x_66_; lean_object* v___x_67_; lean_object* v___x_68_; uint8_t v___x_69_; lean_object* v___x_70_; 
v___x_61_ = ((lean_object*)(lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__5));
v___x_62_ = lp_physical__bridges_Std_Format_joinSep___at___00List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0_spec__0(v_a_59_, v___x_61_);
v___x_63_ = lean_obj_once(&lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__8, &lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__8_once, _init_lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__8);
v___x_64_ = ((lean_object*)(lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__9));
v___x_65_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_65_, 0, v___x_64_);
lean_ctor_set(v___x_65_, 1, v___x_62_);
v___x_66_ = ((lean_object*)(lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__10));
v___x_67_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_67_, 0, v___x_65_);
lean_ctor_set(v___x_67_, 1, v___x_66_);
v___x_68_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_68_, 0, v___x_63_);
lean_ctor_set(v___x_68_, 1, v___x_67_);
v___x_69_ = 0;
v___x_70_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_70_, 0, v___x_68_);
lean_ctor_set_uint8(v___x_70_, sizeof(void*)*1, v___x_69_);
return v___x_70_;
}
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__7(void){
_start:
{
lean_object* v___x_84_; lean_object* v___x_85_; 
v___x_84_ = lean_unsigned_to_nat(17u);
v___x_85_ = lean_nat_to_int(v___x_84_);
return v___x_85_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__10(void){
_start:
{
lean_object* v___x_89_; lean_object* v___x_90_; 
v___x_89_ = lean_unsigned_to_nat(16u);
v___x_90_ = lean_nat_to_int(v___x_89_);
return v___x_90_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__13(void){
_start:
{
lean_object* v___x_94_; lean_object* v___x_95_; 
v___x_94_ = lean_unsigned_to_nat(14u);
v___x_95_ = lean_nat_to_int(v___x_94_);
return v___x_95_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__16(void){
_start:
{
lean_object* v___x_99_; lean_object* v___x_100_; 
v___x_99_ = lean_unsigned_to_nat(13u);
v___x_100_ = lean_nat_to_int(v___x_99_);
return v___x_100_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__19(void){
_start:
{
lean_object* v___x_104_; lean_object* v___x_105_; 
v___x_104_ = lean_unsigned_to_nat(18u);
v___x_105_ = lean_nat_to_int(v___x_104_);
return v___x_105_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__22(void){
_start:
{
lean_object* v___x_109_; lean_object* v___x_110_; 
v___x_109_ = lean_unsigned_to_nat(7u);
v___x_110_ = lean_nat_to_int(v___x_109_);
return v___x_110_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__25(void){
_start:
{
lean_object* v___x_114_; lean_object* v___x_115_; 
v___x_114_ = lean_unsigned_to_nat(11u);
v___x_115_ = lean_nat_to_int(v___x_114_);
return v___x_115_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__27(void){
_start:
{
lean_object* v___x_117_; lean_object* v___x_118_; 
v___x_117_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__0));
v___x_118_ = lean_string_length(v___x_117_);
return v___x_118_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__28(void){
_start:
{
lean_object* v___x_119_; lean_object* v___x_120_; 
v___x_119_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__27, &lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__27_once, _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__27);
v___x_120_ = lean_nat_to_int(v___x_119_);
return v___x_120_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg(lean_object* v_x_125_){
_start:
{
lean_object* v_schemaVersion_126_; lean_object* v_instrumentId_127_; lean_object* v_energyUnit_128_; lean_object* v_valueUnit_129_; lean_object* v_samplePeriodNs_130_; lean_object* v_cfg_131_; lean_object* v_records_132_; lean_object* v___x_133_; lean_object* v___x_134_; lean_object* v___x_135_; lean_object* v___x_136_; lean_object* v___x_137_; lean_object* v___x_138_; uint8_t v___x_139_; lean_object* v___x_140_; lean_object* v___x_141_; lean_object* v___x_142_; lean_object* v___x_143_; lean_object* v___x_144_; lean_object* v___x_145_; lean_object* v___x_146_; lean_object* v___x_147_; lean_object* v___x_148_; lean_object* v___x_149_; lean_object* v___x_150_; lean_object* v___x_151_; lean_object* v___x_152_; lean_object* v___x_153_; lean_object* v___x_154_; lean_object* v___x_155_; lean_object* v___x_156_; lean_object* v___x_157_; lean_object* v___x_158_; lean_object* v___x_159_; lean_object* v___x_160_; lean_object* v___x_161_; lean_object* v___x_162_; lean_object* v___x_163_; lean_object* v___x_164_; lean_object* v___x_165_; lean_object* v___x_166_; lean_object* v___x_167_; lean_object* v___x_168_; lean_object* v___x_169_; lean_object* v___x_170_; lean_object* v___x_171_; lean_object* v___x_172_; lean_object* v___x_173_; lean_object* v___x_174_; lean_object* v___x_175_; lean_object* v___x_176_; lean_object* v___x_177_; lean_object* v___x_178_; lean_object* v___x_179_; lean_object* v___x_180_; lean_object* v___x_181_; lean_object* v___x_182_; lean_object* v___x_183_; lean_object* v___x_184_; lean_object* v___x_185_; lean_object* v___x_186_; lean_object* v___x_187_; lean_object* v___x_188_; lean_object* v___x_189_; lean_object* v___x_190_; lean_object* v___x_191_; lean_object* v___x_192_; lean_object* v___x_193_; lean_object* v___x_194_; lean_object* v___x_195_; lean_object* v___x_196_; lean_object* v___x_197_; lean_object* v___x_198_; lean_object* v___x_199_; lean_object* v___x_200_; lean_object* v___x_201_; lean_object* v___x_202_; lean_object* v___x_203_; lean_object* v___x_204_; lean_object* v___x_205_; lean_object* v___x_206_; lean_object* v___x_207_; lean_object* v___x_208_; lean_object* v___x_209_; lean_object* v___x_210_; lean_object* v___x_211_; lean_object* v___x_212_; lean_object* v___x_213_; lean_object* v___x_214_; 
v_schemaVersion_126_ = lean_ctor_get(v_x_125_, 0);
lean_inc(v_schemaVersion_126_);
v_instrumentId_127_ = lean_ctor_get(v_x_125_, 1);
lean_inc_ref(v_instrumentId_127_);
v_energyUnit_128_ = lean_ctor_get(v_x_125_, 2);
lean_inc_ref(v_energyUnit_128_);
v_valueUnit_129_ = lean_ctor_get(v_x_125_, 3);
lean_inc_ref(v_valueUnit_129_);
v_samplePeriodNs_130_ = lean_ctor_get(v_x_125_, 4);
lean_inc(v_samplePeriodNs_130_);
v_cfg_131_ = lean_ctor_get(v_x_125_, 5);
lean_inc_ref(v_cfg_131_);
v_records_132_ = lean_ctor_get(v_x_125_, 6);
lean_inc(v_records_132_);
lean_dec_ref(v_x_125_);
v___x_133_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__5));
v___x_134_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__6));
v___x_135_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__7, &lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__7_once, _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__7);
v___x_136_ = l_Nat_reprFast(v_schemaVersion_126_);
v___x_137_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_137_, 0, v___x_136_);
v___x_138_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_138_, 0, v___x_135_);
lean_ctor_set(v___x_138_, 1, v___x_137_);
v___x_139_ = 0;
v___x_140_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_140_, 0, v___x_138_);
lean_ctor_set_uint8(v___x_140_, sizeof(void*)*1, v___x_139_);
v___x_141_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_141_, 0, v___x_134_);
lean_ctor_set(v___x_141_, 1, v___x_140_);
v___x_142_ = ((lean_object*)(lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg___closed__4));
v___x_143_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_143_, 0, v___x_141_);
lean_ctor_set(v___x_143_, 1, v___x_142_);
v___x_144_ = lean_box(1);
v___x_145_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_145_, 0, v___x_143_);
lean_ctor_set(v___x_145_, 1, v___x_144_);
v___x_146_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__9));
v___x_147_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_147_, 0, v___x_145_);
lean_ctor_set(v___x_147_, 1, v___x_146_);
v___x_148_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_148_, 0, v___x_147_);
lean_ctor_set(v___x_148_, 1, v___x_133_);
v___x_149_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__10, &lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__10_once, _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__10);
v___x_150_ = l_String_quote(v_instrumentId_127_);
v___x_151_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_151_, 0, v___x_150_);
v___x_152_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_152_, 0, v___x_149_);
lean_ctor_set(v___x_152_, 1, v___x_151_);
v___x_153_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_153_, 0, v___x_152_);
lean_ctor_set_uint8(v___x_153_, sizeof(void*)*1, v___x_139_);
v___x_154_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_154_, 0, v___x_148_);
lean_ctor_set(v___x_154_, 1, v___x_153_);
v___x_155_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_155_, 0, v___x_154_);
lean_ctor_set(v___x_155_, 1, v___x_142_);
v___x_156_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_156_, 0, v___x_155_);
lean_ctor_set(v___x_156_, 1, v___x_144_);
v___x_157_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__12));
v___x_158_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_158_, 0, v___x_156_);
lean_ctor_set(v___x_158_, 1, v___x_157_);
v___x_159_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_159_, 0, v___x_158_);
lean_ctor_set(v___x_159_, 1, v___x_133_);
v___x_160_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__13, &lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__13_once, _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__13);
v___x_161_ = l_String_quote(v_energyUnit_128_);
v___x_162_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_162_, 0, v___x_161_);
v___x_163_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_163_, 0, v___x_160_);
lean_ctor_set(v___x_163_, 1, v___x_162_);
v___x_164_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_164_, 0, v___x_163_);
lean_ctor_set_uint8(v___x_164_, sizeof(void*)*1, v___x_139_);
v___x_165_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_165_, 0, v___x_159_);
lean_ctor_set(v___x_165_, 1, v___x_164_);
v___x_166_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_166_, 0, v___x_165_);
lean_ctor_set(v___x_166_, 1, v___x_142_);
v___x_167_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_167_, 0, v___x_166_);
lean_ctor_set(v___x_167_, 1, v___x_144_);
v___x_168_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__15));
v___x_169_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_169_, 0, v___x_167_);
lean_ctor_set(v___x_169_, 1, v___x_168_);
v___x_170_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_170_, 0, v___x_169_);
lean_ctor_set(v___x_170_, 1, v___x_133_);
v___x_171_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__16, &lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__16_once, _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__16);
v___x_172_ = l_String_quote(v_valueUnit_129_);
v___x_173_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_173_, 0, v___x_172_);
v___x_174_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_174_, 0, v___x_171_);
lean_ctor_set(v___x_174_, 1, v___x_173_);
v___x_175_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_175_, 0, v___x_174_);
lean_ctor_set_uint8(v___x_175_, sizeof(void*)*1, v___x_139_);
v___x_176_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_176_, 0, v___x_170_);
lean_ctor_set(v___x_176_, 1, v___x_175_);
v___x_177_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_177_, 0, v___x_176_);
lean_ctor_set(v___x_177_, 1, v___x_142_);
v___x_178_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_178_, 0, v___x_177_);
lean_ctor_set(v___x_178_, 1, v___x_144_);
v___x_179_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__18));
v___x_180_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_180_, 0, v___x_178_);
lean_ctor_set(v___x_180_, 1, v___x_179_);
v___x_181_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_181_, 0, v___x_180_);
lean_ctor_set(v___x_181_, 1, v___x_133_);
v___x_182_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__19, &lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__19_once, _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__19);
v___x_183_ = l_Nat_reprFast(v_samplePeriodNs_130_);
v___x_184_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_184_, 0, v___x_183_);
v___x_185_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_185_, 0, v___x_182_);
lean_ctor_set(v___x_185_, 1, v___x_184_);
v___x_186_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_186_, 0, v___x_185_);
lean_ctor_set_uint8(v___x_186_, sizeof(void*)*1, v___x_139_);
v___x_187_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_187_, 0, v___x_181_);
lean_ctor_set(v___x_187_, 1, v___x_186_);
v___x_188_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_188_, 0, v___x_187_);
lean_ctor_set(v___x_188_, 1, v___x_142_);
v___x_189_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_189_, 0, v___x_188_);
lean_ctor_set(v___x_189_, 1, v___x_144_);
v___x_190_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__21));
v___x_191_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_191_, 0, v___x_189_);
lean_ctor_set(v___x_191_, 1, v___x_190_);
v___x_192_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_192_, 0, v___x_191_);
lean_ctor_set(v___x_192_, 1, v___x_133_);
v___x_193_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__22, &lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__22_once, _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__22);
v___x_194_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_instReprCheckConfig_repr___redArg(v_cfg_131_);
v___x_195_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_195_, 0, v___x_193_);
lean_ctor_set(v___x_195_, 1, v___x_194_);
v___x_196_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_196_, 0, v___x_195_);
lean_ctor_set_uint8(v___x_196_, sizeof(void*)*1, v___x_139_);
v___x_197_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_197_, 0, v___x_192_);
lean_ctor_set(v___x_197_, 1, v___x_196_);
v___x_198_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_198_, 0, v___x_197_);
lean_ctor_set(v___x_198_, 1, v___x_142_);
v___x_199_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_199_, 0, v___x_198_);
lean_ctor_set(v___x_199_, 1, v___x_144_);
v___x_200_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__24));
v___x_201_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_201_, 0, v___x_199_);
lean_ctor_set(v___x_201_, 1, v___x_200_);
v___x_202_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_202_, 0, v___x_201_);
lean_ctor_set(v___x_202_, 1, v___x_133_);
v___x_203_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__25, &lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__25_once, _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__25);
v___x_204_ = lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg(v_records_132_);
v___x_205_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_205_, 0, v___x_203_);
lean_ctor_set(v___x_205_, 1, v___x_204_);
v___x_206_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_206_, 0, v___x_205_);
lean_ctor_set_uint8(v___x_206_, sizeof(void*)*1, v___x_139_);
v___x_207_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_207_, 0, v___x_202_);
lean_ctor_set(v___x_207_, 1, v___x_206_);
v___x_208_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__28, &lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__28_once, _init_lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__28);
v___x_209_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__29));
v___x_210_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_210_, 0, v___x_209_);
lean_ctor_set(v___x_210_, 1, v___x_207_);
v___x_211_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__30));
v___x_212_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_212_, 0, v___x_210_);
lean_ctor_set(v___x_212_, 1, v___x_211_);
v___x_213_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_213_, 0, v___x_208_);
lean_ctor_set(v___x_213_, 1, v___x_212_);
v___x_214_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_214_, 0, v___x_213_);
lean_ctor_set_uint8(v___x_214_, sizeof(void*)*1, v___x_139_);
return v___x_214_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr(lean_object* v_x_215_, lean_object* v_prec_216_){
_start:
{
lean_object* v___x_217_; 
v___x_217_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg(v_x_215_);
return v___x_217_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___boxed(lean_object* v_x_218_, lean_object* v_prec_219_){
_start:
{
lean_object* v_res_220_; 
v_res_220_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr(v_x_218_, v_prec_219_);
lean_dec(v_prec_219_);
return v_res_220_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0(lean_object* v_a_221_, lean_object* v_n_222_){
_start:
{
lean_object* v___x_223_; 
v___x_223_ = lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___redArg(v_a_221_);
return v___x_223_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0___boxed(lean_object* v_a_224_, lean_object* v_n_225_){
_start:
{
lean_object* v_res_226_; 
v_res_226_ = lp_physical__bridges_List_repr___at___00PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr_spec__0(v_a_224_, v_n_225_);
lean_dec(v_n_225_);
return v_res_226_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objNat(lean_object* v_j_229_, lean_object* v_key_230_){
_start:
{
lean_object* v___x_231_; 
v___x_231_ = l_Lean_Json_getObjVal_x3f(v_j_229_, v_key_230_);
if (lean_obj_tag(v___x_231_) == 0)
{
lean_object* v_a_232_; lean_object* v___x_234_; uint8_t v_isShared_235_; uint8_t v_isSharedCheck_239_; 
v_a_232_ = lean_ctor_get(v___x_231_, 0);
v_isSharedCheck_239_ = !lean_is_exclusive(v___x_231_);
if (v_isSharedCheck_239_ == 0)
{
v___x_234_ = v___x_231_;
v_isShared_235_ = v_isSharedCheck_239_;
goto v_resetjp_233_;
}
else
{
lean_inc(v_a_232_);
lean_dec(v___x_231_);
v___x_234_ = lean_box(0);
v_isShared_235_ = v_isSharedCheck_239_;
goto v_resetjp_233_;
}
v_resetjp_233_:
{
lean_object* v___x_237_; 
if (v_isShared_235_ == 0)
{
v___x_237_ = v___x_234_;
goto v_reusejp_236_;
}
else
{
lean_object* v_reuseFailAlloc_238_; 
v_reuseFailAlloc_238_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_238_, 0, v_a_232_);
v___x_237_ = v_reuseFailAlloc_238_;
goto v_reusejp_236_;
}
v_reusejp_236_:
{
return v___x_237_;
}
}
}
else
{
lean_object* v_a_240_; lean_object* v___x_241_; 
v_a_240_ = lean_ctor_get(v___x_231_, 0);
lean_inc(v_a_240_);
lean_dec_ref_known(v___x_231_, 1);
v___x_241_ = l_Lean_Json_getNat_x3f(v_a_240_);
return v___x_241_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objNat___boxed(lean_object* v_j_242_, lean_object* v_key_243_){
_start:
{
lean_object* v_res_244_; 
v_res_244_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objNat(v_j_242_, v_key_243_);
lean_dec_ref(v_key_243_);
return v_res_244_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objInt(lean_object* v_j_245_, lean_object* v_key_246_){
_start:
{
lean_object* v___x_247_; 
v___x_247_ = l_Lean_Json_getObjVal_x3f(v_j_245_, v_key_246_);
if (lean_obj_tag(v___x_247_) == 0)
{
lean_object* v_a_248_; lean_object* v___x_250_; uint8_t v_isShared_251_; uint8_t v_isSharedCheck_255_; 
v_a_248_ = lean_ctor_get(v___x_247_, 0);
v_isSharedCheck_255_ = !lean_is_exclusive(v___x_247_);
if (v_isSharedCheck_255_ == 0)
{
v___x_250_ = v___x_247_;
v_isShared_251_ = v_isSharedCheck_255_;
goto v_resetjp_249_;
}
else
{
lean_inc(v_a_248_);
lean_dec(v___x_247_);
v___x_250_ = lean_box(0);
v_isShared_251_ = v_isSharedCheck_255_;
goto v_resetjp_249_;
}
v_resetjp_249_:
{
lean_object* v___x_253_; 
if (v_isShared_251_ == 0)
{
v___x_253_ = v___x_250_;
goto v_reusejp_252_;
}
else
{
lean_object* v_reuseFailAlloc_254_; 
v_reuseFailAlloc_254_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_254_, 0, v_a_248_);
v___x_253_ = v_reuseFailAlloc_254_;
goto v_reusejp_252_;
}
v_reusejp_252_:
{
return v___x_253_;
}
}
}
else
{
lean_object* v_a_256_; lean_object* v___x_257_; 
v_a_256_ = lean_ctor_get(v___x_247_, 0);
lean_inc(v_a_256_);
lean_dec_ref_known(v___x_247_, 1);
v___x_257_ = l_Lean_Json_getInt_x3f(v_a_256_);
return v___x_257_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objInt___boxed(lean_object* v_j_258_, lean_object* v_key_259_){
_start:
{
lean_object* v_res_260_; 
v_res_260_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objInt(v_j_258_, v_key_259_);
lean_dec_ref(v_key_259_);
return v_res_260_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objStr(lean_object* v_j_261_, lean_object* v_key_262_){
_start:
{
lean_object* v___x_263_; 
v___x_263_ = l_Lean_Json_getObjVal_x3f(v_j_261_, v_key_262_);
if (lean_obj_tag(v___x_263_) == 0)
{
lean_object* v_a_264_; lean_object* v___x_266_; uint8_t v_isShared_267_; uint8_t v_isSharedCheck_271_; 
v_a_264_ = lean_ctor_get(v___x_263_, 0);
v_isSharedCheck_271_ = !lean_is_exclusive(v___x_263_);
if (v_isSharedCheck_271_ == 0)
{
v___x_266_ = v___x_263_;
v_isShared_267_ = v_isSharedCheck_271_;
goto v_resetjp_265_;
}
else
{
lean_inc(v_a_264_);
lean_dec(v___x_263_);
v___x_266_ = lean_box(0);
v_isShared_267_ = v_isSharedCheck_271_;
goto v_resetjp_265_;
}
v_resetjp_265_:
{
lean_object* v___x_269_; 
if (v_isShared_267_ == 0)
{
v___x_269_ = v___x_266_;
goto v_reusejp_268_;
}
else
{
lean_object* v_reuseFailAlloc_270_; 
v_reuseFailAlloc_270_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_270_, 0, v_a_264_);
v___x_269_ = v_reuseFailAlloc_270_;
goto v_reusejp_268_;
}
v_reusejp_268_:
{
return v___x_269_;
}
}
}
else
{
lean_object* v_a_272_; lean_object* v___x_273_; 
v_a_272_ = lean_ctor_get(v___x_263_, 0);
lean_inc(v_a_272_);
lean_dec_ref_known(v___x_263_, 1);
v___x_273_ = l_Lean_Json_getStr_x3f(v_a_272_);
return v___x_273_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objStr___boxed(lean_object* v_j_274_, lean_object* v_key_275_){
_start:
{
lean_object* v_res_276_; 
v_res_276_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objStr(v_j_274_, v_key_275_);
lean_dec_ref(v_key_275_);
return v_res_276_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord(lean_object* v_j_282_){
_start:
{
lean_object* v___x_283_; lean_object* v___x_284_; 
v___x_283_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__0));
lean_inc(v_j_282_);
v___x_284_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objNat(v_j_282_, v___x_283_);
if (lean_obj_tag(v___x_284_) == 0)
{
lean_object* v_a_285_; lean_object* v___x_287_; uint8_t v_isShared_288_; uint8_t v_isSharedCheck_292_; 
lean_dec(v_j_282_);
v_a_285_ = lean_ctor_get(v___x_284_, 0);
v_isSharedCheck_292_ = !lean_is_exclusive(v___x_284_);
if (v_isSharedCheck_292_ == 0)
{
v___x_287_ = v___x_284_;
v_isShared_288_ = v_isSharedCheck_292_;
goto v_resetjp_286_;
}
else
{
lean_inc(v_a_285_);
lean_dec(v___x_284_);
v___x_287_ = lean_box(0);
v_isShared_288_ = v_isSharedCheck_292_;
goto v_resetjp_286_;
}
v_resetjp_286_:
{
lean_object* v___x_290_; 
if (v_isShared_288_ == 0)
{
v___x_290_ = v___x_287_;
goto v_reusejp_289_;
}
else
{
lean_object* v_reuseFailAlloc_291_; 
v_reuseFailAlloc_291_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_291_, 0, v_a_285_);
v___x_290_ = v_reuseFailAlloc_291_;
goto v_reusejp_289_;
}
v_reusejp_289_:
{
return v___x_290_;
}
}
}
else
{
lean_object* v_a_293_; lean_object* v___x_294_; lean_object* v___x_295_; 
v_a_293_ = lean_ctor_get(v___x_284_, 0);
lean_inc(v_a_293_);
lean_dec_ref_known(v___x_284_, 1);
v___x_294_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__1));
lean_inc(v_j_282_);
v___x_295_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objInt(v_j_282_, v___x_294_);
if (lean_obj_tag(v___x_295_) == 0)
{
lean_object* v_a_296_; lean_object* v___x_298_; uint8_t v_isShared_299_; uint8_t v_isSharedCheck_303_; 
lean_dec(v_a_293_);
lean_dec(v_j_282_);
v_a_296_ = lean_ctor_get(v___x_295_, 0);
v_isSharedCheck_303_ = !lean_is_exclusive(v___x_295_);
if (v_isSharedCheck_303_ == 0)
{
v___x_298_ = v___x_295_;
v_isShared_299_ = v_isSharedCheck_303_;
goto v_resetjp_297_;
}
else
{
lean_inc(v_a_296_);
lean_dec(v___x_295_);
v___x_298_ = lean_box(0);
v_isShared_299_ = v_isSharedCheck_303_;
goto v_resetjp_297_;
}
v_resetjp_297_:
{
lean_object* v___x_301_; 
if (v_isShared_299_ == 0)
{
v___x_301_ = v___x_298_;
goto v_reusejp_300_;
}
else
{
lean_object* v_reuseFailAlloc_302_; 
v_reuseFailAlloc_302_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_302_, 0, v_a_296_);
v___x_301_ = v_reuseFailAlloc_302_;
goto v_reusejp_300_;
}
v_reusejp_300_:
{
return v___x_301_;
}
}
}
else
{
lean_object* v_a_304_; lean_object* v___x_305_; lean_object* v___x_306_; 
v_a_304_ = lean_ctor_get(v___x_295_, 0);
lean_inc(v_a_304_);
lean_dec_ref_known(v___x_295_, 1);
v___x_305_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__2));
lean_inc(v_j_282_);
v___x_306_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objInt(v_j_282_, v___x_305_);
if (lean_obj_tag(v___x_306_) == 0)
{
lean_object* v_a_307_; lean_object* v___x_309_; uint8_t v_isShared_310_; uint8_t v_isSharedCheck_314_; 
lean_dec(v_a_304_);
lean_dec(v_a_293_);
lean_dec(v_j_282_);
v_a_307_ = lean_ctor_get(v___x_306_, 0);
v_isSharedCheck_314_ = !lean_is_exclusive(v___x_306_);
if (v_isSharedCheck_314_ == 0)
{
v___x_309_ = v___x_306_;
v_isShared_310_ = v_isSharedCheck_314_;
goto v_resetjp_308_;
}
else
{
lean_inc(v_a_307_);
lean_dec(v___x_306_);
v___x_309_ = lean_box(0);
v_isShared_310_ = v_isSharedCheck_314_;
goto v_resetjp_308_;
}
v_resetjp_308_:
{
lean_object* v___x_312_; 
if (v_isShared_310_ == 0)
{
v___x_312_ = v___x_309_;
goto v_reusejp_311_;
}
else
{
lean_object* v_reuseFailAlloc_313_; 
v_reuseFailAlloc_313_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_313_, 0, v_a_307_);
v___x_312_ = v_reuseFailAlloc_313_;
goto v_reusejp_311_;
}
v_reusejp_311_:
{
return v___x_312_;
}
}
}
else
{
lean_object* v_a_315_; lean_object* v___x_316_; lean_object* v___x_317_; 
v_a_315_ = lean_ctor_get(v___x_306_, 0);
lean_inc(v_a_315_);
lean_dec_ref_known(v___x_306_, 1);
v___x_316_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__3));
lean_inc(v_j_282_);
v___x_317_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objInt(v_j_282_, v___x_316_);
if (lean_obj_tag(v___x_317_) == 0)
{
lean_object* v_a_318_; lean_object* v___x_320_; uint8_t v_isShared_321_; uint8_t v_isSharedCheck_325_; 
lean_dec(v_a_315_);
lean_dec(v_a_304_);
lean_dec(v_a_293_);
lean_dec(v_j_282_);
v_a_318_ = lean_ctor_get(v___x_317_, 0);
v_isSharedCheck_325_ = !lean_is_exclusive(v___x_317_);
if (v_isSharedCheck_325_ == 0)
{
v___x_320_ = v___x_317_;
v_isShared_321_ = v_isSharedCheck_325_;
goto v_resetjp_319_;
}
else
{
lean_inc(v_a_318_);
lean_dec(v___x_317_);
v___x_320_ = lean_box(0);
v_isShared_321_ = v_isSharedCheck_325_;
goto v_resetjp_319_;
}
v_resetjp_319_:
{
lean_object* v___x_323_; 
if (v_isShared_321_ == 0)
{
v___x_323_ = v___x_320_;
goto v_reusejp_322_;
}
else
{
lean_object* v_reuseFailAlloc_324_; 
v_reuseFailAlloc_324_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_324_, 0, v_a_318_);
v___x_323_ = v_reuseFailAlloc_324_;
goto v_reusejp_322_;
}
v_reusejp_322_:
{
return v___x_323_;
}
}
}
else
{
lean_object* v_a_326_; lean_object* v___x_327_; lean_object* v___x_328_; 
v_a_326_ = lean_ctor_get(v___x_317_, 0);
lean_inc(v_a_326_);
lean_dec_ref_known(v___x_317_, 1);
v___x_327_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord___closed__4));
v___x_328_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objInt(v_j_282_, v___x_327_);
if (lean_obj_tag(v___x_328_) == 0)
{
lean_object* v_a_329_; lean_object* v___x_331_; uint8_t v_isShared_332_; uint8_t v_isSharedCheck_336_; 
lean_dec(v_a_326_);
lean_dec(v_a_315_);
lean_dec(v_a_304_);
lean_dec(v_a_293_);
v_a_329_ = lean_ctor_get(v___x_328_, 0);
v_isSharedCheck_336_ = !lean_is_exclusive(v___x_328_);
if (v_isSharedCheck_336_ == 0)
{
v___x_331_ = v___x_328_;
v_isShared_332_ = v_isSharedCheck_336_;
goto v_resetjp_330_;
}
else
{
lean_inc(v_a_329_);
lean_dec(v___x_328_);
v___x_331_ = lean_box(0);
v_isShared_332_ = v_isSharedCheck_336_;
goto v_resetjp_330_;
}
v_resetjp_330_:
{
lean_object* v___x_334_; 
if (v_isShared_332_ == 0)
{
v___x_334_ = v___x_331_;
goto v_reusejp_333_;
}
else
{
lean_object* v_reuseFailAlloc_335_; 
v_reuseFailAlloc_335_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_335_, 0, v_a_329_);
v___x_334_ = v_reuseFailAlloc_335_;
goto v_reusejp_333_;
}
v_reusejp_333_:
{
return v___x_334_;
}
}
}
else
{
lean_object* v_a_337_; lean_object* v___x_339_; uint8_t v_isShared_340_; uint8_t v_isSharedCheck_345_; 
v_a_337_ = lean_ctor_get(v___x_328_, 0);
v_isSharedCheck_345_ = !lean_is_exclusive(v___x_328_);
if (v_isSharedCheck_345_ == 0)
{
v___x_339_ = v___x_328_;
v_isShared_340_ = v_isSharedCheck_345_;
goto v_resetjp_338_;
}
else
{
lean_inc(v_a_337_);
lean_dec(v___x_328_);
v___x_339_ = lean_box(0);
v_isShared_340_ = v_isSharedCheck_345_;
goto v_resetjp_338_;
}
v_resetjp_338_:
{
lean_object* v___x_341_; lean_object* v___x_343_; 
v___x_341_ = lean_alloc_ctor(0, 5, 0);
lean_ctor_set(v___x_341_, 0, v_a_293_);
lean_ctor_set(v___x_341_, 1, v_a_304_);
lean_ctor_set(v___x_341_, 2, v_a_315_);
lean_ctor_set(v___x_341_, 3, v_a_326_);
lean_ctor_set(v___x_341_, 4, v_a_337_);
if (v_isShared_340_ == 0)
{
lean_ctor_set(v___x_339_, 0, v___x_341_);
v___x_343_ = v___x_339_;
goto v_reusejp_342_;
}
else
{
lean_object* v_reuseFailAlloc_344_; 
v_reuseFailAlloc_344_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_344_, 0, v___x_341_);
v___x_343_ = v_reuseFailAlloc_344_;
goto v_reusejp_342_;
}
v_reusejp_342_:
{
return v___x_343_;
}
}
}
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeConfig(lean_object* v_j_348_){
_start:
{
lean_object* v___x_349_; lean_object* v___x_350_; 
v___x_349_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeConfig___closed__0));
lean_inc(v_j_348_);
v___x_350_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objInt(v_j_348_, v___x_349_);
if (lean_obj_tag(v___x_350_) == 0)
{
lean_object* v_a_351_; lean_object* v___x_353_; uint8_t v_isShared_354_; uint8_t v_isSharedCheck_358_; 
lean_dec(v_j_348_);
v_a_351_ = lean_ctor_get(v___x_350_, 0);
v_isSharedCheck_358_ = !lean_is_exclusive(v___x_350_);
if (v_isSharedCheck_358_ == 0)
{
v___x_353_ = v___x_350_;
v_isShared_354_ = v_isSharedCheck_358_;
goto v_resetjp_352_;
}
else
{
lean_inc(v_a_351_);
lean_dec(v___x_350_);
v___x_353_ = lean_box(0);
v_isShared_354_ = v_isSharedCheck_358_;
goto v_resetjp_352_;
}
v_resetjp_352_:
{
lean_object* v___x_356_; 
if (v_isShared_354_ == 0)
{
v___x_356_ = v___x_353_;
goto v_reusejp_355_;
}
else
{
lean_object* v_reuseFailAlloc_357_; 
v_reuseFailAlloc_357_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_357_, 0, v_a_351_);
v___x_356_ = v_reuseFailAlloc_357_;
goto v_reusejp_355_;
}
v_reusejp_355_:
{
return v___x_356_;
}
}
}
else
{
lean_object* v_a_359_; lean_object* v___x_360_; lean_object* v___x_361_; 
v_a_359_ = lean_ctor_get(v___x_350_, 0);
lean_inc(v_a_359_);
lean_dec_ref_known(v___x_350_, 1);
v___x_360_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeConfig___closed__1));
v___x_361_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objInt(v_j_348_, v___x_360_);
if (lean_obj_tag(v___x_361_) == 0)
{
lean_object* v_a_362_; lean_object* v___x_364_; uint8_t v_isShared_365_; uint8_t v_isSharedCheck_369_; 
lean_dec(v_a_359_);
v_a_362_ = lean_ctor_get(v___x_361_, 0);
v_isSharedCheck_369_ = !lean_is_exclusive(v___x_361_);
if (v_isSharedCheck_369_ == 0)
{
v___x_364_ = v___x_361_;
v_isShared_365_ = v_isSharedCheck_369_;
goto v_resetjp_363_;
}
else
{
lean_inc(v_a_362_);
lean_dec(v___x_361_);
v___x_364_ = lean_box(0);
v_isShared_365_ = v_isSharedCheck_369_;
goto v_resetjp_363_;
}
v_resetjp_363_:
{
lean_object* v___x_367_; 
if (v_isShared_365_ == 0)
{
v___x_367_ = v___x_364_;
goto v_reusejp_366_;
}
else
{
lean_object* v_reuseFailAlloc_368_; 
v_reuseFailAlloc_368_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_368_, 0, v_a_362_);
v___x_367_ = v_reuseFailAlloc_368_;
goto v_reusejp_366_;
}
v_reusejp_366_:
{
return v___x_367_;
}
}
}
else
{
lean_object* v_a_370_; lean_object* v___x_372_; uint8_t v_isShared_373_; uint8_t v_isSharedCheck_378_; 
v_a_370_ = lean_ctor_get(v___x_361_, 0);
v_isSharedCheck_378_ = !lean_is_exclusive(v___x_361_);
if (v_isSharedCheck_378_ == 0)
{
v___x_372_ = v___x_361_;
v_isShared_373_ = v_isSharedCheck_378_;
goto v_resetjp_371_;
}
else
{
lean_inc(v_a_370_);
lean_dec(v___x_361_);
v___x_372_ = lean_box(0);
v_isShared_373_ = v_isSharedCheck_378_;
goto v_resetjp_371_;
}
v_resetjp_371_:
{
lean_object* v___x_374_; lean_object* v___x_376_; 
v___x_374_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_374_, 0, v_a_359_);
lean_ctor_set(v___x_374_, 1, v_a_370_);
if (v_isShared_373_ == 0)
{
lean_ctor_set(v___x_372_, 0, v___x_374_);
v___x_376_ = v___x_372_;
goto v_reusejp_375_;
}
else
{
lean_object* v_reuseFailAlloc_377_; 
v_reuseFailAlloc_377_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_377_, 0, v___x_374_);
v___x_376_ = v_reuseFailAlloc_377_;
goto v_reusejp_375_;
}
v_reusejp_375_:
{
return v___x_376_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_mapM_loop___at___00PhysicalBridges_IRJsonTraceChecker_decodeTraceJson_spec__0(lean_object* v_x_379_, lean_object* v_x_380_){
_start:
{
if (lean_obj_tag(v_x_379_) == 0)
{
lean_object* v___x_381_; lean_object* v___x_382_; 
v___x_381_ = l_List_reverse___redArg(v_x_380_);
v___x_382_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v___x_382_, 0, v___x_381_);
return v___x_382_;
}
else
{
lean_object* v_head_383_; lean_object* v_tail_384_; lean_object* v___x_386_; uint8_t v_isShared_387_; uint8_t v_isSharedCheck_402_; 
v_head_383_ = lean_ctor_get(v_x_379_, 0);
v_tail_384_ = lean_ctor_get(v_x_379_, 1);
v_isSharedCheck_402_ = !lean_is_exclusive(v_x_379_);
if (v_isSharedCheck_402_ == 0)
{
v___x_386_ = v_x_379_;
v_isShared_387_ = v_isSharedCheck_402_;
goto v_resetjp_385_;
}
else
{
lean_inc(v_tail_384_);
lean_inc(v_head_383_);
lean_dec(v_x_379_);
v___x_386_ = lean_box(0);
v_isShared_387_ = v_isSharedCheck_402_;
goto v_resetjp_385_;
}
v_resetjp_385_:
{
lean_object* v___x_388_; 
v___x_388_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeRecord(v_head_383_);
if (lean_obj_tag(v___x_388_) == 0)
{
lean_object* v_a_389_; lean_object* v___x_391_; uint8_t v_isShared_392_; uint8_t v_isSharedCheck_396_; 
lean_del_object(v___x_386_);
lean_dec(v_tail_384_);
lean_dec(v_x_380_);
v_a_389_ = lean_ctor_get(v___x_388_, 0);
v_isSharedCheck_396_ = !lean_is_exclusive(v___x_388_);
if (v_isSharedCheck_396_ == 0)
{
v___x_391_ = v___x_388_;
v_isShared_392_ = v_isSharedCheck_396_;
goto v_resetjp_390_;
}
else
{
lean_inc(v_a_389_);
lean_dec(v___x_388_);
v___x_391_ = lean_box(0);
v_isShared_392_ = v_isSharedCheck_396_;
goto v_resetjp_390_;
}
v_resetjp_390_:
{
lean_object* v___x_394_; 
if (v_isShared_392_ == 0)
{
v___x_394_ = v___x_391_;
goto v_reusejp_393_;
}
else
{
lean_object* v_reuseFailAlloc_395_; 
v_reuseFailAlloc_395_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_395_, 0, v_a_389_);
v___x_394_ = v_reuseFailAlloc_395_;
goto v_reusejp_393_;
}
v_reusejp_393_:
{
return v___x_394_;
}
}
}
else
{
lean_object* v_a_397_; lean_object* v___x_399_; 
v_a_397_ = lean_ctor_get(v___x_388_, 0);
lean_inc(v_a_397_);
lean_dec_ref_known(v___x_388_, 1);
if (v_isShared_387_ == 0)
{
lean_ctor_set(v___x_386_, 1, v_x_380_);
lean_ctor_set(v___x_386_, 0, v_a_397_);
v___x_399_ = v___x_386_;
goto v_reusejp_398_;
}
else
{
lean_object* v_reuseFailAlloc_401_; 
v_reuseFailAlloc_401_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_401_, 0, v_a_397_);
lean_ctor_set(v_reuseFailAlloc_401_, 1, v_x_380_);
v___x_399_ = v_reuseFailAlloc_401_;
goto v_reusejp_398_;
}
v_reusejp_398_:
{
v_x_379_ = v_tail_384_;
v_x_380_ = v___x_399_;
goto _start;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson(lean_object* v_raw_426_){
_start:
{
lean_object* v___x_427_; 
v___x_427_ = l_Lean_Json_parse(v_raw_426_);
if (lean_obj_tag(v___x_427_) == 0)
{
lean_object* v_a_428_; lean_object* v___x_430_; uint8_t v_isShared_431_; uint8_t v_isSharedCheck_435_; 
v_a_428_ = lean_ctor_get(v___x_427_, 0);
v_isSharedCheck_435_ = !lean_is_exclusive(v___x_427_);
if (v_isSharedCheck_435_ == 0)
{
v___x_430_ = v___x_427_;
v_isShared_431_ = v_isSharedCheck_435_;
goto v_resetjp_429_;
}
else
{
lean_inc(v_a_428_);
lean_dec(v___x_427_);
v___x_430_ = lean_box(0);
v_isShared_431_ = v_isSharedCheck_435_;
goto v_resetjp_429_;
}
v_resetjp_429_:
{
lean_object* v___x_433_; 
if (v_isShared_431_ == 0)
{
v___x_433_ = v___x_430_;
goto v_reusejp_432_;
}
else
{
lean_object* v_reuseFailAlloc_434_; 
v_reuseFailAlloc_434_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_434_, 0, v_a_428_);
v___x_433_ = v_reuseFailAlloc_434_;
goto v_reusejp_432_;
}
v_reusejp_432_:
{
return v___x_433_;
}
}
}
else
{
lean_object* v_a_436_; lean_object* v___x_437_; lean_object* v___x_438_; 
v_a_436_ = lean_ctor_get(v___x_427_, 0);
lean_inc_n(v_a_436_, 2);
lean_dec_ref_known(v___x_427_, 1);
v___x_437_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__0));
v___x_438_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objNat(v_a_436_, v___x_437_);
if (lean_obj_tag(v___x_438_) == 0)
{
lean_object* v_a_439_; lean_object* v___x_441_; uint8_t v_isShared_442_; uint8_t v_isSharedCheck_446_; 
lean_dec(v_a_436_);
v_a_439_ = lean_ctor_get(v___x_438_, 0);
v_isSharedCheck_446_ = !lean_is_exclusive(v___x_438_);
if (v_isSharedCheck_446_ == 0)
{
v___x_441_ = v___x_438_;
v_isShared_442_ = v_isSharedCheck_446_;
goto v_resetjp_440_;
}
else
{
lean_inc(v_a_439_);
lean_dec(v___x_438_);
v___x_441_ = lean_box(0);
v_isShared_442_ = v_isSharedCheck_446_;
goto v_resetjp_440_;
}
v_resetjp_440_:
{
lean_object* v___x_444_; 
if (v_isShared_442_ == 0)
{
v___x_444_ = v___x_441_;
goto v_reusejp_443_;
}
else
{
lean_object* v_reuseFailAlloc_445_; 
v_reuseFailAlloc_445_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_445_, 0, v_a_439_);
v___x_444_ = v_reuseFailAlloc_445_;
goto v_reusejp_443_;
}
v_reusejp_443_:
{
return v___x_444_;
}
}
}
else
{
lean_object* v_a_447_; lean_object* v___x_448_; uint8_t v___x_449_; 
v_a_447_ = lean_ctor_get(v___x_438_, 0);
lean_inc(v_a_447_);
lean_dec_ref_known(v___x_438_, 1);
v___x_448_ = lean_unsigned_to_nat(1u);
v___x_449_ = lean_nat_dec_eq(v_a_447_, v___x_448_);
if (v___x_449_ == 0)
{
lean_object* v___x_450_; 
lean_dec(v_a_447_);
lean_dec(v_a_436_);
v___x_450_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__2));
return v___x_450_;
}
else
{
lean_object* v___x_451_; lean_object* v___x_452_; 
v___x_451_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__3));
lean_inc(v_a_436_);
v___x_452_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objStr(v_a_436_, v___x_451_);
if (lean_obj_tag(v___x_452_) == 0)
{
lean_object* v_a_453_; lean_object* v___x_455_; uint8_t v_isShared_456_; uint8_t v_isSharedCheck_460_; 
lean_dec(v_a_447_);
lean_dec(v_a_436_);
v_a_453_ = lean_ctor_get(v___x_452_, 0);
v_isSharedCheck_460_ = !lean_is_exclusive(v___x_452_);
if (v_isSharedCheck_460_ == 0)
{
v___x_455_ = v___x_452_;
v_isShared_456_ = v_isSharedCheck_460_;
goto v_resetjp_454_;
}
else
{
lean_inc(v_a_453_);
lean_dec(v___x_452_);
v___x_455_ = lean_box(0);
v_isShared_456_ = v_isSharedCheck_460_;
goto v_resetjp_454_;
}
v_resetjp_454_:
{
lean_object* v___x_458_; 
if (v_isShared_456_ == 0)
{
v___x_458_ = v___x_455_;
goto v_reusejp_457_;
}
else
{
lean_object* v_reuseFailAlloc_459_; 
v_reuseFailAlloc_459_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_459_, 0, v_a_453_);
v___x_458_ = v_reuseFailAlloc_459_;
goto v_reusejp_457_;
}
v_reusejp_457_:
{
return v___x_458_;
}
}
}
else
{
lean_object* v_a_461_; lean_object* v___x_462_; uint8_t v___x_463_; 
v_a_461_ = lean_ctor_get(v___x_452_, 0);
lean_inc(v_a_461_);
lean_dec_ref_known(v___x_452_, 1);
v___x_462_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__4));
v___x_463_ = lean_string_dec_eq(v_a_461_, v___x_462_);
if (v___x_463_ == 0)
{
lean_object* v___x_464_; 
lean_dec(v_a_461_);
lean_dec(v_a_447_);
lean_dec(v_a_436_);
v___x_464_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__6));
return v___x_464_;
}
else
{
lean_object* v___x_465_; lean_object* v___x_466_; 
v___x_465_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__7));
lean_inc(v_a_436_);
v___x_466_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objStr(v_a_436_, v___x_465_);
if (lean_obj_tag(v___x_466_) == 0)
{
lean_object* v_a_467_; lean_object* v___x_469_; uint8_t v_isShared_470_; uint8_t v_isSharedCheck_474_; 
lean_dec(v_a_461_);
lean_dec(v_a_447_);
lean_dec(v_a_436_);
v_a_467_ = lean_ctor_get(v___x_466_, 0);
v_isSharedCheck_474_ = !lean_is_exclusive(v___x_466_);
if (v_isSharedCheck_474_ == 0)
{
v___x_469_ = v___x_466_;
v_isShared_470_ = v_isSharedCheck_474_;
goto v_resetjp_468_;
}
else
{
lean_inc(v_a_467_);
lean_dec(v___x_466_);
v___x_469_ = lean_box(0);
v_isShared_470_ = v_isSharedCheck_474_;
goto v_resetjp_468_;
}
v_resetjp_468_:
{
lean_object* v___x_472_; 
if (v_isShared_470_ == 0)
{
v___x_472_ = v___x_469_;
goto v_reusejp_471_;
}
else
{
lean_object* v_reuseFailAlloc_473_; 
v_reuseFailAlloc_473_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_473_, 0, v_a_467_);
v___x_472_ = v_reuseFailAlloc_473_;
goto v_reusejp_471_;
}
v_reusejp_471_:
{
return v___x_472_;
}
}
}
else
{
lean_object* v_a_475_; lean_object* v___x_476_; uint8_t v___x_477_; 
v_a_475_ = lean_ctor_get(v___x_466_, 0);
lean_inc(v_a_475_);
lean_dec_ref_known(v___x_466_, 1);
v___x_476_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__8));
v___x_477_ = lean_string_dec_eq(v_a_475_, v___x_476_);
if (v___x_477_ == 0)
{
lean_object* v___x_478_; 
lean_dec(v_a_475_);
lean_dec(v_a_461_);
lean_dec(v_a_447_);
lean_dec(v_a_436_);
v___x_478_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__10));
return v___x_478_;
}
else
{
lean_object* v___x_479_; lean_object* v___x_480_; 
v___x_479_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__11));
lean_inc(v_a_436_);
v___x_480_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objNat(v_a_436_, v___x_479_);
if (lean_obj_tag(v___x_480_) == 0)
{
lean_object* v_a_481_; lean_object* v___x_483_; uint8_t v_isShared_484_; uint8_t v_isSharedCheck_488_; 
lean_dec(v_a_475_);
lean_dec(v_a_461_);
lean_dec(v_a_447_);
lean_dec(v_a_436_);
v_a_481_ = lean_ctor_get(v___x_480_, 0);
v_isSharedCheck_488_ = !lean_is_exclusive(v___x_480_);
if (v_isSharedCheck_488_ == 0)
{
v___x_483_ = v___x_480_;
v_isShared_484_ = v_isSharedCheck_488_;
goto v_resetjp_482_;
}
else
{
lean_inc(v_a_481_);
lean_dec(v___x_480_);
v___x_483_ = lean_box(0);
v_isShared_484_ = v_isSharedCheck_488_;
goto v_resetjp_482_;
}
v_resetjp_482_:
{
lean_object* v___x_486_; 
if (v_isShared_484_ == 0)
{
v___x_486_ = v___x_483_;
goto v_reusejp_485_;
}
else
{
lean_object* v_reuseFailAlloc_487_; 
v_reuseFailAlloc_487_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_487_, 0, v_a_481_);
v___x_486_ = v_reuseFailAlloc_487_;
goto v_reusejp_485_;
}
v_reusejp_485_:
{
return v___x_486_;
}
}
}
else
{
lean_object* v_a_489_; lean_object* v___x_490_; uint8_t v___x_491_; 
v_a_489_ = lean_ctor_get(v___x_480_, 0);
lean_inc(v_a_489_);
lean_dec_ref_known(v___x_480_, 1);
v___x_490_ = lean_unsigned_to_nat(0u);
v___x_491_ = lean_nat_dec_eq(v_a_489_, v___x_490_);
if (v___x_491_ == 0)
{
lean_object* v___x_492_; lean_object* v___x_493_; 
v___x_492_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__12));
lean_inc(v_a_436_);
v___x_493_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_objStr(v_a_436_, v___x_492_);
if (lean_obj_tag(v___x_493_) == 0)
{
lean_object* v_a_494_; lean_object* v___x_496_; uint8_t v_isShared_497_; uint8_t v_isSharedCheck_501_; 
lean_dec(v_a_489_);
lean_dec(v_a_475_);
lean_dec(v_a_461_);
lean_dec(v_a_447_);
lean_dec(v_a_436_);
v_a_494_ = lean_ctor_get(v___x_493_, 0);
v_isSharedCheck_501_ = !lean_is_exclusive(v___x_493_);
if (v_isSharedCheck_501_ == 0)
{
v___x_496_ = v___x_493_;
v_isShared_497_ = v_isSharedCheck_501_;
goto v_resetjp_495_;
}
else
{
lean_inc(v_a_494_);
lean_dec(v___x_493_);
v___x_496_ = lean_box(0);
v_isShared_497_ = v_isSharedCheck_501_;
goto v_resetjp_495_;
}
v_resetjp_495_:
{
lean_object* v___x_499_; 
if (v_isShared_497_ == 0)
{
v___x_499_ = v___x_496_;
goto v_reusejp_498_;
}
else
{
lean_object* v_reuseFailAlloc_500_; 
v_reuseFailAlloc_500_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_500_, 0, v_a_494_);
v___x_499_ = v_reuseFailAlloc_500_;
goto v_reusejp_498_;
}
v_reusejp_498_:
{
return v___x_499_;
}
}
}
else
{
lean_object* v_a_502_; lean_object* v___x_503_; uint8_t v___x_504_; 
v_a_502_ = lean_ctor_get(v___x_493_, 0);
lean_inc(v_a_502_);
lean_dec_ref_known(v___x_493_, 1);
v___x_503_ = lean_string_utf8_byte_size(v_a_502_);
v___x_504_ = lean_nat_dec_eq(v___x_503_, v___x_490_);
if (v___x_504_ == 0)
{
lean_object* v___x_505_; lean_object* v___x_506_; 
v___x_505_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__13));
lean_inc(v_a_436_);
v___x_506_ = l_Lean_Json_getObjVal_x3f(v_a_436_, v___x_505_);
if (lean_obj_tag(v___x_506_) == 0)
{
lean_object* v_a_507_; lean_object* v___x_509_; uint8_t v_isShared_510_; uint8_t v_isSharedCheck_514_; 
lean_dec(v_a_502_);
lean_dec(v_a_489_);
lean_dec(v_a_475_);
lean_dec(v_a_461_);
lean_dec(v_a_447_);
lean_dec(v_a_436_);
v_a_507_ = lean_ctor_get(v___x_506_, 0);
v_isSharedCheck_514_ = !lean_is_exclusive(v___x_506_);
if (v_isSharedCheck_514_ == 0)
{
v___x_509_ = v___x_506_;
v_isShared_510_ = v_isSharedCheck_514_;
goto v_resetjp_508_;
}
else
{
lean_inc(v_a_507_);
lean_dec(v___x_506_);
v___x_509_ = lean_box(0);
v_isShared_510_ = v_isSharedCheck_514_;
goto v_resetjp_508_;
}
v_resetjp_508_:
{
lean_object* v___x_512_; 
if (v_isShared_510_ == 0)
{
v___x_512_ = v___x_509_;
goto v_reusejp_511_;
}
else
{
lean_object* v_reuseFailAlloc_513_; 
v_reuseFailAlloc_513_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_513_, 0, v_a_507_);
v___x_512_ = v_reuseFailAlloc_513_;
goto v_reusejp_511_;
}
v_reusejp_511_:
{
return v___x_512_;
}
}
}
else
{
lean_object* v_a_515_; lean_object* v___x_516_; 
v_a_515_ = lean_ctor_get(v___x_506_, 0);
lean_inc(v_a_515_);
lean_dec_ref_known(v___x_506_, 1);
v___x_516_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeConfig(v_a_515_);
if (lean_obj_tag(v___x_516_) == 0)
{
lean_object* v_a_517_; lean_object* v___x_519_; uint8_t v_isShared_520_; uint8_t v_isSharedCheck_524_; 
lean_dec(v_a_502_);
lean_dec(v_a_489_);
lean_dec(v_a_475_);
lean_dec(v_a_461_);
lean_dec(v_a_447_);
lean_dec(v_a_436_);
v_a_517_ = lean_ctor_get(v___x_516_, 0);
v_isSharedCheck_524_ = !lean_is_exclusive(v___x_516_);
if (v_isSharedCheck_524_ == 0)
{
v___x_519_ = v___x_516_;
v_isShared_520_ = v_isSharedCheck_524_;
goto v_resetjp_518_;
}
else
{
lean_inc(v_a_517_);
lean_dec(v___x_516_);
v___x_519_ = lean_box(0);
v_isShared_520_ = v_isSharedCheck_524_;
goto v_resetjp_518_;
}
v_resetjp_518_:
{
lean_object* v___x_522_; 
if (v_isShared_520_ == 0)
{
v___x_522_ = v___x_519_;
goto v_reusejp_521_;
}
else
{
lean_object* v_reuseFailAlloc_523_; 
v_reuseFailAlloc_523_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_523_, 0, v_a_517_);
v___x_522_ = v_reuseFailAlloc_523_;
goto v_reusejp_521_;
}
v_reusejp_521_:
{
return v___x_522_;
}
}
}
else
{
lean_object* v_a_525_; lean_object* v___x_526_; lean_object* v___x_527_; 
v_a_525_ = lean_ctor_get(v___x_516_, 0);
lean_inc(v_a_525_);
lean_dec_ref_known(v___x_516_, 1);
v___x_526_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_instReprJsonTrace_repr___redArg___closed__23));
v___x_527_ = l_Lean_Json_getObjVal_x3f(v_a_436_, v___x_526_);
if (lean_obj_tag(v___x_527_) == 0)
{
lean_object* v_a_528_; lean_object* v___x_530_; uint8_t v_isShared_531_; uint8_t v_isSharedCheck_535_; 
lean_dec(v_a_525_);
lean_dec(v_a_502_);
lean_dec(v_a_489_);
lean_dec(v_a_475_);
lean_dec(v_a_461_);
lean_dec(v_a_447_);
v_a_528_ = lean_ctor_get(v___x_527_, 0);
v_isSharedCheck_535_ = !lean_is_exclusive(v___x_527_);
if (v_isSharedCheck_535_ == 0)
{
v___x_530_ = v___x_527_;
v_isShared_531_ = v_isSharedCheck_535_;
goto v_resetjp_529_;
}
else
{
lean_inc(v_a_528_);
lean_dec(v___x_527_);
v___x_530_ = lean_box(0);
v_isShared_531_ = v_isSharedCheck_535_;
goto v_resetjp_529_;
}
v_resetjp_529_:
{
lean_object* v___x_533_; 
if (v_isShared_531_ == 0)
{
v___x_533_ = v___x_530_;
goto v_reusejp_532_;
}
else
{
lean_object* v_reuseFailAlloc_534_; 
v_reuseFailAlloc_534_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_534_, 0, v_a_528_);
v___x_533_ = v_reuseFailAlloc_534_;
goto v_reusejp_532_;
}
v_reusejp_532_:
{
return v___x_533_;
}
}
}
else
{
lean_object* v_a_536_; lean_object* v___x_537_; 
v_a_536_ = lean_ctor_get(v___x_527_, 0);
lean_inc(v_a_536_);
lean_dec_ref_known(v___x_527_, 1);
v___x_537_ = l_Lean_Json_getArr_x3f(v_a_536_);
if (lean_obj_tag(v___x_537_) == 0)
{
lean_object* v_a_538_; lean_object* v___x_540_; uint8_t v_isShared_541_; uint8_t v_isSharedCheck_545_; 
lean_dec(v_a_525_);
lean_dec(v_a_502_);
lean_dec(v_a_489_);
lean_dec(v_a_475_);
lean_dec(v_a_461_);
lean_dec(v_a_447_);
v_a_538_ = lean_ctor_get(v___x_537_, 0);
v_isSharedCheck_545_ = !lean_is_exclusive(v___x_537_);
if (v_isSharedCheck_545_ == 0)
{
v___x_540_ = v___x_537_;
v_isShared_541_ = v_isSharedCheck_545_;
goto v_resetjp_539_;
}
else
{
lean_inc(v_a_538_);
lean_dec(v___x_537_);
v___x_540_ = lean_box(0);
v_isShared_541_ = v_isSharedCheck_545_;
goto v_resetjp_539_;
}
v_resetjp_539_:
{
lean_object* v___x_543_; 
if (v_isShared_541_ == 0)
{
v___x_543_ = v___x_540_;
goto v_reusejp_542_;
}
else
{
lean_object* v_reuseFailAlloc_544_; 
v_reuseFailAlloc_544_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_544_, 0, v_a_538_);
v___x_543_ = v_reuseFailAlloc_544_;
goto v_reusejp_542_;
}
v_reusejp_542_:
{
return v___x_543_;
}
}
}
else
{
lean_object* v_a_546_; lean_object* v___x_547_; lean_object* v___x_548_; lean_object* v___x_549_; 
v_a_546_ = lean_ctor_get(v___x_537_, 0);
lean_inc(v_a_546_);
lean_dec_ref_known(v___x_537_, 1);
v___x_547_ = lean_array_to_list(v_a_546_);
v___x_548_ = lean_box(0);
v___x_549_ = lp_physical__bridges_List_mapM_loop___at___00PhysicalBridges_IRJsonTraceChecker_decodeTraceJson_spec__0(v___x_547_, v___x_548_);
if (lean_obj_tag(v___x_549_) == 0)
{
lean_object* v_a_550_; lean_object* v___x_552_; uint8_t v_isShared_553_; uint8_t v_isSharedCheck_557_; 
lean_dec(v_a_525_);
lean_dec(v_a_502_);
lean_dec(v_a_489_);
lean_dec(v_a_475_);
lean_dec(v_a_461_);
lean_dec(v_a_447_);
v_a_550_ = lean_ctor_get(v___x_549_, 0);
v_isSharedCheck_557_ = !lean_is_exclusive(v___x_549_);
if (v_isSharedCheck_557_ == 0)
{
v___x_552_ = v___x_549_;
v_isShared_553_ = v_isSharedCheck_557_;
goto v_resetjp_551_;
}
else
{
lean_inc(v_a_550_);
lean_dec(v___x_549_);
v___x_552_ = lean_box(0);
v_isShared_553_ = v_isSharedCheck_557_;
goto v_resetjp_551_;
}
v_resetjp_551_:
{
lean_object* v___x_555_; 
if (v_isShared_553_ == 0)
{
v___x_555_ = v___x_552_;
goto v_reusejp_554_;
}
else
{
lean_object* v_reuseFailAlloc_556_; 
v_reuseFailAlloc_556_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v_reuseFailAlloc_556_, 0, v_a_550_);
v___x_555_ = v_reuseFailAlloc_556_;
goto v_reusejp_554_;
}
v_reusejp_554_:
{
return v___x_555_;
}
}
}
else
{
lean_object* v_a_558_; lean_object* v___x_560_; uint8_t v_isShared_561_; uint8_t v_isSharedCheck_566_; 
v_a_558_ = lean_ctor_get(v___x_549_, 0);
v_isSharedCheck_566_ = !lean_is_exclusive(v___x_549_);
if (v_isSharedCheck_566_ == 0)
{
v___x_560_ = v___x_549_;
v_isShared_561_ = v_isSharedCheck_566_;
goto v_resetjp_559_;
}
else
{
lean_inc(v_a_558_);
lean_dec(v___x_549_);
v___x_560_ = lean_box(0);
v_isShared_561_ = v_isSharedCheck_566_;
goto v_resetjp_559_;
}
v_resetjp_559_:
{
lean_object* v___x_562_; lean_object* v___x_564_; 
v___x_562_ = lean_alloc_ctor(0, 7, 0);
lean_ctor_set(v___x_562_, 0, v_a_447_);
lean_ctor_set(v___x_562_, 1, v_a_502_);
lean_ctor_set(v___x_562_, 2, v_a_461_);
lean_ctor_set(v___x_562_, 3, v_a_475_);
lean_ctor_set(v___x_562_, 4, v_a_489_);
lean_ctor_set(v___x_562_, 5, v_a_525_);
lean_ctor_set(v___x_562_, 6, v_a_558_);
if (v_isShared_561_ == 0)
{
lean_ctor_set(v___x_560_, 0, v___x_562_);
v___x_564_ = v___x_560_;
goto v_reusejp_563_;
}
else
{
lean_object* v_reuseFailAlloc_565_; 
v_reuseFailAlloc_565_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_565_, 0, v___x_562_);
v___x_564_ = v_reuseFailAlloc_565_;
goto v_reusejp_563_;
}
v_reusejp_563_:
{
return v___x_564_;
}
}
}
}
}
}
}
}
else
{
lean_object* v___x_567_; 
lean_dec(v_a_502_);
lean_dec(v_a_489_);
lean_dec(v_a_475_);
lean_dec(v_a_461_);
lean_dec(v_a_447_);
lean_dec(v_a_436_);
v___x_567_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__15));
return v___x_567_;
}
}
}
else
{
lean_object* v___x_568_; 
lean_dec(v_a_489_);
lean_dec(v_a_475_);
lean_dec(v_a_461_);
lean_dec(v_a_447_);
lean_dec(v_a_436_);
v___x_568_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson___closed__17));
return v___x_568_;
}
}
}
}
}
}
}
}
}
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_verifyJsonText(lean_object* v_raw_569_){
_start:
{
lean_object* v___x_570_; 
v___x_570_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_decodeTraceJson(v_raw_569_);
if (lean_obj_tag(v___x_570_) == 0)
{
uint8_t v___x_571_; 
lean_dec_ref_known(v___x_570_, 1);
v___x_571_ = 0;
return v___x_571_;
}
else
{
lean_object* v_a_572_; lean_object* v_cfg_573_; lean_object* v_records_574_; uint8_t v___x_575_; 
v_a_572_ = lean_ctor_get(v___x_570_, 0);
lean_inc(v_a_572_);
lean_dec_ref_known(v___x_570_, 1);
v_cfg_573_ = lean_ctor_get(v_a_572_, 5);
lean_inc_ref(v_cfg_573_);
v_records_574_ = lean_ctor_get(v_a_572_, 6);
lean_inc(v_records_574_);
lean_dec(v_a_572_);
v___x_575_ = lp_physical__bridges_PhysicalBridges_IRTypedTraceChecker_verifyTraceData(v_cfg_573_, v_records_574_);
lean_dec(v_records_574_);
lean_dec_ref(v_cfg_573_);
return v___x_575_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_verifyJsonText___boxed(lean_object* v_raw_576_){
_start:
{
uint8_t v_res_577_; lean_object* v_r_578_; 
v_res_577_ = lp_physical__bridges_PhysicalBridges_IRJsonTraceChecker_verifyJsonText(v_raw_576_);
v_r_578_ = lean_box(v_res_577_);
return v_r_578_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Lean(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRTypedTraceChecker(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRJsonTraceChecker(uint8_t builtin) {
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
res = initialize_Lean(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_physical__bridges_PhysicalBridges_IRTypedTraceChecker(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
