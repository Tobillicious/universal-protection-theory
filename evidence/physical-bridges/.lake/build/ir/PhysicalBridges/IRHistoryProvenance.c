// Lean compiler output
// Module: PhysicalBridges.IRHistoryProvenance
// Imports: public import Init public meta import Init public import PhysicalBridges.IRContinuation
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
lean_object* l_List_appendTR___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_physicalStep___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_physicalStep(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_recordedStep___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_recordedStep(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_physicalStep___redArg(lean_object* v_h_1_, lean_object* v_e_2_){
_start:
{
lean_object* v_origin_3_; lean_object* v_events_4_; lean_object* v___x_6_; uint8_t v_isShared_7_; uint8_t v_isSharedCheck_14_; 
v_origin_3_ = lean_ctor_get(v_h_1_, 0);
v_events_4_ = lean_ctor_get(v_h_1_, 1);
v_isSharedCheck_14_ = !lean_is_exclusive(v_h_1_);
if (v_isSharedCheck_14_ == 0)
{
v___x_6_ = v_h_1_;
v_isShared_7_ = v_isSharedCheck_14_;
goto v_resetjp_5_;
}
else
{
lean_inc(v_events_4_);
lean_inc(v_origin_3_);
lean_dec(v_h_1_);
v___x_6_ = lean_box(0);
v_isShared_7_ = v_isSharedCheck_14_;
goto v_resetjp_5_;
}
v_resetjp_5_:
{
lean_object* v___x_8_; lean_object* v___x_9_; lean_object* v___x_10_; lean_object* v___x_12_; 
v___x_8_ = lean_box(0);
v___x_9_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_9_, 0, v_e_2_);
lean_ctor_set(v___x_9_, 1, v___x_8_);
v___x_10_ = l_List_appendTR___redArg(v_events_4_, v___x_9_);
if (v_isShared_7_ == 0)
{
lean_ctor_set(v___x_6_, 1, v___x_10_);
v___x_12_ = v___x_6_;
goto v_reusejp_11_;
}
else
{
lean_object* v_reuseFailAlloc_13_; 
v_reuseFailAlloc_13_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_13_, 0, v_origin_3_);
lean_ctor_set(v_reuseFailAlloc_13_, 1, v___x_10_);
v___x_12_ = v_reuseFailAlloc_13_;
goto v_reusejp_11_;
}
v_reusejp_11_:
{
return v___x_12_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_physicalStep(lean_object* v_Origin_15_, lean_object* v_E_16_, lean_object* v_h_17_, lean_object* v_e_18_){
_start:
{
lean_object* v___x_19_; 
v___x_19_ = lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_physicalStep___redArg(v_h_17_, v_e_18_);
return v___x_19_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_recordedStep___redArg(lean_object* v_encode_20_, lean_object* v_r_21_, lean_object* v_e_22_){
_start:
{
lean_object* v_origin_23_; lean_object* v_events_24_; lean_object* v___x_26_; uint8_t v_isShared_27_; uint8_t v_isSharedCheck_35_; 
v_origin_23_ = lean_ctor_get(v_r_21_, 0);
v_events_24_ = lean_ctor_get(v_r_21_, 1);
v_isSharedCheck_35_ = !lean_is_exclusive(v_r_21_);
if (v_isSharedCheck_35_ == 0)
{
v___x_26_ = v_r_21_;
v_isShared_27_ = v_isSharedCheck_35_;
goto v_resetjp_25_;
}
else
{
lean_inc(v_events_24_);
lean_inc(v_origin_23_);
lean_dec(v_r_21_);
v___x_26_ = lean_box(0);
v_isShared_27_ = v_isSharedCheck_35_;
goto v_resetjp_25_;
}
v_resetjp_25_:
{
lean_object* v___x_28_; lean_object* v___x_29_; lean_object* v___x_30_; lean_object* v___x_31_; lean_object* v___x_33_; 
v___x_28_ = lean_apply_1(v_encode_20_, v_e_22_);
v___x_29_ = lean_box(0);
v___x_30_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_30_, 0, v___x_28_);
lean_ctor_set(v___x_30_, 1, v___x_29_);
v___x_31_ = l_List_appendTR___redArg(v_events_24_, v___x_30_);
if (v_isShared_27_ == 0)
{
lean_ctor_set(v___x_26_, 1, v___x_31_);
v___x_33_ = v___x_26_;
goto v_reusejp_32_;
}
else
{
lean_object* v_reuseFailAlloc_34_; 
v_reuseFailAlloc_34_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_34_, 0, v_origin_23_);
lean_ctor_set(v_reuseFailAlloc_34_, 1, v___x_31_);
v___x_33_ = v_reuseFailAlloc_34_;
goto v_reusejp_32_;
}
v_reusejp_32_:
{
return v___x_33_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_recordedStep(lean_object* v_Origin_36_, lean_object* v_E_37_, lean_object* v_Code_38_, lean_object* v_encode_39_, lean_object* v_r_40_, lean_object* v_e_41_){
_start:
{
lean_object* v___x_42_; 
v___x_42_ = lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_recordedStep___redArg(v_encode_39_, v_r_40_, v_e_41_);
return v___x_42_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRContinuation(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRHistoryProvenance(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRContinuation(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
