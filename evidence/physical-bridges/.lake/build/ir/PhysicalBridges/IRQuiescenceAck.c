// Lean compiler output
// Module: PhysicalBridges.IRQuiescenceAck
// Imports: public import Init public meta import Init public import PhysicalBridges.IRDeferredEffects
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
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lp_physical__bridges_PhysicalBridges_IRDeferredEffects_deliver(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRQuiescenceAck_ack(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRQuiescenceAck_ack___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRQuiescenceAck_deliverMany(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRQuiescenceAck_0__PhysicalBridges_IRQuiescenceAck_ack_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRQuiescenceAck_0__PhysicalBridges_IRQuiescenceAck_ack_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRQuiescenceAck_ack(lean_object* v_s_1_){
_start:
{
lean_object* v_pending_2_; 
v_pending_2_ = lean_ctor_get(v_s_1_, 1);
if (lean_obj_tag(v_pending_2_) == 0)
{
uint8_t v___x_3_; 
v___x_3_ = 1;
return v___x_3_;
}
else
{
uint8_t v___x_4_; 
v___x_4_ = 0;
return v___x_4_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRQuiescenceAck_ack___boxed(lean_object* v_s_5_){
_start:
{
uint8_t v_res_6_; lean_object* v_r_7_; 
v_res_6_ = lp_physical__bridges_PhysicalBridges_IRQuiescenceAck_ack(v_s_5_);
lean_dec_ref(v_s_5_);
v_r_7_ = lean_box(v_res_6_);
return v_r_7_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRQuiescenceAck_deliverMany(lean_object* v_x_8_, lean_object* v_x_9_){
_start:
{
lean_object* v_zero_10_; uint8_t v_isZero_11_; 
v_zero_10_ = lean_unsigned_to_nat(0u);
v_isZero_11_ = lean_nat_dec_eq(v_x_8_, v_zero_10_);
if (v_isZero_11_ == 1)
{
lean_dec(v_x_8_);
return v_x_9_;
}
else
{
lean_object* v_one_12_; lean_object* v_n_13_; lean_object* v___x_14_; 
v_one_12_ = lean_unsigned_to_nat(1u);
v_n_13_ = lean_nat_sub(v_x_8_, v_one_12_);
lean_dec(v_x_8_);
v___x_14_ = lp_physical__bridges_PhysicalBridges_IRDeferredEffects_deliver(v_x_9_);
v_x_8_ = v_n_13_;
v_x_9_ = v___x_14_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRQuiescenceAck_0__PhysicalBridges_IRQuiescenceAck_ack_match__1_splitter___redArg(lean_object* v_x_16_, lean_object* v_h__1_17_, lean_object* v_h__2_18_){
_start:
{
if (lean_obj_tag(v_x_16_) == 0)
{
lean_object* v___x_19_; lean_object* v___x_20_; 
lean_dec(v_h__2_18_);
v___x_19_ = lean_box(0);
v___x_20_ = lean_apply_1(v_h__1_17_, v___x_19_);
return v___x_20_;
}
else
{
lean_object* v_head_21_; lean_object* v_tail_22_; lean_object* v___x_23_; 
lean_dec(v_h__1_17_);
v_head_21_ = lean_ctor_get(v_x_16_, 0);
lean_inc(v_head_21_);
v_tail_22_ = lean_ctor_get(v_x_16_, 1);
lean_inc(v_tail_22_);
lean_dec_ref_known(v_x_16_, 2);
v___x_23_ = lean_apply_2(v_h__2_18_, v_head_21_, v_tail_22_);
return v___x_23_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRQuiescenceAck_0__PhysicalBridges_IRQuiescenceAck_ack_match__1_splitter(lean_object* v_motive_24_, lean_object* v_x_25_, lean_object* v_h__1_26_, lean_object* v_h__2_27_){
_start:
{
if (lean_obj_tag(v_x_25_) == 0)
{
lean_object* v___x_28_; lean_object* v___x_29_; 
lean_dec(v_h__2_27_);
v___x_28_ = lean_box(0);
v___x_29_ = lean_apply_1(v_h__1_26_, v___x_28_);
return v___x_29_;
}
else
{
lean_object* v_head_30_; lean_object* v_tail_31_; lean_object* v___x_32_; 
lean_dec(v_h__1_26_);
v_head_30_ = lean_ctor_get(v_x_25_, 0);
lean_inc(v_head_30_);
v_tail_31_ = lean_ctor_get(v_x_25_, 1);
lean_inc(v_tail_31_);
lean_dec_ref_known(v_x_25_, 2);
v___x_32_ = lean_apply_2(v_h__2_27_, v_head_30_, v_tail_31_);
return v___x_32_;
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRDeferredEffects(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRQuiescenceAck(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRDeferredEffects(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
