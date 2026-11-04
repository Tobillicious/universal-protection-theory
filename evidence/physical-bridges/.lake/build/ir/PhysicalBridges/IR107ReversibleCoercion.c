// Lean compiler output
// Module: PhysicalBridges.IR107ReversibleCoercion
// Imports: public import Init public meta import Init public import PhysicalBridges.IR105AuthorizationIndependence
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
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR107_swap(uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR107_swap___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR107_swap(uint8_t v_b_1_){
_start:
{
if (v_b_1_ == 0)
{
uint8_t v___x_2_; 
v___x_2_ = 1;
return v___x_2_;
}
else
{
uint8_t v___x_3_; 
v___x_3_ = 0;
return v___x_3_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR107_swap___boxed(lean_object* v_b_4_){
_start:
{
uint8_t v_b_boxed_5_; uint8_t v_res_6_; lean_object* v_r_7_; 
v_b_boxed_5_ = lean_unbox(v_b_4_);
v_res_6_ = lp_physical__bridges_PhysicalBridges_IR107_swap(v_b_boxed_5_);
v_r_7_ = lean_box(v_res_6_);
return v_r_7_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IR105AuthorizationIndependence(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IR107ReversibleCoercion(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IR105AuthorizationIndependence(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
