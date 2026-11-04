// Lean compiler output
// Module: PhysicalBridges.IRViability
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
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRViability_run___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRViability_run(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRViability_toyStep___redArg(lean_object*, uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRViability_toyStep___redArg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRViability_toyStep(lean_object*, uint8_t, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRViability_toyStep___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRViability_run___redArg(lean_object* v_next_1_, lean_object* v_policy_2_, lean_object* v_x_3_, lean_object* v_x_4_){
_start:
{
if (lean_obj_tag(v_x_4_) == 0)
{
lean_dec(v_policy_2_);
lean_dec(v_next_1_);
return v_x_3_;
}
else
{
lean_object* v_head_5_; lean_object* v_tail_6_; lean_object* v___x_7_; lean_object* v___x_8_; 
v_head_5_ = lean_ctor_get(v_x_4_, 0);
lean_inc(v_head_5_);
v_tail_6_ = lean_ctor_get(v_x_4_, 1);
lean_inc(v_tail_6_);
lean_dec_ref_known(v_x_4_, 2);
lean_inc(v_policy_2_);
lean_inc(v_x_3_);
v___x_7_ = lean_apply_1(v_policy_2_, v_x_3_);
lean_inc(v_next_1_);
v___x_8_ = lean_apply_3(v_next_1_, v_x_3_, v___x_7_, v_head_5_);
v_x_3_ = v___x_8_;
v_x_4_ = v_tail_6_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRViability_run(lean_object* v_S_10_, lean_object* v_A_11_, lean_object* v_D_12_, lean_object* v_next_13_, lean_object* v_policy_14_, lean_object* v_x_15_, lean_object* v_x_16_){
_start:
{
lean_object* v___x_17_; 
v___x_17_ = lp_physical__bridges_PhysicalBridges_IRViability_run___redArg(v_next_13_, v_policy_14_, v_x_15_, v_x_16_);
return v___x_17_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRViability_toyStep___redArg(lean_object* v_s_18_, uint8_t v_a_19_){
_start:
{
lean_object* v___x_20_; uint8_t v___x_21_; 
v___x_20_ = lean_unsigned_to_nat(0u);
v___x_21_ = lean_nat_dec_eq(v_s_18_, v___x_20_);
if (v___x_21_ == 0)
{
lean_object* v___x_22_; 
v___x_22_ = lean_unsigned_to_nat(2u);
return v___x_22_;
}
else
{
if (v_a_19_ == 0)
{
return v___x_20_;
}
else
{
lean_object* v___x_23_; 
v___x_23_ = lean_unsigned_to_nat(1u);
return v___x_23_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRViability_toyStep___redArg___boxed(lean_object* v_s_24_, lean_object* v_a_25_){
_start:
{
uint8_t v_a_boxed_26_; lean_object* v_res_27_; 
v_a_boxed_26_ = lean_unbox(v_a_25_);
v_res_27_ = lp_physical__bridges_PhysicalBridges_IRViability_toyStep___redArg(v_s_24_, v_a_boxed_26_);
lean_dec(v_s_24_);
return v_res_27_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRViability_toyStep(lean_object* v_s_28_, uint8_t v_a_29_, lean_object* v_x_30_){
_start:
{
lean_object* v___x_31_; 
v___x_31_ = lp_physical__bridges_PhysicalBridges_IRViability_toyStep___redArg(v_s_28_, v_a_29_);
return v___x_31_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRViability_toyStep___boxed(lean_object* v_s_32_, lean_object* v_a_33_, lean_object* v_x_34_){
_start:
{
uint8_t v_a_boxed_35_; lean_object* v_res_36_; 
v_a_boxed_35_ = lean_unbox(v_a_33_);
v_res_36_ = lp_physical__bridges_PhysicalBridges_IRViability_toyStep(v_s_32_, v_a_boxed_35_, v_x_34_);
lean_dec(v_s_32_);
return v_res_36_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRViability(uint8_t builtin) {
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
