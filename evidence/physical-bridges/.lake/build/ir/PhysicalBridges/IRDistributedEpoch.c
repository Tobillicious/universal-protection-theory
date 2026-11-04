// Lean compiler output
// Module: PhysicalBridges.IRDistributedEpoch
// Imports: public import Init public meta import Init public import PhysicalBridges.IRDurableEpoch
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
lean_object* l_List_reverse___redArg(lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRDurableEpoch_run_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_mapTR_loop___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1_spec__1(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1_spec__1___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDistributedEpoch_beforeTotal(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_mapTR_loop___at___00PhysicalBridges_IRDistributedEpoch_afterTotal_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDistributedEpoch_afterTotal(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_mapTR_loop___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__0(lean_object* v_a_1_, lean_object* v_a_2_){
_start:
{
if (lean_obj_tag(v_a_1_) == 0)
{
lean_object* v___x_3_; 
v___x_3_ = l_List_reverse___redArg(v_a_2_);
return v___x_3_;
}
else
{
lean_object* v_head_4_; lean_object* v_fst_5_; lean_object* v_live_6_; lean_object* v_tail_7_; lean_object* v___x_9_; uint8_t v_isShared_10_; uint8_t v_isSharedCheck_16_; 
v_head_4_ = lean_ctor_get(v_a_1_, 0);
v_fst_5_ = lean_ctor_get(v_head_4_, 0);
v_live_6_ = lean_ctor_get(v_fst_5_, 1);
lean_inc_ref(v_live_6_);
v_tail_7_ = lean_ctor_get(v_a_1_, 1);
v_isSharedCheck_16_ = !lean_is_exclusive(v_a_1_);
if (v_isSharedCheck_16_ == 0)
{
lean_object* v_unused_17_; 
v_unused_17_ = lean_ctor_get(v_a_1_, 0);
lean_dec(v_unused_17_);
v___x_9_ = v_a_1_;
v_isShared_10_ = v_isSharedCheck_16_;
goto v_resetjp_8_;
}
else
{
lean_inc(v_tail_7_);
lean_dec(v_a_1_);
v___x_9_ = lean_box(0);
v_isShared_10_ = v_isSharedCheck_16_;
goto v_resetjp_8_;
}
v_resetjp_8_:
{
lean_object* v_landed_11_; lean_object* v___x_13_; 
v_landed_11_ = lean_ctor_get(v_live_6_, 2);
lean_inc(v_landed_11_);
lean_dec_ref(v_live_6_);
if (v_isShared_10_ == 0)
{
lean_ctor_set(v___x_9_, 1, v_a_2_);
lean_ctor_set(v___x_9_, 0, v_landed_11_);
v___x_13_ = v___x_9_;
goto v_reusejp_12_;
}
else
{
lean_object* v_reuseFailAlloc_15_; 
v_reuseFailAlloc_15_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_15_, 0, v_landed_11_);
lean_ctor_set(v_reuseFailAlloc_15_, 1, v_a_2_);
v___x_13_ = v_reuseFailAlloc_15_;
goto v_reusejp_12_;
}
v_reusejp_12_:
{
v_a_1_ = v_tail_7_;
v_a_2_ = v___x_13_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1_spec__1(lean_object* v_init_18_, lean_object* v_x_19_){
_start:
{
if (lean_obj_tag(v_x_19_) == 0)
{
lean_inc(v_init_18_);
return v_init_18_;
}
else
{
lean_object* v_head_20_; lean_object* v_tail_21_; lean_object* v___x_22_; lean_object* v___x_23_; 
v_head_20_ = lean_ctor_get(v_x_19_, 0);
v_tail_21_ = lean_ctor_get(v_x_19_, 1);
v___x_22_ = lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1_spec__1(v_init_18_, v_tail_21_);
v___x_23_ = lean_nat_add(v_head_20_, v___x_22_);
lean_dec(v___x_22_);
return v___x_23_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1_spec__1___boxed(lean_object* v_init_24_, lean_object* v_x_25_){
_start:
{
lean_object* v_res_26_; 
v_res_26_ = lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1_spec__1(v_init_24_, v_x_25_);
lean_dec(v_x_25_);
lean_dec(v_init_24_);
return v_res_26_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1(lean_object* v_l_27_){
_start:
{
lean_object* v___x_28_; lean_object* v___x_29_; 
v___x_28_ = lean_unsigned_to_nat(0u);
v___x_29_ = lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1_spec__1(v___x_28_, v_l_27_);
return v___x_29_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1___boxed(lean_object* v_l_30_){
_start:
{
lean_object* v_res_31_; 
v_res_31_ = lp_physical__bridges_List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1(v_l_30_);
lean_dec(v_l_30_);
return v_res_31_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDistributedEpoch_beforeTotal(lean_object* v_devices_32_){
_start:
{
lean_object* v___x_33_; lean_object* v___x_34_; lean_object* v___x_35_; 
v___x_33_ = lean_box(0);
v___x_34_ = lp_physical__bridges_List_mapTR_loop___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__0(v_devices_32_, v___x_33_);
v___x_35_ = lp_physical__bridges_List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1(v___x_34_);
lean_dec(v___x_34_);
return v___x_35_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_mapTR_loop___at___00PhysicalBridges_IRDistributedEpoch_afterTotal_spec__0(lean_object* v_a_36_, lean_object* v_a_37_){
_start:
{
if (lean_obj_tag(v_a_36_) == 0)
{
lean_object* v___x_38_; 
v___x_38_ = l_List_reverse___redArg(v_a_37_);
return v___x_38_;
}
else
{
lean_object* v_head_39_; lean_object* v_tail_40_; lean_object* v___x_42_; uint8_t v_isShared_43_; uint8_t v_isSharedCheck_53_; 
v_head_39_ = lean_ctor_get(v_a_36_, 0);
v_tail_40_ = lean_ctor_get(v_a_36_, 1);
v_isSharedCheck_53_ = !lean_is_exclusive(v_a_36_);
if (v_isSharedCheck_53_ == 0)
{
v___x_42_ = v_a_36_;
v_isShared_43_ = v_isSharedCheck_53_;
goto v_resetjp_41_;
}
else
{
lean_inc(v_tail_40_);
lean_inc(v_head_39_);
lean_dec(v_a_36_);
v___x_42_ = lean_box(0);
v_isShared_43_ = v_isSharedCheck_53_;
goto v_resetjp_41_;
}
v_resetjp_41_:
{
lean_object* v_fst_44_; lean_object* v_snd_45_; lean_object* v___x_46_; lean_object* v_live_47_; lean_object* v_landed_48_; lean_object* v___x_50_; 
v_fst_44_ = lean_ctor_get(v_head_39_, 0);
lean_inc(v_fst_44_);
v_snd_45_ = lean_ctor_get(v_head_39_, 1);
lean_inc(v_snd_45_);
lean_dec(v_head_39_);
v___x_46_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRDurableEpoch_run_spec__0(v_fst_44_, v_snd_45_);
lean_dec(v_snd_45_);
v_live_47_ = lean_ctor_get(v___x_46_, 1);
lean_inc_ref(v_live_47_);
lean_dec_ref(v___x_46_);
v_landed_48_ = lean_ctor_get(v_live_47_, 2);
lean_inc(v_landed_48_);
lean_dec_ref(v_live_47_);
if (v_isShared_43_ == 0)
{
lean_ctor_set(v___x_42_, 1, v_a_37_);
lean_ctor_set(v___x_42_, 0, v_landed_48_);
v___x_50_ = v___x_42_;
goto v_reusejp_49_;
}
else
{
lean_object* v_reuseFailAlloc_52_; 
v_reuseFailAlloc_52_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_52_, 0, v_landed_48_);
lean_ctor_set(v_reuseFailAlloc_52_, 1, v_a_37_);
v___x_50_ = v_reuseFailAlloc_52_;
goto v_reusejp_49_;
}
v_reusejp_49_:
{
v_a_36_ = v_tail_40_;
v_a_37_ = v___x_50_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDistributedEpoch_afterTotal(lean_object* v_devices_54_){
_start:
{
lean_object* v___x_55_; lean_object* v___x_56_; lean_object* v___x_57_; 
v___x_55_ = lean_box(0);
v___x_56_ = lp_physical__bridges_List_mapTR_loop___at___00PhysicalBridges_IRDistributedEpoch_afterTotal_spec__0(v_devices_54_, v___x_55_);
v___x_57_ = lp_physical__bridges_List_sum___at___00PhysicalBridges_IRDistributedEpoch_beforeTotal_spec__1(v___x_56_);
lean_dec(v___x_56_);
return v___x_57_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRDurableEpoch(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRDistributedEpoch(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRDurableEpoch(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
