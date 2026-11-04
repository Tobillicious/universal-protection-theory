// Lean compiler output
// Module: PhysicalBridges.IR118InFlightBacklogBudget
// Imports: public import Init public meta import Init public import PhysicalBridges.IR117SourceInstallationAdapter
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
lean_object* lp_physical__bridges_List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1(lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR118_committedEffects(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR118_committedEffects___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR118_committedEffects(lean_object* v_s_1_){
_start:
{
lean_object* v_inFlight_2_; lean_object* v_pending_3_; lean_object* v_landed_4_; lean_object* v___x_5_; lean_object* v___x_6_; lean_object* v___x_7_; lean_object* v___x_8_; 
v_inFlight_2_ = lean_ctor_get(v_s_1_, 1);
v_pending_3_ = lean_ctor_get(v_s_1_, 2);
v_landed_4_ = lean_ctor_get(v_s_1_, 3);
v___x_5_ = lp_physical__bridges_List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1(v_inFlight_2_);
v___x_6_ = lean_nat_add(v_landed_4_, v___x_5_);
lean_dec(v___x_5_);
v___x_7_ = lp_physical__bridges_List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1(v_pending_3_);
v___x_8_ = lean_nat_add(v___x_6_, v___x_7_);
lean_dec(v___x_7_);
lean_dec(v___x_6_);
return v___x_8_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR118_committedEffects___boxed(lean_object* v_s_9_){
_start:
{
lean_object* v_res_10_; 
v_res_10_ = lp_physical__bridges_PhysicalBridges_IR118_committedEffects(v_s_9_);
lean_dec_ref(v_s_9_);
return v_res_10_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IR117SourceInstallationAdapter(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IR118InFlightBacklogBudget(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IR117SourceInstallationAdapter(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
