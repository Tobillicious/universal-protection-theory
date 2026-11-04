// Lean compiler output
// Module: PhysicalBridges.IRWatchdogLatencyEffects
// Imports: public import Init public meta import Init public import PhysicalBridges.IRInFlightQuiescence public import PhysicalBridges.IRJsonTraceChecker
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
lean_object* l_Nat_reprFast(lean_object*);
lean_object* lean_string_length(lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "{ "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 10, .m_capacity = 10, .m_length = 9, .m_data = "faultTick"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__1_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__2_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__2_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__3_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = " := "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__4 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__4_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__4_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__5_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__3_value),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__6_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__7;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = ","};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__8 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__8_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__8_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__9 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__9_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 13, .m_capacity = 13, .m_length = 12, .m_data = "detectedTick"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__10 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__10_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__10_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__11 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__11_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__12_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__12;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__13_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 11, .m_capacity = 11, .m_length = 10, .m_data = "fencedTick"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__13 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__13_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__14_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__13_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__14 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__14_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__15_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__15;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__16_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 14, .m_capacity = 14, .m_length = 13, .m_data = "quiescentTick"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__16 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__16_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__17_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__16_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__17 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__17_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__18_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__18;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__19_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = " }"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__19 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__19_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__20_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__20;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__21_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__21;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__22_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__22 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__22_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__23_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__19_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__23 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__23_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode___closed__0_value;
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instDecidableEqEpisode_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instDecidableEqEpisode_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instDecidableEqEpisode(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instDecidableEqEpisode___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_actualEffect(uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_actualEffect___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_transient(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_transient___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_absorbingHold___redArg();
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_absorbingHold___redArg___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_absorbingHold(uint8_t, uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_absorbingHold___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_afterHold___redArg();
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_afterHold___redArg___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_afterHold(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_afterHold___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_deliversService(uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_deliversService___boxed(lean_object*);
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__7(void){
_start:
{
lean_object* v___x_14_; lean_object* v___x_15_; 
v___x_14_ = lean_unsigned_to_nat(13u);
v___x_15_ = lean_nat_to_int(v___x_14_);
return v___x_15_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__12(void){
_start:
{
lean_object* v___x_22_; lean_object* v___x_23_; 
v___x_22_ = lean_unsigned_to_nat(16u);
v___x_23_ = lean_nat_to_int(v___x_22_);
return v___x_23_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__15(void){
_start:
{
lean_object* v___x_27_; lean_object* v___x_28_; 
v___x_27_ = lean_unsigned_to_nat(14u);
v___x_28_ = lean_nat_to_int(v___x_27_);
return v___x_28_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__18(void){
_start:
{
lean_object* v___x_32_; lean_object* v___x_33_; 
v___x_32_ = lean_unsigned_to_nat(17u);
v___x_33_ = lean_nat_to_int(v___x_32_);
return v___x_33_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__20(void){
_start:
{
lean_object* v___x_35_; lean_object* v___x_36_; 
v___x_35_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__0));
v___x_36_ = lean_string_length(v___x_35_);
return v___x_36_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__21(void){
_start:
{
lean_object* v___x_37_; lean_object* v___x_38_; 
v___x_37_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__20, &lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__20_once, _init_lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__20);
v___x_38_ = lean_nat_to_int(v___x_37_);
return v___x_38_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg(lean_object* v_x_43_){
_start:
{
lean_object* v_faultTick_44_; lean_object* v_detectedTick_45_; lean_object* v_fencedTick_46_; lean_object* v_quiescentTick_47_; lean_object* v___x_48_; lean_object* v___x_49_; lean_object* v___x_50_; lean_object* v___x_51_; lean_object* v___x_52_; lean_object* v___x_53_; uint8_t v___x_54_; lean_object* v___x_55_; lean_object* v___x_56_; lean_object* v___x_57_; lean_object* v___x_58_; lean_object* v___x_59_; lean_object* v___x_60_; lean_object* v___x_61_; lean_object* v___x_62_; lean_object* v___x_63_; lean_object* v___x_64_; lean_object* v___x_65_; lean_object* v___x_66_; lean_object* v___x_67_; lean_object* v___x_68_; lean_object* v___x_69_; lean_object* v___x_70_; lean_object* v___x_71_; lean_object* v___x_72_; lean_object* v___x_73_; lean_object* v___x_74_; lean_object* v___x_75_; lean_object* v___x_76_; lean_object* v___x_77_; lean_object* v___x_78_; lean_object* v___x_79_; lean_object* v___x_80_; lean_object* v___x_81_; lean_object* v___x_82_; lean_object* v___x_83_; lean_object* v___x_84_; lean_object* v___x_85_; lean_object* v___x_86_; lean_object* v___x_87_; lean_object* v___x_88_; lean_object* v___x_89_; lean_object* v___x_90_; lean_object* v___x_91_; lean_object* v___x_92_; lean_object* v___x_93_; lean_object* v___x_94_; lean_object* v___x_95_; lean_object* v___x_96_; lean_object* v___x_97_; lean_object* v___x_98_; 
v_faultTick_44_ = lean_ctor_get(v_x_43_, 0);
lean_inc(v_faultTick_44_);
v_detectedTick_45_ = lean_ctor_get(v_x_43_, 1);
lean_inc(v_detectedTick_45_);
v_fencedTick_46_ = lean_ctor_get(v_x_43_, 2);
lean_inc(v_fencedTick_46_);
v_quiescentTick_47_ = lean_ctor_get(v_x_43_, 3);
lean_inc(v_quiescentTick_47_);
lean_dec_ref(v_x_43_);
v___x_48_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__5));
v___x_49_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__6));
v___x_50_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__7, &lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__7_once, _init_lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__7);
v___x_51_ = l_Nat_reprFast(v_faultTick_44_);
v___x_52_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_52_, 0, v___x_51_);
v___x_53_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_53_, 0, v___x_50_);
lean_ctor_set(v___x_53_, 1, v___x_52_);
v___x_54_ = 0;
v___x_55_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_55_, 0, v___x_53_);
lean_ctor_set_uint8(v___x_55_, sizeof(void*)*1, v___x_54_);
v___x_56_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_56_, 0, v___x_49_);
lean_ctor_set(v___x_56_, 1, v___x_55_);
v___x_57_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__9));
v___x_58_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_58_, 0, v___x_56_);
lean_ctor_set(v___x_58_, 1, v___x_57_);
v___x_59_ = lean_box(1);
v___x_60_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_60_, 0, v___x_58_);
lean_ctor_set(v___x_60_, 1, v___x_59_);
v___x_61_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__11));
v___x_62_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_62_, 0, v___x_60_);
lean_ctor_set(v___x_62_, 1, v___x_61_);
v___x_63_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_63_, 0, v___x_62_);
lean_ctor_set(v___x_63_, 1, v___x_48_);
v___x_64_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__12, &lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__12_once, _init_lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__12);
v___x_65_ = l_Nat_reprFast(v_detectedTick_45_);
v___x_66_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_66_, 0, v___x_65_);
v___x_67_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_67_, 0, v___x_64_);
lean_ctor_set(v___x_67_, 1, v___x_66_);
v___x_68_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_68_, 0, v___x_67_);
lean_ctor_set_uint8(v___x_68_, sizeof(void*)*1, v___x_54_);
v___x_69_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_69_, 0, v___x_63_);
lean_ctor_set(v___x_69_, 1, v___x_68_);
v___x_70_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_70_, 0, v___x_69_);
lean_ctor_set(v___x_70_, 1, v___x_57_);
v___x_71_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_71_, 0, v___x_70_);
lean_ctor_set(v___x_71_, 1, v___x_59_);
v___x_72_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__14));
v___x_73_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_73_, 0, v___x_71_);
lean_ctor_set(v___x_73_, 1, v___x_72_);
v___x_74_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_74_, 0, v___x_73_);
lean_ctor_set(v___x_74_, 1, v___x_48_);
v___x_75_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__15, &lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__15_once, _init_lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__15);
v___x_76_ = l_Nat_reprFast(v_fencedTick_46_);
v___x_77_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_77_, 0, v___x_76_);
v___x_78_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_78_, 0, v___x_75_);
lean_ctor_set(v___x_78_, 1, v___x_77_);
v___x_79_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_79_, 0, v___x_78_);
lean_ctor_set_uint8(v___x_79_, sizeof(void*)*1, v___x_54_);
v___x_80_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_80_, 0, v___x_74_);
lean_ctor_set(v___x_80_, 1, v___x_79_);
v___x_81_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_81_, 0, v___x_80_);
lean_ctor_set(v___x_81_, 1, v___x_57_);
v___x_82_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_82_, 0, v___x_81_);
lean_ctor_set(v___x_82_, 1, v___x_59_);
v___x_83_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__17));
v___x_84_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_84_, 0, v___x_82_);
lean_ctor_set(v___x_84_, 1, v___x_83_);
v___x_85_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_85_, 0, v___x_84_);
lean_ctor_set(v___x_85_, 1, v___x_48_);
v___x_86_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__18, &lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__18_once, _init_lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__18);
v___x_87_ = l_Nat_reprFast(v_quiescentTick_47_);
v___x_88_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_88_, 0, v___x_87_);
v___x_89_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_89_, 0, v___x_86_);
lean_ctor_set(v___x_89_, 1, v___x_88_);
v___x_90_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_90_, 0, v___x_89_);
lean_ctor_set_uint8(v___x_90_, sizeof(void*)*1, v___x_54_);
v___x_91_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_91_, 0, v___x_85_);
lean_ctor_set(v___x_91_, 1, v___x_90_);
v___x_92_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__21, &lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__21_once, _init_lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__21);
v___x_93_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__22));
v___x_94_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_94_, 0, v___x_93_);
lean_ctor_set(v___x_94_, 1, v___x_91_);
v___x_95_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg___closed__23));
v___x_96_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_96_, 0, v___x_94_);
lean_ctor_set(v___x_96_, 1, v___x_95_);
v___x_97_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_97_, 0, v___x_92_);
lean_ctor_set(v___x_97_, 1, v___x_96_);
v___x_98_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_98_, 0, v___x_97_);
lean_ctor_set_uint8(v___x_98_, sizeof(void*)*1, v___x_54_);
return v___x_98_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr(lean_object* v_x_99_, lean_object* v_prec_100_){
_start:
{
lean_object* v___x_101_; 
v___x_101_ = lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___redArg(v_x_99_);
return v___x_101_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr___boxed(lean_object* v_x_102_, lean_object* v_prec_103_){
_start:
{
lean_object* v_res_104_; 
v_res_104_ = lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instReprEpisode_repr(v_x_102_, v_prec_103_);
lean_dec(v_prec_103_);
return v_res_104_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instDecidableEqEpisode_decEq(lean_object* v_x_107_, lean_object* v_x_108_){
_start:
{
lean_object* v_faultTick_109_; lean_object* v_detectedTick_110_; lean_object* v_fencedTick_111_; lean_object* v_quiescentTick_112_; lean_object* v_faultTick_113_; lean_object* v_detectedTick_114_; lean_object* v_fencedTick_115_; lean_object* v_quiescentTick_116_; uint8_t v___x_117_; 
v_faultTick_109_ = lean_ctor_get(v_x_107_, 0);
v_detectedTick_110_ = lean_ctor_get(v_x_107_, 1);
v_fencedTick_111_ = lean_ctor_get(v_x_107_, 2);
v_quiescentTick_112_ = lean_ctor_get(v_x_107_, 3);
v_faultTick_113_ = lean_ctor_get(v_x_108_, 0);
v_detectedTick_114_ = lean_ctor_get(v_x_108_, 1);
v_fencedTick_115_ = lean_ctor_get(v_x_108_, 2);
v_quiescentTick_116_ = lean_ctor_get(v_x_108_, 3);
v___x_117_ = lean_nat_dec_eq(v_faultTick_109_, v_faultTick_113_);
if (v___x_117_ == 0)
{
return v___x_117_;
}
else
{
uint8_t v___x_118_; 
v___x_118_ = lean_nat_dec_eq(v_detectedTick_110_, v_detectedTick_114_);
if (v___x_118_ == 0)
{
return v___x_118_;
}
else
{
uint8_t v___x_119_; 
v___x_119_ = lean_nat_dec_eq(v_fencedTick_111_, v_fencedTick_115_);
if (v___x_119_ == 0)
{
return v___x_119_;
}
else
{
uint8_t v___x_120_; 
v___x_120_ = lean_nat_dec_eq(v_quiescentTick_112_, v_quiescentTick_116_);
return v___x_120_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instDecidableEqEpisode_decEq___boxed(lean_object* v_x_121_, lean_object* v_x_122_){
_start:
{
uint8_t v_res_123_; lean_object* v_r_124_; 
v_res_123_ = lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instDecidableEqEpisode_decEq(v_x_121_, v_x_122_);
lean_dec_ref(v_x_122_);
lean_dec_ref(v_x_121_);
v_r_124_ = lean_box(v_res_123_);
return v_r_124_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instDecidableEqEpisode(lean_object* v_x_125_, lean_object* v_x_126_){
_start:
{
uint8_t v___x_127_; 
v___x_127_ = lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instDecidableEqEpisode_decEq(v_x_125_, v_x_126_);
return v___x_127_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instDecidableEqEpisode___boxed(lean_object* v_x_128_, lean_object* v_x_129_){
_start:
{
uint8_t v_res_130_; lean_object* v_r_131_; 
v_res_130_ = lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_instDecidableEqEpisode(v_x_128_, v_x_129_);
lean_dec_ref(v_x_129_);
lean_dec_ref(v_x_128_);
v_r_131_ = lean_box(v_res_130_);
return v_r_131_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_actualEffect(uint8_t v_enabled_132_, lean_object* v_requested_133_, lean_object* v_bypass_134_){
_start:
{
if (v_enabled_132_ == 0)
{
lean_inc(v_bypass_134_);
return v_bypass_134_;
}
else
{
lean_object* v___x_135_; 
v___x_135_ = lean_nat_add(v_requested_133_, v_bypass_134_);
return v___x_135_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_actualEffect___boxed(lean_object* v_enabled_136_, lean_object* v_requested_137_, lean_object* v_bypass_138_){
_start:
{
uint8_t v_enabled_boxed_139_; lean_object* v_res_140_; 
v_enabled_boxed_139_ = lean_unbox(v_enabled_136_);
v_res_140_ = lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_actualEffect(v_enabled_boxed_139_, v_requested_137_, v_bypass_138_);
lean_dec(v_bypass_138_);
lean_dec(v_requested_137_);
return v_res_140_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_transient(lean_object* v_t_141_){
_start:
{
lean_object* v___x_142_; uint8_t v___x_143_; 
v___x_142_ = lean_unsigned_to_nat(1u);
v___x_143_ = lean_nat_dec_eq(v_t_141_, v___x_142_);
if (v___x_143_ == 0)
{
lean_object* v___x_144_; 
v___x_144_ = lean_unsigned_to_nat(0u);
return v___x_144_;
}
else
{
lean_object* v___x_145_; 
v___x_145_ = lean_unsigned_to_nat(3u);
return v___x_145_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_transient___boxed(lean_object* v_t_146_){
_start:
{
lean_object* v_res_147_; 
v_res_147_ = lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_transient(v_t_146_);
lean_dec(v_t_146_);
return v_res_147_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_absorbingHold___redArg(){
_start:
{
uint8_t v___x_149_; 
v___x_149_ = 1;
return v___x_149_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_absorbingHold___redArg___boxed(lean_object* v___dummy_150_){
_start:
{
uint8_t v_res_151_; lean_object* v_r_152_; 
v_res_151_ = lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_absorbingHold___redArg();
v_r_152_ = lean_box(v_res_151_);
return v_r_152_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_absorbingHold(uint8_t v___action_153_, uint8_t v___disturbance_154_){
_start:
{
uint8_t v___x_155_; 
v___x_155_ = 1;
return v___x_155_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_absorbingHold___boxed(lean_object* v___action_156_, lean_object* v___disturbance_157_){
_start:
{
uint8_t v___action_boxed_158_; uint8_t v___disturbance_boxed_159_; uint8_t v_res_160_; lean_object* v_r_161_; 
v___action_boxed_158_ = lean_unbox(v___action_156_);
v___disturbance_boxed_159_ = lean_unbox(v___disturbance_157_);
v_res_160_ = lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_absorbingHold(v___action_boxed_158_, v___disturbance_boxed_159_);
v_r_161_ = lean_box(v_res_160_);
return v_r_161_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_afterHold___redArg(){
_start:
{
uint8_t v___x_163_; 
v___x_163_ = 1;
return v___x_163_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_afterHold___redArg___boxed(lean_object* v___dummy_164_){
_start:
{
uint8_t v_res_165_; lean_object* v_r_166_; 
v_res_165_ = lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_afterHold___redArg();
v_r_166_ = lean_box(v_res_165_);
return v_r_166_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_afterHold(lean_object* v___stream_167_, lean_object* v_x_168_){
_start:
{
uint8_t v___x_169_; 
v___x_169_ = 1;
return v___x_169_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_afterHold___boxed(lean_object* v___stream_170_, lean_object* v_x_171_){
_start:
{
uint8_t v_res_172_; lean_object* v_r_173_; 
v_res_172_ = lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_afterHold(v___stream_170_, v_x_171_);
lean_dec(v_x_171_);
lean_dec_ref(v___stream_170_);
v_r_173_ = lean_box(v_res_172_);
return v_r_173_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_deliversService(uint8_t v_held_174_){
_start:
{
if (v_held_174_ == 0)
{
uint8_t v___x_175_; 
v___x_175_ = 1;
return v___x_175_;
}
else
{
uint8_t v___x_176_; 
v___x_176_ = 0;
return v___x_176_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_deliversService___boxed(lean_object* v_held_177_){
_start:
{
uint8_t v_held_boxed_178_; uint8_t v_res_179_; lean_object* v_r_180_; 
v_held_boxed_178_ = lean_unbox(v_held_177_);
v_res_179_ = lp_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects_deliversService(v_held_boxed_178_);
v_r_180_ = lean_box(v_res_179_);
return v_r_180_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRInFlightQuiescence(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRJsonTraceChecker(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRWatchdogLatencyEffects(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRInFlightQuiescence(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_physical__bridges_PhysicalBridges_IRJsonTraceChecker(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
