// Lean compiler output
// Module: PhysicalBridges.IRFiniteProfileObstruction
// Imports: public import Init public meta import Init public import PhysicalBridges.IRProfileAudit
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
lean_object* lean_nat_add(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFiniteProfileObstruction_aboveEvery(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFiniteProfileObstruction_aboveEvery___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRFiniteProfileObstruction_0__PhysicalBridges_IRFiniteProfileObstruction_aboveEvery_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRFiniteProfileObstruction_0__PhysicalBridges_IRFiniteProfileObstruction_aboveEvery_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFiniteProfileObstruction_aboveEvery(lean_object* v_x_1_){
_start:
{
if (lean_obj_tag(v_x_1_) == 0)
{
lean_object* v___x_2_; 
v___x_2_ = lean_unsigned_to_nat(0u);
return v___x_2_;
}
else
{
lean_object* v_head_3_; lean_object* v_tail_4_; lean_object* v___x_5_; lean_object* v___x_6_; lean_object* v___x_7_; lean_object* v___x_8_; 
v_head_3_ = lean_ctor_get(v_x_1_, 0);
v_tail_4_ = lean_ctor_get(v_x_1_, 1);
v___x_5_ = lp_physical__bridges_PhysicalBridges_IRFiniteProfileObstruction_aboveEvery(v_tail_4_);
v___x_6_ = lean_nat_add(v_head_3_, v___x_5_);
lean_dec(v___x_5_);
v___x_7_ = lean_unsigned_to_nat(1u);
v___x_8_ = lean_nat_add(v___x_6_, v___x_7_);
lean_dec(v___x_6_);
return v___x_8_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFiniteProfileObstruction_aboveEvery___boxed(lean_object* v_x_9_){
_start:
{
lean_object* v_res_10_; 
v_res_10_ = lp_physical__bridges_PhysicalBridges_IRFiniteProfileObstruction_aboveEvery(v_x_9_);
lean_dec(v_x_9_);
return v_res_10_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRFiniteProfileObstruction_0__PhysicalBridges_IRFiniteProfileObstruction_aboveEvery_match__1_splitter___redArg(lean_object* v_x_11_, lean_object* v_h__1_12_, lean_object* v_h__2_13_){
_start:
{
if (lean_obj_tag(v_x_11_) == 0)
{
lean_object* v___x_14_; lean_object* v___x_15_; 
lean_dec(v_h__2_13_);
v___x_14_ = lean_box(0);
v___x_15_ = lean_apply_1(v_h__1_12_, v___x_14_);
return v___x_15_;
}
else
{
lean_object* v_head_16_; lean_object* v_tail_17_; lean_object* v___x_18_; 
lean_dec(v_h__1_12_);
v_head_16_ = lean_ctor_get(v_x_11_, 0);
lean_inc(v_head_16_);
v_tail_17_ = lean_ctor_get(v_x_11_, 1);
lean_inc(v_tail_17_);
lean_dec_ref_known(v_x_11_, 2);
v___x_18_ = lean_apply_2(v_h__2_13_, v_head_16_, v_tail_17_);
return v___x_18_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRFiniteProfileObstruction_0__PhysicalBridges_IRFiniteProfileObstruction_aboveEvery_match__1_splitter(lean_object* v_motive_19_, lean_object* v_x_20_, lean_object* v_h__1_21_, lean_object* v_h__2_22_){
_start:
{
if (lean_obj_tag(v_x_20_) == 0)
{
lean_object* v___x_23_; lean_object* v___x_24_; 
lean_dec(v_h__2_22_);
v___x_23_ = lean_box(0);
v___x_24_ = lean_apply_1(v_h__1_21_, v___x_23_);
return v___x_24_;
}
else
{
lean_object* v_head_25_; lean_object* v_tail_26_; lean_object* v___x_27_; 
lean_dec(v_h__1_21_);
v_head_25_ = lean_ctor_get(v_x_20_, 0);
lean_inc(v_head_25_);
v_tail_26_ = lean_ctor_get(v_x_20_, 1);
lean_inc(v_tail_26_);
lean_dec_ref_known(v_x_20_, 2);
v___x_27_ = lean_apply_2(v_h__2_22_, v_head_25_, v_tail_26_);
return v___x_27_;
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRProfileAudit(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRFiniteProfileObstruction(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRProfileAudit(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
