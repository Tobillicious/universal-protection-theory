// Lean compiler output
// Module: PhysicalBridges.IRStaleReadingAge
// Imports: public import Init public meta import Init public import PhysicalBridges.IRInterSampleEnvelope
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
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStaleReadingAge_steadilyRising(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStaleReadingAge_steadilyRising___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStaleReadingAge_steadilyRising(lean_object* v_t_1_){
_start:
{
lean_inc(v_t_1_);
return v_t_1_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRStaleReadingAge_steadilyRising___boxed(lean_object* v_t_2_){
_start:
{
lean_object* v_res_3_; 
v_res_3_ = lp_physical__bridges_PhysicalBridges_IRStaleReadingAge_steadilyRising(v_t_2_);
lean_dec(v_t_2_);
return v_res_3_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRInterSampleEnvelope(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRStaleReadingAge(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRInterSampleEnvelope(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
