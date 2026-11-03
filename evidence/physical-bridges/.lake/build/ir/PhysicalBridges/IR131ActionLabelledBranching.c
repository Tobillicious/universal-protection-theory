// Lean compiler output
// Module: PhysicalBridges.IR131ActionLabelledBranching
// Imports: public import Init public meta import Init public import PhysicalBridges.IR96DisturbanceSimulation
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
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR131_oscillation;
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IR131_oscillation(void){
_start:
{
lean_object* v___x_1_; 
v___x_1_ = lean_box(0);
return v___x_1_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IR96DisturbanceSimulation(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IR131ActionLabelledBranching(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IR96DisturbanceSimulation(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
lp_physical__bridges_PhysicalBridges_IR131_oscillation = _init_lp_physical__bridges_PhysicalBridges_IR131_oscillation();
lean_mark_persistent(lp_physical__bridges_PhysicalBridges_IR131_oscillation);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
