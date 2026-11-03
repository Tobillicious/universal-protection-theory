// Lean compiler output
// Module: PhysicalBridges.BCRDIdentityCharge
// Imports: public import Init public meta import Init public import PhysicalBridges.FrozenBCRDEvents
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
lean_object* lp_physical__bridges_PhysicalBridges_FrozenBCRDEvents_jointParity(lean_object*, lean_object*);
lean_object* lp_physical__bridges_PhysicalBridges_FrozenBCRDEvents_mul(lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* lp_physical__bridges_PhysicalBridges_FrozenBCRDEvents_trace(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDIdentityCharge_L(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDIdentityCharge_L(lean_object* v_rho_1_){
_start:
{
lean_object* v___x_2_; lean_object* v___x_3_; lean_object* v___x_4_; 
v___x_2_ = lean_alloc_closure((void*)(lp_physical__bridges_PhysicalBridges_FrozenBCRDEvents_jointParity), 2, 0);
v___x_3_ = lean_alloc_closure((void*)(lp_physical__bridges_PhysicalBridges_FrozenBCRDEvents_mul), 4, 2);
lean_closure_set(v___x_3_, 0, v_rho_1_);
lean_closure_set(v___x_3_, 1, v___x_2_);
v___x_4_ = lp_physical__bridges_PhysicalBridges_FrozenBCRDEvents_trace(v___x_3_);
return v___x_4_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_FrozenBCRDEvents(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_BCRDIdentityCharge(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_FrozenBCRDEvents(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
