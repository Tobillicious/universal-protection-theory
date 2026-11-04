// Lean compiler output
// Module: PhysicalBridges.IRServiceProgress
// Imports: public import Init public meta import Init public import PhysicalBridges.IRBeliefTrace
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
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_frozenStep___redArg();
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_frozenStep___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_frozenStep(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_unfairNext___redArg(uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_unfairNext___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_unfairNext(lean_object*, uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_unfairNext___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_frozenStep___redArg(){
_start:
{
lean_object* v___x_2_; 
v___x_2_ = lean_box(0);
return v___x_2_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_frozenStep___redArg___boxed(lean_object* v___dummy_3_){
_start:
{
lean_object* v_res_4_; 
v_res_4_ = lp_physical__bridges_PhysicalBridges_IRServiceProgress_frozenStep___redArg();
return v_res_4_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_frozenStep(lean_object* v_x_5_, lean_object* v_x_6_){
_start:
{
lean_object* v___x_7_; 
v___x_7_ = lean_box(0);
return v___x_7_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_unfairNext___redArg(uint8_t v_d_8_){
_start:
{
if (v_d_8_ == 0)
{
lean_object* v___x_9_; 
v___x_9_ = lean_unsigned_to_nat(1u);
return v___x_9_;
}
else
{
lean_object* v___x_10_; 
v___x_10_ = lean_unsigned_to_nat(0u);
return v___x_10_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_unfairNext___redArg___boxed(lean_object* v_d_11_){
_start:
{
uint8_t v_d_boxed_12_; lean_object* v_res_13_; 
v_d_boxed_12_ = lean_unbox(v_d_11_);
v_res_13_ = lp_physical__bridges_PhysicalBridges_IRServiceProgress_unfairNext___redArg(v_d_boxed_12_);
return v_res_13_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_unfairNext(lean_object* v_x_14_, uint8_t v_d_15_){
_start:
{
lean_object* v___x_16_; 
v___x_16_ = lp_physical__bridges_PhysicalBridges_IRServiceProgress_unfairNext___redArg(v_d_15_);
return v___x_16_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRServiceProgress_unfairNext___boxed(lean_object* v_x_17_, lean_object* v_d_18_){
_start:
{
uint8_t v_d_boxed_19_; lean_object* v_res_20_; 
v_d_boxed_19_ = lean_unbox(v_d_18_);
v_res_20_ = lp_physical__bridges_PhysicalBridges_IRServiceProgress_unfairNext(v_x_17_, v_d_boxed_19_);
lean_dec(v_x_17_);
return v_res_20_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRBeliefTrace(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRServiceProgress(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRBeliefTrace(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
