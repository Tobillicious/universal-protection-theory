// Lean compiler output
// Module: PhysicalBridges.IRFinalApplyFence
// Imports: public import Init public meta import Init public import PhysicalBridges.IRInFlightQuiescence
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
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_hold(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_hold___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_deliver(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_deliverMany(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_unsafeDeliver(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_hold(lean_object* v_s_1_, lean_object* v_generation_2_){
_start:
{
lean_object* v_floor_3_; lean_object* v_pending_4_; lean_object* v_landed_5_; lean_object* v___x_6_; lean_object* v___x_7_; uint8_t v___x_8_; 
v_floor_3_ = lean_ctor_get(v_s_1_, 0);
v_pending_4_ = lean_ctor_get(v_s_1_, 1);
v_landed_5_ = lean_ctor_get(v_s_1_, 2);
v___x_6_ = lean_unsigned_to_nat(1u);
v___x_7_ = lean_nat_add(v_generation_2_, v___x_6_);
v___x_8_ = lean_nat_dec_le(v_floor_3_, v___x_7_);
if (v___x_8_ == 0)
{
lean_dec(v___x_7_);
return v_s_1_;
}
else
{
lean_object* v___x_10_; uint8_t v_isShared_11_; uint8_t v_isSharedCheck_15_; 
lean_inc(v_landed_5_);
lean_inc(v_pending_4_);
v_isSharedCheck_15_ = !lean_is_exclusive(v_s_1_);
if (v_isSharedCheck_15_ == 0)
{
lean_object* v_unused_16_; lean_object* v_unused_17_; lean_object* v_unused_18_; 
v_unused_16_ = lean_ctor_get(v_s_1_, 2);
lean_dec(v_unused_16_);
v_unused_17_ = lean_ctor_get(v_s_1_, 1);
lean_dec(v_unused_17_);
v_unused_18_ = lean_ctor_get(v_s_1_, 0);
lean_dec(v_unused_18_);
v___x_10_ = v_s_1_;
v_isShared_11_ = v_isSharedCheck_15_;
goto v_resetjp_9_;
}
else
{
lean_dec(v_s_1_);
v___x_10_ = lean_box(0);
v_isShared_11_ = v_isSharedCheck_15_;
goto v_resetjp_9_;
}
v_resetjp_9_:
{
lean_object* v___x_13_; 
if (v_isShared_11_ == 0)
{
lean_ctor_set(v___x_10_, 0, v___x_7_);
v___x_13_ = v___x_10_;
goto v_reusejp_12_;
}
else
{
lean_object* v_reuseFailAlloc_14_; 
v_reuseFailAlloc_14_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v_reuseFailAlloc_14_, 0, v___x_7_);
lean_ctor_set(v_reuseFailAlloc_14_, 1, v_pending_4_);
lean_ctor_set(v_reuseFailAlloc_14_, 2, v_landed_5_);
v___x_13_ = v_reuseFailAlloc_14_;
goto v_reusejp_12_;
}
v_reusejp_12_:
{
return v___x_13_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_hold___boxed(lean_object* v_s_19_, lean_object* v_generation_20_){
_start:
{
lean_object* v_res_21_; 
v_res_21_ = lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_hold(v_s_19_, v_generation_20_);
lean_dec(v_generation_20_);
return v_res_21_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_deliver(lean_object* v_s_22_){
_start:
{
lean_object* v_pending_23_; 
v_pending_23_ = lean_ctor_get(v_s_22_, 1);
if (lean_obj_tag(v_pending_23_) == 0)
{
return v_s_22_;
}
else
{
lean_object* v_head_24_; lean_object* v_floor_25_; lean_object* v_landed_26_; lean_object* v___x_28_; uint8_t v_isShared_29_; uint8_t v_isSharedCheck_41_; 
lean_inc_ref(v_pending_23_);
v_head_24_ = lean_ctor_get(v_pending_23_, 0);
lean_inc(v_head_24_);
v_floor_25_ = lean_ctor_get(v_s_22_, 0);
v_landed_26_ = lean_ctor_get(v_s_22_, 2);
v_isSharedCheck_41_ = !lean_is_exclusive(v_s_22_);
if (v_isSharedCheck_41_ == 0)
{
lean_object* v_unused_42_; 
v_unused_42_ = lean_ctor_get(v_s_22_, 1);
lean_dec(v_unused_42_);
v___x_28_ = v_s_22_;
v_isShared_29_ = v_isSharedCheck_41_;
goto v_resetjp_27_;
}
else
{
lean_inc(v_landed_26_);
lean_inc(v_floor_25_);
lean_dec(v_s_22_);
v___x_28_ = lean_box(0);
v_isShared_29_ = v_isSharedCheck_41_;
goto v_resetjp_27_;
}
v_resetjp_27_:
{
lean_object* v_tail_30_; lean_object* v_fst_31_; lean_object* v_snd_32_; uint8_t v___x_33_; 
v_tail_30_ = lean_ctor_get(v_pending_23_, 1);
lean_inc(v_tail_30_);
lean_dec_ref_known(v_pending_23_, 2);
v_fst_31_ = lean_ctor_get(v_head_24_, 0);
lean_inc(v_fst_31_);
v_snd_32_ = lean_ctor_get(v_head_24_, 1);
lean_inc(v_snd_32_);
lean_dec(v_head_24_);
v___x_33_ = lean_nat_dec_le(v_floor_25_, v_fst_31_);
lean_dec(v_fst_31_);
if (v___x_33_ == 0)
{
lean_object* v___x_35_; 
lean_dec(v_snd_32_);
if (v_isShared_29_ == 0)
{
lean_ctor_set(v___x_28_, 1, v_tail_30_);
v___x_35_ = v___x_28_;
goto v_reusejp_34_;
}
else
{
lean_object* v_reuseFailAlloc_36_; 
v_reuseFailAlloc_36_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v_reuseFailAlloc_36_, 0, v_floor_25_);
lean_ctor_set(v_reuseFailAlloc_36_, 1, v_tail_30_);
lean_ctor_set(v_reuseFailAlloc_36_, 2, v_landed_26_);
v___x_35_ = v_reuseFailAlloc_36_;
goto v_reusejp_34_;
}
v_reusejp_34_:
{
return v___x_35_;
}
}
else
{
lean_object* v___x_37_; lean_object* v___x_39_; 
v___x_37_ = lean_nat_add(v_landed_26_, v_snd_32_);
lean_dec(v_snd_32_);
lean_dec(v_landed_26_);
if (v_isShared_29_ == 0)
{
lean_ctor_set(v___x_28_, 2, v___x_37_);
lean_ctor_set(v___x_28_, 1, v_tail_30_);
v___x_39_ = v___x_28_;
goto v_reusejp_38_;
}
else
{
lean_object* v_reuseFailAlloc_40_; 
v_reuseFailAlloc_40_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v_reuseFailAlloc_40_, 0, v_floor_25_);
lean_ctor_set(v_reuseFailAlloc_40_, 1, v_tail_30_);
lean_ctor_set(v_reuseFailAlloc_40_, 2, v___x_37_);
v___x_39_ = v_reuseFailAlloc_40_;
goto v_reusejp_38_;
}
v_reusejp_38_:
{
return v___x_39_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_deliverMany(lean_object* v_x_43_, lean_object* v_x_44_){
_start:
{
lean_object* v_zero_45_; uint8_t v_isZero_46_; 
v_zero_45_ = lean_unsigned_to_nat(0u);
v_isZero_46_ = lean_nat_dec_eq(v_x_43_, v_zero_45_);
if (v_isZero_46_ == 1)
{
lean_dec(v_x_43_);
return v_x_44_;
}
else
{
lean_object* v_one_47_; lean_object* v_n_48_; lean_object* v___x_49_; 
v_one_47_ = lean_unsigned_to_nat(1u);
v_n_48_ = lean_nat_sub(v_x_43_, v_one_47_);
lean_dec(v_x_43_);
v___x_49_ = lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_deliver(v_x_44_);
v_x_43_ = v_n_48_;
v_x_44_ = v___x_49_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_unsafeDeliver(lean_object* v_s_51_){
_start:
{
lean_object* v_pending_52_; 
v_pending_52_ = lean_ctor_get(v_s_51_, 1);
if (lean_obj_tag(v_pending_52_) == 0)
{
return v_s_51_;
}
else
{
lean_object* v_head_53_; lean_object* v_floor_54_; lean_object* v_landed_55_; lean_object* v___x_57_; uint8_t v_isShared_58_; uint8_t v_isSharedCheck_65_; 
lean_inc_ref(v_pending_52_);
v_head_53_ = lean_ctor_get(v_pending_52_, 0);
lean_inc(v_head_53_);
v_floor_54_ = lean_ctor_get(v_s_51_, 0);
v_landed_55_ = lean_ctor_get(v_s_51_, 2);
v_isSharedCheck_65_ = !lean_is_exclusive(v_s_51_);
if (v_isSharedCheck_65_ == 0)
{
lean_object* v_unused_66_; 
v_unused_66_ = lean_ctor_get(v_s_51_, 1);
lean_dec(v_unused_66_);
v___x_57_ = v_s_51_;
v_isShared_58_ = v_isSharedCheck_65_;
goto v_resetjp_56_;
}
else
{
lean_inc(v_landed_55_);
lean_inc(v_floor_54_);
lean_dec(v_s_51_);
v___x_57_ = lean_box(0);
v_isShared_58_ = v_isSharedCheck_65_;
goto v_resetjp_56_;
}
v_resetjp_56_:
{
lean_object* v_tail_59_; lean_object* v_snd_60_; lean_object* v___x_61_; lean_object* v___x_63_; 
v_tail_59_ = lean_ctor_get(v_pending_52_, 1);
lean_inc(v_tail_59_);
lean_dec_ref_known(v_pending_52_, 2);
v_snd_60_ = lean_ctor_get(v_head_53_, 1);
lean_inc(v_snd_60_);
lean_dec(v_head_53_);
v___x_61_ = lean_nat_add(v_landed_55_, v_snd_60_);
lean_dec(v_snd_60_);
lean_dec(v_landed_55_);
if (v_isShared_58_ == 0)
{
lean_ctor_set(v___x_57_, 2, v___x_61_);
lean_ctor_set(v___x_57_, 1, v_tail_59_);
v___x_63_ = v___x_57_;
goto v_reusejp_62_;
}
else
{
lean_object* v_reuseFailAlloc_64_; 
v_reuseFailAlloc_64_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v_reuseFailAlloc_64_, 0, v_floor_54_);
lean_ctor_set(v_reuseFailAlloc_64_, 1, v_tail_59_);
lean_ctor_set(v_reuseFailAlloc_64_, 2, v___x_61_);
v___x_63_ = v_reuseFailAlloc_64_;
goto v_reusejp_62_;
}
v_reusejp_62_:
{
return v___x_63_;
}
}
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRInFlightQuiescence(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRFinalApplyFence(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRInFlightQuiescence(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
