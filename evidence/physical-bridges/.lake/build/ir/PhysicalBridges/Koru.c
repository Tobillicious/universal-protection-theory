// Lean compiler output
// Module: PhysicalBridges.Koru
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
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_Koru_reindexWeb___redArg();
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_Koru_reindexWeb___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_Koru_reindexWeb(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_Koru_reindexWeb___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_Koru_reindexWeb___redArg(){
_start:
{
lean_object* v___x_2_; 
v___x_2_ = lean_box(0);
return v___x_2_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_Koru_reindexWeb___redArg___boxed(lean_object* v___dummy_3_){
_start:
{
lean_object* v_res_4_; 
v_res_4_ = lp_physical__bridges_PhysicalBridges_Koru_reindexWeb___redArg();
return v_res_4_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_Koru_reindexWeb(lean_object* v_P_5_, lean_object* v_00_u03c3_6_, lean_object* v_w_7_){
_start:
{
lean_object* v___x_8_; 
v___x_8_ = lean_box(0);
return v___x_8_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_Koru_reindexWeb___boxed(lean_object* v_P_9_, lean_object* v_00_u03c3_10_, lean_object* v_w_11_){
_start:
{
lean_object* v_res_12_; 
v_res_12_ = lp_physical__bridges_PhysicalBridges_Koru_reindexWeb(v_P_9_, v_00_u03c3_10_, v_w_11_);
lean_dec_ref(v_00_u03c3_10_);
return v_res_12_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_Koru(uint8_t builtin) {
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
