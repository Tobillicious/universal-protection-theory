// Lean compiler output
// Module: PhysicalBridges.IRPhysicalAbstraction
// Imports: public import Init public meta import Init public import PhysicalBridges.IREventTimeBudget
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
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalStep___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalStep___redArg___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalStep(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalStep___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRPhysicalAbstraction_physicalRun_spec__0___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalRun___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalRun(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRPhysicalAbstraction_physicalRun_spec__0(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalStep___redArg(lean_object* v_effect_1_, lean_object* v_value_2_, lean_object* v_e_3_){
_start:
{
lean_object* v___x_4_; lean_object* v___x_5_; 
v___x_4_ = lean_apply_1(v_effect_1_, v_e_3_);
v___x_5_ = lean_nat_add(v_value_2_, v___x_4_);
lean_dec(v___x_4_);
return v___x_5_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalStep___redArg___boxed(lean_object* v_effect_6_, lean_object* v_value_7_, lean_object* v_e_8_){
_start:
{
lean_object* v_res_9_; 
v_res_9_ = lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalStep___redArg(v_effect_6_, v_value_7_, v_e_8_);
lean_dec(v_value_7_);
return v_res_9_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalStep(lean_object* v_E_10_, lean_object* v_effect_11_, lean_object* v_value_12_, lean_object* v_e_13_){
_start:
{
lean_object* v___x_14_; 
v___x_14_ = lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalStep___redArg(v_effect_11_, v_value_12_, v_e_13_);
return v___x_14_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalStep___boxed(lean_object* v_E_15_, lean_object* v_effect_16_, lean_object* v_value_17_, lean_object* v_e_18_){
_start:
{
lean_object* v_res_19_; 
v_res_19_ = lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalStep(v_E_15_, v_effect_16_, v_value_17_, v_e_18_);
lean_dec(v_value_17_);
return v_res_19_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRPhysicalAbstraction_physicalRun_spec__0___redArg(lean_object* v_effect_20_, lean_object* v_x_21_, lean_object* v_x_22_){
_start:
{
if (lean_obj_tag(v_x_22_) == 0)
{
lean_dec_ref(v_effect_20_);
return v_x_21_;
}
else
{
lean_object* v_head_23_; lean_object* v_tail_24_; lean_object* v___x_25_; 
v_head_23_ = lean_ctor_get(v_x_22_, 0);
lean_inc(v_head_23_);
v_tail_24_ = lean_ctor_get(v_x_22_, 1);
lean_inc(v_tail_24_);
lean_dec_ref_known(v_x_22_, 2);
lean_inc_ref(v_effect_20_);
v___x_25_ = lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalStep___redArg(v_effect_20_, v_x_21_, v_head_23_);
lean_dec(v_x_21_);
v_x_21_ = v___x_25_;
v_x_22_ = v_tail_24_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalRun___redArg(lean_object* v_effect_27_, lean_object* v_value_28_, lean_object* v_events_29_){
_start:
{
lean_object* v___x_30_; 
v___x_30_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRPhysicalAbstraction_physicalRun_spec__0___redArg(v_effect_27_, v_value_28_, v_events_29_);
return v___x_30_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRPhysicalAbstraction_physicalRun(lean_object* v_E_31_, lean_object* v_effect_32_, lean_object* v_value_33_, lean_object* v_events_34_){
_start:
{
lean_object* v___x_35_; 
v___x_35_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRPhysicalAbstraction_physicalRun_spec__0___redArg(v_effect_32_, v_value_33_, v_events_34_);
return v___x_35_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRPhysicalAbstraction_physicalRun_spec__0(lean_object* v_E_36_, lean_object* v_effect_37_, lean_object* v_x_38_, lean_object* v_x_39_){
_start:
{
lean_object* v___x_40_; 
v___x_40_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRPhysicalAbstraction_physicalRun_spec__0___redArg(v_effect_37_, v_x_38_, v_x_39_);
return v___x_40_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IREventTimeBudget(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRPhysicalAbstraction(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IREventTimeBudget(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
