// Lean compiler output
// Module: PhysicalBridges.IRDeferredEffects
// Imports: public import Init public meta import Init public import ControllerFence
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
lean_object* lp_physical__bridges_UPTFence_apply(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDeferredEffects_hold(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDeferredEffects_hold___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDeferredEffects_deliver(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDeferredEffects_cancelPending(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDeferredEffects_hold(lean_object* v_s_1_, lean_object* v_g_2_){
_start:
{
lean_object* v_gate_3_; lean_object* v_pending_4_; lean_object* v_landed_5_; lean_object* v___x_7_; uint8_t v_isShared_8_; uint8_t v_isSharedCheck_16_; 
v_gate_3_ = lean_ctor_get(v_s_1_, 0);
v_pending_4_ = lean_ctor_get(v_s_1_, 1);
v_landed_5_ = lean_ctor_get(v_s_1_, 2);
v_isSharedCheck_16_ = !lean_is_exclusive(v_s_1_);
if (v_isSharedCheck_16_ == 0)
{
v___x_7_ = v_s_1_;
v_isShared_8_ = v_isSharedCheck_16_;
goto v_resetjp_6_;
}
else
{
lean_inc(v_landed_5_);
lean_inc(v_pending_4_);
lean_inc(v_gate_3_);
lean_dec(v_s_1_);
v___x_7_ = lean_box(0);
v_isShared_8_ = v_isSharedCheck_16_;
goto v_resetjp_6_;
}
v_resetjp_6_:
{
lean_object* v___x_9_; lean_object* v___x_10_; lean_object* v___x_11_; lean_object* v___x_12_; lean_object* v___x_14_; 
v___x_9_ = lean_unsigned_to_nat(1u);
v___x_10_ = lean_nat_add(v_g_2_, v___x_9_);
v___x_11_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_11_, 0, v___x_10_);
v___x_12_ = lp_physical__bridges_UPTFence_apply(v_gate_3_, v___x_11_);
lean_dec_ref_known(v___x_11_, 1);
if (v_isShared_8_ == 0)
{
lean_ctor_set(v___x_7_, 0, v___x_12_);
v___x_14_ = v___x_7_;
goto v_reusejp_13_;
}
else
{
lean_object* v_reuseFailAlloc_15_; 
v_reuseFailAlloc_15_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v_reuseFailAlloc_15_, 0, v___x_12_);
lean_ctor_set(v_reuseFailAlloc_15_, 1, v_pending_4_);
lean_ctor_set(v_reuseFailAlloc_15_, 2, v_landed_5_);
v___x_14_ = v_reuseFailAlloc_15_;
goto v_reusejp_13_;
}
v_reusejp_13_:
{
return v___x_14_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDeferredEffects_hold___boxed(lean_object* v_s_17_, lean_object* v_g_18_){
_start:
{
lean_object* v_res_19_; 
v_res_19_ = lp_physical__bridges_PhysicalBridges_IRDeferredEffects_hold(v_s_17_, v_g_18_);
lean_dec(v_g_18_);
return v_res_19_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDeferredEffects_deliver(lean_object* v_s_20_){
_start:
{
lean_object* v_pending_21_; 
v_pending_21_ = lean_ctor_get(v_s_20_, 1);
if (lean_obj_tag(v_pending_21_) == 0)
{
return v_s_20_;
}
else
{
lean_object* v_gate_22_; lean_object* v_landed_23_; lean_object* v___x_25_; uint8_t v_isShared_26_; uint8_t v_isSharedCheck_33_; 
lean_inc_ref(v_pending_21_);
v_gate_22_ = lean_ctor_get(v_s_20_, 0);
v_landed_23_ = lean_ctor_get(v_s_20_, 2);
v_isSharedCheck_33_ = !lean_is_exclusive(v_s_20_);
if (v_isSharedCheck_33_ == 0)
{
lean_object* v_unused_34_; 
v_unused_34_ = lean_ctor_get(v_s_20_, 1);
lean_dec(v_unused_34_);
v___x_25_ = v_s_20_;
v_isShared_26_ = v_isSharedCheck_33_;
goto v_resetjp_24_;
}
else
{
lean_inc(v_landed_23_);
lean_inc(v_gate_22_);
lean_dec(v_s_20_);
v___x_25_ = lean_box(0);
v_isShared_26_ = v_isSharedCheck_33_;
goto v_resetjp_24_;
}
v_resetjp_24_:
{
lean_object* v_head_27_; lean_object* v_tail_28_; lean_object* v___x_29_; lean_object* v___x_31_; 
v_head_27_ = lean_ctor_get(v_pending_21_, 0);
lean_inc(v_head_27_);
v_tail_28_ = lean_ctor_get(v_pending_21_, 1);
lean_inc(v_tail_28_);
lean_dec_ref_known(v_pending_21_, 2);
v___x_29_ = lean_nat_add(v_landed_23_, v_head_27_);
lean_dec(v_head_27_);
lean_dec(v_landed_23_);
if (v_isShared_26_ == 0)
{
lean_ctor_set(v___x_25_, 2, v___x_29_);
lean_ctor_set(v___x_25_, 1, v_tail_28_);
v___x_31_ = v___x_25_;
goto v_reusejp_30_;
}
else
{
lean_object* v_reuseFailAlloc_32_; 
v_reuseFailAlloc_32_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v_reuseFailAlloc_32_, 0, v_gate_22_);
lean_ctor_set(v_reuseFailAlloc_32_, 1, v_tail_28_);
lean_ctor_set(v_reuseFailAlloc_32_, 2, v___x_29_);
v___x_31_ = v_reuseFailAlloc_32_;
goto v_reusejp_30_;
}
v_reusejp_30_:
{
return v___x_31_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDeferredEffects_cancelPending(lean_object* v_s_35_){
_start:
{
lean_object* v_gate_36_; lean_object* v_landed_37_; lean_object* v___x_39_; uint8_t v_isShared_40_; uint8_t v_isSharedCheck_45_; 
v_gate_36_ = lean_ctor_get(v_s_35_, 0);
v_landed_37_ = lean_ctor_get(v_s_35_, 2);
v_isSharedCheck_45_ = !lean_is_exclusive(v_s_35_);
if (v_isSharedCheck_45_ == 0)
{
lean_object* v_unused_46_; 
v_unused_46_ = lean_ctor_get(v_s_35_, 1);
lean_dec(v_unused_46_);
v___x_39_ = v_s_35_;
v_isShared_40_ = v_isSharedCheck_45_;
goto v_resetjp_38_;
}
else
{
lean_inc(v_landed_37_);
lean_inc(v_gate_36_);
lean_dec(v_s_35_);
v___x_39_ = lean_box(0);
v_isShared_40_ = v_isSharedCheck_45_;
goto v_resetjp_38_;
}
v_resetjp_38_:
{
lean_object* v___x_41_; lean_object* v___x_43_; 
v___x_41_ = lean_box(0);
if (v_isShared_40_ == 0)
{
lean_ctor_set(v___x_39_, 1, v___x_41_);
v___x_43_ = v___x_39_;
goto v_reusejp_42_;
}
else
{
lean_object* v_reuseFailAlloc_44_; 
v_reuseFailAlloc_44_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v_reuseFailAlloc_44_, 0, v_gate_36_);
lean_ctor_set(v_reuseFailAlloc_44_, 1, v___x_41_);
lean_ctor_set(v_reuseFailAlloc_44_, 2, v_landed_37_);
v___x_43_ = v_reuseFailAlloc_44_;
goto v_reusejp_42_;
}
v_reusejp_42_:
{
return v___x_43_;
}
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_ControllerFence(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRDeferredEffects(uint8_t builtin) {
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
res = initialize_physical__bridges_ControllerFence(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
