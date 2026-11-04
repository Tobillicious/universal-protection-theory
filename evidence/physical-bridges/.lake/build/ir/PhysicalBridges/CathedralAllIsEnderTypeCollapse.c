// Lean compiler output
// Module: PhysicalBridges.CathedralAllIsEnderTypeCollapse
// Imports: public import Init public meta import Init public import PhysicalBridges.CathedralCapstoneJoins
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
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralAllIsEnderTypeCollapse_semanticDistinction___lam__0(uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralAllIsEnderTypeCollapse_semanticDistinction___lam__0___boxed(lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_CathedralAllIsEnderTypeCollapse_semanticDistinction___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_CathedralAllIsEnderTypeCollapse_semanticDistinction___lam__0___boxed, .m_arity = 1, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_CathedralAllIsEnderTypeCollapse_semanticDistinction___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_CathedralAllIsEnderTypeCollapse_semanticDistinction___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_CathedralAllIsEnderTypeCollapse_semanticDistinction = (const lean_object*)&lp_physical__bridges_PhysicalBridges_CathedralAllIsEnderTypeCollapse_semanticDistinction___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralAllIsEnderTypeCollapse_semanticDistinction___lam__0(uint8_t v_x_1_){
_start:
{
lean_object* v___x_2_; 
v___x_2_ = lean_box(0);
return v___x_2_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralAllIsEnderTypeCollapse_semanticDistinction___lam__0___boxed(lean_object* v_x_3_){
_start:
{
uint8_t v_x_8__boxed_4_; lean_object* v_res_5_; 
v_x_8__boxed_4_ = lean_unbox(v_x_3_);
v_res_5_ = lp_physical__bridges_PhysicalBridges_CathedralAllIsEnderTypeCollapse_semanticDistinction___lam__0(v_x_8__boxed_4_);
return v_res_5_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_CathedralCapstoneJoins(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_CathedralAllIsEnderTypeCollapse(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_CathedralCapstoneJoins(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
