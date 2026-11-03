// Lean compiler output
// Module: PhysicalBridges.IRTwoStageInfiniteLex
// Imports: public import Init public meta import Init public import PhysicalBridges.IRInfiniteFinitaryMaximality
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
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTwoStageInfiniteLex_independentChoice___redArg();
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTwoStageInfiniteLex_independentChoice___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTwoStageInfiniteLex_independentChoice(lean_object*, lean_object*);
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRTwoStageInfiniteLex_coupledChoice_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 0}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)(((size_t)(0) << 1) | 1))}};
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRTwoStageInfiniteLex_coupledChoice = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRTwoStageInfiniteLex_coupledChoice_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTwoStageInfiniteLex_independentChoice___redArg(){
_start:
{
lean_object* v___x_2_; 
v___x_2_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_2_, 0, lean_box(0));
lean_ctor_set(v___x_2_, 1, lean_box(0));
return v___x_2_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTwoStageInfiniteLex_independentChoice___redArg___boxed(lean_object* v___dummy_3_){
_start:
{
lean_object* v_res_4_; 
v_res_4_ = lp_physical__bridges_PhysicalBridges_IRTwoStageInfiniteLex_independentChoice___redArg();
return v_res_4_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRTwoStageInfiniteLex_independentChoice(lean_object* v_f0_5_, lean_object* v_f1_6_){
_start:
{
lean_object* v___x_7_; 
v___x_7_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_7_, 0, lean_box(0));
lean_ctor_set(v___x_7_, 1, lean_box(0));
return v___x_7_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRInfiniteFinitaryMaximality(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRTwoStageInfiniteLex(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRInfiniteFinitaryMaximality(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
