// Lean compiler output
// Module: PhysicalBridges.CathedralBridgeDischargeAssembly
// Imports: public import Init public meta import Init public import PhysicalBridges.CathedralFirstEventForcing public import PhysicalBridges.CathedralGuardianOnlyCapstone
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
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralBridgeDischargeAssembly_toSource___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralBridgeDischargeAssembly_toSource___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralBridgeDischargeAssembly_toSource(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralBridgeDischargeAssembly_toSource___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralBridgeDischargeAssembly_toSource___redArg(lean_object* v_m_1_){
_start:
{
lean_object* v_detLat_2_; lean_object* v_irrevDeadline_3_; lean_object* v_reqWork_4_; lean_object* v_availWork_5_; lean_object* v___x_6_; 
v_detLat_2_ = lean_ctor_get(v_m_1_, 2);
v_irrevDeadline_3_ = lean_ctor_get(v_m_1_, 3);
v_reqWork_4_ = lean_ctor_get(v_m_1_, 4);
v_availWork_5_ = lean_ctor_get(v_m_1_, 5);
lean_inc_ref(v_availWork_5_);
lean_inc_ref(v_reqWork_4_);
lean_inc_ref(v_irrevDeadline_3_);
lean_inc_ref(v_detLat_2_);
v___x_6_ = lean_alloc_ctor(0, 4, 0);
lean_ctor_set(v___x_6_, 0, v_detLat_2_);
lean_ctor_set(v___x_6_, 1, v_irrevDeadline_3_);
lean_ctor_set(v___x_6_, 2, v_reqWork_4_);
lean_ctor_set(v___x_6_, 3, v_availWork_5_);
return v___x_6_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralBridgeDischargeAssembly_toSource___redArg___boxed(lean_object* v_m_7_){
_start:
{
lean_object* v_res_8_; 
v_res_8_ = lp_physical__bridges_PhysicalBridges_CathedralBridgeDischargeAssembly_toSource___redArg(v_m_7_);
lean_dec_ref(v_m_7_);
return v_res_8_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralBridgeDischargeAssembly_toSource(lean_object* v_S_9_, lean_object* v_m_10_){
_start:
{
lean_object* v___x_11_; 
v___x_11_ = lp_physical__bridges_PhysicalBridges_CathedralBridgeDischargeAssembly_toSource___redArg(v_m_10_);
return v___x_11_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralBridgeDischargeAssembly_toSource___boxed(lean_object* v_S_12_, lean_object* v_m_13_){
_start:
{
lean_object* v_res_14_; 
v_res_14_ = lp_physical__bridges_PhysicalBridges_CathedralBridgeDischargeAssembly_toSource(v_S_12_, v_m_13_);
lean_dec_ref(v_m_13_);
return v_res_14_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_CathedralFirstEventForcing(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_CathedralGuardianOnlyCapstone(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_CathedralBridgeDischargeAssembly(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_CathedralFirstEventForcing(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_physical__bridges_PhysicalBridges_CathedralGuardianOnlyCapstone(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
