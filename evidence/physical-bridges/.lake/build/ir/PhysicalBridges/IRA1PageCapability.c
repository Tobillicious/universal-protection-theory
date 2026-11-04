// Lean compiler output
// Module: PhysicalBridges.IRA1PageCapability
// Imports: public import Init public meta import Init public import PhysicalBridges.IRA1HostMediation
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
lean_object* lp_physical__bridges_PhysicalBridges_IRA1HostMediation_hostStep(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorIdx(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorElim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorElim(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_host_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_host_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_grant_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_grant_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_execute(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_execute___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRA1PageCapability_0__PhysicalBridges_IRA1PageCapability_execute_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRA1PageCapability_0__PhysicalBridges_IRA1PageCapability_execute_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1PageCapability_run_spec__0(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1PageCapability_run_spec__0___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_run(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_run___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_unsafeGrant(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorIdx(lean_object* v_x_1_){
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
lean_object* v___x_3_; 
v___x_3_ = lean_unsigned_to_nat(1u);
return v___x_3_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorIdx___boxed(lean_object* v_x_4_){
_start:
{
lean_object* v_res_5_; 
v_res_5_ = lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorIdx(v_x_4_);
lean_dec_ref(v_x_4_);
return v_res_5_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorElim___redArg(lean_object* v_t_6_, lean_object* v_k_7_){
_start:
{
if (lean_obj_tag(v_t_6_) == 0)
{
lean_object* v_event_8_; lean_object* v___x_9_; 
v_event_8_ = lean_ctor_get(v_t_6_, 0);
lean_inc_ref(v_event_8_);
lean_dec_ref_known(v_t_6_, 1);
v___x_9_ = lean_apply_1(v_k_7_, v_event_8_);
return v___x_9_;
}
else
{
lean_object* v_capability_10_; lean_object* v___x_11_; 
v_capability_10_ = lean_ctor_get(v_t_6_, 0);
lean_inc(v_capability_10_);
lean_dec_ref_known(v_t_6_, 1);
v___x_11_ = lean_apply_1(v_k_7_, v_capability_10_);
return v___x_11_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorElim(lean_object* v_motive_12_, lean_object* v_ctorIdx_13_, lean_object* v_t_14_, lean_object* v_h_15_, lean_object* v_k_16_){
_start:
{
lean_object* v___x_17_; 
v___x_17_ = lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorElim___redArg(v_t_14_, v_k_16_);
return v___x_17_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorElim___boxed(lean_object* v_motive_18_, lean_object* v_ctorIdx_19_, lean_object* v_t_20_, lean_object* v_h_21_, lean_object* v_k_22_){
_start:
{
lean_object* v_res_23_; 
v_res_23_ = lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorElim(v_motive_18_, v_ctorIdx_19_, v_t_20_, v_h_21_, v_k_22_);
lean_dec(v_ctorIdx_19_);
return v_res_23_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_host_elim___redArg(lean_object* v_t_24_, lean_object* v_host_25_){
_start:
{
lean_object* v___x_26_; 
v___x_26_ = lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorElim___redArg(v_t_24_, v_host_25_);
return v___x_26_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_host_elim(lean_object* v_motive_27_, lean_object* v_t_28_, lean_object* v_h_29_, lean_object* v_host_30_){
_start:
{
lean_object* v___x_31_; 
v___x_31_ = lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorElim___redArg(v_t_28_, v_host_30_);
return v___x_31_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_grant_elim___redArg(lean_object* v_t_32_, lean_object* v_grant_33_){
_start:
{
lean_object* v___x_34_; 
v___x_34_ = lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorElim___redArg(v_t_32_, v_grant_33_);
return v___x_34_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_grant_elim(lean_object* v_motive_35_, lean_object* v_t_36_, lean_object* v_h_37_, lean_object* v_grant_38_){
_start:
{
lean_object* v___x_39_; 
v___x_39_ = lp_physical__bridges_PhysicalBridges_IRA1PageCapability_PageEvent_ctorElim___redArg(v_t_36_, v_grant_38_);
return v___x_39_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_execute(lean_object* v_window_40_, lean_object* v_ceiling_41_, lean_object* v_s_42_, lean_object* v_x_43_){
_start:
{
if (lean_obj_tag(v_x_43_) == 0)
{
lean_object* v_event_44_; lean_object* v_host_45_; lean_object* v_permittedMask_46_; lean_object* v_installed_47_; lean_object* v___x_49_; uint8_t v_isShared_50_; uint8_t v_isSharedCheck_55_; 
v_event_44_ = lean_ctor_get(v_x_43_, 0);
lean_inc_ref(v_event_44_);
lean_dec_ref_known(v_x_43_, 1);
v_host_45_ = lean_ctor_get(v_s_42_, 0);
v_permittedMask_46_ = lean_ctor_get(v_s_42_, 1);
v_installed_47_ = lean_ctor_get(v_s_42_, 2);
v_isSharedCheck_55_ = !lean_is_exclusive(v_s_42_);
if (v_isSharedCheck_55_ == 0)
{
v___x_49_ = v_s_42_;
v_isShared_50_ = v_isSharedCheck_55_;
goto v_resetjp_48_;
}
else
{
lean_inc(v_installed_47_);
lean_inc(v_permittedMask_46_);
lean_inc(v_host_45_);
lean_dec(v_s_42_);
v___x_49_ = lean_box(0);
v_isShared_50_ = v_isSharedCheck_55_;
goto v_resetjp_48_;
}
v_resetjp_48_:
{
lean_object* v___x_51_; lean_object* v___x_53_; 
v___x_51_ = lp_physical__bridges_PhysicalBridges_IRA1HostMediation_hostStep(v_window_40_, v_ceiling_41_, v_host_45_, v_event_44_);
if (v_isShared_50_ == 0)
{
lean_ctor_set(v___x_49_, 0, v___x_51_);
v___x_53_ = v___x_49_;
goto v_reusejp_52_;
}
else
{
lean_object* v_reuseFailAlloc_54_; 
v_reuseFailAlloc_54_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v_reuseFailAlloc_54_, 0, v___x_51_);
lean_ctor_set(v_reuseFailAlloc_54_, 1, v_permittedMask_46_);
lean_ctor_set(v_reuseFailAlloc_54_, 2, v_installed_47_);
v___x_53_ = v_reuseFailAlloc_54_;
goto v_reusejp_52_;
}
v_reusejp_52_:
{
return v___x_53_;
}
}
}
else
{
lean_object* v_capability_56_; lean_object* v_host_57_; lean_object* v_permittedMask_58_; lean_object* v_installed_59_; lean_object* v___x_60_; uint8_t v___x_61_; 
lean_dec(v_window_40_);
v_capability_56_ = lean_ctor_get(v_x_43_, 0);
lean_inc_n(v_capability_56_, 2);
lean_dec_ref_known(v_x_43_, 1);
v_host_57_ = lean_ctor_get(v_s_42_, 0);
v_permittedMask_58_ = lean_ctor_get(v_s_42_, 1);
v_installed_59_ = lean_ctor_get(v_s_42_, 2);
lean_inc_ref(v_permittedMask_58_);
v___x_60_ = lean_apply_1(v_permittedMask_58_, v_capability_56_);
v___x_61_ = lean_unbox(v___x_60_);
if (v___x_61_ == 0)
{
lean_dec(v_capability_56_);
return v_s_42_;
}
else
{
lean_object* v___x_63_; uint8_t v_isShared_64_; uint8_t v_isSharedCheck_69_; 
lean_inc(v_installed_59_);
lean_inc_ref(v_permittedMask_58_);
lean_inc_ref(v_host_57_);
v_isSharedCheck_69_ = !lean_is_exclusive(v_s_42_);
if (v_isSharedCheck_69_ == 0)
{
lean_object* v_unused_70_; lean_object* v_unused_71_; lean_object* v_unused_72_; 
v_unused_70_ = lean_ctor_get(v_s_42_, 2);
lean_dec(v_unused_70_);
v_unused_71_ = lean_ctor_get(v_s_42_, 1);
lean_dec(v_unused_71_);
v_unused_72_ = lean_ctor_get(v_s_42_, 0);
lean_dec(v_unused_72_);
v___x_63_ = v_s_42_;
v_isShared_64_ = v_isSharedCheck_69_;
goto v_resetjp_62_;
}
else
{
lean_dec(v_s_42_);
v___x_63_ = lean_box(0);
v_isShared_64_ = v_isSharedCheck_69_;
goto v_resetjp_62_;
}
v_resetjp_62_:
{
lean_object* v___x_65_; lean_object* v___x_67_; 
v___x_65_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_65_, 0, v_capability_56_);
lean_ctor_set(v___x_65_, 1, v_installed_59_);
if (v_isShared_64_ == 0)
{
lean_ctor_set(v___x_63_, 2, v___x_65_);
v___x_67_ = v___x_63_;
goto v_reusejp_66_;
}
else
{
lean_object* v_reuseFailAlloc_68_; 
v_reuseFailAlloc_68_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v_reuseFailAlloc_68_, 0, v_host_57_);
lean_ctor_set(v_reuseFailAlloc_68_, 1, v_permittedMask_58_);
lean_ctor_set(v_reuseFailAlloc_68_, 2, v___x_65_);
v___x_67_ = v_reuseFailAlloc_68_;
goto v_reusejp_66_;
}
v_reusejp_66_:
{
return v___x_67_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_execute___boxed(lean_object* v_window_73_, lean_object* v_ceiling_74_, lean_object* v_s_75_, lean_object* v_x_76_){
_start:
{
lean_object* v_res_77_; 
v_res_77_ = lp_physical__bridges_PhysicalBridges_IRA1PageCapability_execute(v_window_73_, v_ceiling_74_, v_s_75_, v_x_76_);
lean_dec(v_ceiling_74_);
return v_res_77_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRA1PageCapability_0__PhysicalBridges_IRA1PageCapability_execute_match__1_splitter___redArg(lean_object* v_x_78_, lean_object* v_h__1_79_, lean_object* v_h__2_80_){
_start:
{
if (lean_obj_tag(v_x_78_) == 0)
{
lean_object* v_event_81_; lean_object* v___x_82_; 
lean_dec(v_h__2_80_);
v_event_81_ = lean_ctor_get(v_x_78_, 0);
lean_inc_ref(v_event_81_);
lean_dec_ref_known(v_x_78_, 1);
v___x_82_ = lean_apply_1(v_h__1_79_, v_event_81_);
return v___x_82_;
}
else
{
lean_object* v_capability_83_; lean_object* v___x_84_; 
lean_dec(v_h__1_79_);
v_capability_83_ = lean_ctor_get(v_x_78_, 0);
lean_inc(v_capability_83_);
lean_dec_ref_known(v_x_78_, 1);
v___x_84_ = lean_apply_1(v_h__2_80_, v_capability_83_);
return v___x_84_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRA1PageCapability_0__PhysicalBridges_IRA1PageCapability_execute_match__1_splitter(lean_object* v_motive_85_, lean_object* v_x_86_, lean_object* v_h__1_87_, lean_object* v_h__2_88_){
_start:
{
if (lean_obj_tag(v_x_86_) == 0)
{
lean_object* v_event_89_; lean_object* v___x_90_; 
lean_dec(v_h__2_88_);
v_event_89_ = lean_ctor_get(v_x_86_, 0);
lean_inc_ref(v_event_89_);
lean_dec_ref_known(v_x_86_, 1);
v___x_90_ = lean_apply_1(v_h__1_87_, v_event_89_);
return v___x_90_;
}
else
{
lean_object* v_capability_91_; lean_object* v___x_92_; 
lean_dec(v_h__1_87_);
v_capability_91_ = lean_ctor_get(v_x_86_, 0);
lean_inc(v_capability_91_);
lean_dec_ref_known(v_x_86_, 1);
v___x_92_ = lean_apply_1(v_h__2_88_, v_capability_91_);
return v___x_92_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1PageCapability_run_spec__0(lean_object* v_window_93_, lean_object* v_ceiling_94_, lean_object* v_x_95_, lean_object* v_x_96_){
_start:
{
if (lean_obj_tag(v_x_96_) == 0)
{
lean_dec(v_window_93_);
return v_x_95_;
}
else
{
lean_object* v_head_97_; lean_object* v_tail_98_; lean_object* v___x_99_; 
v_head_97_ = lean_ctor_get(v_x_96_, 0);
lean_inc(v_head_97_);
v_tail_98_ = lean_ctor_get(v_x_96_, 1);
lean_inc(v_tail_98_);
lean_dec_ref_known(v_x_96_, 2);
lean_inc(v_window_93_);
v___x_99_ = lp_physical__bridges_PhysicalBridges_IRA1PageCapability_execute(v_window_93_, v_ceiling_94_, v_x_95_, v_head_97_);
v_x_95_ = v___x_99_;
v_x_96_ = v_tail_98_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1PageCapability_run_spec__0___boxed(lean_object* v_window_101_, lean_object* v_ceiling_102_, lean_object* v_x_103_, lean_object* v_x_104_){
_start:
{
lean_object* v_res_105_; 
v_res_105_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1PageCapability_run_spec__0(v_window_101_, v_ceiling_102_, v_x_103_, v_x_104_);
lean_dec(v_ceiling_102_);
return v_res_105_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_run(lean_object* v_window_106_, lean_object* v_ceiling_107_, lean_object* v_s_108_, lean_object* v_events_109_){
_start:
{
lean_object* v___x_110_; 
v___x_110_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1PageCapability_run_spec__0(v_window_106_, v_ceiling_107_, v_s_108_, v_events_109_);
return v___x_110_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_run___boxed(lean_object* v_window_111_, lean_object* v_ceiling_112_, lean_object* v_s_113_, lean_object* v_events_114_){
_start:
{
lean_object* v_res_115_; 
v_res_115_ = lp_physical__bridges_PhysicalBridges_IRA1PageCapability_run(v_window_111_, v_ceiling_112_, v_s_113_, v_events_114_);
lean_dec(v_ceiling_112_);
return v_res_115_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PageCapability_unsafeGrant(lean_object* v_s_116_, lean_object* v_cap_117_){
_start:
{
lean_object* v_host_118_; lean_object* v_permittedMask_119_; lean_object* v_installed_120_; lean_object* v___x_122_; uint8_t v_isShared_123_; uint8_t v_isSharedCheck_128_; 
v_host_118_ = lean_ctor_get(v_s_116_, 0);
v_permittedMask_119_ = lean_ctor_get(v_s_116_, 1);
v_installed_120_ = lean_ctor_get(v_s_116_, 2);
v_isSharedCheck_128_ = !lean_is_exclusive(v_s_116_);
if (v_isSharedCheck_128_ == 0)
{
v___x_122_ = v_s_116_;
v_isShared_123_ = v_isSharedCheck_128_;
goto v_resetjp_121_;
}
else
{
lean_inc(v_installed_120_);
lean_inc(v_permittedMask_119_);
lean_inc(v_host_118_);
lean_dec(v_s_116_);
v___x_122_ = lean_box(0);
v_isShared_123_ = v_isSharedCheck_128_;
goto v_resetjp_121_;
}
v_resetjp_121_:
{
lean_object* v___x_124_; lean_object* v___x_126_; 
v___x_124_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_124_, 0, v_cap_117_);
lean_ctor_set(v___x_124_, 1, v_installed_120_);
if (v_isShared_123_ == 0)
{
lean_ctor_set(v___x_122_, 2, v___x_124_);
v___x_126_ = v___x_122_;
goto v_reusejp_125_;
}
else
{
lean_object* v_reuseFailAlloc_127_; 
v_reuseFailAlloc_127_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v_reuseFailAlloc_127_, 0, v_host_118_);
lean_ctor_set(v_reuseFailAlloc_127_, 1, v_permittedMask_119_);
lean_ctor_set(v_reuseFailAlloc_127_, 2, v___x_124_);
v___x_126_ = v_reuseFailAlloc_127_;
goto v_reusejp_125_;
}
v_reusejp_125_:
{
return v___x_126_;
}
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRA1HostMediation(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRA1PageCapability(uint8_t builtin) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
lean_initialize();
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Init(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_physical__bridges_PhysicalBridges_IRA1HostMediation(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
