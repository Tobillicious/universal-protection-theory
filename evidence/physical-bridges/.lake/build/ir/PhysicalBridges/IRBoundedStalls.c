// Lean compiler output
// Module: PhysicalBridges.IRBoundedStalls
// Imports: public import Init public meta import Init public import PhysicalBridges.IRStutterObstruction
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
lean_object* l_List_lengthTR___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_filterTR_loop___at___00PhysicalBridges_IRBoundedStalls_progressCount_spec__0___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedStalls_progressCount___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedStalls_progressCount(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_filterTR_loop___at___00PhysicalBridges_IRBoundedStalls_progressCount_spec__0(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_filterTR_loop___at___00PhysicalBridges_IRBoundedStalls_stallCount_spec__0___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedStalls_stallCount___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedStalls_stallCount(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_filterTR_loop___at___00PhysicalBridges_IRBoundedStalls_stallCount_spec__0(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_filterTR_loop___at___00PhysicalBridges_IRBoundedStalls_progressCount_spec__0___redArg(lean_object* v_productive_1_, lean_object* v_a_2_, lean_object* v_a_3_){
_start:
{
if (lean_obj_tag(v_a_2_) == 0)
{
lean_object* v___x_4_; 
lean_dec_ref(v_productive_1_);
v___x_4_ = l_List_reverse___redArg(v_a_3_);
return v___x_4_;
}
else
{
lean_object* v_head_5_; lean_object* v_tail_6_; lean_object* v___x_8_; uint8_t v_isShared_9_; uint8_t v_isSharedCheck_17_; 
v_head_5_ = lean_ctor_get(v_a_2_, 0);
v_tail_6_ = lean_ctor_get(v_a_2_, 1);
v_isSharedCheck_17_ = !lean_is_exclusive(v_a_2_);
if (v_isSharedCheck_17_ == 0)
{
v___x_8_ = v_a_2_;
v_isShared_9_ = v_isSharedCheck_17_;
goto v_resetjp_7_;
}
else
{
lean_inc(v_tail_6_);
lean_inc(v_head_5_);
lean_dec(v_a_2_);
v___x_8_ = lean_box(0);
v_isShared_9_ = v_isSharedCheck_17_;
goto v_resetjp_7_;
}
v_resetjp_7_:
{
lean_object* v___x_10_; uint8_t v___x_11_; 
lean_inc_ref(v_productive_1_);
lean_inc(v_head_5_);
v___x_10_ = lean_apply_1(v_productive_1_, v_head_5_);
v___x_11_ = lean_unbox(v___x_10_);
if (v___x_11_ == 0)
{
lean_del_object(v___x_8_);
lean_dec(v_head_5_);
v_a_2_ = v_tail_6_;
goto _start;
}
else
{
lean_object* v___x_14_; 
if (v_isShared_9_ == 0)
{
lean_ctor_set(v___x_8_, 1, v_a_3_);
v___x_14_ = v___x_8_;
goto v_reusejp_13_;
}
else
{
lean_object* v_reuseFailAlloc_16_; 
v_reuseFailAlloc_16_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_16_, 0, v_head_5_);
lean_ctor_set(v_reuseFailAlloc_16_, 1, v_a_3_);
v___x_14_ = v_reuseFailAlloc_16_;
goto v_reusejp_13_;
}
v_reusejp_13_:
{
v_a_2_ = v_tail_6_;
v_a_3_ = v___x_14_;
goto _start;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedStalls_progressCount___redArg(lean_object* v_productive_18_, lean_object* v_trace_19_){
_start:
{
lean_object* v___x_20_; lean_object* v___x_21_; lean_object* v___x_22_; 
v___x_20_ = lean_box(0);
v___x_21_ = lp_physical__bridges_List_filterTR_loop___at___00PhysicalBridges_IRBoundedStalls_progressCount_spec__0___redArg(v_productive_18_, v_trace_19_, v___x_20_);
v___x_22_ = l_List_lengthTR___redArg(v___x_21_);
lean_dec(v___x_21_);
return v___x_22_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedStalls_progressCount(lean_object* v_D_23_, lean_object* v_productive_24_, lean_object* v_trace_25_){
_start:
{
lean_object* v___x_26_; 
v___x_26_ = lp_physical__bridges_PhysicalBridges_IRBoundedStalls_progressCount___redArg(v_productive_24_, v_trace_25_);
return v___x_26_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_filterTR_loop___at___00PhysicalBridges_IRBoundedStalls_progressCount_spec__0(lean_object* v_D_27_, lean_object* v_productive_28_, lean_object* v_a_29_, lean_object* v_a_30_){
_start:
{
lean_object* v___x_31_; 
v___x_31_ = lp_physical__bridges_List_filterTR_loop___at___00PhysicalBridges_IRBoundedStalls_progressCount_spec__0___redArg(v_productive_28_, v_a_29_, v_a_30_);
return v___x_31_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_filterTR_loop___at___00PhysicalBridges_IRBoundedStalls_stallCount_spec__0___redArg(lean_object* v_productive_32_, lean_object* v_a_33_, lean_object* v_a_34_){
_start:
{
if (lean_obj_tag(v_a_33_) == 0)
{
lean_object* v___x_35_; 
lean_dec_ref(v_productive_32_);
v___x_35_ = l_List_reverse___redArg(v_a_34_);
return v___x_35_;
}
else
{
lean_object* v_head_36_; lean_object* v_tail_37_; lean_object* v___x_39_; uint8_t v_isShared_40_; uint8_t v_isSharedCheck_48_; 
v_head_36_ = lean_ctor_get(v_a_33_, 0);
v_tail_37_ = lean_ctor_get(v_a_33_, 1);
v_isSharedCheck_48_ = !lean_is_exclusive(v_a_33_);
if (v_isSharedCheck_48_ == 0)
{
v___x_39_ = v_a_33_;
v_isShared_40_ = v_isSharedCheck_48_;
goto v_resetjp_38_;
}
else
{
lean_inc(v_tail_37_);
lean_inc(v_head_36_);
lean_dec(v_a_33_);
v___x_39_ = lean_box(0);
v_isShared_40_ = v_isSharedCheck_48_;
goto v_resetjp_38_;
}
v_resetjp_38_:
{
lean_object* v___x_41_; uint8_t v___x_42_; 
lean_inc_ref(v_productive_32_);
lean_inc(v_head_36_);
v___x_41_ = lean_apply_1(v_productive_32_, v_head_36_);
v___x_42_ = lean_unbox(v___x_41_);
if (v___x_42_ == 0)
{
lean_object* v___x_44_; 
if (v_isShared_40_ == 0)
{
lean_ctor_set(v___x_39_, 1, v_a_34_);
v___x_44_ = v___x_39_;
goto v_reusejp_43_;
}
else
{
lean_object* v_reuseFailAlloc_46_; 
v_reuseFailAlloc_46_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_46_, 0, v_head_36_);
lean_ctor_set(v_reuseFailAlloc_46_, 1, v_a_34_);
v___x_44_ = v_reuseFailAlloc_46_;
goto v_reusejp_43_;
}
v_reusejp_43_:
{
v_a_33_ = v_tail_37_;
v_a_34_ = v___x_44_;
goto _start;
}
}
else
{
lean_del_object(v___x_39_);
lean_dec(v_head_36_);
v_a_33_ = v_tail_37_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedStalls_stallCount___redArg(lean_object* v_productive_49_, lean_object* v_trace_50_){
_start:
{
lean_object* v___x_51_; lean_object* v___x_52_; lean_object* v___x_53_; 
v___x_51_ = lean_box(0);
v___x_52_ = lp_physical__bridges_List_filterTR_loop___at___00PhysicalBridges_IRBoundedStalls_stallCount_spec__0___redArg(v_productive_49_, v_trace_50_, v___x_51_);
v___x_53_ = l_List_lengthTR___redArg(v___x_52_);
lean_dec(v___x_52_);
return v___x_53_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedStalls_stallCount(lean_object* v_D_54_, lean_object* v_productive_55_, lean_object* v_trace_56_){
_start:
{
lean_object* v___x_57_; 
v___x_57_ = lp_physical__bridges_PhysicalBridges_IRBoundedStalls_stallCount___redArg(v_productive_55_, v_trace_56_);
return v___x_57_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_filterTR_loop___at___00PhysicalBridges_IRBoundedStalls_stallCount_spec__0(lean_object* v_D_58_, lean_object* v_productive_59_, lean_object* v_a_60_, lean_object* v_a_61_){
_start:
{
lean_object* v___x_62_; 
v___x_62_ = lp_physical__bridges_List_filterTR_loop___at___00PhysicalBridges_IRBoundedStalls_stallCount_spec__0___redArg(v_productive_59_, v_a_60_, v_a_61_);
return v___x_62_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRStutterObstruction(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRBoundedStalls(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRStutterObstruction(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
