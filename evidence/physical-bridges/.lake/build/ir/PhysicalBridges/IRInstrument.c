// Lean compiler output
// Module: PhysicalBridges.IRInstrument
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
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
uint8_t l_List_elem___at___00Lean_Meta_Occurrences_contains_spec__0(lean_object*, lean_object*);
lean_object* lp_physical__bridges_UPTFence_apply(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInstrument_execute(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInstrument_0__PhysicalBridges_IRInstrument_execute_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInstrument_0__PhysicalBridges_IRInstrument_execute_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRInstrument_run_spec__0(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInstrument_run(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInstrument_execute(lean_object* v_impact_1_, lean_object* v_s_2_, lean_object* v_x_3_){
_start:
{
if (lean_obj_tag(v_x_3_) == 2)
{
lean_object* v_target_4_; lean_object* v_g_5_; lean_object* v_physical_6_; lean_object* v_floor_7_; lean_object* v_minted_8_; uint8_t v___x_9_; 
v_target_4_ = lean_ctor_get(v_s_2_, 0);
v_g_5_ = lean_ctor_get(v_x_3_, 0);
lean_inc(v_g_5_);
v_physical_6_ = lean_ctor_get(v_s_2_, 1);
v_floor_7_ = lean_ctor_get(v_target_4_, 0);
v_minted_8_ = lean_ctor_get(v_target_4_, 1);
v___x_9_ = lean_nat_dec_le(v_floor_7_, v_g_5_);
if (v___x_9_ == 0)
{
lean_dec(v_g_5_);
lean_dec_ref_known(v_x_3_, 1);
lean_dec_ref(v_impact_1_);
return v_s_2_;
}
else
{
uint8_t v___x_10_; 
v___x_10_ = l_List_elem___at___00Lean_Meta_Occurrences_contains_spec__0(v_g_5_, v_minted_8_);
if (v___x_10_ == 0)
{
lean_dec(v_g_5_);
lean_dec_ref_known(v_x_3_, 1);
lean_dec_ref(v_impact_1_);
return v_s_2_;
}
else
{
lean_object* v___x_12_; uint8_t v_isShared_13_; uint8_t v_isSharedCheck_20_; 
lean_inc(v_physical_6_);
lean_inc_ref(v_target_4_);
v_isSharedCheck_20_ = !lean_is_exclusive(v_s_2_);
if (v_isSharedCheck_20_ == 0)
{
lean_object* v_unused_21_; lean_object* v_unused_22_; 
v_unused_21_ = lean_ctor_get(v_s_2_, 1);
lean_dec(v_unused_21_);
v_unused_22_ = lean_ctor_get(v_s_2_, 0);
lean_dec(v_unused_22_);
v___x_12_ = v_s_2_;
v_isShared_13_ = v_isSharedCheck_20_;
goto v_resetjp_11_;
}
else
{
lean_dec(v_s_2_);
v___x_12_ = lean_box(0);
v_isShared_13_ = v_isSharedCheck_20_;
goto v_resetjp_11_;
}
v_resetjp_11_:
{
lean_object* v___x_14_; lean_object* v___x_15_; lean_object* v___x_16_; lean_object* v___x_18_; 
v___x_14_ = lp_physical__bridges_UPTFence_apply(v_target_4_, v_x_3_);
lean_dec_ref_known(v_x_3_, 1);
v___x_15_ = lean_apply_1(v_impact_1_, v_g_5_);
v___x_16_ = lean_nat_add(v_physical_6_, v___x_15_);
lean_dec(v___x_15_);
lean_dec(v_physical_6_);
if (v_isShared_13_ == 0)
{
lean_ctor_set(v___x_12_, 1, v___x_16_);
lean_ctor_set(v___x_12_, 0, v___x_14_);
v___x_18_ = v___x_12_;
goto v_reusejp_17_;
}
else
{
lean_object* v_reuseFailAlloc_19_; 
v_reuseFailAlloc_19_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_19_, 0, v___x_14_);
lean_ctor_set(v_reuseFailAlloc_19_, 1, v___x_16_);
v___x_18_ = v_reuseFailAlloc_19_;
goto v_reusejp_17_;
}
v_reusejp_17_:
{
return v___x_18_;
}
}
}
}
}
else
{
lean_object* v_target_23_; lean_object* v_physical_24_; lean_object* v___x_26_; uint8_t v_isShared_27_; uint8_t v_isSharedCheck_32_; 
lean_dec_ref(v_impact_1_);
v_target_23_ = lean_ctor_get(v_s_2_, 0);
v_physical_24_ = lean_ctor_get(v_s_2_, 1);
v_isSharedCheck_32_ = !lean_is_exclusive(v_s_2_);
if (v_isSharedCheck_32_ == 0)
{
v___x_26_ = v_s_2_;
v_isShared_27_ = v_isSharedCheck_32_;
goto v_resetjp_25_;
}
else
{
lean_inc(v_physical_24_);
lean_inc(v_target_23_);
lean_dec(v_s_2_);
v___x_26_ = lean_box(0);
v_isShared_27_ = v_isSharedCheck_32_;
goto v_resetjp_25_;
}
v_resetjp_25_:
{
lean_object* v___x_28_; lean_object* v___x_30_; 
v___x_28_ = lp_physical__bridges_UPTFence_apply(v_target_23_, v_x_3_);
lean_dec_ref(v_x_3_);
if (v_isShared_27_ == 0)
{
lean_ctor_set(v___x_26_, 0, v___x_28_);
v___x_30_ = v___x_26_;
goto v_reusejp_29_;
}
else
{
lean_object* v_reuseFailAlloc_31_; 
v_reuseFailAlloc_31_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_31_, 0, v___x_28_);
lean_ctor_set(v_reuseFailAlloc_31_, 1, v_physical_24_);
v___x_30_ = v_reuseFailAlloc_31_;
goto v_reusejp_29_;
}
v_reusejp_29_:
{
return v___x_30_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInstrument_0__PhysicalBridges_IRInstrument_execute_match__1_splitter___redArg(lean_object* v_x_33_, lean_object* v_h__1_34_, lean_object* v_h__2_35_, lean_object* v_h__3_36_){
_start:
{
switch(lean_obj_tag(v_x_33_))
{
case 0:
{
lean_object* v_g_37_; lean_object* v___x_38_; 
lean_dec(v_h__3_36_);
lean_dec(v_h__2_35_);
v_g_37_ = lean_ctor_get(v_x_33_, 0);
lean_inc(v_g_37_);
lean_dec_ref_known(v_x_33_, 1);
v___x_38_ = lean_apply_1(v_h__1_34_, v_g_37_);
return v___x_38_;
}
case 1:
{
lean_object* v_g_39_; lean_object* v___x_40_; 
lean_dec(v_h__3_36_);
lean_dec(v_h__1_34_);
v_g_39_ = lean_ctor_get(v_x_33_, 0);
lean_inc(v_g_39_);
lean_dec_ref_known(v_x_33_, 1);
v___x_40_ = lean_apply_1(v_h__2_35_, v_g_39_);
return v___x_40_;
}
default: 
{
lean_object* v_g_41_; lean_object* v___x_42_; 
lean_dec(v_h__2_35_);
lean_dec(v_h__1_34_);
v_g_41_ = lean_ctor_get(v_x_33_, 0);
lean_inc(v_g_41_);
lean_dec_ref_known(v_x_33_, 1);
v___x_42_ = lean_apply_1(v_h__3_36_, v_g_41_);
return v___x_42_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInstrument_0__PhysicalBridges_IRInstrument_execute_match__1_splitter(lean_object* v_motive_43_, lean_object* v_x_44_, lean_object* v_h__1_45_, lean_object* v_h__2_46_, lean_object* v_h__3_47_){
_start:
{
switch(lean_obj_tag(v_x_44_))
{
case 0:
{
lean_object* v_g_48_; lean_object* v___x_49_; 
lean_dec(v_h__3_47_);
lean_dec(v_h__2_46_);
v_g_48_ = lean_ctor_get(v_x_44_, 0);
lean_inc(v_g_48_);
lean_dec_ref_known(v_x_44_, 1);
v___x_49_ = lean_apply_1(v_h__1_45_, v_g_48_);
return v___x_49_;
}
case 1:
{
lean_object* v_g_50_; lean_object* v___x_51_; 
lean_dec(v_h__3_47_);
lean_dec(v_h__1_45_);
v_g_50_ = lean_ctor_get(v_x_44_, 0);
lean_inc(v_g_50_);
lean_dec_ref_known(v_x_44_, 1);
v___x_51_ = lean_apply_1(v_h__2_46_, v_g_50_);
return v___x_51_;
}
default: 
{
lean_object* v_g_52_; lean_object* v___x_53_; 
lean_dec(v_h__2_46_);
lean_dec(v_h__1_45_);
v_g_52_ = lean_ctor_get(v_x_44_, 0);
lean_inc(v_g_52_);
lean_dec_ref_known(v_x_44_, 1);
v___x_53_ = lean_apply_1(v_h__3_47_, v_g_52_);
return v___x_53_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRInstrument_run_spec__0(lean_object* v_impact_54_, lean_object* v_x_55_, lean_object* v_x_56_){
_start:
{
if (lean_obj_tag(v_x_56_) == 0)
{
lean_dec_ref(v_impact_54_);
return v_x_55_;
}
else
{
lean_object* v_head_57_; lean_object* v_tail_58_; lean_object* v___x_59_; 
v_head_57_ = lean_ctor_get(v_x_56_, 0);
lean_inc(v_head_57_);
v_tail_58_ = lean_ctor_get(v_x_56_, 1);
lean_inc(v_tail_58_);
lean_dec_ref_known(v_x_56_, 2);
lean_inc_ref(v_impact_54_);
v___x_59_ = lp_physical__bridges_PhysicalBridges_IRInstrument_execute(v_impact_54_, v_x_55_, v_head_57_);
v_x_55_ = v___x_59_;
v_x_56_ = v_tail_58_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInstrument_run(lean_object* v_impact_61_, lean_object* v_s_62_, lean_object* v_trace_63_){
_start:
{
lean_object* v___x_64_; 
v___x_64_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRInstrument_run_spec__0(v_impact_61_, v_s_62_, v_trace_63_);
return v___x_64_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_ControllerFence(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRInstrument(uint8_t builtin) {
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
