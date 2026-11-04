// Lean compiler output
// Module: ControllerFinality
// Imports: public import Init public meta import Init
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
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* lean_nat_to_int(lean_object*);
lean_object* l_Nat_reprFast(lean_object*);
lean_object* lean_string_length(lean_object*);
lean_object* l_Std_Format_fill(lean_object*);
lean_object* l_instDecidableEqNat___boxed(lean_object*, lean_object*);
uint8_t l_instDecidableEqList___redArg(lean_object*, lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
uint8_t l_Option_instDecidableEq___redArg(lean_object*, lean_object*, lean_object*);
lean_object* l_Repr_addAppParen(lean_object*, lean_object*);
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
lean_object* l_Bool_repr___redArg(uint8_t);
uint8_t lean_nat_dec_lt(lean_object*, lean_object*);
lean_object* l_List_appendTR___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_tally___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_tally(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_tally_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_tally_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqContext_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqContext_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqContext(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqContext___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr_x27___at___00UPTController_instReprContext_repr_spec__0_spec__0_spec__1_spec__2(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00Std_Format_joinSep___at___00List_repr_x27___at___00UPTController_instReprContext_repr_spec__0_spec__0_spec__1(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_Std_Format_joinSep___at___00List_repr_x27___at___00UPTController_instReprContext_repr_spec__0_spec__0___lam__0(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_Std_Format_joinSep___at___00List_repr_x27___at___00UPTController_instReprContext_repr_spec__0_spec__0(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "[]"};
static const lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__0_value;
static const lean_ctor_object lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__1_value;
static const lean_string_object lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = "["};
static const lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__2_value;
static const lean_string_object lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = ","};
static const lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__3_value;
static const lean_ctor_object lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__3_value)}};
static const lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__4 = (const lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__4_value;
static const lean_ctor_object lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__4_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__5_value;
static const lean_string_object lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = "]"};
static const lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__6_value;
static lean_once_cell_t lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__7;
static lean_once_cell_t lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__8_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__8;
static const lean_ctor_object lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__2_value)}};
static const lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__9 = (const lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__9_value;
static const lean_ctor_object lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__6_value)}};
static const lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__10 = (const lean_object*)&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__10_value;
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg(lean_object*);
static const lean_string_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "{ "};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__0_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 6, .m_capacity = 6, .m_length = 5, .m_data = "scope"};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__1_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__1_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__2_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__2_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__3_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = " := "};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__4 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__4_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__4_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__5_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__3_value),((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__6_value;
static lean_once_cell_t lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__7;
static const lean_string_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 11, .m_capacity = 11, .m_length = 10, .m_data = "generation"};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__8 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__8_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__8_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__9 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__9_value;
static lean_once_cell_t lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__10_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__10;
static const lean_string_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = "boot"};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__11 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__11_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__12_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__11_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__12 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__12_value;
static lean_once_cell_t lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13;
static const lean_string_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__14_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "sequence"};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__14 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__14_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__15_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__14_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__15 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__15_value;
static lean_once_cell_t lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__16_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__16;
static const lean_string_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__17_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 6, .m_capacity = 6, .m_length = 5, .m_data = "nonce"};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__17 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__17_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__18_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__17_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__18 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__18_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__19_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = " }"};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__19 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__19_value;
static lean_once_cell_t lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__20_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__20;
static lean_once_cell_t lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__22_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__22 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__22_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__23_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__19_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__23 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__23_value;
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprContext_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprContext_repr___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_UPTController_instReprContext___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_UPTController_instReprContext_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_UPTController_instReprContext___closed__0 = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_UPTController_instReprContext = (const lean_object*)&lp_physical__bridges_UPTController_instReprContext___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_contextWords(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqState_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqState_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqState(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqState___boxed(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = "none"};
static const lean_object* lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__0 = (const lean_object*)&lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__0_value;
static const lean_ctor_object lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__0_value)}};
static const lean_object* lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__1 = (const lean_object*)&lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__1_value;
static const lean_string_object lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 6, .m_capacity = 6, .m_length = 5, .m_data = "some "};
static const lean_object* lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__2 = (const lean_object*)&lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__2_value;
static const lean_ctor_object lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__2_value)}};
static const lean_object* lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__3 = (const lean_object*)&lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__3_value;
LEAN_EXPORT lean_object* lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___boxed(lean_object*, lean_object*);
static const lean_ctor_object lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__9_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__0_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__0_value),((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__1_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = "held"};
static const lean_object* lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__2_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__2_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__3_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 7, .m_capacity = 7, .m_length = 6, .m_data = "closed"};
static const lean_object* lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__4 = (const lean_object*)&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__4_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__4_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__5_value;
static lean_once_cell_t lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__6_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__6;
static const lean_string_object lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = "pending"};
static const lean_object* lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__7 = (const lean_object*)&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__7_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__7_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__8 = (const lean_object*)&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__8_value;
static lean_once_cell_t lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__9_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__9;
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprState_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprState_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprState_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_UPTController_instReprState___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_UPTController_instReprState_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_UPTController_instReprState___closed__0 = (const lean_object*)&lp_physical__bridges_UPTController_instReprState___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_UPTController_instReprState = (const lean_object*)&lp_physical__bridges_UPTController_instReprState___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_ctorIdx(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_ctorElim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_ctorElim(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_authorize_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_authorize_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_retire_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_retire_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_release_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_release_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_openBoot_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_openBoot_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_close_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_close_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqOp_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqOp_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqOp(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqOp___boxed(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_UPTController_instReprOp_repr___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 27, .m_capacity = 27, .m_length = 26, .m_data = "UPTController.Op.authorize"};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__0 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__0_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprOp_repr___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__0_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__1 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__1_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprOp_repr___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__1_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__2 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__2_value;
static lean_once_cell_t lp_physical__bridges_UPTController_instReprOp_repr___closed__3_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__3;
static lean_once_cell_t lp_physical__bridges_UPTController_instReprOp_repr___closed__4_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__4;
static const lean_string_object lp_physical__bridges_UPTController_instReprOp_repr___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 24, .m_capacity = 24, .m_length = 23, .m_data = "UPTController.Op.retire"};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__5 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__5_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprOp_repr___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__5_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__6 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__6_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprOp_repr___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__6_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__7 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__7_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprOp_repr___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 25, .m_capacity = 25, .m_length = 24, .m_data = "UPTController.Op.release"};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__8 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__8_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprOp_repr___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__8_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__9 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__9_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprOp_repr___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__9_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__10 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__10_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprOp_repr___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 26, .m_capacity = 26, .m_length = 25, .m_data = "UPTController.Op.openBoot"};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__11 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__11_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprOp_repr___closed__12_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__11_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__12 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__12_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprOp_repr___closed__13_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__12_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__13 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__13_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprOp_repr___closed__14_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 23, .m_capacity = 23, .m_length = 22, .m_data = "UPTController.Op.close"};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__14 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__14_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprOp_repr___closed__15_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__14_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__15 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__15_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprOp_repr___closed__16_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__15_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_UPTController_instReprOp_repr___closed__16 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp_repr___closed__16_value;
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprOp_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprOp_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_UPTController_instReprOp___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_UPTController_instReprOp_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_UPTController_instReprOp___closed__0 = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_UPTController_instReprOp = (const lean_object*)&lp_physical__bridges_UPTController_instReprOp___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_ctorIdx(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_ctorElim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_ctorElim(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_rejected_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_rejected_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_grant_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_grant_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_floor_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_floor_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_released_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_released_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_booted_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_booted_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_closed_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_closed_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqReply_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqReply_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqReply(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqReply___boxed(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_UPTController_instReprReply_repr___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 29, .m_capacity = 29, .m_length = 28, .m_data = "UPTController.Reply.rejected"};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__0 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__0_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprReply_repr___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__0_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__1 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__1_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprReply_repr___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 29, .m_capacity = 29, .m_length = 28, .m_data = "UPTController.Reply.released"};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__2 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__2_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprReply_repr___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__2_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__3 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__3_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprReply_repr___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 27, .m_capacity = 27, .m_length = 26, .m_data = "UPTController.Reply.booted"};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__4 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__4_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprReply_repr___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__4_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__5 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__5_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprReply_repr___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 27, .m_capacity = 27, .m_length = 26, .m_data = "UPTController.Reply.closed"};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__6 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__6_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprReply_repr___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__6_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__7 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__7_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprReply_repr___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 26, .m_capacity = 26, .m_length = 25, .m_data = "UPTController.Reply.grant"};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__8 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__8_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprReply_repr___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__8_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__9 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__9_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprReply_repr___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__9_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__10 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__10_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprReply_repr___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 26, .m_capacity = 26, .m_length = 25, .m_data = "UPTController.Reply.floor"};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__11 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__11_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprReply_repr___closed__12_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__11_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__12 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__12_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprReply_repr___closed__13_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__12_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_UPTController_instReprReply_repr___closed__13 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply_repr___closed__13_value;
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprReply_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprReply_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_UPTController_instReprReply___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_UPTController_instReprReply_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_UPTController_instReprReply___closed__0 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_UPTController_instReprReply = (const lean_object*)&lp_physical__bridges_UPTController_instReprReply___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_step(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_run(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_run_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_run_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_instReprOp_repr_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_instReprOp_repr_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_step_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_step_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqReceipt_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqReceipt_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqReceipt(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqReceipt___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00UPTController_instReprReceipt_repr_spec__0_spec__0_spec__1_spec__2(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00UPTController_instReprReceipt_repr_spec__0_spec__0_spec__1(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_Std_Format_joinSep___at___00List_repr___at___00UPTController_instReprReceipt_repr_spec__0_spec__0___lam__0(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_Std_Format_joinSep___at___00List_repr___at___00UPTController_instReprReceipt_repr_spec__0_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr___at___00UPTController_instReprReceipt_repr_spec__0___redArg(lean_object*);
static const lean_string_object lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = "past"};
static const lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__0_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__1_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__1_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__2_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__2_value),((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__3_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = "context"};
static const lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__4 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__4_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__4_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__5_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 8, .m_capacity = 8, .m_length = 7, .m_data = "isFloor"};
static const lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__6_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__6_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__7 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__7_value;
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr___at___00UPTController_instReprReceipt_repr_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr___at___00UPTController_instReprReceipt_repr_spec__0___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_UPTController_instReprReceipt___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_UPTController_instReprReceipt_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_UPTController_instReprReceipt___closed__0 = (const lean_object*)&lp_physical__bridges_UPTController_instReprReceipt___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_UPTController_instReprReceipt = (const lean_object*)&lp_physical__bridges_UPTController_instReprReceipt___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_namedOp(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_namedOp___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_expectedReply(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_expectedReply___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_history(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqLocal_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqLocal_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqLocal(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqLocal___boxed(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 6, .m_capacity = 6, .m_length = 5, .m_data = "floor"};
static const lean_object* lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__0_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__1_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__1_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__2_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__2_value),((lean_object*)&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__3_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 6, .m_capacity = 6, .m_length = 5, .m_data = "ready"};
static const lean_object* lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__4 = (const lean_object*)&lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__4_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__4_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__5_value;
static const lean_string_object lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 9, .m_capacity = 9, .m_length = 8, .m_data = "consumed"};
static const lean_object* lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__6_value;
static const lean_ctor_object lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__6_value)}};
static const lean_object* lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__7 = (const lean_object*)&lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__7_value;
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprLocal_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprLocal_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprLocal_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_UPTController_instReprLocal___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_UPTController_instReprLocal_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_UPTController_instReprLocal___closed__0 = (const lean_object*)&lp_physical__bridges_UPTController_instReprLocal___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_UPTController_instReprLocal = (const lean_object*)&lp_physical__bridges_UPTController_instReprLocal___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_consume(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_restart(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_emits(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_issued(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_emits_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_emits_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_tally___redArg(lean_object* v_p_1_, lean_object* v_x_2_){
_start:
{
if (lean_obj_tag(v_x_2_) == 0)
{
lean_object* v___x_3_; 
lean_dec_ref(v_p_1_);
v___x_3_ = lean_unsigned_to_nat(0u);
return v___x_3_;
}
else
{
lean_object* v_head_4_; lean_object* v_tail_5_; lean_object* v___y_7_; lean_object* v___x_10_; uint8_t v___x_11_; 
v_head_4_ = lean_ctor_get(v_x_2_, 0);
lean_inc(v_head_4_);
v_tail_5_ = lean_ctor_get(v_x_2_, 1);
lean_inc(v_tail_5_);
lean_dec_ref_known(v_x_2_, 2);
lean_inc_ref(v_p_1_);
v___x_10_ = lean_apply_1(v_p_1_, v_head_4_);
v___x_11_ = lean_unbox(v___x_10_);
if (v___x_11_ == 0)
{
lean_object* v___x_12_; 
v___x_12_ = lean_unsigned_to_nat(0u);
v___y_7_ = v___x_12_;
goto v___jp_6_;
}
else
{
lean_object* v___x_13_; 
v___x_13_ = lean_unsigned_to_nat(1u);
v___y_7_ = v___x_13_;
goto v___jp_6_;
}
v___jp_6_:
{
lean_object* v___x_8_; lean_object* v___x_9_; 
v___x_8_ = lp_physical__bridges_UPTController_tally___redArg(v_p_1_, v_tail_5_);
v___x_9_ = lean_nat_add(v___y_7_, v___x_8_);
lean_dec(v___x_8_);
return v___x_9_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_tally(lean_object* v_00_u03b1_14_, lean_object* v_p_15_, lean_object* v_x_16_){
_start:
{
lean_object* v___x_17_; 
v___x_17_ = lp_physical__bridges_UPTController_tally___redArg(v_p_15_, v_x_16_);
return v___x_17_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_tally_match__1_splitter___redArg(lean_object* v_x_18_, lean_object* v_h__1_19_, lean_object* v_h__2_20_){
_start:
{
if (lean_obj_tag(v_x_18_) == 0)
{
lean_object* v___x_21_; lean_object* v___x_22_; 
lean_dec(v_h__2_20_);
v___x_21_ = lean_box(0);
v___x_22_ = lean_apply_1(v_h__1_19_, v___x_21_);
return v___x_22_;
}
else
{
lean_object* v_head_23_; lean_object* v_tail_24_; lean_object* v___x_25_; 
lean_dec(v_h__1_19_);
v_head_23_ = lean_ctor_get(v_x_18_, 0);
lean_inc(v_head_23_);
v_tail_24_ = lean_ctor_get(v_x_18_, 1);
lean_inc(v_tail_24_);
lean_dec_ref_known(v_x_18_, 2);
v___x_25_ = lean_apply_2(v_h__2_20_, v_head_23_, v_tail_24_);
return v___x_25_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_tally_match__1_splitter(lean_object* v_00_u03b1_26_, lean_object* v_motive_27_, lean_object* v_x_28_, lean_object* v_h__1_29_, lean_object* v_h__2_30_){
_start:
{
if (lean_obj_tag(v_x_28_) == 0)
{
lean_object* v___x_31_; lean_object* v___x_32_; 
lean_dec(v_h__2_30_);
v___x_31_ = lean_box(0);
v___x_32_ = lean_apply_1(v_h__1_29_, v___x_31_);
return v___x_32_;
}
else
{
lean_object* v_head_33_; lean_object* v_tail_34_; lean_object* v___x_35_; 
lean_dec(v_h__1_29_);
v_head_33_ = lean_ctor_get(v_x_28_, 0);
lean_inc(v_head_33_);
v_tail_34_ = lean_ctor_get(v_x_28_, 1);
lean_inc(v_tail_34_);
lean_dec_ref_known(v_x_28_, 2);
v___x_35_ = lean_apply_2(v_h__2_30_, v_head_33_, v_tail_34_);
return v___x_35_;
}
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqContext_decEq(lean_object* v_x_36_, lean_object* v_x_37_){
_start:
{
lean_object* v_scope_38_; lean_object* v_generation_39_; lean_object* v_boot_40_; lean_object* v_sequence_41_; lean_object* v_nonce_42_; lean_object* v_scope_43_; lean_object* v_generation_44_; lean_object* v_boot_45_; lean_object* v_sequence_46_; lean_object* v_nonce_47_; lean_object* v___x_48_; uint8_t v___x_49_; 
v_scope_38_ = lean_ctor_get(v_x_36_, 0);
lean_inc(v_scope_38_);
v_generation_39_ = lean_ctor_get(v_x_36_, 1);
lean_inc(v_generation_39_);
v_boot_40_ = lean_ctor_get(v_x_36_, 2);
lean_inc(v_boot_40_);
v_sequence_41_ = lean_ctor_get(v_x_36_, 3);
lean_inc(v_sequence_41_);
v_nonce_42_ = lean_ctor_get(v_x_36_, 4);
lean_inc(v_nonce_42_);
lean_dec_ref(v_x_36_);
v_scope_43_ = lean_ctor_get(v_x_37_, 0);
lean_inc(v_scope_43_);
v_generation_44_ = lean_ctor_get(v_x_37_, 1);
lean_inc(v_generation_44_);
v_boot_45_ = lean_ctor_get(v_x_37_, 2);
lean_inc(v_boot_45_);
v_sequence_46_ = lean_ctor_get(v_x_37_, 3);
lean_inc(v_sequence_46_);
v_nonce_47_ = lean_ctor_get(v_x_37_, 4);
lean_inc(v_nonce_47_);
lean_dec_ref(v_x_37_);
v___x_48_ = lean_alloc_closure((void*)(l_instDecidableEqNat___boxed), 2, 0);
v___x_49_ = l_instDecidableEqList___redArg(v___x_48_, v_scope_38_, v_scope_43_);
if (v___x_49_ == 0)
{
lean_dec(v_nonce_47_);
lean_dec(v_sequence_46_);
lean_dec(v_boot_45_);
lean_dec(v_generation_44_);
lean_dec(v_nonce_42_);
lean_dec(v_sequence_41_);
lean_dec(v_boot_40_);
lean_dec(v_generation_39_);
return v___x_49_;
}
else
{
uint8_t v___x_50_; 
v___x_50_ = lean_nat_dec_eq(v_generation_39_, v_generation_44_);
lean_dec(v_generation_44_);
lean_dec(v_generation_39_);
if (v___x_50_ == 0)
{
lean_dec(v_nonce_47_);
lean_dec(v_sequence_46_);
lean_dec(v_boot_45_);
lean_dec(v_nonce_42_);
lean_dec(v_sequence_41_);
lean_dec(v_boot_40_);
return v___x_50_;
}
else
{
uint8_t v___x_51_; 
v___x_51_ = lean_nat_dec_eq(v_boot_40_, v_boot_45_);
lean_dec(v_boot_45_);
lean_dec(v_boot_40_);
if (v___x_51_ == 0)
{
lean_dec(v_nonce_47_);
lean_dec(v_sequence_46_);
lean_dec(v_nonce_42_);
lean_dec(v_sequence_41_);
return v___x_51_;
}
else
{
uint8_t v___x_52_; 
v___x_52_ = lean_nat_dec_eq(v_sequence_41_, v_sequence_46_);
lean_dec(v_sequence_46_);
lean_dec(v_sequence_41_);
if (v___x_52_ == 0)
{
lean_dec(v_nonce_47_);
lean_dec(v_nonce_42_);
return v___x_52_;
}
else
{
uint8_t v___x_53_; 
v___x_53_ = lean_nat_dec_eq(v_nonce_42_, v_nonce_47_);
lean_dec(v_nonce_47_);
lean_dec(v_nonce_42_);
return v___x_53_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqContext_decEq___boxed(lean_object* v_x_54_, lean_object* v_x_55_){
_start:
{
uint8_t v_res_56_; lean_object* v_r_57_; 
v_res_56_ = lp_physical__bridges_UPTController_instDecidableEqContext_decEq(v_x_54_, v_x_55_);
v_r_57_ = lean_box(v_res_56_);
return v_r_57_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqContext(lean_object* v_x_58_, lean_object* v_x_59_){
_start:
{
uint8_t v___x_60_; 
v___x_60_ = lp_physical__bridges_UPTController_instDecidableEqContext_decEq(v_x_58_, v_x_59_);
return v___x_60_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqContext___boxed(lean_object* v_x_61_, lean_object* v_x_62_){
_start:
{
uint8_t v_res_63_; lean_object* v_r_64_; 
v_res_63_ = lp_physical__bridges_UPTController_instDecidableEqContext(v_x_61_, v_x_62_);
v_r_64_ = lean_box(v_res_63_);
return v_r_64_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr_x27___at___00UPTController_instReprContext_repr_spec__0_spec__0_spec__1_spec__2(lean_object* v_x_65_, lean_object* v_x_66_, lean_object* v_x_67_){
_start:
{
if (lean_obj_tag(v_x_67_) == 0)
{
lean_dec(v_x_65_);
return v_x_66_;
}
else
{
lean_object* v_head_68_; lean_object* v_tail_69_; lean_object* v___x_71_; uint8_t v_isShared_72_; uint8_t v_isSharedCheck_80_; 
v_head_68_ = lean_ctor_get(v_x_67_, 0);
v_tail_69_ = lean_ctor_get(v_x_67_, 1);
v_isSharedCheck_80_ = !lean_is_exclusive(v_x_67_);
if (v_isSharedCheck_80_ == 0)
{
v___x_71_ = v_x_67_;
v_isShared_72_ = v_isSharedCheck_80_;
goto v_resetjp_70_;
}
else
{
lean_inc(v_tail_69_);
lean_inc(v_head_68_);
lean_dec(v_x_67_);
v___x_71_ = lean_box(0);
v_isShared_72_ = v_isSharedCheck_80_;
goto v_resetjp_70_;
}
v_resetjp_70_:
{
lean_object* v___x_74_; 
lean_inc(v_x_65_);
if (v_isShared_72_ == 0)
{
lean_ctor_set_tag(v___x_71_, 5);
lean_ctor_set(v___x_71_, 1, v_x_65_);
lean_ctor_set(v___x_71_, 0, v_x_66_);
v___x_74_ = v___x_71_;
goto v_reusejp_73_;
}
else
{
lean_object* v_reuseFailAlloc_79_; 
v_reuseFailAlloc_79_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v_reuseFailAlloc_79_, 0, v_x_66_);
lean_ctor_set(v_reuseFailAlloc_79_, 1, v_x_65_);
v___x_74_ = v_reuseFailAlloc_79_;
goto v_reusejp_73_;
}
v_reusejp_73_:
{
lean_object* v___x_75_; lean_object* v___x_76_; lean_object* v___x_77_; 
v___x_75_ = l_Nat_reprFast(v_head_68_);
v___x_76_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_76_, 0, v___x_75_);
v___x_77_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_77_, 0, v___x_74_);
lean_ctor_set(v___x_77_, 1, v___x_76_);
v_x_66_ = v___x_77_;
v_x_67_ = v_tail_69_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00Std_Format_joinSep___at___00List_repr_x27___at___00UPTController_instReprContext_repr_spec__0_spec__0_spec__1(lean_object* v_x_81_, lean_object* v_x_82_, lean_object* v_x_83_){
_start:
{
if (lean_obj_tag(v_x_83_) == 0)
{
lean_dec(v_x_81_);
return v_x_82_;
}
else
{
lean_object* v_head_84_; lean_object* v_tail_85_; lean_object* v___x_87_; uint8_t v_isShared_88_; uint8_t v_isSharedCheck_96_; 
v_head_84_ = lean_ctor_get(v_x_83_, 0);
v_tail_85_ = lean_ctor_get(v_x_83_, 1);
v_isSharedCheck_96_ = !lean_is_exclusive(v_x_83_);
if (v_isSharedCheck_96_ == 0)
{
v___x_87_ = v_x_83_;
v_isShared_88_ = v_isSharedCheck_96_;
goto v_resetjp_86_;
}
else
{
lean_inc(v_tail_85_);
lean_inc(v_head_84_);
lean_dec(v_x_83_);
v___x_87_ = lean_box(0);
v_isShared_88_ = v_isSharedCheck_96_;
goto v_resetjp_86_;
}
v_resetjp_86_:
{
lean_object* v___x_90_; 
lean_inc(v_x_81_);
if (v_isShared_88_ == 0)
{
lean_ctor_set_tag(v___x_87_, 5);
lean_ctor_set(v___x_87_, 1, v_x_81_);
lean_ctor_set(v___x_87_, 0, v_x_82_);
v___x_90_ = v___x_87_;
goto v_reusejp_89_;
}
else
{
lean_object* v_reuseFailAlloc_95_; 
v_reuseFailAlloc_95_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v_reuseFailAlloc_95_, 0, v_x_82_);
lean_ctor_set(v_reuseFailAlloc_95_, 1, v_x_81_);
v___x_90_ = v_reuseFailAlloc_95_;
goto v_reusejp_89_;
}
v_reusejp_89_:
{
lean_object* v___x_91_; lean_object* v___x_92_; lean_object* v___x_93_; lean_object* v___x_94_; 
v___x_91_ = l_Nat_reprFast(v_head_84_);
v___x_92_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_92_, 0, v___x_91_);
v___x_93_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_93_, 0, v___x_90_);
lean_ctor_set(v___x_93_, 1, v___x_92_);
v___x_94_ = lp_physical__bridges_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr_x27___at___00UPTController_instReprContext_repr_spec__0_spec__0_spec__1_spec__2(v_x_81_, v___x_93_, v_tail_85_);
return v___x_94_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_Std_Format_joinSep___at___00List_repr_x27___at___00UPTController_instReprContext_repr_spec__0_spec__0___lam__0(lean_object* v___y_97_){
_start:
{
lean_object* v___x_98_; lean_object* v___x_99_; 
v___x_98_ = l_Nat_reprFast(v___y_97_);
v___x_99_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_99_, 0, v___x_98_);
return v___x_99_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_Std_Format_joinSep___at___00List_repr_x27___at___00UPTController_instReprContext_repr_spec__0_spec__0(lean_object* v_x_100_, lean_object* v_x_101_){
_start:
{
if (lean_obj_tag(v_x_100_) == 0)
{
lean_object* v___x_102_; 
lean_dec(v_x_101_);
v___x_102_ = lean_box(0);
return v___x_102_;
}
else
{
lean_object* v_tail_103_; 
v_tail_103_ = lean_ctor_get(v_x_100_, 1);
if (lean_obj_tag(v_tail_103_) == 0)
{
lean_object* v_head_104_; lean_object* v___x_105_; 
lean_dec(v_x_101_);
v_head_104_ = lean_ctor_get(v_x_100_, 0);
lean_inc(v_head_104_);
lean_dec_ref_known(v_x_100_, 2);
v___x_105_ = lp_physical__bridges_Std_Format_joinSep___at___00List_repr_x27___at___00UPTController_instReprContext_repr_spec__0_spec__0___lam__0(v_head_104_);
return v___x_105_;
}
else
{
lean_object* v_head_106_; lean_object* v___x_107_; lean_object* v___x_108_; 
lean_inc(v_tail_103_);
v_head_106_ = lean_ctor_get(v_x_100_, 0);
lean_inc(v_head_106_);
lean_dec_ref_known(v_x_100_, 2);
v___x_107_ = lp_physical__bridges_Std_Format_joinSep___at___00List_repr_x27___at___00UPTController_instReprContext_repr_spec__0_spec__0___lam__0(v_head_106_);
v___x_108_ = lp_physical__bridges_List_foldl___at___00Std_Format_joinSep___at___00List_repr_x27___at___00UPTController_instReprContext_repr_spec__0_spec__0_spec__1(v_x_101_, v___x_107_, v_tail_103_);
return v___x_108_;
}
}
}
}
static lean_object* _init_lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__7(void){
_start:
{
lean_object* v___x_120_; lean_object* v___x_121_; 
v___x_120_ = ((lean_object*)(lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__2));
v___x_121_ = lean_string_length(v___x_120_);
return v___x_121_;
}
}
static lean_object* _init_lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__8(void){
_start:
{
lean_object* v___x_122_; lean_object* v___x_123_; 
v___x_122_ = lean_obj_once(&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__7, &lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__7_once, _init_lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__7);
v___x_123_ = lean_nat_to_int(v___x_122_);
return v___x_123_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg(lean_object* v_a_128_){
_start:
{
if (lean_obj_tag(v_a_128_) == 0)
{
lean_object* v___x_129_; 
v___x_129_ = ((lean_object*)(lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__1));
return v___x_129_;
}
else
{
lean_object* v___x_130_; lean_object* v___x_131_; lean_object* v___x_132_; lean_object* v___x_133_; lean_object* v___x_134_; lean_object* v___x_135_; lean_object* v___x_136_; lean_object* v___x_137_; lean_object* v___x_138_; 
v___x_130_ = ((lean_object*)(lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__5));
v___x_131_ = lp_physical__bridges_Std_Format_joinSep___at___00List_repr_x27___at___00UPTController_instReprContext_repr_spec__0_spec__0(v_a_128_, v___x_130_);
v___x_132_ = lean_obj_once(&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__8, &lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__8_once, _init_lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__8);
v___x_133_ = ((lean_object*)(lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__9));
v___x_134_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_134_, 0, v___x_133_);
lean_ctor_set(v___x_134_, 1, v___x_131_);
v___x_135_ = ((lean_object*)(lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__10));
v___x_136_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_136_, 0, v___x_134_);
lean_ctor_set(v___x_136_, 1, v___x_135_);
v___x_137_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_137_, 0, v___x_132_);
lean_ctor_set(v___x_137_, 1, v___x_136_);
v___x_138_ = l_Std_Format_fill(v___x_137_);
return v___x_138_;
}
}
}
static lean_object* _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__7(void){
_start:
{
lean_object* v___x_152_; lean_object* v___x_153_; 
v___x_152_ = lean_unsigned_to_nat(9u);
v___x_153_ = lean_nat_to_int(v___x_152_);
return v___x_153_;
}
}
static lean_object* _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__10(void){
_start:
{
lean_object* v___x_157_; lean_object* v___x_158_; 
v___x_157_ = lean_unsigned_to_nat(14u);
v___x_158_ = lean_nat_to_int(v___x_157_);
return v___x_158_;
}
}
static lean_object* _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13(void){
_start:
{
lean_object* v___x_162_; lean_object* v___x_163_; 
v___x_162_ = lean_unsigned_to_nat(8u);
v___x_163_ = lean_nat_to_int(v___x_162_);
return v___x_163_;
}
}
static lean_object* _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__16(void){
_start:
{
lean_object* v___x_167_; lean_object* v___x_168_; 
v___x_167_ = lean_unsigned_to_nat(12u);
v___x_168_ = lean_nat_to_int(v___x_167_);
return v___x_168_;
}
}
static lean_object* _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__20(void){
_start:
{
lean_object* v___x_173_; lean_object* v___x_174_; 
v___x_173_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__0));
v___x_174_ = lean_string_length(v___x_173_);
return v___x_174_;
}
}
static lean_object* _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21(void){
_start:
{
lean_object* v___x_175_; lean_object* v___x_176_; 
v___x_175_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__20, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__20_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__20);
v___x_176_ = lean_nat_to_int(v___x_175_);
return v___x_176_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprContext_repr___redArg(lean_object* v_x_181_){
_start:
{
lean_object* v_scope_182_; lean_object* v_generation_183_; lean_object* v_boot_184_; lean_object* v_sequence_185_; lean_object* v_nonce_186_; lean_object* v___x_187_; lean_object* v___x_188_; lean_object* v___x_189_; lean_object* v___x_190_; lean_object* v___x_191_; uint8_t v___x_192_; lean_object* v___x_193_; lean_object* v___x_194_; lean_object* v___x_195_; lean_object* v___x_196_; lean_object* v___x_197_; lean_object* v___x_198_; lean_object* v___x_199_; lean_object* v___x_200_; lean_object* v___x_201_; lean_object* v___x_202_; lean_object* v___x_203_; lean_object* v___x_204_; lean_object* v___x_205_; lean_object* v___x_206_; lean_object* v___x_207_; lean_object* v___x_208_; lean_object* v___x_209_; lean_object* v___x_210_; lean_object* v___x_211_; lean_object* v___x_212_; lean_object* v___x_213_; lean_object* v___x_214_; lean_object* v___x_215_; lean_object* v___x_216_; lean_object* v___x_217_; lean_object* v___x_218_; lean_object* v___x_219_; lean_object* v___x_220_; lean_object* v___x_221_; lean_object* v___x_222_; lean_object* v___x_223_; lean_object* v___x_224_; lean_object* v___x_225_; lean_object* v___x_226_; lean_object* v___x_227_; lean_object* v___x_228_; lean_object* v___x_229_; lean_object* v___x_230_; lean_object* v___x_231_; lean_object* v___x_232_; lean_object* v___x_233_; lean_object* v___x_234_; lean_object* v___x_235_; lean_object* v___x_236_; lean_object* v___x_237_; lean_object* v___x_238_; lean_object* v___x_239_; lean_object* v___x_240_; lean_object* v___x_241_; lean_object* v___x_242_; lean_object* v___x_243_; lean_object* v___x_244_; lean_object* v___x_245_; lean_object* v___x_246_; 
v_scope_182_ = lean_ctor_get(v_x_181_, 0);
lean_inc(v_scope_182_);
v_generation_183_ = lean_ctor_get(v_x_181_, 1);
lean_inc(v_generation_183_);
v_boot_184_ = lean_ctor_get(v_x_181_, 2);
lean_inc(v_boot_184_);
v_sequence_185_ = lean_ctor_get(v_x_181_, 3);
lean_inc(v_sequence_185_);
v_nonce_186_ = lean_ctor_get(v_x_181_, 4);
lean_inc(v_nonce_186_);
lean_dec_ref(v_x_181_);
v___x_187_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__5));
v___x_188_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__6));
v___x_189_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__7, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__7_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__7);
v___x_190_ = lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg(v_scope_182_);
v___x_191_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_191_, 0, v___x_189_);
lean_ctor_set(v___x_191_, 1, v___x_190_);
v___x_192_ = 0;
v___x_193_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_193_, 0, v___x_191_);
lean_ctor_set_uint8(v___x_193_, sizeof(void*)*1, v___x_192_);
v___x_194_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_194_, 0, v___x_188_);
lean_ctor_set(v___x_194_, 1, v___x_193_);
v___x_195_ = ((lean_object*)(lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__4));
v___x_196_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_196_, 0, v___x_194_);
lean_ctor_set(v___x_196_, 1, v___x_195_);
v___x_197_ = lean_box(1);
v___x_198_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_198_, 0, v___x_196_);
lean_ctor_set(v___x_198_, 1, v___x_197_);
v___x_199_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__9));
v___x_200_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_200_, 0, v___x_198_);
lean_ctor_set(v___x_200_, 1, v___x_199_);
v___x_201_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_201_, 0, v___x_200_);
lean_ctor_set(v___x_201_, 1, v___x_187_);
v___x_202_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__10, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__10_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__10);
v___x_203_ = l_Nat_reprFast(v_generation_183_);
v___x_204_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_204_, 0, v___x_203_);
v___x_205_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_205_, 0, v___x_202_);
lean_ctor_set(v___x_205_, 1, v___x_204_);
v___x_206_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_206_, 0, v___x_205_);
lean_ctor_set_uint8(v___x_206_, sizeof(void*)*1, v___x_192_);
v___x_207_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_207_, 0, v___x_201_);
lean_ctor_set(v___x_207_, 1, v___x_206_);
v___x_208_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_208_, 0, v___x_207_);
lean_ctor_set(v___x_208_, 1, v___x_195_);
v___x_209_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_209_, 0, v___x_208_);
lean_ctor_set(v___x_209_, 1, v___x_197_);
v___x_210_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__12));
v___x_211_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_211_, 0, v___x_209_);
lean_ctor_set(v___x_211_, 1, v___x_210_);
v___x_212_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_212_, 0, v___x_211_);
lean_ctor_set(v___x_212_, 1, v___x_187_);
v___x_213_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13);
v___x_214_ = l_Nat_reprFast(v_boot_184_);
v___x_215_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_215_, 0, v___x_214_);
v___x_216_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_216_, 0, v___x_213_);
lean_ctor_set(v___x_216_, 1, v___x_215_);
v___x_217_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_217_, 0, v___x_216_);
lean_ctor_set_uint8(v___x_217_, sizeof(void*)*1, v___x_192_);
v___x_218_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_218_, 0, v___x_212_);
lean_ctor_set(v___x_218_, 1, v___x_217_);
v___x_219_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_219_, 0, v___x_218_);
lean_ctor_set(v___x_219_, 1, v___x_195_);
v___x_220_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_220_, 0, v___x_219_);
lean_ctor_set(v___x_220_, 1, v___x_197_);
v___x_221_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__15));
v___x_222_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_222_, 0, v___x_220_);
lean_ctor_set(v___x_222_, 1, v___x_221_);
v___x_223_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_223_, 0, v___x_222_);
lean_ctor_set(v___x_223_, 1, v___x_187_);
v___x_224_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__16, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__16_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__16);
v___x_225_ = l_Nat_reprFast(v_sequence_185_);
v___x_226_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_226_, 0, v___x_225_);
v___x_227_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_227_, 0, v___x_224_);
lean_ctor_set(v___x_227_, 1, v___x_226_);
v___x_228_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_228_, 0, v___x_227_);
lean_ctor_set_uint8(v___x_228_, sizeof(void*)*1, v___x_192_);
v___x_229_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_229_, 0, v___x_223_);
lean_ctor_set(v___x_229_, 1, v___x_228_);
v___x_230_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_230_, 0, v___x_229_);
lean_ctor_set(v___x_230_, 1, v___x_195_);
v___x_231_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_231_, 0, v___x_230_);
lean_ctor_set(v___x_231_, 1, v___x_197_);
v___x_232_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__18));
v___x_233_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_233_, 0, v___x_231_);
lean_ctor_set(v___x_233_, 1, v___x_232_);
v___x_234_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_234_, 0, v___x_233_);
lean_ctor_set(v___x_234_, 1, v___x_187_);
v___x_235_ = l_Nat_reprFast(v_nonce_186_);
v___x_236_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_236_, 0, v___x_235_);
v___x_237_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_237_, 0, v___x_189_);
lean_ctor_set(v___x_237_, 1, v___x_236_);
v___x_238_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_238_, 0, v___x_237_);
lean_ctor_set_uint8(v___x_238_, sizeof(void*)*1, v___x_192_);
v___x_239_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_239_, 0, v___x_234_);
lean_ctor_set(v___x_239_, 1, v___x_238_);
v___x_240_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21);
v___x_241_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__22));
v___x_242_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_242_, 0, v___x_241_);
lean_ctor_set(v___x_242_, 1, v___x_239_);
v___x_243_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__23));
v___x_244_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_244_, 0, v___x_242_);
lean_ctor_set(v___x_244_, 1, v___x_243_);
v___x_245_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_245_, 0, v___x_240_);
lean_ctor_set(v___x_245_, 1, v___x_244_);
v___x_246_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_246_, 0, v___x_245_);
lean_ctor_set_uint8(v___x_246_, sizeof(void*)*1, v___x_192_);
return v___x_246_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprContext_repr(lean_object* v_x_247_, lean_object* v_prec_248_){
_start:
{
lean_object* v___x_249_; 
v___x_249_ = lp_physical__bridges_UPTController_instReprContext_repr___redArg(v_x_247_);
return v___x_249_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprContext_repr___boxed(lean_object* v_x_250_, lean_object* v_prec_251_){
_start:
{
lean_object* v_res_252_; 
v_res_252_ = lp_physical__bridges_UPTController_instReprContext_repr(v_x_250_, v_prec_251_);
lean_dec(v_prec_251_);
return v_res_252_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0(lean_object* v_a_253_, lean_object* v_n_254_){
_start:
{
lean_object* v___x_255_; 
v___x_255_ = lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg(v_a_253_);
return v___x_255_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___boxed(lean_object* v_a_256_, lean_object* v_n_257_){
_start:
{
lean_object* v_res_258_; 
v_res_258_ = lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0(v_a_256_, v_n_257_);
lean_dec(v_n_257_);
return v_res_258_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_contextWords(lean_object* v_c_261_){
_start:
{
lean_object* v_scope_262_; lean_object* v_generation_263_; lean_object* v_boot_264_; lean_object* v_sequence_265_; lean_object* v_nonce_266_; lean_object* v___x_267_; lean_object* v___x_268_; lean_object* v___x_269_; lean_object* v___x_270_; lean_object* v___x_271_; lean_object* v___x_272_; lean_object* v___x_273_; lean_object* v___x_274_; 
v_scope_262_ = lean_ctor_get(v_c_261_, 0);
lean_inc(v_scope_262_);
v_generation_263_ = lean_ctor_get(v_c_261_, 1);
lean_inc(v_generation_263_);
v_boot_264_ = lean_ctor_get(v_c_261_, 2);
lean_inc(v_boot_264_);
v_sequence_265_ = lean_ctor_get(v_c_261_, 3);
lean_inc(v_sequence_265_);
v_nonce_266_ = lean_ctor_get(v_c_261_, 4);
lean_inc(v_nonce_266_);
lean_dec_ref(v_c_261_);
v___x_267_ = lean_unsigned_to_nat(1u);
v___x_268_ = lean_box(0);
v___x_269_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_269_, 0, v_nonce_266_);
lean_ctor_set(v___x_269_, 1, v___x_268_);
v___x_270_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_270_, 0, v_sequence_265_);
lean_ctor_set(v___x_270_, 1, v___x_269_);
v___x_271_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_271_, 0, v_boot_264_);
lean_ctor_set(v___x_271_, 1, v___x_270_);
v___x_272_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_272_, 0, v_generation_263_);
lean_ctor_set(v___x_272_, 1, v___x_271_);
v___x_273_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_273_, 0, v___x_267_);
lean_ctor_set(v___x_273_, 1, v___x_272_);
v___x_274_ = l_List_appendTR___redArg(v___x_273_, v_scope_262_);
return v___x_274_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqState_decEq(lean_object* v_x_275_, lean_object* v_x_276_){
_start:
{
lean_object* v_generation_277_; uint8_t v_held_278_; lean_object* v_boot_279_; lean_object* v_closed_280_; lean_object* v_pending_281_; lean_object* v_generation_282_; uint8_t v_held_283_; lean_object* v_boot_284_; lean_object* v_closed_285_; lean_object* v_pending_286_; uint8_t v___y_288_; uint8_t v___x_293_; 
v_generation_277_ = lean_ctor_get(v_x_275_, 0);
lean_inc(v_generation_277_);
v_held_278_ = lean_ctor_get_uint8(v_x_275_, sizeof(void*)*4);
v_boot_279_ = lean_ctor_get(v_x_275_, 1);
lean_inc(v_boot_279_);
v_closed_280_ = lean_ctor_get(v_x_275_, 2);
lean_inc(v_closed_280_);
v_pending_281_ = lean_ctor_get(v_x_275_, 3);
lean_inc(v_pending_281_);
lean_dec_ref(v_x_275_);
v_generation_282_ = lean_ctor_get(v_x_276_, 0);
lean_inc(v_generation_282_);
v_held_283_ = lean_ctor_get_uint8(v_x_276_, sizeof(void*)*4);
v_boot_284_ = lean_ctor_get(v_x_276_, 1);
lean_inc(v_boot_284_);
v_closed_285_ = lean_ctor_get(v_x_276_, 2);
lean_inc(v_closed_285_);
v_pending_286_ = lean_ctor_get(v_x_276_, 3);
lean_inc(v_pending_286_);
lean_dec_ref(v_x_276_);
v___x_293_ = lean_nat_dec_eq(v_generation_277_, v_generation_282_);
lean_dec(v_generation_282_);
lean_dec(v_generation_277_);
if (v___x_293_ == 0)
{
lean_dec(v_pending_286_);
lean_dec(v_closed_285_);
lean_dec(v_boot_284_);
lean_dec(v_pending_281_);
lean_dec(v_closed_280_);
lean_dec(v_boot_279_);
return v___x_293_;
}
else
{
if (v_held_283_ == 0)
{
if (v_held_278_ == 0)
{
v___y_288_ = v___x_293_;
goto v___jp_287_;
}
else
{
lean_dec(v_pending_286_);
lean_dec(v_closed_285_);
lean_dec(v_boot_284_);
lean_dec(v_pending_281_);
lean_dec(v_closed_280_);
lean_dec(v_boot_279_);
return v_held_283_;
}
}
else
{
v___y_288_ = v_held_278_;
goto v___jp_287_;
}
}
v___jp_287_:
{
if (v___y_288_ == 0)
{
lean_dec(v_pending_286_);
lean_dec(v_closed_285_);
lean_dec(v_boot_284_);
lean_dec(v_pending_281_);
lean_dec(v_closed_280_);
lean_dec(v_boot_279_);
return v___y_288_;
}
else
{
uint8_t v___x_289_; 
v___x_289_ = lean_nat_dec_eq(v_boot_279_, v_boot_284_);
lean_dec(v_boot_284_);
lean_dec(v_boot_279_);
if (v___x_289_ == 0)
{
lean_dec(v_pending_286_);
lean_dec(v_closed_285_);
lean_dec(v_pending_281_);
lean_dec(v_closed_280_);
return v___x_289_;
}
else
{
uint8_t v___x_290_; 
v___x_290_ = lean_nat_dec_eq(v_closed_280_, v_closed_285_);
lean_dec(v_closed_285_);
lean_dec(v_closed_280_);
if (v___x_290_ == 0)
{
lean_dec(v_pending_286_);
lean_dec(v_pending_281_);
return v___x_290_;
}
else
{
lean_object* v___x_291_; uint8_t v___x_292_; 
v___x_291_ = lean_alloc_closure((void*)(lp_physical__bridges_UPTController_instDecidableEqContext___boxed), 2, 0);
v___x_292_ = l_Option_instDecidableEq___redArg(v___x_291_, v_pending_281_, v_pending_286_);
return v___x_292_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqState_decEq___boxed(lean_object* v_x_294_, lean_object* v_x_295_){
_start:
{
uint8_t v_res_296_; lean_object* v_r_297_; 
v_res_296_ = lp_physical__bridges_UPTController_instDecidableEqState_decEq(v_x_294_, v_x_295_);
v_r_297_ = lean_box(v_res_296_);
return v_r_297_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqState(lean_object* v_x_298_, lean_object* v_x_299_){
_start:
{
uint8_t v___x_300_; 
v___x_300_ = lp_physical__bridges_UPTController_instDecidableEqState_decEq(v_x_298_, v_x_299_);
return v___x_300_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqState___boxed(lean_object* v_x_301_, lean_object* v_x_302_){
_start:
{
uint8_t v_res_303_; lean_object* v_r_304_; 
v_res_303_ = lp_physical__bridges_UPTController_instDecidableEqState(v_x_301_, v_x_302_);
v_r_304_ = lean_box(v_res_303_);
return v_r_304_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0(lean_object* v_x_311_, lean_object* v_x_312_){
_start:
{
if (lean_obj_tag(v_x_311_) == 0)
{
lean_object* v___x_313_; 
v___x_313_ = ((lean_object*)(lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__1));
return v___x_313_;
}
else
{
lean_object* v_val_314_; lean_object* v___x_315_; lean_object* v___x_316_; lean_object* v___x_317_; lean_object* v___x_318_; 
v_val_314_ = lean_ctor_get(v_x_311_, 0);
lean_inc(v_val_314_);
lean_dec_ref_known(v_x_311_, 1);
v___x_315_ = ((lean_object*)(lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___closed__3));
v___x_316_ = lp_physical__bridges_UPTController_instReprContext_repr___redArg(v_val_314_);
v___x_317_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_317_, 0, v___x_315_);
lean_ctor_set(v___x_317_, 1, v___x_316_);
v___x_318_ = l_Repr_addAppParen(v___x_317_, v_x_312_);
return v___x_318_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0___boxed(lean_object* v_x_319_, lean_object* v_x_320_){
_start:
{
lean_object* v_res_321_; 
v_res_321_ = lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0(v_x_319_, v_x_320_);
lean_dec(v_x_320_);
return v_res_321_;
}
}
static lean_object* _init_lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__6(void){
_start:
{
lean_object* v___x_334_; lean_object* v___x_335_; 
v___x_334_ = lean_unsigned_to_nat(10u);
v___x_335_ = lean_nat_to_int(v___x_334_);
return v___x_335_;
}
}
static lean_object* _init_lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__9(void){
_start:
{
lean_object* v___x_339_; lean_object* v___x_340_; 
v___x_339_ = lean_unsigned_to_nat(11u);
v___x_340_ = lean_nat_to_int(v___x_339_);
return v___x_340_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprState_repr___redArg(lean_object* v_x_341_){
_start:
{
lean_object* v_generation_342_; uint8_t v_held_343_; lean_object* v_boot_344_; lean_object* v_closed_345_; lean_object* v_pending_346_; lean_object* v___x_347_; lean_object* v___x_348_; lean_object* v___x_349_; lean_object* v___x_350_; lean_object* v___x_351_; lean_object* v___x_352_; uint8_t v___x_353_; lean_object* v___x_354_; lean_object* v___x_355_; lean_object* v___x_356_; lean_object* v___x_357_; lean_object* v___x_358_; lean_object* v___x_359_; lean_object* v___x_360_; lean_object* v___x_361_; lean_object* v___x_362_; lean_object* v___x_363_; lean_object* v___x_364_; lean_object* v___x_365_; lean_object* v___x_366_; lean_object* v___x_367_; lean_object* v___x_368_; lean_object* v___x_369_; lean_object* v___x_370_; lean_object* v___x_371_; lean_object* v___x_372_; lean_object* v___x_373_; lean_object* v___x_374_; lean_object* v___x_375_; lean_object* v___x_376_; lean_object* v___x_377_; lean_object* v___x_378_; lean_object* v___x_379_; lean_object* v___x_380_; lean_object* v___x_381_; lean_object* v___x_382_; lean_object* v___x_383_; lean_object* v___x_384_; lean_object* v___x_385_; lean_object* v___x_386_; lean_object* v___x_387_; lean_object* v___x_388_; lean_object* v___x_389_; lean_object* v___x_390_; lean_object* v___x_391_; lean_object* v___x_392_; lean_object* v___x_393_; lean_object* v___x_394_; lean_object* v___x_395_; lean_object* v___x_396_; lean_object* v___x_397_; lean_object* v___x_398_; lean_object* v___x_399_; lean_object* v___x_400_; lean_object* v___x_401_; lean_object* v___x_402_; lean_object* v___x_403_; lean_object* v___x_404_; lean_object* v___x_405_; lean_object* v___x_406_; 
v_generation_342_ = lean_ctor_get(v_x_341_, 0);
lean_inc(v_generation_342_);
v_held_343_ = lean_ctor_get_uint8(v_x_341_, sizeof(void*)*4);
v_boot_344_ = lean_ctor_get(v_x_341_, 1);
lean_inc(v_boot_344_);
v_closed_345_ = lean_ctor_get(v_x_341_, 2);
lean_inc(v_closed_345_);
v_pending_346_ = lean_ctor_get(v_x_341_, 3);
lean_inc(v_pending_346_);
lean_dec_ref(v_x_341_);
v___x_347_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__5));
v___x_348_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__1));
v___x_349_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__10, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__10_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__10);
v___x_350_ = l_Nat_reprFast(v_generation_342_);
v___x_351_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_351_, 0, v___x_350_);
v___x_352_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_352_, 0, v___x_349_);
lean_ctor_set(v___x_352_, 1, v___x_351_);
v___x_353_ = 0;
v___x_354_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_354_, 0, v___x_352_);
lean_ctor_set_uint8(v___x_354_, sizeof(void*)*1, v___x_353_);
v___x_355_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_355_, 0, v___x_348_);
lean_ctor_set(v___x_355_, 1, v___x_354_);
v___x_356_ = ((lean_object*)(lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__4));
v___x_357_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_357_, 0, v___x_355_);
lean_ctor_set(v___x_357_, 1, v___x_356_);
v___x_358_ = lean_box(1);
v___x_359_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_359_, 0, v___x_357_);
lean_ctor_set(v___x_359_, 1, v___x_358_);
v___x_360_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__3));
v___x_361_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_361_, 0, v___x_359_);
lean_ctor_set(v___x_361_, 1, v___x_360_);
v___x_362_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_362_, 0, v___x_361_);
lean_ctor_set(v___x_362_, 1, v___x_347_);
v___x_363_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13);
v___x_364_ = lean_unsigned_to_nat(0u);
v___x_365_ = l_Bool_repr___redArg(v_held_343_);
v___x_366_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_366_, 0, v___x_363_);
lean_ctor_set(v___x_366_, 1, v___x_365_);
v___x_367_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_367_, 0, v___x_366_);
lean_ctor_set_uint8(v___x_367_, sizeof(void*)*1, v___x_353_);
v___x_368_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_368_, 0, v___x_362_);
lean_ctor_set(v___x_368_, 1, v___x_367_);
v___x_369_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_369_, 0, v___x_368_);
lean_ctor_set(v___x_369_, 1, v___x_356_);
v___x_370_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_370_, 0, v___x_369_);
lean_ctor_set(v___x_370_, 1, v___x_358_);
v___x_371_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__12));
v___x_372_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_372_, 0, v___x_370_);
lean_ctor_set(v___x_372_, 1, v___x_371_);
v___x_373_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_373_, 0, v___x_372_);
lean_ctor_set(v___x_373_, 1, v___x_347_);
v___x_374_ = l_Nat_reprFast(v_boot_344_);
v___x_375_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_375_, 0, v___x_374_);
v___x_376_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_376_, 0, v___x_363_);
lean_ctor_set(v___x_376_, 1, v___x_375_);
v___x_377_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_377_, 0, v___x_376_);
lean_ctor_set_uint8(v___x_377_, sizeof(void*)*1, v___x_353_);
v___x_378_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_378_, 0, v___x_373_);
lean_ctor_set(v___x_378_, 1, v___x_377_);
v___x_379_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_379_, 0, v___x_378_);
lean_ctor_set(v___x_379_, 1, v___x_356_);
v___x_380_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_380_, 0, v___x_379_);
lean_ctor_set(v___x_380_, 1, v___x_358_);
v___x_381_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__5));
v___x_382_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_382_, 0, v___x_380_);
lean_ctor_set(v___x_382_, 1, v___x_381_);
v___x_383_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_383_, 0, v___x_382_);
lean_ctor_set(v___x_383_, 1, v___x_347_);
v___x_384_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__6, &lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__6_once, _init_lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__6);
v___x_385_ = l_Nat_reprFast(v_closed_345_);
v___x_386_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_386_, 0, v___x_385_);
v___x_387_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_387_, 0, v___x_384_);
lean_ctor_set(v___x_387_, 1, v___x_386_);
v___x_388_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_388_, 0, v___x_387_);
lean_ctor_set_uint8(v___x_388_, sizeof(void*)*1, v___x_353_);
v___x_389_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_389_, 0, v___x_383_);
lean_ctor_set(v___x_389_, 1, v___x_388_);
v___x_390_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_390_, 0, v___x_389_);
lean_ctor_set(v___x_390_, 1, v___x_356_);
v___x_391_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_391_, 0, v___x_390_);
lean_ctor_set(v___x_391_, 1, v___x_358_);
v___x_392_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__8));
v___x_393_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_393_, 0, v___x_391_);
lean_ctor_set(v___x_393_, 1, v___x_392_);
v___x_394_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_394_, 0, v___x_393_);
lean_ctor_set(v___x_394_, 1, v___x_347_);
v___x_395_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__9, &lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__9_once, _init_lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__9);
v___x_396_ = lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0(v_pending_346_, v___x_364_);
v___x_397_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_397_, 0, v___x_395_);
lean_ctor_set(v___x_397_, 1, v___x_396_);
v___x_398_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_398_, 0, v___x_397_);
lean_ctor_set_uint8(v___x_398_, sizeof(void*)*1, v___x_353_);
v___x_399_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_399_, 0, v___x_394_);
lean_ctor_set(v___x_399_, 1, v___x_398_);
v___x_400_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21);
v___x_401_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__22));
v___x_402_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_402_, 0, v___x_401_);
lean_ctor_set(v___x_402_, 1, v___x_399_);
v___x_403_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__23));
v___x_404_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_404_, 0, v___x_402_);
lean_ctor_set(v___x_404_, 1, v___x_403_);
v___x_405_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_405_, 0, v___x_400_);
lean_ctor_set(v___x_405_, 1, v___x_404_);
v___x_406_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_406_, 0, v___x_405_);
lean_ctor_set_uint8(v___x_406_, sizeof(void*)*1, v___x_353_);
return v___x_406_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprState_repr(lean_object* v_x_407_, lean_object* v_prec_408_){
_start:
{
lean_object* v___x_409_; 
v___x_409_ = lp_physical__bridges_UPTController_instReprState_repr___redArg(v_x_407_);
return v___x_409_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprState_repr___boxed(lean_object* v_x_410_, lean_object* v_prec_411_){
_start:
{
lean_object* v_res_412_; 
v_res_412_ = lp_physical__bridges_UPTController_instReprState_repr(v_x_410_, v_prec_411_);
lean_dec(v_prec_411_);
return v_res_412_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_ctorIdx(lean_object* v_x_415_){
_start:
{
switch(lean_obj_tag(v_x_415_))
{
case 0:
{
lean_object* v___x_416_; 
v___x_416_ = lean_unsigned_to_nat(0u);
return v___x_416_;
}
case 1:
{
lean_object* v___x_417_; 
v___x_417_ = lean_unsigned_to_nat(1u);
return v___x_417_;
}
case 2:
{
lean_object* v___x_418_; 
v___x_418_ = lean_unsigned_to_nat(2u);
return v___x_418_;
}
case 3:
{
lean_object* v___x_419_; 
v___x_419_ = lean_unsigned_to_nat(3u);
return v___x_419_;
}
default: 
{
lean_object* v___x_420_; 
v___x_420_ = lean_unsigned_to_nat(4u);
return v___x_420_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_ctorIdx___boxed(lean_object* v_x_421_){
_start:
{
lean_object* v_res_422_; 
v_res_422_ = lp_physical__bridges_UPTController_Op_ctorIdx(v_x_421_);
lean_dec_ref(v_x_421_);
return v_res_422_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_ctorElim___redArg(lean_object* v_t_423_, lean_object* v_k_424_){
_start:
{
switch(lean_obj_tag(v_t_423_))
{
case 3:
{
lean_object* v_b_425_; lean_object* v___x_426_; 
v_b_425_ = lean_ctor_get(v_t_423_, 0);
lean_inc(v_b_425_);
lean_dec_ref_known(v_t_423_, 1);
v___x_426_ = lean_apply_1(v_k_424_, v_b_425_);
return v___x_426_;
}
case 4:
{
lean_object* v_q_427_; lean_object* v___x_428_; 
v_q_427_ = lean_ctor_get(v_t_423_, 0);
lean_inc(v_q_427_);
lean_dec_ref_known(v_t_423_, 1);
v___x_428_ = lean_apply_1(v_k_424_, v_q_427_);
return v___x_428_;
}
default: 
{
lean_object* v_c_429_; lean_object* v___x_430_; 
v_c_429_ = lean_ctor_get(v_t_423_, 0);
lean_inc_ref(v_c_429_);
lean_dec_ref(v_t_423_);
v___x_430_ = lean_apply_1(v_k_424_, v_c_429_);
return v___x_430_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_ctorElim(lean_object* v_motive_431_, lean_object* v_ctorIdx_432_, lean_object* v_t_433_, lean_object* v_h_434_, lean_object* v_k_435_){
_start:
{
lean_object* v___x_436_; 
v___x_436_ = lp_physical__bridges_UPTController_Op_ctorElim___redArg(v_t_433_, v_k_435_);
return v___x_436_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_ctorElim___boxed(lean_object* v_motive_437_, lean_object* v_ctorIdx_438_, lean_object* v_t_439_, lean_object* v_h_440_, lean_object* v_k_441_){
_start:
{
lean_object* v_res_442_; 
v_res_442_ = lp_physical__bridges_UPTController_Op_ctorElim(v_motive_437_, v_ctorIdx_438_, v_t_439_, v_h_440_, v_k_441_);
lean_dec(v_ctorIdx_438_);
return v_res_442_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_authorize_elim___redArg(lean_object* v_t_443_, lean_object* v_authorize_444_){
_start:
{
lean_object* v___x_445_; 
v___x_445_ = lp_physical__bridges_UPTController_Op_ctorElim___redArg(v_t_443_, v_authorize_444_);
return v___x_445_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_authorize_elim(lean_object* v_motive_446_, lean_object* v_t_447_, lean_object* v_h_448_, lean_object* v_authorize_449_){
_start:
{
lean_object* v___x_450_; 
v___x_450_ = lp_physical__bridges_UPTController_Op_ctorElim___redArg(v_t_447_, v_authorize_449_);
return v___x_450_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_retire_elim___redArg(lean_object* v_t_451_, lean_object* v_retire_452_){
_start:
{
lean_object* v___x_453_; 
v___x_453_ = lp_physical__bridges_UPTController_Op_ctorElim___redArg(v_t_451_, v_retire_452_);
return v___x_453_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_retire_elim(lean_object* v_motive_454_, lean_object* v_t_455_, lean_object* v_h_456_, lean_object* v_retire_457_){
_start:
{
lean_object* v___x_458_; 
v___x_458_ = lp_physical__bridges_UPTController_Op_ctorElim___redArg(v_t_455_, v_retire_457_);
return v___x_458_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_release_elim___redArg(lean_object* v_t_459_, lean_object* v_release_460_){
_start:
{
lean_object* v___x_461_; 
v___x_461_ = lp_physical__bridges_UPTController_Op_ctorElim___redArg(v_t_459_, v_release_460_);
return v___x_461_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_release_elim(lean_object* v_motive_462_, lean_object* v_t_463_, lean_object* v_h_464_, lean_object* v_release_465_){
_start:
{
lean_object* v___x_466_; 
v___x_466_ = lp_physical__bridges_UPTController_Op_ctorElim___redArg(v_t_463_, v_release_465_);
return v___x_466_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_openBoot_elim___redArg(lean_object* v_t_467_, lean_object* v_openBoot_468_){
_start:
{
lean_object* v___x_469_; 
v___x_469_ = lp_physical__bridges_UPTController_Op_ctorElim___redArg(v_t_467_, v_openBoot_468_);
return v___x_469_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_openBoot_elim(lean_object* v_motive_470_, lean_object* v_t_471_, lean_object* v_h_472_, lean_object* v_openBoot_473_){
_start:
{
lean_object* v___x_474_; 
v___x_474_ = lp_physical__bridges_UPTController_Op_ctorElim___redArg(v_t_471_, v_openBoot_473_);
return v___x_474_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_close_elim___redArg(lean_object* v_t_475_, lean_object* v_close_476_){
_start:
{
lean_object* v___x_477_; 
v___x_477_ = lp_physical__bridges_UPTController_Op_ctorElim___redArg(v_t_475_, v_close_476_);
return v___x_477_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Op_close_elim(lean_object* v_motive_478_, lean_object* v_t_479_, lean_object* v_h_480_, lean_object* v_close_481_){
_start:
{
lean_object* v___x_482_; 
v___x_482_ = lp_physical__bridges_UPTController_Op_ctorElim___redArg(v_t_479_, v_close_481_);
return v___x_482_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqOp_decEq(lean_object* v_x_483_, lean_object* v_x_484_){
_start:
{
switch(lean_obj_tag(v_x_483_))
{
case 0:
{
if (lean_obj_tag(v_x_484_) == 0)
{
lean_object* v_c_485_; lean_object* v_c_486_; uint8_t v___x_487_; 
v_c_485_ = lean_ctor_get(v_x_483_, 0);
lean_inc_ref(v_c_485_);
lean_dec_ref_known(v_x_483_, 1);
v_c_486_ = lean_ctor_get(v_x_484_, 0);
lean_inc_ref(v_c_486_);
lean_dec_ref_known(v_x_484_, 1);
v___x_487_ = lp_physical__bridges_UPTController_instDecidableEqContext_decEq(v_c_485_, v_c_486_);
return v___x_487_;
}
else
{
uint8_t v___x_488_; 
lean_dec_ref_known(v_x_483_, 1);
lean_dec_ref(v_x_484_);
v___x_488_ = 0;
return v___x_488_;
}
}
case 1:
{
if (lean_obj_tag(v_x_484_) == 1)
{
lean_object* v_c_489_; lean_object* v_c_490_; uint8_t v___x_491_; 
v_c_489_ = lean_ctor_get(v_x_483_, 0);
lean_inc_ref(v_c_489_);
lean_dec_ref_known(v_x_483_, 1);
v_c_490_ = lean_ctor_get(v_x_484_, 0);
lean_inc_ref(v_c_490_);
lean_dec_ref_known(v_x_484_, 1);
v___x_491_ = lp_physical__bridges_UPTController_instDecidableEqContext_decEq(v_c_489_, v_c_490_);
return v___x_491_;
}
else
{
uint8_t v___x_492_; 
lean_dec_ref_known(v_x_483_, 1);
lean_dec_ref(v_x_484_);
v___x_492_ = 0;
return v___x_492_;
}
}
case 2:
{
if (lean_obj_tag(v_x_484_) == 2)
{
lean_object* v_c_493_; lean_object* v_c_494_; uint8_t v___x_495_; 
v_c_493_ = lean_ctor_get(v_x_483_, 0);
lean_inc_ref(v_c_493_);
lean_dec_ref_known(v_x_483_, 1);
v_c_494_ = lean_ctor_get(v_x_484_, 0);
lean_inc_ref(v_c_494_);
lean_dec_ref_known(v_x_484_, 1);
v___x_495_ = lp_physical__bridges_UPTController_instDecidableEqContext_decEq(v_c_493_, v_c_494_);
return v___x_495_;
}
else
{
uint8_t v___x_496_; 
lean_dec_ref_known(v_x_483_, 1);
lean_dec_ref(v_x_484_);
v___x_496_ = 0;
return v___x_496_;
}
}
case 3:
{
if (lean_obj_tag(v_x_484_) == 3)
{
lean_object* v_b_497_; lean_object* v_b_498_; uint8_t v___x_499_; 
v_b_497_ = lean_ctor_get(v_x_483_, 0);
lean_inc(v_b_497_);
lean_dec_ref_known(v_x_483_, 1);
v_b_498_ = lean_ctor_get(v_x_484_, 0);
lean_inc(v_b_498_);
lean_dec_ref_known(v_x_484_, 1);
v___x_499_ = lean_nat_dec_eq(v_b_497_, v_b_498_);
lean_dec(v_b_498_);
lean_dec(v_b_497_);
return v___x_499_;
}
else
{
uint8_t v___x_500_; 
lean_dec_ref_known(v_x_483_, 1);
lean_dec_ref(v_x_484_);
v___x_500_ = 0;
return v___x_500_;
}
}
default: 
{
if (lean_obj_tag(v_x_484_) == 4)
{
lean_object* v_q_501_; lean_object* v_q_502_; uint8_t v___x_503_; 
v_q_501_ = lean_ctor_get(v_x_483_, 0);
lean_inc(v_q_501_);
lean_dec_ref_known(v_x_483_, 1);
v_q_502_ = lean_ctor_get(v_x_484_, 0);
lean_inc(v_q_502_);
lean_dec_ref_known(v_x_484_, 1);
v___x_503_ = lean_nat_dec_eq(v_q_501_, v_q_502_);
lean_dec(v_q_502_);
lean_dec(v_q_501_);
return v___x_503_;
}
else
{
uint8_t v___x_504_; 
lean_dec_ref_known(v_x_483_, 1);
lean_dec_ref(v_x_484_);
v___x_504_ = 0;
return v___x_504_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqOp_decEq___boxed(lean_object* v_x_505_, lean_object* v_x_506_){
_start:
{
uint8_t v_res_507_; lean_object* v_r_508_; 
v_res_507_ = lp_physical__bridges_UPTController_instDecidableEqOp_decEq(v_x_505_, v_x_506_);
v_r_508_ = lean_box(v_res_507_);
return v_r_508_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqOp(lean_object* v_x_509_, lean_object* v_x_510_){
_start:
{
uint8_t v___x_511_; 
v___x_511_ = lp_physical__bridges_UPTController_instDecidableEqOp_decEq(v_x_509_, v_x_510_);
return v___x_511_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqOp___boxed(lean_object* v_x_512_, lean_object* v_x_513_){
_start:
{
uint8_t v_res_514_; lean_object* v_r_515_; 
v_res_514_ = lp_physical__bridges_UPTController_instDecidableEqOp(v_x_512_, v_x_513_);
v_r_515_ = lean_box(v_res_514_);
return v_r_515_;
}
}
static lean_object* _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__3(void){
_start:
{
lean_object* v___x_522_; lean_object* v___x_523_; 
v___x_522_ = lean_unsigned_to_nat(2u);
v___x_523_ = lean_nat_to_int(v___x_522_);
return v___x_523_;
}
}
static lean_object* _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__4(void){
_start:
{
lean_object* v___x_524_; lean_object* v___x_525_; 
v___x_524_ = lean_unsigned_to_nat(1u);
v___x_525_ = lean_nat_to_int(v___x_524_);
return v___x_525_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprOp_repr(lean_object* v_x_550_, lean_object* v_prec_551_){
_start:
{
switch(lean_obj_tag(v_x_550_))
{
case 0:
{
lean_object* v_c_552_; lean_object* v___y_554_; lean_object* v___x_562_; uint8_t v___x_563_; 
v_c_552_ = lean_ctor_get(v_x_550_, 0);
lean_inc_ref(v_c_552_);
lean_dec_ref_known(v_x_550_, 1);
v___x_562_ = lean_unsigned_to_nat(1024u);
v___x_563_ = lean_nat_dec_le(v___x_562_, v_prec_551_);
if (v___x_563_ == 0)
{
lean_object* v___x_564_; 
v___x_564_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__3, &lp_physical__bridges_UPTController_instReprOp_repr___closed__3_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__3);
v___y_554_ = v___x_564_;
goto v___jp_553_;
}
else
{
lean_object* v___x_565_; 
v___x_565_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__4, &lp_physical__bridges_UPTController_instReprOp_repr___closed__4_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__4);
v___y_554_ = v___x_565_;
goto v___jp_553_;
}
v___jp_553_:
{
lean_object* v___x_555_; lean_object* v___x_556_; lean_object* v___x_557_; lean_object* v___x_558_; uint8_t v___x_559_; lean_object* v___x_560_; lean_object* v___x_561_; 
v___x_555_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprOp_repr___closed__2));
v___x_556_ = lp_physical__bridges_UPTController_instReprContext_repr___redArg(v_c_552_);
v___x_557_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_557_, 0, v___x_555_);
lean_ctor_set(v___x_557_, 1, v___x_556_);
lean_inc(v___y_554_);
v___x_558_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_558_, 0, v___y_554_);
lean_ctor_set(v___x_558_, 1, v___x_557_);
v___x_559_ = 0;
v___x_560_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_560_, 0, v___x_558_);
lean_ctor_set_uint8(v___x_560_, sizeof(void*)*1, v___x_559_);
v___x_561_ = l_Repr_addAppParen(v___x_560_, v_prec_551_);
return v___x_561_;
}
}
case 1:
{
lean_object* v_c_566_; lean_object* v___y_568_; lean_object* v___x_576_; uint8_t v___x_577_; 
v_c_566_ = lean_ctor_get(v_x_550_, 0);
lean_inc_ref(v_c_566_);
lean_dec_ref_known(v_x_550_, 1);
v___x_576_ = lean_unsigned_to_nat(1024u);
v___x_577_ = lean_nat_dec_le(v___x_576_, v_prec_551_);
if (v___x_577_ == 0)
{
lean_object* v___x_578_; 
v___x_578_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__3, &lp_physical__bridges_UPTController_instReprOp_repr___closed__3_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__3);
v___y_568_ = v___x_578_;
goto v___jp_567_;
}
else
{
lean_object* v___x_579_; 
v___x_579_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__4, &lp_physical__bridges_UPTController_instReprOp_repr___closed__4_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__4);
v___y_568_ = v___x_579_;
goto v___jp_567_;
}
v___jp_567_:
{
lean_object* v___x_569_; lean_object* v___x_570_; lean_object* v___x_571_; lean_object* v___x_572_; uint8_t v___x_573_; lean_object* v___x_574_; lean_object* v___x_575_; 
v___x_569_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprOp_repr___closed__7));
v___x_570_ = lp_physical__bridges_UPTController_instReprContext_repr___redArg(v_c_566_);
v___x_571_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_571_, 0, v___x_569_);
lean_ctor_set(v___x_571_, 1, v___x_570_);
lean_inc(v___y_568_);
v___x_572_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_572_, 0, v___y_568_);
lean_ctor_set(v___x_572_, 1, v___x_571_);
v___x_573_ = 0;
v___x_574_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_574_, 0, v___x_572_);
lean_ctor_set_uint8(v___x_574_, sizeof(void*)*1, v___x_573_);
v___x_575_ = l_Repr_addAppParen(v___x_574_, v_prec_551_);
return v___x_575_;
}
}
case 2:
{
lean_object* v_c_580_; lean_object* v___y_582_; lean_object* v___x_590_; uint8_t v___x_591_; 
v_c_580_ = lean_ctor_get(v_x_550_, 0);
lean_inc_ref(v_c_580_);
lean_dec_ref_known(v_x_550_, 1);
v___x_590_ = lean_unsigned_to_nat(1024u);
v___x_591_ = lean_nat_dec_le(v___x_590_, v_prec_551_);
if (v___x_591_ == 0)
{
lean_object* v___x_592_; 
v___x_592_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__3, &lp_physical__bridges_UPTController_instReprOp_repr___closed__3_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__3);
v___y_582_ = v___x_592_;
goto v___jp_581_;
}
else
{
lean_object* v___x_593_; 
v___x_593_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__4, &lp_physical__bridges_UPTController_instReprOp_repr___closed__4_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__4);
v___y_582_ = v___x_593_;
goto v___jp_581_;
}
v___jp_581_:
{
lean_object* v___x_583_; lean_object* v___x_584_; lean_object* v___x_585_; lean_object* v___x_586_; uint8_t v___x_587_; lean_object* v___x_588_; lean_object* v___x_589_; 
v___x_583_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprOp_repr___closed__10));
v___x_584_ = lp_physical__bridges_UPTController_instReprContext_repr___redArg(v_c_580_);
v___x_585_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_585_, 0, v___x_583_);
lean_ctor_set(v___x_585_, 1, v___x_584_);
lean_inc(v___y_582_);
v___x_586_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_586_, 0, v___y_582_);
lean_ctor_set(v___x_586_, 1, v___x_585_);
v___x_587_ = 0;
v___x_588_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_588_, 0, v___x_586_);
lean_ctor_set_uint8(v___x_588_, sizeof(void*)*1, v___x_587_);
v___x_589_ = l_Repr_addAppParen(v___x_588_, v_prec_551_);
return v___x_589_;
}
}
case 3:
{
lean_object* v_b_594_; lean_object* v___x_596_; uint8_t v_isShared_597_; uint8_t v_isSharedCheck_614_; 
v_b_594_ = lean_ctor_get(v_x_550_, 0);
v_isSharedCheck_614_ = !lean_is_exclusive(v_x_550_);
if (v_isSharedCheck_614_ == 0)
{
v___x_596_ = v_x_550_;
v_isShared_597_ = v_isSharedCheck_614_;
goto v_resetjp_595_;
}
else
{
lean_inc(v_b_594_);
lean_dec(v_x_550_);
v___x_596_ = lean_box(0);
v_isShared_597_ = v_isSharedCheck_614_;
goto v_resetjp_595_;
}
v_resetjp_595_:
{
lean_object* v___y_599_; lean_object* v___x_610_; uint8_t v___x_611_; 
v___x_610_ = lean_unsigned_to_nat(1024u);
v___x_611_ = lean_nat_dec_le(v___x_610_, v_prec_551_);
if (v___x_611_ == 0)
{
lean_object* v___x_612_; 
v___x_612_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__3, &lp_physical__bridges_UPTController_instReprOp_repr___closed__3_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__3);
v___y_599_ = v___x_612_;
goto v___jp_598_;
}
else
{
lean_object* v___x_613_; 
v___x_613_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__4, &lp_physical__bridges_UPTController_instReprOp_repr___closed__4_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__4);
v___y_599_ = v___x_613_;
goto v___jp_598_;
}
v___jp_598_:
{
lean_object* v___x_600_; lean_object* v___x_601_; lean_object* v___x_603_; 
v___x_600_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprOp_repr___closed__13));
v___x_601_ = l_Nat_reprFast(v_b_594_);
if (v_isShared_597_ == 0)
{
lean_ctor_set(v___x_596_, 0, v___x_601_);
v___x_603_ = v___x_596_;
goto v_reusejp_602_;
}
else
{
lean_object* v_reuseFailAlloc_609_; 
v_reuseFailAlloc_609_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v_reuseFailAlloc_609_, 0, v___x_601_);
v___x_603_ = v_reuseFailAlloc_609_;
goto v_reusejp_602_;
}
v_reusejp_602_:
{
lean_object* v___x_604_; lean_object* v___x_605_; uint8_t v___x_606_; lean_object* v___x_607_; lean_object* v___x_608_; 
v___x_604_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_604_, 0, v___x_600_);
lean_ctor_set(v___x_604_, 1, v___x_603_);
lean_inc(v___y_599_);
v___x_605_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_605_, 0, v___y_599_);
lean_ctor_set(v___x_605_, 1, v___x_604_);
v___x_606_ = 0;
v___x_607_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_607_, 0, v___x_605_);
lean_ctor_set_uint8(v___x_607_, sizeof(void*)*1, v___x_606_);
v___x_608_ = l_Repr_addAppParen(v___x_607_, v_prec_551_);
return v___x_608_;
}
}
}
}
default: 
{
lean_object* v_q_615_; lean_object* v___x_617_; uint8_t v_isShared_618_; uint8_t v_isSharedCheck_635_; 
v_q_615_ = lean_ctor_get(v_x_550_, 0);
v_isSharedCheck_635_ = !lean_is_exclusive(v_x_550_);
if (v_isSharedCheck_635_ == 0)
{
v___x_617_ = v_x_550_;
v_isShared_618_ = v_isSharedCheck_635_;
goto v_resetjp_616_;
}
else
{
lean_inc(v_q_615_);
lean_dec(v_x_550_);
v___x_617_ = lean_box(0);
v_isShared_618_ = v_isSharedCheck_635_;
goto v_resetjp_616_;
}
v_resetjp_616_:
{
lean_object* v___y_620_; lean_object* v___x_631_; uint8_t v___x_632_; 
v___x_631_ = lean_unsigned_to_nat(1024u);
v___x_632_ = lean_nat_dec_le(v___x_631_, v_prec_551_);
if (v___x_632_ == 0)
{
lean_object* v___x_633_; 
v___x_633_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__3, &lp_physical__bridges_UPTController_instReprOp_repr___closed__3_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__3);
v___y_620_ = v___x_633_;
goto v___jp_619_;
}
else
{
lean_object* v___x_634_; 
v___x_634_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__4, &lp_physical__bridges_UPTController_instReprOp_repr___closed__4_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__4);
v___y_620_ = v___x_634_;
goto v___jp_619_;
}
v___jp_619_:
{
lean_object* v___x_621_; lean_object* v___x_622_; lean_object* v___x_624_; 
v___x_621_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprOp_repr___closed__16));
v___x_622_ = l_Nat_reprFast(v_q_615_);
if (v_isShared_618_ == 0)
{
lean_ctor_set_tag(v___x_617_, 3);
lean_ctor_set(v___x_617_, 0, v___x_622_);
v___x_624_ = v___x_617_;
goto v_reusejp_623_;
}
else
{
lean_object* v_reuseFailAlloc_630_; 
v_reuseFailAlloc_630_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v_reuseFailAlloc_630_, 0, v___x_622_);
v___x_624_ = v_reuseFailAlloc_630_;
goto v_reusejp_623_;
}
v_reusejp_623_:
{
lean_object* v___x_625_; lean_object* v___x_626_; uint8_t v___x_627_; lean_object* v___x_628_; lean_object* v___x_629_; 
v___x_625_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_625_, 0, v___x_621_);
lean_ctor_set(v___x_625_, 1, v___x_624_);
lean_inc(v___y_620_);
v___x_626_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_626_, 0, v___y_620_);
lean_ctor_set(v___x_626_, 1, v___x_625_);
v___x_627_ = 0;
v___x_628_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_628_, 0, v___x_626_);
lean_ctor_set_uint8(v___x_628_, sizeof(void*)*1, v___x_627_);
v___x_629_ = l_Repr_addAppParen(v___x_628_, v_prec_551_);
return v___x_629_;
}
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprOp_repr___boxed(lean_object* v_x_636_, lean_object* v_prec_637_){
_start:
{
lean_object* v_res_638_; 
v_res_638_ = lp_physical__bridges_UPTController_instReprOp_repr(v_x_636_, v_prec_637_);
lean_dec(v_prec_637_);
return v_res_638_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_ctorIdx(lean_object* v_x_641_){
_start:
{
switch(lean_obj_tag(v_x_641_))
{
case 0:
{
lean_object* v___x_642_; 
v___x_642_ = lean_unsigned_to_nat(0u);
return v___x_642_;
}
case 1:
{
lean_object* v___x_643_; 
v___x_643_ = lean_unsigned_to_nat(1u);
return v___x_643_;
}
case 2:
{
lean_object* v___x_644_; 
v___x_644_ = lean_unsigned_to_nat(2u);
return v___x_644_;
}
case 3:
{
lean_object* v___x_645_; 
v___x_645_ = lean_unsigned_to_nat(3u);
return v___x_645_;
}
case 4:
{
lean_object* v___x_646_; 
v___x_646_ = lean_unsigned_to_nat(4u);
return v___x_646_;
}
default: 
{
lean_object* v___x_647_; 
v___x_647_ = lean_unsigned_to_nat(5u);
return v___x_647_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_ctorIdx___boxed(lean_object* v_x_648_){
_start:
{
lean_object* v_res_649_; 
v_res_649_ = lp_physical__bridges_UPTController_Reply_ctorIdx(v_x_648_);
lean_dec(v_x_648_);
return v_res_649_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_ctorElim___redArg(lean_object* v_t_650_, lean_object* v_k_651_){
_start:
{
switch(lean_obj_tag(v_t_650_))
{
case 1:
{
lean_object* v_c_652_; lean_object* v___x_653_; 
v_c_652_ = lean_ctor_get(v_t_650_, 0);
lean_inc_ref(v_c_652_);
lean_dec_ref_known(v_t_650_, 1);
v___x_653_ = lean_apply_1(v_k_651_, v_c_652_);
return v___x_653_;
}
case 2:
{
lean_object* v_c_654_; lean_object* v_newFloor_655_; lean_object* v___x_656_; 
v_c_654_ = lean_ctor_get(v_t_650_, 0);
lean_inc_ref(v_c_654_);
v_newFloor_655_ = lean_ctor_get(v_t_650_, 1);
lean_inc(v_newFloor_655_);
lean_dec_ref_known(v_t_650_, 2);
v___x_656_ = lean_apply_2(v_k_651_, v_c_654_, v_newFloor_655_);
return v___x_656_;
}
default: 
{
lean_dec(v_t_650_);
return v_k_651_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_ctorElim(lean_object* v_motive_657_, lean_object* v_ctorIdx_658_, lean_object* v_t_659_, lean_object* v_h_660_, lean_object* v_k_661_){
_start:
{
lean_object* v___x_662_; 
v___x_662_ = lp_physical__bridges_UPTController_Reply_ctorElim___redArg(v_t_659_, v_k_661_);
return v___x_662_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_ctorElim___boxed(lean_object* v_motive_663_, lean_object* v_ctorIdx_664_, lean_object* v_t_665_, lean_object* v_h_666_, lean_object* v_k_667_){
_start:
{
lean_object* v_res_668_; 
v_res_668_ = lp_physical__bridges_UPTController_Reply_ctorElim(v_motive_663_, v_ctorIdx_664_, v_t_665_, v_h_666_, v_k_667_);
lean_dec(v_ctorIdx_664_);
return v_res_668_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_rejected_elim___redArg(lean_object* v_t_669_, lean_object* v_rejected_670_){
_start:
{
lean_object* v___x_671_; 
v___x_671_ = lp_physical__bridges_UPTController_Reply_ctorElim___redArg(v_t_669_, v_rejected_670_);
return v___x_671_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_rejected_elim(lean_object* v_motive_672_, lean_object* v_t_673_, lean_object* v_h_674_, lean_object* v_rejected_675_){
_start:
{
lean_object* v___x_676_; 
v___x_676_ = lp_physical__bridges_UPTController_Reply_ctorElim___redArg(v_t_673_, v_rejected_675_);
return v___x_676_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_grant_elim___redArg(lean_object* v_t_677_, lean_object* v_grant_678_){
_start:
{
lean_object* v___x_679_; 
v___x_679_ = lp_physical__bridges_UPTController_Reply_ctorElim___redArg(v_t_677_, v_grant_678_);
return v___x_679_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_grant_elim(lean_object* v_motive_680_, lean_object* v_t_681_, lean_object* v_h_682_, lean_object* v_grant_683_){
_start:
{
lean_object* v___x_684_; 
v___x_684_ = lp_physical__bridges_UPTController_Reply_ctorElim___redArg(v_t_681_, v_grant_683_);
return v___x_684_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_floor_elim___redArg(lean_object* v_t_685_, lean_object* v_floor_686_){
_start:
{
lean_object* v___x_687_; 
v___x_687_ = lp_physical__bridges_UPTController_Reply_ctorElim___redArg(v_t_685_, v_floor_686_);
return v___x_687_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_floor_elim(lean_object* v_motive_688_, lean_object* v_t_689_, lean_object* v_h_690_, lean_object* v_floor_691_){
_start:
{
lean_object* v___x_692_; 
v___x_692_ = lp_physical__bridges_UPTController_Reply_ctorElim___redArg(v_t_689_, v_floor_691_);
return v___x_692_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_released_elim___redArg(lean_object* v_t_693_, lean_object* v_released_694_){
_start:
{
lean_object* v___x_695_; 
v___x_695_ = lp_physical__bridges_UPTController_Reply_ctorElim___redArg(v_t_693_, v_released_694_);
return v___x_695_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_released_elim(lean_object* v_motive_696_, lean_object* v_t_697_, lean_object* v_h_698_, lean_object* v_released_699_){
_start:
{
lean_object* v___x_700_; 
v___x_700_ = lp_physical__bridges_UPTController_Reply_ctorElim___redArg(v_t_697_, v_released_699_);
return v___x_700_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_booted_elim___redArg(lean_object* v_t_701_, lean_object* v_booted_702_){
_start:
{
lean_object* v___x_703_; 
v___x_703_ = lp_physical__bridges_UPTController_Reply_ctorElim___redArg(v_t_701_, v_booted_702_);
return v___x_703_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_booted_elim(lean_object* v_motive_704_, lean_object* v_t_705_, lean_object* v_h_706_, lean_object* v_booted_707_){
_start:
{
lean_object* v___x_708_; 
v___x_708_ = lp_physical__bridges_UPTController_Reply_ctorElim___redArg(v_t_705_, v_booted_707_);
return v___x_708_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_closed_elim___redArg(lean_object* v_t_709_, lean_object* v_closed_710_){
_start:
{
lean_object* v___x_711_; 
v___x_711_ = lp_physical__bridges_UPTController_Reply_ctorElim___redArg(v_t_709_, v_closed_710_);
return v___x_711_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_Reply_closed_elim(lean_object* v_motive_712_, lean_object* v_t_713_, lean_object* v_h_714_, lean_object* v_closed_715_){
_start:
{
lean_object* v___x_716_; 
v___x_716_ = lp_physical__bridges_UPTController_Reply_ctorElim___redArg(v_t_713_, v_closed_715_);
return v___x_716_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqReply_decEq(lean_object* v_x_717_, lean_object* v_x_718_){
_start:
{
switch(lean_obj_tag(v_x_717_))
{
case 0:
{
if (lean_obj_tag(v_x_718_) == 0)
{
uint8_t v___x_719_; 
v___x_719_ = 1;
return v___x_719_;
}
else
{
uint8_t v___x_720_; 
lean_dec(v_x_718_);
v___x_720_ = 0;
return v___x_720_;
}
}
case 1:
{
if (lean_obj_tag(v_x_718_) == 1)
{
lean_object* v_c_721_; lean_object* v_c_722_; uint8_t v___x_723_; 
v_c_721_ = lean_ctor_get(v_x_717_, 0);
lean_inc_ref(v_c_721_);
lean_dec_ref_known(v_x_717_, 1);
v_c_722_ = lean_ctor_get(v_x_718_, 0);
lean_inc_ref(v_c_722_);
lean_dec_ref_known(v_x_718_, 1);
v___x_723_ = lp_physical__bridges_UPTController_instDecidableEqContext_decEq(v_c_721_, v_c_722_);
return v___x_723_;
}
else
{
uint8_t v___x_724_; 
lean_dec_ref_known(v_x_717_, 1);
lean_dec(v_x_718_);
v___x_724_ = 0;
return v___x_724_;
}
}
case 2:
{
if (lean_obj_tag(v_x_718_) == 2)
{
lean_object* v_c_725_; lean_object* v_newFloor_726_; lean_object* v_c_727_; lean_object* v_newFloor_728_; uint8_t v___x_729_; 
v_c_725_ = lean_ctor_get(v_x_717_, 0);
lean_inc_ref(v_c_725_);
v_newFloor_726_ = lean_ctor_get(v_x_717_, 1);
lean_inc(v_newFloor_726_);
lean_dec_ref_known(v_x_717_, 2);
v_c_727_ = lean_ctor_get(v_x_718_, 0);
lean_inc_ref(v_c_727_);
v_newFloor_728_ = lean_ctor_get(v_x_718_, 1);
lean_inc(v_newFloor_728_);
lean_dec_ref_known(v_x_718_, 2);
v___x_729_ = lp_physical__bridges_UPTController_instDecidableEqContext_decEq(v_c_725_, v_c_727_);
if (v___x_729_ == 0)
{
lean_dec(v_newFloor_728_);
lean_dec(v_newFloor_726_);
return v___x_729_;
}
else
{
uint8_t v___x_730_; 
v___x_730_ = lean_nat_dec_eq(v_newFloor_726_, v_newFloor_728_);
lean_dec(v_newFloor_728_);
lean_dec(v_newFloor_726_);
return v___x_730_;
}
}
else
{
uint8_t v___x_731_; 
lean_dec_ref_known(v_x_717_, 2);
lean_dec(v_x_718_);
v___x_731_ = 0;
return v___x_731_;
}
}
case 3:
{
if (lean_obj_tag(v_x_718_) == 3)
{
uint8_t v___x_732_; 
v___x_732_ = 1;
return v___x_732_;
}
else
{
uint8_t v___x_733_; 
lean_dec(v_x_718_);
v___x_733_ = 0;
return v___x_733_;
}
}
case 4:
{
if (lean_obj_tag(v_x_718_) == 4)
{
uint8_t v___x_734_; 
v___x_734_ = 1;
return v___x_734_;
}
else
{
uint8_t v___x_735_; 
lean_dec(v_x_718_);
v___x_735_ = 0;
return v___x_735_;
}
}
default: 
{
if (lean_obj_tag(v_x_718_) == 5)
{
uint8_t v___x_736_; 
v___x_736_ = 1;
return v___x_736_;
}
else
{
uint8_t v___x_737_; 
lean_dec(v_x_718_);
v___x_737_ = 0;
return v___x_737_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqReply_decEq___boxed(lean_object* v_x_738_, lean_object* v_x_739_){
_start:
{
uint8_t v_res_740_; lean_object* v_r_741_; 
v_res_740_ = lp_physical__bridges_UPTController_instDecidableEqReply_decEq(v_x_738_, v_x_739_);
v_r_741_ = lean_box(v_res_740_);
return v_r_741_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqReply(lean_object* v_x_742_, lean_object* v_x_743_){
_start:
{
uint8_t v___x_744_; 
v___x_744_ = lp_physical__bridges_UPTController_instDecidableEqReply_decEq(v_x_742_, v_x_743_);
return v___x_744_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqReply___boxed(lean_object* v_x_745_, lean_object* v_x_746_){
_start:
{
uint8_t v_res_747_; lean_object* v_r_748_; 
v_res_747_ = lp_physical__bridges_UPTController_instDecidableEqReply(v_x_745_, v_x_746_);
v_r_748_ = lean_box(v_res_747_);
return v_r_748_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprReply_repr(lean_object* v_x_773_, lean_object* v_prec_774_){
_start:
{
lean_object* v___y_776_; lean_object* v___y_783_; lean_object* v___y_790_; lean_object* v___y_797_; 
switch(lean_obj_tag(v_x_773_))
{
case 0:
{
lean_object* v___x_803_; uint8_t v___x_804_; 
v___x_803_ = lean_unsigned_to_nat(1024u);
v___x_804_ = lean_nat_dec_le(v___x_803_, v_prec_774_);
if (v___x_804_ == 0)
{
lean_object* v___x_805_; 
v___x_805_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__3, &lp_physical__bridges_UPTController_instReprOp_repr___closed__3_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__3);
v___y_776_ = v___x_805_;
goto v___jp_775_;
}
else
{
lean_object* v___x_806_; 
v___x_806_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__4, &lp_physical__bridges_UPTController_instReprOp_repr___closed__4_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__4);
v___y_776_ = v___x_806_;
goto v___jp_775_;
}
}
case 1:
{
lean_object* v_c_807_; lean_object* v___y_809_; lean_object* v___x_817_; uint8_t v___x_818_; 
v_c_807_ = lean_ctor_get(v_x_773_, 0);
lean_inc_ref(v_c_807_);
lean_dec_ref_known(v_x_773_, 1);
v___x_817_ = lean_unsigned_to_nat(1024u);
v___x_818_ = lean_nat_dec_le(v___x_817_, v_prec_774_);
if (v___x_818_ == 0)
{
lean_object* v___x_819_; 
v___x_819_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__3, &lp_physical__bridges_UPTController_instReprOp_repr___closed__3_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__3);
v___y_809_ = v___x_819_;
goto v___jp_808_;
}
else
{
lean_object* v___x_820_; 
v___x_820_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__4, &lp_physical__bridges_UPTController_instReprOp_repr___closed__4_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__4);
v___y_809_ = v___x_820_;
goto v___jp_808_;
}
v___jp_808_:
{
lean_object* v___x_810_; lean_object* v___x_811_; lean_object* v___x_812_; lean_object* v___x_813_; uint8_t v___x_814_; lean_object* v___x_815_; lean_object* v___x_816_; 
v___x_810_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprReply_repr___closed__10));
v___x_811_ = lp_physical__bridges_UPTController_instReprContext_repr___redArg(v_c_807_);
v___x_812_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_812_, 0, v___x_810_);
lean_ctor_set(v___x_812_, 1, v___x_811_);
lean_inc(v___y_809_);
v___x_813_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_813_, 0, v___y_809_);
lean_ctor_set(v___x_813_, 1, v___x_812_);
v___x_814_ = 0;
v___x_815_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_815_, 0, v___x_813_);
lean_ctor_set_uint8(v___x_815_, sizeof(void*)*1, v___x_814_);
v___x_816_ = l_Repr_addAppParen(v___x_815_, v_prec_774_);
return v___x_816_;
}
}
case 2:
{
lean_object* v_c_821_; lean_object* v_newFloor_822_; lean_object* v___x_824_; uint8_t v_isShared_825_; uint8_t v_isSharedCheck_846_; 
v_c_821_ = lean_ctor_get(v_x_773_, 0);
v_newFloor_822_ = lean_ctor_get(v_x_773_, 1);
v_isSharedCheck_846_ = !lean_is_exclusive(v_x_773_);
if (v_isSharedCheck_846_ == 0)
{
v___x_824_ = v_x_773_;
v_isShared_825_ = v_isSharedCheck_846_;
goto v_resetjp_823_;
}
else
{
lean_inc(v_newFloor_822_);
lean_inc(v_c_821_);
lean_dec(v_x_773_);
v___x_824_ = lean_box(0);
v_isShared_825_ = v_isSharedCheck_846_;
goto v_resetjp_823_;
}
v_resetjp_823_:
{
lean_object* v___y_827_; lean_object* v___x_842_; uint8_t v___x_843_; 
v___x_842_ = lean_unsigned_to_nat(1024u);
v___x_843_ = lean_nat_dec_le(v___x_842_, v_prec_774_);
if (v___x_843_ == 0)
{
lean_object* v___x_844_; 
v___x_844_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__3, &lp_physical__bridges_UPTController_instReprOp_repr___closed__3_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__3);
v___y_827_ = v___x_844_;
goto v___jp_826_;
}
else
{
lean_object* v___x_845_; 
v___x_845_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__4, &lp_physical__bridges_UPTController_instReprOp_repr___closed__4_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__4);
v___y_827_ = v___x_845_;
goto v___jp_826_;
}
v___jp_826_:
{
lean_object* v___x_828_; lean_object* v___x_829_; lean_object* v___x_830_; lean_object* v___x_832_; 
v___x_828_ = lean_box(1);
v___x_829_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprReply_repr___closed__13));
v___x_830_ = lp_physical__bridges_UPTController_instReprContext_repr___redArg(v_c_821_);
if (v_isShared_825_ == 0)
{
lean_ctor_set_tag(v___x_824_, 5);
lean_ctor_set(v___x_824_, 1, v___x_830_);
lean_ctor_set(v___x_824_, 0, v___x_829_);
v___x_832_ = v___x_824_;
goto v_reusejp_831_;
}
else
{
lean_object* v_reuseFailAlloc_841_; 
v_reuseFailAlloc_841_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v_reuseFailAlloc_841_, 0, v___x_829_);
lean_ctor_set(v_reuseFailAlloc_841_, 1, v___x_830_);
v___x_832_ = v_reuseFailAlloc_841_;
goto v_reusejp_831_;
}
v_reusejp_831_:
{
lean_object* v___x_833_; lean_object* v___x_834_; lean_object* v___x_835_; lean_object* v___x_836_; lean_object* v___x_837_; uint8_t v___x_838_; lean_object* v___x_839_; lean_object* v___x_840_; 
v___x_833_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_833_, 0, v___x_832_);
lean_ctor_set(v___x_833_, 1, v___x_828_);
v___x_834_ = l_Nat_reprFast(v_newFloor_822_);
v___x_835_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_835_, 0, v___x_834_);
v___x_836_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_836_, 0, v___x_833_);
lean_ctor_set(v___x_836_, 1, v___x_835_);
lean_inc(v___y_827_);
v___x_837_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_837_, 0, v___y_827_);
lean_ctor_set(v___x_837_, 1, v___x_836_);
v___x_838_ = 0;
v___x_839_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_839_, 0, v___x_837_);
lean_ctor_set_uint8(v___x_839_, sizeof(void*)*1, v___x_838_);
v___x_840_ = l_Repr_addAppParen(v___x_839_, v_prec_774_);
return v___x_840_;
}
}
}
}
case 3:
{
lean_object* v___x_847_; uint8_t v___x_848_; 
v___x_847_ = lean_unsigned_to_nat(1024u);
v___x_848_ = lean_nat_dec_le(v___x_847_, v_prec_774_);
if (v___x_848_ == 0)
{
lean_object* v___x_849_; 
v___x_849_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__3, &lp_physical__bridges_UPTController_instReprOp_repr___closed__3_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__3);
v___y_783_ = v___x_849_;
goto v___jp_782_;
}
else
{
lean_object* v___x_850_; 
v___x_850_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__4, &lp_physical__bridges_UPTController_instReprOp_repr___closed__4_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__4);
v___y_783_ = v___x_850_;
goto v___jp_782_;
}
}
case 4:
{
lean_object* v___x_851_; uint8_t v___x_852_; 
v___x_851_ = lean_unsigned_to_nat(1024u);
v___x_852_ = lean_nat_dec_le(v___x_851_, v_prec_774_);
if (v___x_852_ == 0)
{
lean_object* v___x_853_; 
v___x_853_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__3, &lp_physical__bridges_UPTController_instReprOp_repr___closed__3_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__3);
v___y_790_ = v___x_853_;
goto v___jp_789_;
}
else
{
lean_object* v___x_854_; 
v___x_854_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__4, &lp_physical__bridges_UPTController_instReprOp_repr___closed__4_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__4);
v___y_790_ = v___x_854_;
goto v___jp_789_;
}
}
default: 
{
lean_object* v___x_855_; uint8_t v___x_856_; 
v___x_855_ = lean_unsigned_to_nat(1024u);
v___x_856_ = lean_nat_dec_le(v___x_855_, v_prec_774_);
if (v___x_856_ == 0)
{
lean_object* v___x_857_; 
v___x_857_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__3, &lp_physical__bridges_UPTController_instReprOp_repr___closed__3_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__3);
v___y_797_ = v___x_857_;
goto v___jp_796_;
}
else
{
lean_object* v___x_858_; 
v___x_858_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprOp_repr___closed__4, &lp_physical__bridges_UPTController_instReprOp_repr___closed__4_once, _init_lp_physical__bridges_UPTController_instReprOp_repr___closed__4);
v___y_797_ = v___x_858_;
goto v___jp_796_;
}
}
}
v___jp_775_:
{
lean_object* v___x_777_; lean_object* v___x_778_; uint8_t v___x_779_; lean_object* v___x_780_; lean_object* v___x_781_; 
v___x_777_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprReply_repr___closed__1));
lean_inc(v___y_776_);
v___x_778_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_778_, 0, v___y_776_);
lean_ctor_set(v___x_778_, 1, v___x_777_);
v___x_779_ = 0;
v___x_780_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_780_, 0, v___x_778_);
lean_ctor_set_uint8(v___x_780_, sizeof(void*)*1, v___x_779_);
v___x_781_ = l_Repr_addAppParen(v___x_780_, v_prec_774_);
return v___x_781_;
}
v___jp_782_:
{
lean_object* v___x_784_; lean_object* v___x_785_; uint8_t v___x_786_; lean_object* v___x_787_; lean_object* v___x_788_; 
v___x_784_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprReply_repr___closed__3));
lean_inc(v___y_783_);
v___x_785_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_785_, 0, v___y_783_);
lean_ctor_set(v___x_785_, 1, v___x_784_);
v___x_786_ = 0;
v___x_787_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_787_, 0, v___x_785_);
lean_ctor_set_uint8(v___x_787_, sizeof(void*)*1, v___x_786_);
v___x_788_ = l_Repr_addAppParen(v___x_787_, v_prec_774_);
return v___x_788_;
}
v___jp_789_:
{
lean_object* v___x_791_; lean_object* v___x_792_; uint8_t v___x_793_; lean_object* v___x_794_; lean_object* v___x_795_; 
v___x_791_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprReply_repr___closed__5));
lean_inc(v___y_790_);
v___x_792_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_792_, 0, v___y_790_);
lean_ctor_set(v___x_792_, 1, v___x_791_);
v___x_793_ = 0;
v___x_794_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_794_, 0, v___x_792_);
lean_ctor_set_uint8(v___x_794_, sizeof(void*)*1, v___x_793_);
v___x_795_ = l_Repr_addAppParen(v___x_794_, v_prec_774_);
return v___x_795_;
}
v___jp_796_:
{
lean_object* v___x_798_; lean_object* v___x_799_; uint8_t v___x_800_; lean_object* v___x_801_; lean_object* v___x_802_; 
v___x_798_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprReply_repr___closed__7));
lean_inc(v___y_797_);
v___x_799_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_799_, 0, v___y_797_);
lean_ctor_set(v___x_799_, 1, v___x_798_);
v___x_800_ = 0;
v___x_801_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_801_, 0, v___x_799_);
lean_ctor_set_uint8(v___x_801_, sizeof(void*)*1, v___x_800_);
v___x_802_ = l_Repr_addAppParen(v___x_801_, v_prec_774_);
return v___x_802_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprReply_repr___boxed(lean_object* v_x_859_, lean_object* v_prec_860_){
_start:
{
lean_object* v_res_861_; 
v_res_861_ = lp_physical__bridges_UPTController_instReprReply_repr(v_x_859_, v_prec_860_);
lean_dec(v_prec_860_);
return v_res_861_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_step(lean_object* v_enrol_864_, lean_object* v_s_865_, lean_object* v_x_866_){
_start:
{
switch(lean_obj_tag(v_x_866_))
{
case 0:
{
lean_object* v_c_876_; lean_object* v___x_878_; uint8_t v_isShared_879_; uint8_t v_isSharedCheck_927_; 
v_c_876_ = lean_ctor_get(v_x_866_, 0);
v_isSharedCheck_927_ = !lean_is_exclusive(v_x_866_);
if (v_isSharedCheck_927_ == 0)
{
v___x_878_ = v_x_866_;
v_isShared_879_ = v_isSharedCheck_927_;
goto v_resetjp_877_;
}
else
{
lean_inc(v_c_876_);
lean_dec(v_x_866_);
v___x_878_ = lean_box(0);
v_isShared_879_ = v_isSharedCheck_927_;
goto v_resetjp_877_;
}
v_resetjp_877_:
{
lean_object* v_scope_880_; lean_object* v_generation_881_; lean_object* v_boot_882_; lean_object* v_sequence_883_; lean_object* v___x_884_; lean_object* v___x_885_; uint8_t v___x_886_; 
v_scope_880_ = lean_ctor_get(v_c_876_, 0);
v_generation_881_ = lean_ctor_get(v_c_876_, 1);
v_boot_882_ = lean_ctor_get(v_c_876_, 2);
v_sequence_883_ = lean_ctor_get(v_c_876_, 3);
v___x_884_ = lean_alloc_closure((void*)(l_instDecidableEqNat___boxed), 2, 0);
lean_inc(v_generation_881_);
v___x_885_ = lean_apply_1(v_enrol_864_, v_generation_881_);
lean_inc(v_scope_880_);
v___x_886_ = l_instDecidableEqList___redArg(v___x_884_, v_scope_880_, v___x_885_);
if (v___x_886_ == 0)
{
lean_del_object(v___x_878_);
lean_dec_ref(v_c_876_);
goto v___jp_873_;
}
else
{
lean_object* v_generation_887_; uint8_t v_held_888_; lean_object* v_boot_889_; lean_object* v_closed_890_; lean_object* v_pending_891_; uint8_t v___x_892_; 
v_generation_887_ = lean_ctor_get(v_s_865_, 0);
v_held_888_ = lean_ctor_get_uint8(v_s_865_, sizeof(void*)*4);
v_boot_889_ = lean_ctor_get(v_s_865_, 1);
v_closed_890_ = lean_ctor_get(v_s_865_, 2);
v_pending_891_ = lean_ctor_get(v_s_865_, 3);
lean_inc(v_pending_891_);
v___x_892_ = lean_nat_dec_eq(v_generation_881_, v_generation_887_);
if (v___x_892_ == 0)
{
lean_dec(v_pending_891_);
lean_del_object(v___x_878_);
lean_dec_ref(v_c_876_);
goto v___jp_873_;
}
else
{
if (v_held_888_ == 0)
{
if (v___x_892_ == 0)
{
lean_dec(v_pending_891_);
lean_del_object(v___x_878_);
lean_dec_ref(v_c_876_);
goto v___jp_873_;
}
else
{
uint8_t v___x_893_; 
v___x_893_ = lean_nat_dec_eq(v_boot_882_, v_boot_889_);
if (v___x_893_ == 0)
{
lean_dec(v_pending_891_);
lean_del_object(v___x_878_);
lean_dec_ref(v_c_876_);
goto v___jp_873_;
}
else
{
if (lean_obj_tag(v_pending_891_) == 0)
{
lean_object* v___x_894_; lean_object* v___x_895_; uint8_t v___x_896_; 
v___x_894_ = lean_unsigned_to_nat(1u);
v___x_895_ = lean_nat_add(v_closed_890_, v___x_894_);
v___x_896_ = lean_nat_dec_eq(v_sequence_883_, v___x_895_);
lean_dec(v___x_895_);
if (v___x_896_ == 0)
{
lean_object* v___x_897_; lean_object* v___x_898_; 
lean_del_object(v___x_878_);
lean_dec_ref(v_c_876_);
v___x_897_ = lean_box(0);
v___x_898_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_898_, 0, v_s_865_);
lean_ctor_set(v___x_898_, 1, v___x_897_);
return v___x_898_;
}
else
{
lean_object* v___x_900_; uint8_t v_isShared_901_; uint8_t v_isSharedCheck_910_; 
lean_inc(v_closed_890_);
lean_inc(v_boot_889_);
lean_inc(v_generation_887_);
v_isSharedCheck_910_ = !lean_is_exclusive(v_s_865_);
if (v_isSharedCheck_910_ == 0)
{
lean_object* v_unused_911_; lean_object* v_unused_912_; lean_object* v_unused_913_; lean_object* v_unused_914_; 
v_unused_911_ = lean_ctor_get(v_s_865_, 3);
lean_dec(v_unused_911_);
v_unused_912_ = lean_ctor_get(v_s_865_, 2);
lean_dec(v_unused_912_);
v_unused_913_ = lean_ctor_get(v_s_865_, 1);
lean_dec(v_unused_913_);
v_unused_914_ = lean_ctor_get(v_s_865_, 0);
lean_dec(v_unused_914_);
v___x_900_ = v_s_865_;
v_isShared_901_ = v_isSharedCheck_910_;
goto v_resetjp_899_;
}
else
{
lean_dec(v_s_865_);
v___x_900_ = lean_box(0);
v_isShared_901_ = v_isSharedCheck_910_;
goto v_resetjp_899_;
}
v_resetjp_899_:
{
lean_object* v___x_903_; 
lean_inc_ref(v_c_876_);
if (v_isShared_879_ == 0)
{
lean_ctor_set_tag(v___x_878_, 1);
v___x_903_ = v___x_878_;
goto v_reusejp_902_;
}
else
{
lean_object* v_reuseFailAlloc_909_; 
v_reuseFailAlloc_909_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_909_, 0, v_c_876_);
v___x_903_ = v_reuseFailAlloc_909_;
goto v_reusejp_902_;
}
v_reusejp_902_:
{
lean_object* v___x_905_; 
if (v_isShared_901_ == 0)
{
lean_ctor_set(v___x_900_, 3, v___x_903_);
v___x_905_ = v___x_900_;
goto v_reusejp_904_;
}
else
{
lean_object* v_reuseFailAlloc_908_; 
v_reuseFailAlloc_908_ = lean_alloc_ctor(0, 4, 1);
lean_ctor_set(v_reuseFailAlloc_908_, 0, v_generation_887_);
lean_ctor_set(v_reuseFailAlloc_908_, 1, v_boot_889_);
lean_ctor_set(v_reuseFailAlloc_908_, 2, v_closed_890_);
lean_ctor_set(v_reuseFailAlloc_908_, 3, v___x_903_);
lean_ctor_set_uint8(v_reuseFailAlloc_908_, sizeof(void*)*4, v_held_888_);
v___x_905_ = v_reuseFailAlloc_908_;
goto v_reusejp_904_;
}
v_reusejp_904_:
{
lean_object* v___x_906_; lean_object* v___x_907_; 
v___x_906_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v___x_906_, 0, v_c_876_);
v___x_907_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_907_, 0, v___x_905_);
lean_ctor_set(v___x_907_, 1, v___x_906_);
return v___x_907_;
}
}
}
}
}
else
{
lean_object* v_val_915_; lean_object* v___x_917_; uint8_t v_isShared_918_; uint8_t v_isSharedCheck_926_; 
lean_del_object(v___x_878_);
v_val_915_ = lean_ctor_get(v_pending_891_, 0);
v_isSharedCheck_926_ = !lean_is_exclusive(v_pending_891_);
if (v_isSharedCheck_926_ == 0)
{
v___x_917_ = v_pending_891_;
v_isShared_918_ = v_isSharedCheck_926_;
goto v_resetjp_916_;
}
else
{
lean_inc(v_val_915_);
lean_dec(v_pending_891_);
v___x_917_ = lean_box(0);
v_isShared_918_ = v_isSharedCheck_926_;
goto v_resetjp_916_;
}
v_resetjp_916_:
{
uint8_t v___x_919_; 
lean_inc(v_val_915_);
v___x_919_ = lp_physical__bridges_UPTController_instDecidableEqContext_decEq(v_val_915_, v_c_876_);
if (v___x_919_ == 0)
{
lean_object* v___x_920_; lean_object* v___x_921_; 
lean_del_object(v___x_917_);
lean_dec(v_val_915_);
v___x_920_ = lean_box(0);
v___x_921_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_921_, 0, v_s_865_);
lean_ctor_set(v___x_921_, 1, v___x_920_);
return v___x_921_;
}
else
{
lean_object* v___x_923_; 
if (v_isShared_918_ == 0)
{
v___x_923_ = v___x_917_;
goto v_reusejp_922_;
}
else
{
lean_object* v_reuseFailAlloc_925_; 
v_reuseFailAlloc_925_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_925_, 0, v_val_915_);
v___x_923_ = v_reuseFailAlloc_925_;
goto v_reusejp_922_;
}
v_reusejp_922_:
{
lean_object* v___x_924_; 
v___x_924_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_924_, 0, v_s_865_);
lean_ctor_set(v___x_924_, 1, v___x_923_);
return v___x_924_;
}
}
}
}
}
}
}
else
{
lean_dec(v_pending_891_);
lean_del_object(v___x_878_);
lean_dec_ref(v_c_876_);
goto v___jp_873_;
}
}
}
}
}
case 1:
{
lean_object* v_c_928_; lean_object* v_scope_929_; lean_object* v_generation_930_; lean_object* v___x_931_; lean_object* v___x_932_; uint8_t v___x_933_; 
v_c_928_ = lean_ctor_get(v_x_866_, 0);
lean_inc_ref(v_c_928_);
lean_dec_ref_known(v_x_866_, 1);
v_scope_929_ = lean_ctor_get(v_c_928_, 0);
v_generation_930_ = lean_ctor_get(v_c_928_, 1);
v___x_931_ = lean_alloc_closure((void*)(l_instDecidableEqNat___boxed), 2, 0);
lean_inc(v_generation_930_);
v___x_932_ = lean_apply_1(v_enrol_864_, v_generation_930_);
lean_inc(v_scope_929_);
v___x_933_ = l_instDecidableEqList___redArg(v___x_931_, v_scope_929_, v___x_932_);
if (v___x_933_ == 0)
{
lean_dec_ref(v_c_928_);
goto v___jp_870_;
}
else
{
lean_object* v_generation_934_; lean_object* v_boot_935_; lean_object* v_closed_936_; lean_object* v_pending_937_; uint8_t v___x_938_; 
v_generation_934_ = lean_ctor_get(v_s_865_, 0);
v_boot_935_ = lean_ctor_get(v_s_865_, 1);
v_closed_936_ = lean_ctor_get(v_s_865_, 2);
v_pending_937_ = lean_ctor_get(v_s_865_, 3);
v___x_938_ = lean_nat_dec_eq(v_generation_930_, v_generation_934_);
if (v___x_938_ == 0)
{
lean_dec_ref(v_c_928_);
goto v___jp_870_;
}
else
{
lean_object* v___x_940_; uint8_t v_isShared_941_; uint8_t v_isSharedCheck_949_; 
lean_inc(v_pending_937_);
lean_inc(v_closed_936_);
lean_inc(v_boot_935_);
lean_inc(v_generation_934_);
v_isSharedCheck_949_ = !lean_is_exclusive(v_s_865_);
if (v_isSharedCheck_949_ == 0)
{
lean_object* v_unused_950_; lean_object* v_unused_951_; lean_object* v_unused_952_; lean_object* v_unused_953_; 
v_unused_950_ = lean_ctor_get(v_s_865_, 3);
lean_dec(v_unused_950_);
v_unused_951_ = lean_ctor_get(v_s_865_, 2);
lean_dec(v_unused_951_);
v_unused_952_ = lean_ctor_get(v_s_865_, 1);
lean_dec(v_unused_952_);
v_unused_953_ = lean_ctor_get(v_s_865_, 0);
lean_dec(v_unused_953_);
v___x_940_ = v_s_865_;
v_isShared_941_ = v_isSharedCheck_949_;
goto v_resetjp_939_;
}
else
{
lean_dec(v_s_865_);
v___x_940_ = lean_box(0);
v_isShared_941_ = v_isSharedCheck_949_;
goto v_resetjp_939_;
}
v_resetjp_939_:
{
lean_object* v___x_942_; lean_object* v___x_943_; lean_object* v___x_945_; 
v___x_942_ = lean_unsigned_to_nat(1u);
v___x_943_ = lean_nat_add(v_generation_934_, v___x_942_);
lean_dec(v_generation_934_);
lean_inc(v___x_943_);
if (v_isShared_941_ == 0)
{
lean_ctor_set(v___x_940_, 0, v___x_943_);
v___x_945_ = v___x_940_;
goto v_reusejp_944_;
}
else
{
lean_object* v_reuseFailAlloc_948_; 
v_reuseFailAlloc_948_ = lean_alloc_ctor(0, 4, 1);
lean_ctor_set(v_reuseFailAlloc_948_, 0, v___x_943_);
lean_ctor_set(v_reuseFailAlloc_948_, 1, v_boot_935_);
lean_ctor_set(v_reuseFailAlloc_948_, 2, v_closed_936_);
lean_ctor_set(v_reuseFailAlloc_948_, 3, v_pending_937_);
v___x_945_ = v_reuseFailAlloc_948_;
goto v_reusejp_944_;
}
v_reusejp_944_:
{
lean_object* v___x_946_; lean_object* v___x_947_; 
lean_ctor_set_uint8(v___x_945_, sizeof(void*)*4, v___x_938_);
v___x_946_ = lean_alloc_ctor(2, 2, 0);
lean_ctor_set(v___x_946_, 0, v_c_928_);
lean_ctor_set(v___x_946_, 1, v___x_943_);
v___x_947_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_947_, 0, v___x_945_);
lean_ctor_set(v___x_947_, 1, v___x_946_);
return v___x_947_;
}
}
}
}
}
case 2:
{
lean_object* v_c_954_; lean_object* v_scope_955_; lean_object* v_generation_956_; lean_object* v_boot_957_; lean_object* v___x_958_; lean_object* v___x_959_; uint8_t v___x_960_; 
v_c_954_ = lean_ctor_get(v_x_866_, 0);
lean_inc_ref(v_c_954_);
lean_dec_ref_known(v_x_866_, 1);
v_scope_955_ = lean_ctor_get(v_c_954_, 0);
lean_inc(v_scope_955_);
v_generation_956_ = lean_ctor_get(v_c_954_, 1);
lean_inc_n(v_generation_956_, 2);
v_boot_957_ = lean_ctor_get(v_c_954_, 2);
lean_inc(v_boot_957_);
lean_dec_ref(v_c_954_);
v___x_958_ = lean_alloc_closure((void*)(l_instDecidableEqNat___boxed), 2, 0);
v___x_959_ = lean_apply_1(v_enrol_864_, v_generation_956_);
v___x_960_ = l_instDecidableEqList___redArg(v___x_958_, v_scope_955_, v___x_959_);
if (v___x_960_ == 0)
{
lean_dec(v_boot_957_);
lean_dec(v_generation_956_);
goto v___jp_867_;
}
else
{
lean_object* v_generation_961_; uint8_t v_held_962_; lean_object* v_boot_963_; uint8_t v___x_964_; 
v_generation_961_ = lean_ctor_get(v_s_865_, 0);
v_held_962_ = lean_ctor_get_uint8(v_s_865_, sizeof(void*)*4);
v_boot_963_ = lean_ctor_get(v_s_865_, 1);
v___x_964_ = lean_nat_dec_eq(v_generation_956_, v_generation_961_);
lean_dec(v_generation_956_);
if (v___x_964_ == 0)
{
lean_dec(v_boot_957_);
goto v___jp_867_;
}
else
{
if (v_held_962_ == 0)
{
lean_dec(v_boot_957_);
goto v___jp_867_;
}
else
{
uint8_t v___x_965_; 
v___x_965_ = lean_nat_dec_lt(v_boot_963_, v_boot_957_);
if (v___x_965_ == 0)
{
lean_dec(v_boot_957_);
goto v___jp_867_;
}
else
{
lean_object* v___x_967_; uint8_t v_isShared_968_; uint8_t v_isSharedCheck_977_; 
lean_inc(v_generation_961_);
v_isSharedCheck_977_ = !lean_is_exclusive(v_s_865_);
if (v_isSharedCheck_977_ == 0)
{
lean_object* v_unused_978_; lean_object* v_unused_979_; lean_object* v_unused_980_; lean_object* v_unused_981_; 
v_unused_978_ = lean_ctor_get(v_s_865_, 3);
lean_dec(v_unused_978_);
v_unused_979_ = lean_ctor_get(v_s_865_, 2);
lean_dec(v_unused_979_);
v_unused_980_ = lean_ctor_get(v_s_865_, 1);
lean_dec(v_unused_980_);
v_unused_981_ = lean_ctor_get(v_s_865_, 0);
lean_dec(v_unused_981_);
v___x_967_ = v_s_865_;
v_isShared_968_ = v_isSharedCheck_977_;
goto v_resetjp_966_;
}
else
{
lean_dec(v_s_865_);
v___x_967_ = lean_box(0);
v_isShared_968_ = v_isSharedCheck_977_;
goto v_resetjp_966_;
}
v_resetjp_966_:
{
uint8_t v___x_969_; lean_object* v___x_970_; lean_object* v___x_971_; lean_object* v___x_973_; 
v___x_969_ = 0;
v___x_970_ = lean_unsigned_to_nat(0u);
v___x_971_ = lean_box(0);
if (v_isShared_968_ == 0)
{
lean_ctor_set(v___x_967_, 3, v___x_971_);
lean_ctor_set(v___x_967_, 2, v___x_970_);
lean_ctor_set(v___x_967_, 1, v_boot_957_);
v___x_973_ = v___x_967_;
goto v_reusejp_972_;
}
else
{
lean_object* v_reuseFailAlloc_976_; 
v_reuseFailAlloc_976_ = lean_alloc_ctor(0, 4, 1);
lean_ctor_set(v_reuseFailAlloc_976_, 0, v_generation_961_);
lean_ctor_set(v_reuseFailAlloc_976_, 1, v_boot_957_);
lean_ctor_set(v_reuseFailAlloc_976_, 2, v___x_970_);
lean_ctor_set(v_reuseFailAlloc_976_, 3, v___x_971_);
v___x_973_ = v_reuseFailAlloc_976_;
goto v_reusejp_972_;
}
v_reusejp_972_:
{
lean_object* v___x_974_; lean_object* v___x_975_; 
lean_ctor_set_uint8(v___x_973_, sizeof(void*)*4, v___x_969_);
v___x_974_ = lean_box(3);
v___x_975_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_975_, 0, v___x_973_);
lean_ctor_set(v___x_975_, 1, v___x_974_);
return v___x_975_;
}
}
}
}
}
}
}
case 3:
{
lean_object* v_b_982_; lean_object* v_generation_983_; uint8_t v_held_984_; lean_object* v_boot_985_; uint8_t v___x_986_; 
lean_dec_ref(v_enrol_864_);
v_b_982_ = lean_ctor_get(v_x_866_, 0);
lean_inc(v_b_982_);
lean_dec_ref_known(v_x_866_, 1);
v_generation_983_ = lean_ctor_get(v_s_865_, 0);
v_held_984_ = lean_ctor_get_uint8(v_s_865_, sizeof(void*)*4);
v_boot_985_ = lean_ctor_get(v_s_865_, 1);
v___x_986_ = lean_nat_dec_lt(v_boot_985_, v_b_982_);
if (v___x_986_ == 0)
{
lean_object* v___x_987_; lean_object* v___x_988_; 
lean_dec(v_b_982_);
v___x_987_ = lean_box(0);
v___x_988_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_988_, 0, v_s_865_);
lean_ctor_set(v___x_988_, 1, v___x_987_);
return v___x_988_;
}
else
{
lean_object* v___x_990_; uint8_t v_isShared_991_; uint8_t v_isSharedCheck_999_; 
lean_inc(v_generation_983_);
v_isSharedCheck_999_ = !lean_is_exclusive(v_s_865_);
if (v_isSharedCheck_999_ == 0)
{
lean_object* v_unused_1000_; lean_object* v_unused_1001_; lean_object* v_unused_1002_; lean_object* v_unused_1003_; 
v_unused_1000_ = lean_ctor_get(v_s_865_, 3);
lean_dec(v_unused_1000_);
v_unused_1001_ = lean_ctor_get(v_s_865_, 2);
lean_dec(v_unused_1001_);
v_unused_1002_ = lean_ctor_get(v_s_865_, 1);
lean_dec(v_unused_1002_);
v_unused_1003_ = lean_ctor_get(v_s_865_, 0);
lean_dec(v_unused_1003_);
v___x_990_ = v_s_865_;
v_isShared_991_ = v_isSharedCheck_999_;
goto v_resetjp_989_;
}
else
{
lean_dec(v_s_865_);
v___x_990_ = lean_box(0);
v_isShared_991_ = v_isSharedCheck_999_;
goto v_resetjp_989_;
}
v_resetjp_989_:
{
lean_object* v___x_992_; lean_object* v___x_993_; lean_object* v___x_995_; 
v___x_992_ = lean_unsigned_to_nat(0u);
v___x_993_ = lean_box(0);
if (v_isShared_991_ == 0)
{
lean_ctor_set(v___x_990_, 3, v___x_993_);
lean_ctor_set(v___x_990_, 2, v___x_992_);
lean_ctor_set(v___x_990_, 1, v_b_982_);
v___x_995_ = v___x_990_;
goto v_reusejp_994_;
}
else
{
lean_object* v_reuseFailAlloc_998_; 
v_reuseFailAlloc_998_ = lean_alloc_ctor(0, 4, 1);
lean_ctor_set(v_reuseFailAlloc_998_, 0, v_generation_983_);
lean_ctor_set(v_reuseFailAlloc_998_, 1, v_b_982_);
lean_ctor_set(v_reuseFailAlloc_998_, 2, v___x_992_);
lean_ctor_set(v_reuseFailAlloc_998_, 3, v___x_993_);
lean_ctor_set_uint8(v_reuseFailAlloc_998_, sizeof(void*)*4, v_held_984_);
v___x_995_ = v_reuseFailAlloc_998_;
goto v_reusejp_994_;
}
v_reusejp_994_:
{
lean_object* v___x_996_; lean_object* v___x_997_; 
v___x_996_ = lean_box(4);
v___x_997_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_997_, 0, v___x_995_);
lean_ctor_set(v___x_997_, 1, v___x_996_);
return v___x_997_;
}
}
}
}
default: 
{
lean_object* v_q_1004_; lean_object* v_generation_1005_; uint8_t v_held_1006_; lean_object* v_boot_1007_; lean_object* v_closed_1008_; lean_object* v_pending_1009_; lean_object* v___y_1011_; 
lean_dec_ref(v_enrol_864_);
v_q_1004_ = lean_ctor_get(v_x_866_, 0);
lean_inc(v_q_1004_);
lean_dec_ref_known(v_x_866_, 1);
v_generation_1005_ = lean_ctor_get(v_s_865_, 0);
v_held_1006_ = lean_ctor_get_uint8(v_s_865_, sizeof(void*)*4);
v_boot_1007_ = lean_ctor_get(v_s_865_, 1);
v_closed_1008_ = lean_ctor_get(v_s_865_, 2);
v_pending_1009_ = lean_ctor_get(v_s_865_, 3);
if (lean_obj_tag(v_pending_1009_) == 0)
{
uint8_t v___x_1016_; 
v___x_1016_ = lean_nat_dec_le(v_q_1004_, v_closed_1008_);
lean_dec(v_q_1004_);
if (v___x_1016_ == 0)
{
lean_object* v___x_1017_; lean_object* v___x_1018_; 
v___x_1017_ = lean_box(0);
v___x_1018_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_1018_, 0, v_s_865_);
lean_ctor_set(v___x_1018_, 1, v___x_1017_);
return v___x_1018_;
}
else
{
lean_object* v___x_1019_; lean_object* v___x_1020_; 
v___x_1019_ = lean_box(5);
v___x_1020_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_1020_, 0, v_s_865_);
lean_ctor_set(v___x_1020_, 1, v___x_1019_);
return v___x_1020_;
}
}
else
{
lean_object* v_val_1021_; lean_object* v_sequence_1022_; uint8_t v___x_1023_; 
v_val_1021_ = lean_ctor_get(v_pending_1009_, 0);
v_sequence_1022_ = lean_ctor_get(v_val_1021_, 3);
v___x_1023_ = lean_nat_dec_eq(v_q_1004_, v_sequence_1022_);
if (v___x_1023_ == 0)
{
lean_object* v___x_1024_; lean_object* v___x_1025_; 
lean_dec(v_q_1004_);
v___x_1024_ = lean_box(0);
v___x_1025_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_1025_, 0, v_s_865_);
lean_ctor_set(v___x_1025_, 1, v___x_1024_);
return v___x_1025_;
}
else
{
uint8_t v___x_1026_; 
lean_inc(v_closed_1008_);
lean_inc(v_boot_1007_);
lean_inc(v_generation_1005_);
lean_dec_ref(v_s_865_);
v___x_1026_ = lean_nat_dec_le(v_closed_1008_, v_q_1004_);
if (v___x_1026_ == 0)
{
lean_dec(v_q_1004_);
v___y_1011_ = v_closed_1008_;
goto v___jp_1010_;
}
else
{
lean_dec(v_closed_1008_);
v___y_1011_ = v_q_1004_;
goto v___jp_1010_;
}
}
}
v___jp_1010_:
{
lean_object* v___x_1012_; lean_object* v___x_1013_; lean_object* v___x_1014_; lean_object* v___x_1015_; 
v___x_1012_ = lean_box(0);
v___x_1013_ = lean_alloc_ctor(0, 4, 1);
lean_ctor_set(v___x_1013_, 0, v_generation_1005_);
lean_ctor_set(v___x_1013_, 1, v_boot_1007_);
lean_ctor_set(v___x_1013_, 2, v___y_1011_);
lean_ctor_set(v___x_1013_, 3, v___x_1012_);
lean_ctor_set_uint8(v___x_1013_, sizeof(void*)*4, v_held_1006_);
v___x_1014_ = lean_box(5);
v___x_1015_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_1015_, 0, v___x_1013_);
lean_ctor_set(v___x_1015_, 1, v___x_1014_);
return v___x_1015_;
}
}
}
v___jp_867_:
{
lean_object* v___x_868_; lean_object* v___x_869_; 
v___x_868_ = lean_box(0);
v___x_869_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_869_, 0, v_s_865_);
lean_ctor_set(v___x_869_, 1, v___x_868_);
return v___x_869_;
}
v___jp_870_:
{
lean_object* v___x_871_; lean_object* v___x_872_; 
v___x_871_ = lean_box(0);
v___x_872_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_872_, 0, v_s_865_);
lean_ctor_set(v___x_872_, 1, v___x_871_);
return v___x_872_;
}
v___jp_873_:
{
lean_object* v___x_874_; lean_object* v___x_875_; 
v___x_874_ = lean_box(0);
v___x_875_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_875_, 0, v_s_865_);
lean_ctor_set(v___x_875_, 1, v___x_874_);
return v___x_875_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_run(lean_object* v_enrol_1027_, lean_object* v_s_1028_, lean_object* v_x_1029_){
_start:
{
if (lean_obj_tag(v_x_1029_) == 0)
{
lean_dec_ref(v_enrol_1027_);
return v_s_1028_;
}
else
{
lean_object* v_head_1030_; lean_object* v_tail_1031_; lean_object* v___x_1032_; lean_object* v_fst_1033_; 
v_head_1030_ = lean_ctor_get(v_x_1029_, 0);
lean_inc(v_head_1030_);
v_tail_1031_ = lean_ctor_get(v_x_1029_, 1);
lean_inc(v_tail_1031_);
lean_dec_ref_known(v_x_1029_, 2);
lean_inc_ref(v_enrol_1027_);
v___x_1032_ = lp_physical__bridges_UPTController_step(v_enrol_1027_, v_s_1028_, v_head_1030_);
v_fst_1033_ = lean_ctor_get(v___x_1032_, 0);
lean_inc(v_fst_1033_);
lean_dec_ref(v___x_1032_);
v_s_1028_ = v_fst_1033_;
v_x_1029_ = v_tail_1031_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_run_match__1_splitter___redArg(lean_object* v_x_1035_, lean_object* v_h__1_1036_, lean_object* v_h__2_1037_){
_start:
{
if (lean_obj_tag(v_x_1035_) == 0)
{
lean_object* v___x_1038_; lean_object* v___x_1039_; 
lean_dec(v_h__2_1037_);
v___x_1038_ = lean_box(0);
v___x_1039_ = lean_apply_1(v_h__1_1036_, v___x_1038_);
return v___x_1039_;
}
else
{
lean_object* v_head_1040_; lean_object* v_tail_1041_; lean_object* v___x_1042_; 
lean_dec(v_h__1_1036_);
v_head_1040_ = lean_ctor_get(v_x_1035_, 0);
lean_inc(v_head_1040_);
v_tail_1041_ = lean_ctor_get(v_x_1035_, 1);
lean_inc(v_tail_1041_);
lean_dec_ref_known(v_x_1035_, 2);
v___x_1042_ = lean_apply_2(v_h__2_1037_, v_head_1040_, v_tail_1041_);
return v___x_1042_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_run_match__1_splitter(lean_object* v_motive_1043_, lean_object* v_x_1044_, lean_object* v_h__1_1045_, lean_object* v_h__2_1046_){
_start:
{
if (lean_obj_tag(v_x_1044_) == 0)
{
lean_object* v___x_1047_; lean_object* v___x_1048_; 
lean_dec(v_h__2_1046_);
v___x_1047_ = lean_box(0);
v___x_1048_ = lean_apply_1(v_h__1_1045_, v___x_1047_);
return v___x_1048_;
}
else
{
lean_object* v_head_1049_; lean_object* v_tail_1050_; lean_object* v___x_1051_; 
lean_dec(v_h__1_1045_);
v_head_1049_ = lean_ctor_get(v_x_1044_, 0);
lean_inc(v_head_1049_);
v_tail_1050_ = lean_ctor_get(v_x_1044_, 1);
lean_inc(v_tail_1050_);
lean_dec_ref_known(v_x_1044_, 2);
v___x_1051_ = lean_apply_2(v_h__2_1046_, v_head_1049_, v_tail_1050_);
return v___x_1051_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_instReprOp_repr_match__1_splitter___redArg(lean_object* v_x_1052_, lean_object* v_h__1_1053_, lean_object* v_h__2_1054_, lean_object* v_h__3_1055_, lean_object* v_h__4_1056_, lean_object* v_h__5_1057_){
_start:
{
switch(lean_obj_tag(v_x_1052_))
{
case 0:
{
lean_object* v_c_1058_; lean_object* v___x_1059_; 
lean_dec(v_h__5_1057_);
lean_dec(v_h__4_1056_);
lean_dec(v_h__3_1055_);
lean_dec(v_h__2_1054_);
v_c_1058_ = lean_ctor_get(v_x_1052_, 0);
lean_inc_ref(v_c_1058_);
lean_dec_ref_known(v_x_1052_, 1);
v___x_1059_ = lean_apply_1(v_h__1_1053_, v_c_1058_);
return v___x_1059_;
}
case 1:
{
lean_object* v_c_1060_; lean_object* v___x_1061_; 
lean_dec(v_h__5_1057_);
lean_dec(v_h__4_1056_);
lean_dec(v_h__3_1055_);
lean_dec(v_h__1_1053_);
v_c_1060_ = lean_ctor_get(v_x_1052_, 0);
lean_inc_ref(v_c_1060_);
lean_dec_ref_known(v_x_1052_, 1);
v___x_1061_ = lean_apply_1(v_h__2_1054_, v_c_1060_);
return v___x_1061_;
}
case 2:
{
lean_object* v_c_1062_; lean_object* v___x_1063_; 
lean_dec(v_h__5_1057_);
lean_dec(v_h__4_1056_);
lean_dec(v_h__2_1054_);
lean_dec(v_h__1_1053_);
v_c_1062_ = lean_ctor_get(v_x_1052_, 0);
lean_inc_ref(v_c_1062_);
lean_dec_ref_known(v_x_1052_, 1);
v___x_1063_ = lean_apply_1(v_h__3_1055_, v_c_1062_);
return v___x_1063_;
}
case 3:
{
lean_object* v_b_1064_; lean_object* v___x_1065_; 
lean_dec(v_h__5_1057_);
lean_dec(v_h__3_1055_);
lean_dec(v_h__2_1054_);
lean_dec(v_h__1_1053_);
v_b_1064_ = lean_ctor_get(v_x_1052_, 0);
lean_inc(v_b_1064_);
lean_dec_ref_known(v_x_1052_, 1);
v___x_1065_ = lean_apply_1(v_h__4_1056_, v_b_1064_);
return v___x_1065_;
}
default: 
{
lean_object* v_q_1066_; lean_object* v___x_1067_; 
lean_dec(v_h__4_1056_);
lean_dec(v_h__3_1055_);
lean_dec(v_h__2_1054_);
lean_dec(v_h__1_1053_);
v_q_1066_ = lean_ctor_get(v_x_1052_, 0);
lean_inc(v_q_1066_);
lean_dec_ref_known(v_x_1052_, 1);
v___x_1067_ = lean_apply_1(v_h__5_1057_, v_q_1066_);
return v___x_1067_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_instReprOp_repr_match__1_splitter(lean_object* v_motive_1068_, lean_object* v_x_1069_, lean_object* v_h__1_1070_, lean_object* v_h__2_1071_, lean_object* v_h__3_1072_, lean_object* v_h__4_1073_, lean_object* v_h__5_1074_){
_start:
{
switch(lean_obj_tag(v_x_1069_))
{
case 0:
{
lean_object* v_c_1075_; lean_object* v___x_1076_; 
lean_dec(v_h__5_1074_);
lean_dec(v_h__4_1073_);
lean_dec(v_h__3_1072_);
lean_dec(v_h__2_1071_);
v_c_1075_ = lean_ctor_get(v_x_1069_, 0);
lean_inc_ref(v_c_1075_);
lean_dec_ref_known(v_x_1069_, 1);
v___x_1076_ = lean_apply_1(v_h__1_1070_, v_c_1075_);
return v___x_1076_;
}
case 1:
{
lean_object* v_c_1077_; lean_object* v___x_1078_; 
lean_dec(v_h__5_1074_);
lean_dec(v_h__4_1073_);
lean_dec(v_h__3_1072_);
lean_dec(v_h__1_1070_);
v_c_1077_ = lean_ctor_get(v_x_1069_, 0);
lean_inc_ref(v_c_1077_);
lean_dec_ref_known(v_x_1069_, 1);
v___x_1078_ = lean_apply_1(v_h__2_1071_, v_c_1077_);
return v___x_1078_;
}
case 2:
{
lean_object* v_c_1079_; lean_object* v___x_1080_; 
lean_dec(v_h__5_1074_);
lean_dec(v_h__4_1073_);
lean_dec(v_h__2_1071_);
lean_dec(v_h__1_1070_);
v_c_1079_ = lean_ctor_get(v_x_1069_, 0);
lean_inc_ref(v_c_1079_);
lean_dec_ref_known(v_x_1069_, 1);
v___x_1080_ = lean_apply_1(v_h__3_1072_, v_c_1079_);
return v___x_1080_;
}
case 3:
{
lean_object* v_b_1081_; lean_object* v___x_1082_; 
lean_dec(v_h__5_1074_);
lean_dec(v_h__3_1072_);
lean_dec(v_h__2_1071_);
lean_dec(v_h__1_1070_);
v_b_1081_ = lean_ctor_get(v_x_1069_, 0);
lean_inc(v_b_1081_);
lean_dec_ref_known(v_x_1069_, 1);
v___x_1082_ = lean_apply_1(v_h__4_1073_, v_b_1081_);
return v___x_1082_;
}
default: 
{
lean_object* v_q_1083_; lean_object* v___x_1084_; 
lean_dec(v_h__4_1073_);
lean_dec(v_h__3_1072_);
lean_dec(v_h__2_1071_);
lean_dec(v_h__1_1070_);
v_q_1083_ = lean_ctor_get(v_x_1069_, 0);
lean_inc(v_q_1083_);
lean_dec_ref_known(v_x_1069_, 1);
v___x_1084_ = lean_apply_1(v_h__5_1074_, v_q_1083_);
return v___x_1084_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_step_match__1_splitter___redArg(lean_object* v_x_1085_, lean_object* v_h__1_1086_, lean_object* v_h__2_1087_){
_start:
{
if (lean_obj_tag(v_x_1085_) == 0)
{
lean_object* v___x_1088_; lean_object* v___x_1089_; 
lean_dec(v_h__1_1086_);
v___x_1088_ = lean_box(0);
v___x_1089_ = lean_apply_1(v_h__2_1087_, v___x_1088_);
return v___x_1089_;
}
else
{
lean_object* v_val_1090_; lean_object* v___x_1091_; 
lean_dec(v_h__2_1087_);
v_val_1090_ = lean_ctor_get(v_x_1085_, 0);
lean_inc(v_val_1090_);
lean_dec_ref_known(v_x_1085_, 1);
v___x_1091_ = lean_apply_1(v_h__1_1086_, v_val_1090_);
return v___x_1091_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_step_match__1_splitter(lean_object* v_motive_1092_, lean_object* v_x_1093_, lean_object* v_h__1_1094_, lean_object* v_h__2_1095_){
_start:
{
if (lean_obj_tag(v_x_1093_) == 0)
{
lean_object* v___x_1096_; lean_object* v___x_1097_; 
lean_dec(v_h__1_1094_);
v___x_1096_ = lean_box(0);
v___x_1097_ = lean_apply_1(v_h__2_1095_, v___x_1096_);
return v___x_1097_;
}
else
{
lean_object* v_val_1098_; lean_object* v___x_1099_; 
lean_dec(v_h__2_1095_);
v_val_1098_ = lean_ctor_get(v_x_1093_, 0);
lean_inc(v_val_1098_);
lean_dec_ref_known(v_x_1093_, 1);
v___x_1099_ = lean_apply_1(v_h__1_1094_, v_val_1098_);
return v___x_1099_;
}
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqReceipt_decEq(lean_object* v_x_1100_, lean_object* v_x_1101_){
_start:
{
lean_object* v_past_1102_; lean_object* v_context_1103_; uint8_t v_isFloor_1104_; lean_object* v_past_1105_; lean_object* v_context_1106_; uint8_t v_isFloor_1107_; lean_object* v___x_1108_; uint8_t v___x_1109_; 
v_past_1102_ = lean_ctor_get(v_x_1100_, 0);
lean_inc(v_past_1102_);
v_context_1103_ = lean_ctor_get(v_x_1100_, 1);
lean_inc_ref(v_context_1103_);
v_isFloor_1104_ = lean_ctor_get_uint8(v_x_1100_, sizeof(void*)*2);
lean_dec_ref(v_x_1100_);
v_past_1105_ = lean_ctor_get(v_x_1101_, 0);
lean_inc(v_past_1105_);
v_context_1106_ = lean_ctor_get(v_x_1101_, 1);
lean_inc_ref(v_context_1106_);
v_isFloor_1107_ = lean_ctor_get_uint8(v_x_1101_, sizeof(void*)*2);
lean_dec_ref(v_x_1101_);
v___x_1108_ = lean_alloc_closure((void*)(lp_physical__bridges_UPTController_instDecidableEqOp___boxed), 2, 0);
v___x_1109_ = l_instDecidableEqList___redArg(v___x_1108_, v_past_1102_, v_past_1105_);
if (v___x_1109_ == 0)
{
lean_dec_ref(v_context_1106_);
lean_dec_ref(v_context_1103_);
return v___x_1109_;
}
else
{
uint8_t v___x_1110_; 
v___x_1110_ = lp_physical__bridges_UPTController_instDecidableEqContext_decEq(v_context_1103_, v_context_1106_);
if (v___x_1110_ == 0)
{
return v___x_1110_;
}
else
{
if (v_isFloor_1107_ == 0)
{
if (v_isFloor_1104_ == 0)
{
return v___x_1110_;
}
else
{
return v_isFloor_1107_;
}
}
else
{
return v_isFloor_1104_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqReceipt_decEq___boxed(lean_object* v_x_1111_, lean_object* v_x_1112_){
_start:
{
uint8_t v_res_1113_; lean_object* v_r_1114_; 
v_res_1113_ = lp_physical__bridges_UPTController_instDecidableEqReceipt_decEq(v_x_1111_, v_x_1112_);
v_r_1114_ = lean_box(v_res_1113_);
return v_r_1114_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqReceipt(lean_object* v_x_1115_, lean_object* v_x_1116_){
_start:
{
uint8_t v___x_1117_; 
v___x_1117_ = lp_physical__bridges_UPTController_instDecidableEqReceipt_decEq(v_x_1115_, v_x_1116_);
return v___x_1117_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqReceipt___boxed(lean_object* v_x_1118_, lean_object* v_x_1119_){
_start:
{
uint8_t v_res_1120_; lean_object* v_r_1121_; 
v_res_1120_ = lp_physical__bridges_UPTController_instDecidableEqReceipt(v_x_1118_, v_x_1119_);
v_r_1121_ = lean_box(v_res_1120_);
return v_r_1121_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00UPTController_instReprReceipt_repr_spec__0_spec__0_spec__1_spec__2(lean_object* v_x_1122_, lean_object* v_x_1123_, lean_object* v_x_1124_){
_start:
{
if (lean_obj_tag(v_x_1124_) == 0)
{
lean_dec(v_x_1122_);
return v_x_1123_;
}
else
{
lean_object* v_head_1125_; lean_object* v_tail_1126_; lean_object* v___x_1128_; uint8_t v_isShared_1129_; uint8_t v_isSharedCheck_1137_; 
v_head_1125_ = lean_ctor_get(v_x_1124_, 0);
v_tail_1126_ = lean_ctor_get(v_x_1124_, 1);
v_isSharedCheck_1137_ = !lean_is_exclusive(v_x_1124_);
if (v_isSharedCheck_1137_ == 0)
{
v___x_1128_ = v_x_1124_;
v_isShared_1129_ = v_isSharedCheck_1137_;
goto v_resetjp_1127_;
}
else
{
lean_inc(v_tail_1126_);
lean_inc(v_head_1125_);
lean_dec(v_x_1124_);
v___x_1128_ = lean_box(0);
v_isShared_1129_ = v_isSharedCheck_1137_;
goto v_resetjp_1127_;
}
v_resetjp_1127_:
{
lean_object* v___x_1131_; 
lean_inc(v_x_1122_);
if (v_isShared_1129_ == 0)
{
lean_ctor_set_tag(v___x_1128_, 5);
lean_ctor_set(v___x_1128_, 1, v_x_1122_);
lean_ctor_set(v___x_1128_, 0, v_x_1123_);
v___x_1131_ = v___x_1128_;
goto v_reusejp_1130_;
}
else
{
lean_object* v_reuseFailAlloc_1136_; 
v_reuseFailAlloc_1136_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v_reuseFailAlloc_1136_, 0, v_x_1123_);
lean_ctor_set(v_reuseFailAlloc_1136_, 1, v_x_1122_);
v___x_1131_ = v_reuseFailAlloc_1136_;
goto v_reusejp_1130_;
}
v_reusejp_1130_:
{
lean_object* v___x_1132_; lean_object* v___x_1133_; lean_object* v___x_1134_; 
v___x_1132_ = lean_unsigned_to_nat(0u);
v___x_1133_ = lp_physical__bridges_UPTController_instReprOp_repr(v_head_1125_, v___x_1132_);
v___x_1134_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1134_, 0, v___x_1131_);
lean_ctor_set(v___x_1134_, 1, v___x_1133_);
v_x_1123_ = v___x_1134_;
v_x_1124_ = v_tail_1126_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00UPTController_instReprReceipt_repr_spec__0_spec__0_spec__1(lean_object* v_x_1138_, lean_object* v_x_1139_, lean_object* v_x_1140_){
_start:
{
if (lean_obj_tag(v_x_1140_) == 0)
{
lean_dec(v_x_1138_);
return v_x_1139_;
}
else
{
lean_object* v_head_1141_; lean_object* v_tail_1142_; lean_object* v___x_1144_; uint8_t v_isShared_1145_; uint8_t v_isSharedCheck_1153_; 
v_head_1141_ = lean_ctor_get(v_x_1140_, 0);
v_tail_1142_ = lean_ctor_get(v_x_1140_, 1);
v_isSharedCheck_1153_ = !lean_is_exclusive(v_x_1140_);
if (v_isSharedCheck_1153_ == 0)
{
v___x_1144_ = v_x_1140_;
v_isShared_1145_ = v_isSharedCheck_1153_;
goto v_resetjp_1143_;
}
else
{
lean_inc(v_tail_1142_);
lean_inc(v_head_1141_);
lean_dec(v_x_1140_);
v___x_1144_ = lean_box(0);
v_isShared_1145_ = v_isSharedCheck_1153_;
goto v_resetjp_1143_;
}
v_resetjp_1143_:
{
lean_object* v___x_1147_; 
lean_inc(v_x_1138_);
if (v_isShared_1145_ == 0)
{
lean_ctor_set_tag(v___x_1144_, 5);
lean_ctor_set(v___x_1144_, 1, v_x_1138_);
lean_ctor_set(v___x_1144_, 0, v_x_1139_);
v___x_1147_ = v___x_1144_;
goto v_reusejp_1146_;
}
else
{
lean_object* v_reuseFailAlloc_1152_; 
v_reuseFailAlloc_1152_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v_reuseFailAlloc_1152_, 0, v_x_1139_);
lean_ctor_set(v_reuseFailAlloc_1152_, 1, v_x_1138_);
v___x_1147_ = v_reuseFailAlloc_1152_;
goto v_reusejp_1146_;
}
v_reusejp_1146_:
{
lean_object* v___x_1148_; lean_object* v___x_1149_; lean_object* v___x_1150_; lean_object* v___x_1151_; 
v___x_1148_ = lean_unsigned_to_nat(0u);
v___x_1149_ = lp_physical__bridges_UPTController_instReprOp_repr(v_head_1141_, v___x_1148_);
v___x_1150_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1150_, 0, v___x_1147_);
lean_ctor_set(v___x_1150_, 1, v___x_1149_);
v___x_1151_ = lp_physical__bridges_List_foldl___at___00List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00UPTController_instReprReceipt_repr_spec__0_spec__0_spec__1_spec__2(v_x_1138_, v___x_1150_, v_tail_1142_);
return v___x_1151_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_Std_Format_joinSep___at___00List_repr___at___00UPTController_instReprReceipt_repr_spec__0_spec__0___lam__0(lean_object* v___y_1154_){
_start:
{
lean_object* v___x_1155_; lean_object* v___x_1156_; 
v___x_1155_ = lean_unsigned_to_nat(0u);
v___x_1156_ = lp_physical__bridges_UPTController_instReprOp_repr(v___y_1154_, v___x_1155_);
return v___x_1156_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_Std_Format_joinSep___at___00List_repr___at___00UPTController_instReprReceipt_repr_spec__0_spec__0(lean_object* v_x_1157_, lean_object* v_x_1158_){
_start:
{
if (lean_obj_tag(v_x_1157_) == 0)
{
lean_object* v___x_1159_; 
lean_dec(v_x_1158_);
v___x_1159_ = lean_box(0);
return v___x_1159_;
}
else
{
lean_object* v_tail_1160_; 
v_tail_1160_ = lean_ctor_get(v_x_1157_, 1);
if (lean_obj_tag(v_tail_1160_) == 0)
{
lean_object* v_head_1161_; lean_object* v___x_1162_; 
lean_dec(v_x_1158_);
v_head_1161_ = lean_ctor_get(v_x_1157_, 0);
lean_inc(v_head_1161_);
lean_dec_ref_known(v_x_1157_, 2);
v___x_1162_ = lp_physical__bridges_Std_Format_joinSep___at___00List_repr___at___00UPTController_instReprReceipt_repr_spec__0_spec__0___lam__0(v_head_1161_);
return v___x_1162_;
}
else
{
lean_object* v_head_1163_; lean_object* v___x_1164_; lean_object* v___x_1165_; 
lean_inc(v_tail_1160_);
v_head_1163_ = lean_ctor_get(v_x_1157_, 0);
lean_inc(v_head_1163_);
lean_dec_ref_known(v_x_1157_, 2);
v___x_1164_ = lp_physical__bridges_Std_Format_joinSep___at___00List_repr___at___00UPTController_instReprReceipt_repr_spec__0_spec__0___lam__0(v_head_1163_);
v___x_1165_ = lp_physical__bridges_List_foldl___at___00Std_Format_joinSep___at___00List_repr___at___00UPTController_instReprReceipt_repr_spec__0_spec__0_spec__1(v_x_1158_, v___x_1164_, v_tail_1160_);
return v___x_1165_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr___at___00UPTController_instReprReceipt_repr_spec__0___redArg(lean_object* v_a_1166_){
_start:
{
if (lean_obj_tag(v_a_1166_) == 0)
{
lean_object* v___x_1167_; 
v___x_1167_ = ((lean_object*)(lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__1));
return v___x_1167_;
}
else
{
lean_object* v___x_1168_; lean_object* v___x_1169_; lean_object* v___x_1170_; lean_object* v___x_1171_; lean_object* v___x_1172_; lean_object* v___x_1173_; lean_object* v___x_1174_; lean_object* v___x_1175_; uint8_t v___x_1176_; lean_object* v___x_1177_; 
v___x_1168_ = ((lean_object*)(lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__5));
v___x_1169_ = lp_physical__bridges_Std_Format_joinSep___at___00List_repr___at___00UPTController_instReprReceipt_repr_spec__0_spec__0(v_a_1166_, v___x_1168_);
v___x_1170_ = lean_obj_once(&lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__8, &lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__8_once, _init_lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__8);
v___x_1171_ = ((lean_object*)(lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__9));
v___x_1172_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1172_, 0, v___x_1171_);
lean_ctor_set(v___x_1172_, 1, v___x_1169_);
v___x_1173_ = ((lean_object*)(lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__10));
v___x_1174_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1174_, 0, v___x_1172_);
lean_ctor_set(v___x_1174_, 1, v___x_1173_);
v___x_1175_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_1175_, 0, v___x_1170_);
lean_ctor_set(v___x_1175_, 1, v___x_1174_);
v___x_1176_ = 0;
v___x_1177_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_1177_, 0, v___x_1175_);
lean_ctor_set_uint8(v___x_1177_, sizeof(void*)*1, v___x_1176_);
return v___x_1177_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr___redArg(lean_object* v_x_1193_){
_start:
{
lean_object* v_past_1194_; lean_object* v_context_1195_; uint8_t v_isFloor_1196_; lean_object* v___x_1197_; lean_object* v___x_1198_; lean_object* v___x_1199_; lean_object* v___x_1200_; lean_object* v___x_1201_; uint8_t v___x_1202_; lean_object* v___x_1203_; lean_object* v___x_1204_; lean_object* v___x_1205_; lean_object* v___x_1206_; lean_object* v___x_1207_; lean_object* v___x_1208_; lean_object* v___x_1209_; lean_object* v___x_1210_; lean_object* v___x_1211_; lean_object* v___x_1212_; lean_object* v___x_1213_; lean_object* v___x_1214_; lean_object* v___x_1215_; lean_object* v___x_1216_; lean_object* v___x_1217_; lean_object* v___x_1218_; lean_object* v___x_1219_; lean_object* v___x_1220_; lean_object* v___x_1221_; lean_object* v___x_1222_; lean_object* v___x_1223_; lean_object* v___x_1224_; lean_object* v___x_1225_; lean_object* v___x_1226_; lean_object* v___x_1227_; lean_object* v___x_1228_; lean_object* v___x_1229_; lean_object* v___x_1230_; lean_object* v___x_1231_; lean_object* v___x_1232_; 
v_past_1194_ = lean_ctor_get(v_x_1193_, 0);
lean_inc(v_past_1194_);
v_context_1195_ = lean_ctor_get(v_x_1193_, 1);
lean_inc_ref(v_context_1195_);
v_isFloor_1196_ = lean_ctor_get_uint8(v_x_1193_, sizeof(void*)*2);
lean_dec_ref(v_x_1193_);
v___x_1197_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__5));
v___x_1198_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__3));
v___x_1199_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13);
v___x_1200_ = lp_physical__bridges_List_repr___at___00UPTController_instReprReceipt_repr_spec__0___redArg(v_past_1194_);
v___x_1201_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_1201_, 0, v___x_1199_);
lean_ctor_set(v___x_1201_, 1, v___x_1200_);
v___x_1202_ = 0;
v___x_1203_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_1203_, 0, v___x_1201_);
lean_ctor_set_uint8(v___x_1203_, sizeof(void*)*1, v___x_1202_);
v___x_1204_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1204_, 0, v___x_1198_);
lean_ctor_set(v___x_1204_, 1, v___x_1203_);
v___x_1205_ = ((lean_object*)(lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__4));
v___x_1206_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1206_, 0, v___x_1204_);
lean_ctor_set(v___x_1206_, 1, v___x_1205_);
v___x_1207_ = lean_box(1);
v___x_1208_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1208_, 0, v___x_1206_);
lean_ctor_set(v___x_1208_, 1, v___x_1207_);
v___x_1209_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__5));
v___x_1210_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1210_, 0, v___x_1208_);
lean_ctor_set(v___x_1210_, 1, v___x_1209_);
v___x_1211_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1211_, 0, v___x_1210_);
lean_ctor_set(v___x_1211_, 1, v___x_1197_);
v___x_1212_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__9, &lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__9_once, _init_lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__9);
v___x_1213_ = lp_physical__bridges_UPTController_instReprContext_repr___redArg(v_context_1195_);
v___x_1214_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_1214_, 0, v___x_1212_);
lean_ctor_set(v___x_1214_, 1, v___x_1213_);
v___x_1215_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_1215_, 0, v___x_1214_);
lean_ctor_set_uint8(v___x_1215_, sizeof(void*)*1, v___x_1202_);
v___x_1216_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1216_, 0, v___x_1211_);
lean_ctor_set(v___x_1216_, 1, v___x_1215_);
v___x_1217_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1217_, 0, v___x_1216_);
lean_ctor_set(v___x_1217_, 1, v___x_1205_);
v___x_1218_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1218_, 0, v___x_1217_);
lean_ctor_set(v___x_1218_, 1, v___x_1207_);
v___x_1219_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprReceipt_repr___redArg___closed__7));
v___x_1220_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1220_, 0, v___x_1218_);
lean_ctor_set(v___x_1220_, 1, v___x_1219_);
v___x_1221_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1221_, 0, v___x_1220_);
lean_ctor_set(v___x_1221_, 1, v___x_1197_);
v___x_1222_ = l_Bool_repr___redArg(v_isFloor_1196_);
v___x_1223_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_1223_, 0, v___x_1212_);
lean_ctor_set(v___x_1223_, 1, v___x_1222_);
v___x_1224_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_1224_, 0, v___x_1223_);
lean_ctor_set_uint8(v___x_1224_, sizeof(void*)*1, v___x_1202_);
v___x_1225_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1225_, 0, v___x_1221_);
lean_ctor_set(v___x_1225_, 1, v___x_1224_);
v___x_1226_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21);
v___x_1227_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__22));
v___x_1228_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1228_, 0, v___x_1227_);
lean_ctor_set(v___x_1228_, 1, v___x_1225_);
v___x_1229_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__23));
v___x_1230_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1230_, 0, v___x_1228_);
lean_ctor_set(v___x_1230_, 1, v___x_1229_);
v___x_1231_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_1231_, 0, v___x_1226_);
lean_ctor_set(v___x_1231_, 1, v___x_1230_);
v___x_1232_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_1232_, 0, v___x_1231_);
lean_ctor_set_uint8(v___x_1232_, sizeof(void*)*1, v___x_1202_);
return v___x_1232_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr(lean_object* v_x_1233_, lean_object* v_prec_1234_){
_start:
{
lean_object* v___x_1235_; 
v___x_1235_ = lp_physical__bridges_UPTController_instReprReceipt_repr___redArg(v_x_1233_);
return v___x_1235_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprReceipt_repr___boxed(lean_object* v_x_1236_, lean_object* v_prec_1237_){
_start:
{
lean_object* v_res_1238_; 
v_res_1238_ = lp_physical__bridges_UPTController_instReprReceipt_repr(v_x_1236_, v_prec_1237_);
lean_dec(v_prec_1237_);
return v_res_1238_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr___at___00UPTController_instReprReceipt_repr_spec__0(lean_object* v_a_1239_, lean_object* v_n_1240_){
_start:
{
lean_object* v___x_1241_; 
v___x_1241_ = lp_physical__bridges_List_repr___at___00UPTController_instReprReceipt_repr_spec__0___redArg(v_a_1239_);
return v___x_1241_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_repr___at___00UPTController_instReprReceipt_repr_spec__0___boxed(lean_object* v_a_1242_, lean_object* v_n_1243_){
_start:
{
lean_object* v_res_1244_; 
v_res_1244_ = lp_physical__bridges_List_repr___at___00UPTController_instReprReceipt_repr_spec__0(v_a_1242_, v_n_1243_);
lean_dec(v_n_1243_);
return v_res_1244_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_namedOp(lean_object* v_r_1247_){
_start:
{
uint8_t v_isFloor_1248_; 
v_isFloor_1248_ = lean_ctor_get_uint8(v_r_1247_, sizeof(void*)*2);
if (v_isFloor_1248_ == 0)
{
lean_object* v_context_1249_; lean_object* v___x_1250_; 
v_context_1249_ = lean_ctor_get(v_r_1247_, 1);
lean_inc_ref(v_context_1249_);
v___x_1250_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_1250_, 0, v_context_1249_);
return v___x_1250_;
}
else
{
lean_object* v_context_1251_; lean_object* v___x_1252_; 
v_context_1251_ = lean_ctor_get(v_r_1247_, 1);
lean_inc_ref(v_context_1251_);
v___x_1252_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v___x_1252_, 0, v_context_1251_);
return v___x_1252_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_namedOp___boxed(lean_object* v_r_1253_){
_start:
{
lean_object* v_res_1254_; 
v_res_1254_ = lp_physical__bridges_UPTController_namedOp(v_r_1253_);
lean_dec_ref(v_r_1253_);
return v_res_1254_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_expectedReply(lean_object* v_r_1255_){
_start:
{
uint8_t v_isFloor_1256_; 
v_isFloor_1256_ = lean_ctor_get_uint8(v_r_1255_, sizeof(void*)*2);
if (v_isFloor_1256_ == 0)
{
lean_object* v_context_1257_; lean_object* v___x_1258_; 
v_context_1257_ = lean_ctor_get(v_r_1255_, 1);
lean_inc_ref(v_context_1257_);
v___x_1258_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v___x_1258_, 0, v_context_1257_);
return v___x_1258_;
}
else
{
lean_object* v_context_1259_; lean_object* v_generation_1260_; lean_object* v___x_1261_; lean_object* v___x_1262_; lean_object* v___x_1263_; 
v_context_1259_ = lean_ctor_get(v_r_1255_, 1);
v_generation_1260_ = lean_ctor_get(v_context_1259_, 1);
v___x_1261_ = lean_unsigned_to_nat(1u);
v___x_1262_ = lean_nat_add(v_generation_1260_, v___x_1261_);
lean_inc_ref(v_context_1259_);
v___x_1263_ = lean_alloc_ctor(2, 2, 0);
lean_ctor_set(v___x_1263_, 0, v_context_1259_);
lean_ctor_set(v___x_1263_, 1, v___x_1262_);
return v___x_1263_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_expectedReply___boxed(lean_object* v_r_1264_){
_start:
{
lean_object* v_res_1265_; 
v_res_1265_ = lp_physical__bridges_UPTController_expectedReply(v_r_1264_);
lean_dec_ref(v_r_1264_);
return v_res_1265_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_history(lean_object* v_r_1266_){
_start:
{
lean_object* v_past_1267_; lean_object* v___x_1268_; lean_object* v___x_1269_; lean_object* v___x_1270_; lean_object* v___x_1271_; 
v_past_1267_ = lean_ctor_get(v_r_1266_, 0);
lean_inc(v_past_1267_);
v___x_1268_ = lp_physical__bridges_UPTController_namedOp(v_r_1266_);
lean_dec_ref(v_r_1266_);
v___x_1269_ = lean_box(0);
v___x_1270_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_1270_, 0, v___x_1268_);
lean_ctor_set(v___x_1270_, 1, v___x_1269_);
v___x_1271_ = l_List_appendTR___redArg(v_past_1267_, v___x_1270_);
return v___x_1271_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqLocal_decEq(lean_object* v_x_1272_, lean_object* v_x_1273_){
_start:
{
lean_object* v_floor_1274_; lean_object* v_boot_1275_; uint8_t v_ready_1276_; uint8_t v_consumed_1277_; lean_object* v_pending_1278_; lean_object* v_floor_1279_; lean_object* v_boot_1280_; uint8_t v_ready_1281_; uint8_t v_consumed_1282_; lean_object* v_pending_1283_; uint8_t v___y_1288_; uint8_t v___x_1289_; 
v_floor_1274_ = lean_ctor_get(v_x_1272_, 0);
lean_inc(v_floor_1274_);
v_boot_1275_ = lean_ctor_get(v_x_1272_, 1);
lean_inc(v_boot_1275_);
v_ready_1276_ = lean_ctor_get_uint8(v_x_1272_, sizeof(void*)*3);
v_consumed_1277_ = lean_ctor_get_uint8(v_x_1272_, sizeof(void*)*3 + 1);
v_pending_1278_ = lean_ctor_get(v_x_1272_, 2);
lean_inc(v_pending_1278_);
lean_dec_ref(v_x_1272_);
v_floor_1279_ = lean_ctor_get(v_x_1273_, 0);
lean_inc(v_floor_1279_);
v_boot_1280_ = lean_ctor_get(v_x_1273_, 1);
lean_inc(v_boot_1280_);
v_ready_1281_ = lean_ctor_get_uint8(v_x_1273_, sizeof(void*)*3);
v_consumed_1282_ = lean_ctor_get_uint8(v_x_1273_, sizeof(void*)*3 + 1);
v_pending_1283_ = lean_ctor_get(v_x_1273_, 2);
lean_inc(v_pending_1283_);
lean_dec_ref(v_x_1273_);
v___x_1289_ = lean_nat_dec_eq(v_floor_1274_, v_floor_1279_);
lean_dec(v_floor_1279_);
lean_dec(v_floor_1274_);
if (v___x_1289_ == 0)
{
lean_dec(v_pending_1283_);
lean_dec(v_boot_1280_);
lean_dec(v_pending_1278_);
lean_dec(v_boot_1275_);
return v___x_1289_;
}
else
{
uint8_t v___x_1290_; 
v___x_1290_ = lean_nat_dec_eq(v_boot_1275_, v_boot_1280_);
lean_dec(v_boot_1280_);
lean_dec(v_boot_1275_);
if (v___x_1290_ == 0)
{
lean_dec(v_pending_1283_);
lean_dec(v_pending_1278_);
return v___x_1290_;
}
else
{
if (v_ready_1281_ == 0)
{
if (v_ready_1276_ == 0)
{
v___y_1288_ = v___x_1290_;
goto v___jp_1287_;
}
else
{
lean_dec(v_pending_1283_);
lean_dec(v_pending_1278_);
return v_ready_1281_;
}
}
else
{
v___y_1288_ = v_ready_1276_;
goto v___jp_1287_;
}
}
}
v___jp_1284_:
{
lean_object* v___x_1285_; uint8_t v___x_1286_; 
v___x_1285_ = lean_alloc_closure((void*)(lp_physical__bridges_UPTController_instDecidableEqContext___boxed), 2, 0);
v___x_1286_ = l_Option_instDecidableEq___redArg(v___x_1285_, v_pending_1278_, v_pending_1283_);
return v___x_1286_;
}
v___jp_1287_:
{
if (v___y_1288_ == 0)
{
lean_dec(v_pending_1283_);
lean_dec(v_pending_1278_);
return v___y_1288_;
}
else
{
if (v_consumed_1282_ == 0)
{
if (v_consumed_1277_ == 0)
{
goto v___jp_1284_;
}
else
{
lean_dec(v_pending_1283_);
lean_dec(v_pending_1278_);
return v_consumed_1282_;
}
}
else
{
if (v_consumed_1277_ == 0)
{
lean_dec(v_pending_1283_);
lean_dec(v_pending_1278_);
return v_consumed_1277_;
}
else
{
goto v___jp_1284_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqLocal_decEq___boxed(lean_object* v_x_1291_, lean_object* v_x_1292_){
_start:
{
uint8_t v_res_1293_; lean_object* v_r_1294_; 
v_res_1293_ = lp_physical__bridges_UPTController_instDecidableEqLocal_decEq(v_x_1291_, v_x_1292_);
v_r_1294_ = lean_box(v_res_1293_);
return v_r_1294_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_UPTController_instDecidableEqLocal(lean_object* v_x_1295_, lean_object* v_x_1296_){
_start:
{
uint8_t v___x_1297_; 
v___x_1297_ = lp_physical__bridges_UPTController_instDecidableEqLocal_decEq(v_x_1295_, v_x_1296_);
return v___x_1297_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instDecidableEqLocal___boxed(lean_object* v_x_1298_, lean_object* v_x_1299_){
_start:
{
uint8_t v_res_1300_; lean_object* v_r_1301_; 
v_res_1300_ = lp_physical__bridges_UPTController_instDecidableEqLocal(v_x_1298_, v_x_1299_);
v_r_1301_ = lean_box(v_res_1300_);
return v_r_1301_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprLocal_repr___redArg(lean_object* v_x_1317_){
_start:
{
lean_object* v_floor_1318_; lean_object* v_boot_1319_; uint8_t v_ready_1320_; uint8_t v_consumed_1321_; lean_object* v_pending_1322_; lean_object* v___x_1323_; lean_object* v___x_1324_; lean_object* v___x_1325_; lean_object* v___x_1326_; lean_object* v___x_1327_; lean_object* v___x_1328_; uint8_t v___x_1329_; lean_object* v___x_1330_; lean_object* v___x_1331_; lean_object* v___x_1332_; lean_object* v___x_1333_; lean_object* v___x_1334_; lean_object* v___x_1335_; lean_object* v___x_1336_; lean_object* v___x_1337_; lean_object* v___x_1338_; lean_object* v___x_1339_; lean_object* v___x_1340_; lean_object* v___x_1341_; lean_object* v___x_1342_; lean_object* v___x_1343_; lean_object* v___x_1344_; lean_object* v___x_1345_; lean_object* v___x_1346_; lean_object* v___x_1347_; lean_object* v___x_1348_; lean_object* v___x_1349_; lean_object* v___x_1350_; lean_object* v___x_1351_; lean_object* v___x_1352_; lean_object* v___x_1353_; lean_object* v___x_1354_; lean_object* v___x_1355_; lean_object* v___x_1356_; lean_object* v___x_1357_; lean_object* v___x_1358_; lean_object* v___x_1359_; lean_object* v___x_1360_; lean_object* v___x_1361_; lean_object* v___x_1362_; lean_object* v___x_1363_; lean_object* v___x_1364_; lean_object* v___x_1365_; lean_object* v___x_1366_; lean_object* v___x_1367_; lean_object* v___x_1368_; lean_object* v___x_1369_; lean_object* v___x_1370_; lean_object* v___x_1371_; lean_object* v___x_1372_; lean_object* v___x_1373_; lean_object* v___x_1374_; lean_object* v___x_1375_; lean_object* v___x_1376_; lean_object* v___x_1377_; lean_object* v___x_1378_; lean_object* v___x_1379_; lean_object* v___x_1380_; lean_object* v___x_1381_; 
v_floor_1318_ = lean_ctor_get(v_x_1317_, 0);
lean_inc(v_floor_1318_);
v_boot_1319_ = lean_ctor_get(v_x_1317_, 1);
lean_inc(v_boot_1319_);
v_ready_1320_ = lean_ctor_get_uint8(v_x_1317_, sizeof(void*)*3);
v_consumed_1321_ = lean_ctor_get_uint8(v_x_1317_, sizeof(void*)*3 + 1);
v_pending_1322_ = lean_ctor_get(v_x_1317_, 2);
lean_inc(v_pending_1322_);
lean_dec_ref(v_x_1317_);
v___x_1323_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__5));
v___x_1324_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__3));
v___x_1325_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__7, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__7_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__7);
v___x_1326_ = l_Nat_reprFast(v_floor_1318_);
v___x_1327_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_1327_, 0, v___x_1326_);
v___x_1328_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_1328_, 0, v___x_1325_);
lean_ctor_set(v___x_1328_, 1, v___x_1327_);
v___x_1329_ = 0;
v___x_1330_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_1330_, 0, v___x_1328_);
lean_ctor_set_uint8(v___x_1330_, sizeof(void*)*1, v___x_1329_);
v___x_1331_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1331_, 0, v___x_1324_);
lean_ctor_set(v___x_1331_, 1, v___x_1330_);
v___x_1332_ = ((lean_object*)(lp_physical__bridges_List_repr_x27___at___00UPTController_instReprContext_repr_spec__0___redArg___closed__4));
v___x_1333_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1333_, 0, v___x_1331_);
lean_ctor_set(v___x_1333_, 1, v___x_1332_);
v___x_1334_ = lean_box(1);
v___x_1335_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1335_, 0, v___x_1333_);
lean_ctor_set(v___x_1335_, 1, v___x_1334_);
v___x_1336_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__12));
v___x_1337_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1337_, 0, v___x_1335_);
lean_ctor_set(v___x_1337_, 1, v___x_1336_);
v___x_1338_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1338_, 0, v___x_1337_);
lean_ctor_set(v___x_1338_, 1, v___x_1323_);
v___x_1339_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__13);
v___x_1340_ = l_Nat_reprFast(v_boot_1319_);
v___x_1341_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_1341_, 0, v___x_1340_);
v___x_1342_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_1342_, 0, v___x_1339_);
lean_ctor_set(v___x_1342_, 1, v___x_1341_);
v___x_1343_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_1343_, 0, v___x_1342_);
lean_ctor_set_uint8(v___x_1343_, sizeof(void*)*1, v___x_1329_);
v___x_1344_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1344_, 0, v___x_1338_);
lean_ctor_set(v___x_1344_, 1, v___x_1343_);
v___x_1345_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1345_, 0, v___x_1344_);
lean_ctor_set(v___x_1345_, 1, v___x_1332_);
v___x_1346_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1346_, 0, v___x_1345_);
lean_ctor_set(v___x_1346_, 1, v___x_1334_);
v___x_1347_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__5));
v___x_1348_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1348_, 0, v___x_1346_);
lean_ctor_set(v___x_1348_, 1, v___x_1347_);
v___x_1349_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1349_, 0, v___x_1348_);
lean_ctor_set(v___x_1349_, 1, v___x_1323_);
v___x_1350_ = lean_unsigned_to_nat(0u);
v___x_1351_ = l_Bool_repr___redArg(v_ready_1320_);
v___x_1352_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_1352_, 0, v___x_1325_);
lean_ctor_set(v___x_1352_, 1, v___x_1351_);
v___x_1353_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_1353_, 0, v___x_1352_);
lean_ctor_set_uint8(v___x_1353_, sizeof(void*)*1, v___x_1329_);
v___x_1354_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1354_, 0, v___x_1349_);
lean_ctor_set(v___x_1354_, 1, v___x_1353_);
v___x_1355_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1355_, 0, v___x_1354_);
lean_ctor_set(v___x_1355_, 1, v___x_1332_);
v___x_1356_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1356_, 0, v___x_1355_);
lean_ctor_set(v___x_1356_, 1, v___x_1334_);
v___x_1357_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprLocal_repr___redArg___closed__7));
v___x_1358_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1358_, 0, v___x_1356_);
lean_ctor_set(v___x_1358_, 1, v___x_1357_);
v___x_1359_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1359_, 0, v___x_1358_);
lean_ctor_set(v___x_1359_, 1, v___x_1323_);
v___x_1360_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__16, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__16_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__16);
v___x_1361_ = l_Bool_repr___redArg(v_consumed_1321_);
v___x_1362_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_1362_, 0, v___x_1360_);
lean_ctor_set(v___x_1362_, 1, v___x_1361_);
v___x_1363_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_1363_, 0, v___x_1362_);
lean_ctor_set_uint8(v___x_1363_, sizeof(void*)*1, v___x_1329_);
v___x_1364_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1364_, 0, v___x_1359_);
lean_ctor_set(v___x_1364_, 1, v___x_1363_);
v___x_1365_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1365_, 0, v___x_1364_);
lean_ctor_set(v___x_1365_, 1, v___x_1332_);
v___x_1366_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1366_, 0, v___x_1365_);
lean_ctor_set(v___x_1366_, 1, v___x_1334_);
v___x_1367_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__8));
v___x_1368_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1368_, 0, v___x_1366_);
lean_ctor_set(v___x_1368_, 1, v___x_1367_);
v___x_1369_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1369_, 0, v___x_1368_);
lean_ctor_set(v___x_1369_, 1, v___x_1323_);
v___x_1370_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__9, &lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__9_once, _init_lp_physical__bridges_UPTController_instReprState_repr___redArg___closed__9);
v___x_1371_ = lp_physical__bridges_Option_repr___at___00UPTController_instReprState_repr_spec__0(v_pending_1322_, v___x_1350_);
v___x_1372_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_1372_, 0, v___x_1370_);
lean_ctor_set(v___x_1372_, 1, v___x_1371_);
v___x_1373_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_1373_, 0, v___x_1372_);
lean_ctor_set_uint8(v___x_1373_, sizeof(void*)*1, v___x_1329_);
v___x_1374_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1374_, 0, v___x_1369_);
lean_ctor_set(v___x_1374_, 1, v___x_1373_);
v___x_1375_ = lean_obj_once(&lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21, &lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21_once, _init_lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__21);
v___x_1376_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__22));
v___x_1377_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1377_, 0, v___x_1376_);
lean_ctor_set(v___x_1377_, 1, v___x_1374_);
v___x_1378_ = ((lean_object*)(lp_physical__bridges_UPTController_instReprContext_repr___redArg___closed__23));
v___x_1379_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_1379_, 0, v___x_1377_);
lean_ctor_set(v___x_1379_, 1, v___x_1378_);
v___x_1380_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_1380_, 0, v___x_1375_);
lean_ctor_set(v___x_1380_, 1, v___x_1379_);
v___x_1381_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_1381_, 0, v___x_1380_);
lean_ctor_set_uint8(v___x_1381_, sizeof(void*)*1, v___x_1329_);
return v___x_1381_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprLocal_repr(lean_object* v_x_1382_, lean_object* v_prec_1383_){
_start:
{
lean_object* v___x_1384_; 
v___x_1384_ = lp_physical__bridges_UPTController_instReprLocal_repr___redArg(v_x_1382_);
return v___x_1384_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_instReprLocal_repr___boxed(lean_object* v_x_1385_, lean_object* v_prec_1386_){
_start:
{
lean_object* v_res_1387_; 
v_res_1387_ = lp_physical__bridges_UPTController_instReprLocal_repr(v_x_1385_, v_prec_1386_);
lean_dec(v_prec_1386_);
return v_res_1387_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_consume(lean_object* v_s_1390_){
_start:
{
lean_object* v_floor_1391_; lean_object* v_boot_1392_; uint8_t v_ready_1393_; lean_object* v___x_1395_; uint8_t v_isShared_1396_; uint8_t v_isSharedCheck_1402_; 
v_floor_1391_ = lean_ctor_get(v_s_1390_, 0);
v_boot_1392_ = lean_ctor_get(v_s_1390_, 1);
v_ready_1393_ = lean_ctor_get_uint8(v_s_1390_, sizeof(void*)*3);
v_isSharedCheck_1402_ = !lean_is_exclusive(v_s_1390_);
if (v_isSharedCheck_1402_ == 0)
{
lean_object* v_unused_1403_; 
v_unused_1403_ = lean_ctor_get(v_s_1390_, 2);
lean_dec(v_unused_1403_);
v___x_1395_ = v_s_1390_;
v_isShared_1396_ = v_isSharedCheck_1402_;
goto v_resetjp_1394_;
}
else
{
lean_inc(v_boot_1392_);
lean_inc(v_floor_1391_);
lean_dec(v_s_1390_);
v___x_1395_ = lean_box(0);
v_isShared_1396_ = v_isSharedCheck_1402_;
goto v_resetjp_1394_;
}
v_resetjp_1394_:
{
uint8_t v___x_1397_; lean_object* v___x_1398_; lean_object* v___x_1400_; 
v___x_1397_ = 1;
v___x_1398_ = lean_box(0);
if (v_isShared_1396_ == 0)
{
lean_ctor_set(v___x_1395_, 2, v___x_1398_);
v___x_1400_ = v___x_1395_;
goto v_reusejp_1399_;
}
else
{
lean_object* v_reuseFailAlloc_1401_; 
v_reuseFailAlloc_1401_ = lean_alloc_ctor(0, 3, 2);
lean_ctor_set(v_reuseFailAlloc_1401_, 0, v_floor_1391_);
lean_ctor_set(v_reuseFailAlloc_1401_, 1, v_boot_1392_);
lean_ctor_set(v_reuseFailAlloc_1401_, 2, v___x_1398_);
lean_ctor_set_uint8(v_reuseFailAlloc_1401_, sizeof(void*)*3, v_ready_1393_);
v___x_1400_ = v_reuseFailAlloc_1401_;
goto v_reusejp_1399_;
}
v_reusejp_1399_:
{
lean_ctor_set_uint8(v___x_1400_, sizeof(void*)*3 + 1, v___x_1397_);
return v___x_1400_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_restart(lean_object* v_s_1404_, lean_object* v_checkpointFloor_1405_){
_start:
{
lean_object* v_floor_1406_; lean_object* v_boot_1407_; lean_object* v___x_1409_; uint8_t v_isShared_1410_; uint8_t v_isSharedCheck_1422_; 
v_floor_1406_ = lean_ctor_get(v_s_1404_, 0);
v_boot_1407_ = lean_ctor_get(v_s_1404_, 1);
v_isSharedCheck_1422_ = !lean_is_exclusive(v_s_1404_);
if (v_isSharedCheck_1422_ == 0)
{
lean_object* v_unused_1423_; 
v_unused_1423_ = lean_ctor_get(v_s_1404_, 2);
lean_dec(v_unused_1423_);
v___x_1409_ = v_s_1404_;
v_isShared_1410_ = v_isSharedCheck_1422_;
goto v_resetjp_1408_;
}
else
{
lean_inc(v_boot_1407_);
lean_inc(v_floor_1406_);
lean_dec(v_s_1404_);
v___x_1409_ = lean_box(0);
v_isShared_1410_ = v_isSharedCheck_1422_;
goto v_resetjp_1408_;
}
v_resetjp_1408_:
{
lean_object* v___y_1412_; uint8_t v___x_1421_; 
v___x_1421_ = lean_nat_dec_le(v_floor_1406_, v_checkpointFloor_1405_);
if (v___x_1421_ == 0)
{
lean_dec(v_checkpointFloor_1405_);
v___y_1412_ = v_floor_1406_;
goto v___jp_1411_;
}
else
{
lean_dec(v_floor_1406_);
v___y_1412_ = v_checkpointFloor_1405_;
goto v___jp_1411_;
}
v___jp_1411_:
{
lean_object* v___x_1413_; lean_object* v___x_1414_; uint8_t v___x_1415_; uint8_t v___x_1416_; lean_object* v___x_1417_; lean_object* v___x_1419_; 
v___x_1413_ = lean_unsigned_to_nat(1u);
v___x_1414_ = lean_nat_add(v_boot_1407_, v___x_1413_);
lean_dec(v_boot_1407_);
v___x_1415_ = 0;
v___x_1416_ = 1;
v___x_1417_ = lean_box(0);
if (v_isShared_1410_ == 0)
{
lean_ctor_set(v___x_1409_, 2, v___x_1417_);
lean_ctor_set(v___x_1409_, 1, v___x_1414_);
lean_ctor_set(v___x_1409_, 0, v___y_1412_);
v___x_1419_ = v___x_1409_;
goto v_reusejp_1418_;
}
else
{
lean_object* v_reuseFailAlloc_1420_; 
v_reuseFailAlloc_1420_ = lean_alloc_ctor(0, 3, 2);
lean_ctor_set(v_reuseFailAlloc_1420_, 0, v___y_1412_);
lean_ctor_set(v_reuseFailAlloc_1420_, 1, v___x_1414_);
lean_ctor_set(v_reuseFailAlloc_1420_, 2, v___x_1417_);
v___x_1419_ = v_reuseFailAlloc_1420_;
goto v_reusejp_1418_;
}
v_reusejp_1418_:
{
lean_ctor_set_uint8(v___x_1419_, sizeof(void*)*3, v___x_1415_);
lean_ctor_set_uint8(v___x_1419_, sizeof(void*)*3 + 1, v___x_1416_);
return v___x_1419_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_emits(lean_object* v_enrol_1424_, lean_object* v_s_1425_, lean_object* v_x_1426_){
_start:
{
if (lean_obj_tag(v_x_1426_) == 0)
{
lean_object* v_c_1427_; lean_object* v___x_1428_; lean_object* v_snd_1429_; lean_object* v___x_1431_; uint8_t v_isShared_1432_; uint8_t v_isSharedCheck_1441_; 
v_c_1427_ = lean_ctor_get(v_x_1426_, 0);
lean_inc_ref(v_c_1427_);
v___x_1428_ = lp_physical__bridges_UPTController_step(v_enrol_1424_, v_s_1425_, v_x_1426_);
v_snd_1429_ = lean_ctor_get(v___x_1428_, 1);
v_isSharedCheck_1441_ = !lean_is_exclusive(v___x_1428_);
if (v_isSharedCheck_1441_ == 0)
{
lean_object* v_unused_1442_; 
v_unused_1442_ = lean_ctor_get(v___x_1428_, 0);
lean_dec(v_unused_1442_);
v___x_1431_ = v___x_1428_;
v_isShared_1432_ = v_isSharedCheck_1441_;
goto v_resetjp_1430_;
}
else
{
lean_inc(v_snd_1429_);
lean_dec(v___x_1428_);
v___x_1431_ = lean_box(0);
v_isShared_1432_ = v_isSharedCheck_1441_;
goto v_resetjp_1430_;
}
v_resetjp_1430_:
{
lean_object* v___x_1433_; uint8_t v___x_1434_; 
lean_inc_ref(v_c_1427_);
v___x_1433_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v___x_1433_, 0, v_c_1427_);
v___x_1434_ = lp_physical__bridges_UPTController_instDecidableEqReply_decEq(v_snd_1429_, v___x_1433_);
if (v___x_1434_ == 0)
{
lean_object* v___x_1435_; 
lean_del_object(v___x_1431_);
lean_dec_ref(v_c_1427_);
v___x_1435_ = lean_box(0);
return v___x_1435_;
}
else
{
lean_object* v_generation_1436_; lean_object* v___x_1437_; lean_object* v___x_1439_; 
v_generation_1436_ = lean_ctor_get(v_c_1427_, 1);
lean_inc(v_generation_1436_);
lean_dec_ref(v_c_1427_);
v___x_1437_ = lean_box(0);
if (v_isShared_1432_ == 0)
{
lean_ctor_set_tag(v___x_1431_, 1);
lean_ctor_set(v___x_1431_, 1, v___x_1437_);
lean_ctor_set(v___x_1431_, 0, v_generation_1436_);
v___x_1439_ = v___x_1431_;
goto v_reusejp_1438_;
}
else
{
lean_object* v_reuseFailAlloc_1440_; 
v_reuseFailAlloc_1440_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_1440_, 0, v_generation_1436_);
lean_ctor_set(v_reuseFailAlloc_1440_, 1, v___x_1437_);
v___x_1439_ = v_reuseFailAlloc_1440_;
goto v_reusejp_1438_;
}
v_reusejp_1438_:
{
return v___x_1439_;
}
}
}
}
else
{
lean_object* v___x_1443_; 
lean_dec_ref(v_x_1426_);
lean_dec_ref(v_s_1425_);
lean_dec_ref(v_enrol_1424_);
v___x_1443_ = lean_box(0);
return v___x_1443_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_UPTController_issued(lean_object* v_enrol_1444_, lean_object* v_s_1445_, lean_object* v_x_1446_){
_start:
{
if (lean_obj_tag(v_x_1446_) == 0)
{
lean_object* v___x_1447_; 
lean_dec_ref(v_s_1445_);
lean_dec_ref(v_enrol_1444_);
v___x_1447_ = lean_box(0);
return v___x_1447_;
}
else
{
lean_object* v_head_1448_; lean_object* v_tail_1449_; lean_object* v___x_1450_; lean_object* v___x_1451_; lean_object* v_fst_1452_; lean_object* v___x_1453_; lean_object* v___x_1454_; 
v_head_1448_ = lean_ctor_get(v_x_1446_, 0);
lean_inc_n(v_head_1448_, 2);
v_tail_1449_ = lean_ctor_get(v_x_1446_, 1);
lean_inc(v_tail_1449_);
lean_dec_ref_known(v_x_1446_, 2);
lean_inc_ref(v_s_1445_);
lean_inc_ref_n(v_enrol_1444_, 2);
v___x_1450_ = lp_physical__bridges_UPTController_emits(v_enrol_1444_, v_s_1445_, v_head_1448_);
v___x_1451_ = lp_physical__bridges_UPTController_step(v_enrol_1444_, v_s_1445_, v_head_1448_);
v_fst_1452_ = lean_ctor_get(v___x_1451_, 0);
lean_inc(v_fst_1452_);
lean_dec_ref(v___x_1451_);
v___x_1453_ = lp_physical__bridges_UPTController_issued(v_enrol_1444_, v_fst_1452_, v_tail_1449_);
v___x_1454_ = l_List_appendTR___redArg(v___x_1450_, v___x_1453_);
return v___x_1454_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_emits_match__1_splitter___redArg(lean_object* v_x_1455_, lean_object* v_h__1_1456_, lean_object* v_h__2_1457_){
_start:
{
if (lean_obj_tag(v_x_1455_) == 0)
{
lean_object* v_c_1458_; lean_object* v___x_1459_; 
lean_dec(v_h__2_1457_);
v_c_1458_ = lean_ctor_get(v_x_1455_, 0);
lean_inc_ref(v_c_1458_);
lean_dec_ref_known(v_x_1455_, 1);
v___x_1459_ = lean_apply_1(v_h__1_1456_, v_c_1458_);
return v___x_1459_;
}
else
{
lean_object* v___x_1460_; 
lean_dec(v_h__1_1456_);
v___x_1460_ = lean_apply_2(v_h__2_1457_, v_x_1455_, lean_box(0));
return v___x_1460_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_ControllerFinality_0__UPTController_emits_match__1_splitter(lean_object* v_motive_1461_, lean_object* v_x_1462_, lean_object* v_h__1_1463_, lean_object* v_h__2_1464_){
_start:
{
if (lean_obj_tag(v_x_1462_) == 0)
{
lean_object* v_c_1465_; lean_object* v___x_1466_; 
lean_dec(v_h__2_1464_);
v_c_1465_ = lean_ctor_get(v_x_1462_, 0);
lean_inc_ref(v_c_1465_);
lean_dec_ref_known(v_x_1462_, 1);
v___x_1466_ = lean_apply_1(v_h__1_1463_, v_c_1465_);
return v___x_1466_;
}
else
{
lean_object* v___x_1467_; 
lean_dec(v_h__1_1463_);
v___x_1467_ = lean_apply_2(v_h__2_1464_, v_x_1462_, lean_box(0));
return v___x_1467_;
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_ControllerFinality(uint8_t builtin) {
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
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
