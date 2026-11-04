// Lean compiler output
// Module: PhysicalBridges.IRBeliefTrace
// Imports: public import Init public meta import Init public import PhysicalBridges.IRBeliefViability
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
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_advance___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_advance(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_advance___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRBeliefTrace_run_spec__0___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_run___redArg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_run___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_run(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_run___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRBeliefTrace_run_spec__0(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRBeliefTrace_run_spec__0___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_advance___redArg(lean_object* v_next_1_, lean_object* v_policy_2_, lean_object* v_state_3_, lean_object* v_d_4_){
_start:
{
lean_object* v_a_5_; lean_object* v_t_6_; 
v_a_5_ = lean_apply_1(v_policy_2_, lean_box(0));
v_t_6_ = lean_apply_3(v_next_1_, v_state_3_, v_a_5_, v_d_4_);
return v_t_6_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_advance(lean_object* v_S_7_, lean_object* v_A_8_, lean_object* v_D_9_, lean_object* v_O_10_, lean_object* v_next_11_, lean_object* v_observe_12_, lean_object* v_policy_13_, lean_object* v_state_14_, lean_object* v_d_15_){
_start:
{
lean_object* v___x_16_; 
v___x_16_ = lp_physical__bridges_PhysicalBridges_IRBeliefTrace_advance___redArg(v_next_11_, v_policy_13_, v_state_14_, v_d_15_);
return v___x_16_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_advance___boxed(lean_object* v_S_17_, lean_object* v_A_18_, lean_object* v_D_19_, lean_object* v_O_20_, lean_object* v_next_21_, lean_object* v_observe_22_, lean_object* v_policy_23_, lean_object* v_state_24_, lean_object* v_d_25_){
_start:
{
lean_object* v_res_26_; 
v_res_26_ = lp_physical__bridges_PhysicalBridges_IRBeliefTrace_advance(v_S_17_, v_A_18_, v_D_19_, v_O_20_, v_next_21_, v_observe_22_, v_policy_23_, v_state_24_, v_d_25_);
lean_dec(v_observe_22_);
return v_res_26_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRBeliefTrace_run_spec__0___redArg(lean_object* v_next_27_, lean_object* v_policy_28_, lean_object* v_x_29_, lean_object* v_x_30_){
_start:
{
if (lean_obj_tag(v_x_30_) == 0)
{
lean_dec(v_policy_28_);
lean_dec(v_next_27_);
return v_x_29_;
}
else
{
lean_object* v_head_31_; lean_object* v_tail_32_; lean_object* v___x_33_; 
v_head_31_ = lean_ctor_get(v_x_30_, 0);
lean_inc(v_head_31_);
v_tail_32_ = lean_ctor_get(v_x_30_, 1);
lean_inc(v_tail_32_);
lean_dec_ref_known(v_x_30_, 2);
lean_inc(v_policy_28_);
lean_inc(v_next_27_);
v___x_33_ = lp_physical__bridges_PhysicalBridges_IRBeliefTrace_advance___redArg(v_next_27_, v_policy_28_, v_x_29_, v_head_31_);
v_x_29_ = v___x_33_;
v_x_30_ = v_tail_32_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_run___redArg(lean_object* v_next_35_, lean_object* v_observe_36_, lean_object* v_policy_37_, lean_object* v_start_38_, lean_object* v_trace_39_){
_start:
{
lean_object* v___x_40_; 
v___x_40_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRBeliefTrace_run_spec__0___redArg(v_next_35_, v_policy_37_, v_start_38_, v_trace_39_);
return v___x_40_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_run___redArg___boxed(lean_object* v_next_41_, lean_object* v_observe_42_, lean_object* v_policy_43_, lean_object* v_start_44_, lean_object* v_trace_45_){
_start:
{
lean_object* v_res_46_; 
v_res_46_ = lp_physical__bridges_PhysicalBridges_IRBeliefTrace_run___redArg(v_next_41_, v_observe_42_, v_policy_43_, v_start_44_, v_trace_45_);
lean_dec(v_observe_42_);
return v_res_46_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_run(lean_object* v_S_47_, lean_object* v_A_48_, lean_object* v_D_49_, lean_object* v_O_50_, lean_object* v_next_51_, lean_object* v_observe_52_, lean_object* v_policy_53_, lean_object* v_start_54_, lean_object* v_trace_55_){
_start:
{
lean_object* v___x_56_; 
v___x_56_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRBeliefTrace_run_spec__0___redArg(v_next_51_, v_policy_53_, v_start_54_, v_trace_55_);
return v___x_56_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBeliefTrace_run___boxed(lean_object* v_S_57_, lean_object* v_A_58_, lean_object* v_D_59_, lean_object* v_O_60_, lean_object* v_next_61_, lean_object* v_observe_62_, lean_object* v_policy_63_, lean_object* v_start_64_, lean_object* v_trace_65_){
_start:
{
lean_object* v_res_66_; 
v_res_66_ = lp_physical__bridges_PhysicalBridges_IRBeliefTrace_run(v_S_57_, v_A_58_, v_D_59_, v_O_60_, v_next_61_, v_observe_62_, v_policy_63_, v_start_64_, v_trace_65_);
lean_dec(v_observe_62_);
return v_res_66_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRBeliefTrace_run_spec__0(lean_object* v_S_67_, lean_object* v_D_68_, lean_object* v_A_69_, lean_object* v_O_70_, lean_object* v_next_71_, lean_object* v_observe_72_, lean_object* v_policy_73_, lean_object* v_x_74_, lean_object* v_x_75_){
_start:
{
lean_object* v___x_76_; 
v___x_76_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRBeliefTrace_run_spec__0___redArg(v_next_71_, v_policy_73_, v_x_74_, v_x_75_);
return v___x_76_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRBeliefTrace_run_spec__0___boxed(lean_object* v_S_77_, lean_object* v_D_78_, lean_object* v_A_79_, lean_object* v_O_80_, lean_object* v_next_81_, lean_object* v_observe_82_, lean_object* v_policy_83_, lean_object* v_x_84_, lean_object* v_x_85_){
_start:
{
lean_object* v_res_86_; 
v_res_86_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRBeliefTrace_run_spec__0(v_S_77_, v_D_78_, v_A_79_, v_O_80_, v_next_81_, v_observe_82_, v_policy_83_, v_x_84_, v_x_85_);
lean_dec(v_observe_82_);
return v_res_86_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRBeliefViability(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRBeliefTrace(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRBeliefViability(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
