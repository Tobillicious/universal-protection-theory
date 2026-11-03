// Lean compiler output
// Module: PhysicalBridges.IRBoundedDrift
// Imports: public import Init public meta import Init public import PhysicalBridges.IRInstrument
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
lean_object* lp_physical__bridges_PhysicalBridges_IRInstrument_execute(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorIdx(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorElim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorElim(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_gate_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_gate_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_drift_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_drift_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_execute(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_gateEvents(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_driftSum(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_driftSum___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRBoundedDrift_run_spec__0(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_run(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRBoundedDrift_0__PhysicalBridges_IRBoundedDrift_execute_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRBoundedDrift_0__PhysicalBridges_IRBoundedDrift_execute_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRBoundedDrift_0__PhysicalBridges_IRBoundedDrift_gateEvents_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRBoundedDrift_0__PhysicalBridges_IRBoundedDrift_gateEvents_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_total(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_total___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorIdx(lean_object* v_x_1_){
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
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorIdx___boxed(lean_object* v_x_4_){
_start:
{
lean_object* v_res_5_; 
v_res_5_ = lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorIdx(v_x_4_);
lean_dec_ref(v_x_4_);
return v_res_5_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorElim___redArg(lean_object* v_t_6_, lean_object* v_k_7_){
_start:
{
if (lean_obj_tag(v_t_6_) == 0)
{
lean_object* v_e_8_; lean_object* v___x_9_; 
v_e_8_ = lean_ctor_get(v_t_6_, 0);
lean_inc_ref(v_e_8_);
lean_dec_ref_known(v_t_6_, 1);
v___x_9_ = lean_apply_1(v_k_7_, v_e_8_);
return v___x_9_;
}
else
{
lean_object* v_amount_10_; lean_object* v___x_11_; 
v_amount_10_ = lean_ctor_get(v_t_6_, 0);
lean_inc(v_amount_10_);
lean_dec_ref_known(v_t_6_, 1);
v___x_11_ = lean_apply_1(v_k_7_, v_amount_10_);
return v___x_11_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorElim(lean_object* v_motive_12_, lean_object* v_ctorIdx_13_, lean_object* v_t_14_, lean_object* v_h_15_, lean_object* v_k_16_){
_start:
{
lean_object* v___x_17_; 
v___x_17_ = lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorElim___redArg(v_t_14_, v_k_16_);
return v___x_17_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorElim___boxed(lean_object* v_motive_18_, lean_object* v_ctorIdx_19_, lean_object* v_t_20_, lean_object* v_h_21_, lean_object* v_k_22_){
_start:
{
lean_object* v_res_23_; 
v_res_23_ = lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorElim(v_motive_18_, v_ctorIdx_19_, v_t_20_, v_h_21_, v_k_22_);
lean_dec(v_ctorIdx_19_);
return v_res_23_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_gate_elim___redArg(lean_object* v_t_24_, lean_object* v_gate_25_){
_start:
{
lean_object* v___x_26_; 
v___x_26_ = lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorElim___redArg(v_t_24_, v_gate_25_);
return v___x_26_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_gate_elim(lean_object* v_motive_27_, lean_object* v_t_28_, lean_object* v_h_29_, lean_object* v_gate_30_){
_start:
{
lean_object* v___x_31_; 
v___x_31_ = lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorElim___redArg(v_t_28_, v_gate_30_);
return v___x_31_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_drift_elim___redArg(lean_object* v_t_32_, lean_object* v_drift_33_){
_start:
{
lean_object* v___x_34_; 
v___x_34_ = lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorElim___redArg(v_t_32_, v_drift_33_);
return v___x_34_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_drift_elim(lean_object* v_motive_35_, lean_object* v_t_36_, lean_object* v_h_37_, lean_object* v_drift_38_){
_start:
{
lean_object* v___x_39_; 
v___x_39_ = lp_physical__bridges_PhysicalBridges_IRBoundedDrift_Event_ctorElim___redArg(v_t_36_, v_drift_38_);
return v___x_39_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_execute(lean_object* v_impact_40_, lean_object* v_s_41_, lean_object* v_x_42_){
_start:
{
if (lean_obj_tag(v_x_42_) == 0)
{
lean_object* v_e_43_; lean_object* v_controlled_44_; lean_object* v_outside_45_; lean_object* v___x_47_; uint8_t v_isShared_48_; uint8_t v_isSharedCheck_53_; 
v_e_43_ = lean_ctor_get(v_x_42_, 0);
lean_inc_ref(v_e_43_);
lean_dec_ref_known(v_x_42_, 1);
v_controlled_44_ = lean_ctor_get(v_s_41_, 0);
v_outside_45_ = lean_ctor_get(v_s_41_, 1);
v_isSharedCheck_53_ = !lean_is_exclusive(v_s_41_);
if (v_isSharedCheck_53_ == 0)
{
v___x_47_ = v_s_41_;
v_isShared_48_ = v_isSharedCheck_53_;
goto v_resetjp_46_;
}
else
{
lean_inc(v_outside_45_);
lean_inc(v_controlled_44_);
lean_dec(v_s_41_);
v___x_47_ = lean_box(0);
v_isShared_48_ = v_isSharedCheck_53_;
goto v_resetjp_46_;
}
v_resetjp_46_:
{
lean_object* v___x_49_; lean_object* v___x_51_; 
v___x_49_ = lp_physical__bridges_PhysicalBridges_IRInstrument_execute(v_impact_40_, v_controlled_44_, v_e_43_);
if (v_isShared_48_ == 0)
{
lean_ctor_set(v___x_47_, 0, v___x_49_);
v___x_51_ = v___x_47_;
goto v_reusejp_50_;
}
else
{
lean_object* v_reuseFailAlloc_52_; 
v_reuseFailAlloc_52_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_52_, 0, v___x_49_);
lean_ctor_set(v_reuseFailAlloc_52_, 1, v_outside_45_);
v___x_51_ = v_reuseFailAlloc_52_;
goto v_reusejp_50_;
}
v_reusejp_50_:
{
return v___x_51_;
}
}
}
else
{
lean_object* v_amount_54_; lean_object* v_controlled_55_; lean_object* v_outside_56_; lean_object* v___x_58_; uint8_t v_isShared_59_; uint8_t v_isSharedCheck_64_; 
lean_dec_ref(v_impact_40_);
v_amount_54_ = lean_ctor_get(v_x_42_, 0);
lean_inc(v_amount_54_);
lean_dec_ref_known(v_x_42_, 1);
v_controlled_55_ = lean_ctor_get(v_s_41_, 0);
v_outside_56_ = lean_ctor_get(v_s_41_, 1);
v_isSharedCheck_64_ = !lean_is_exclusive(v_s_41_);
if (v_isSharedCheck_64_ == 0)
{
v___x_58_ = v_s_41_;
v_isShared_59_ = v_isSharedCheck_64_;
goto v_resetjp_57_;
}
else
{
lean_inc(v_outside_56_);
lean_inc(v_controlled_55_);
lean_dec(v_s_41_);
v___x_58_ = lean_box(0);
v_isShared_59_ = v_isSharedCheck_64_;
goto v_resetjp_57_;
}
v_resetjp_57_:
{
lean_object* v___x_60_; lean_object* v___x_62_; 
v___x_60_ = lean_nat_add(v_outside_56_, v_amount_54_);
lean_dec(v_amount_54_);
lean_dec(v_outside_56_);
if (v_isShared_59_ == 0)
{
lean_ctor_set(v___x_58_, 1, v___x_60_);
v___x_62_ = v___x_58_;
goto v_reusejp_61_;
}
else
{
lean_object* v_reuseFailAlloc_63_; 
v_reuseFailAlloc_63_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_63_, 0, v_controlled_55_);
lean_ctor_set(v_reuseFailAlloc_63_, 1, v___x_60_);
v___x_62_ = v_reuseFailAlloc_63_;
goto v_reusejp_61_;
}
v_reusejp_61_:
{
return v___x_62_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_gateEvents(lean_object* v_x_65_){
_start:
{
if (lean_obj_tag(v_x_65_) == 0)
{
lean_object* v___x_66_; 
v___x_66_ = lean_box(0);
return v___x_66_;
}
else
{
lean_object* v_head_67_; 
v_head_67_ = lean_ctor_get(v_x_65_, 0);
if (lean_obj_tag(v_head_67_) == 0)
{
lean_object* v_tail_68_; lean_object* v___x_70_; uint8_t v_isShared_71_; uint8_t v_isSharedCheck_77_; 
lean_inc_ref(v_head_67_);
v_tail_68_ = lean_ctor_get(v_x_65_, 1);
v_isSharedCheck_77_ = !lean_is_exclusive(v_x_65_);
if (v_isSharedCheck_77_ == 0)
{
lean_object* v_unused_78_; 
v_unused_78_ = lean_ctor_get(v_x_65_, 0);
lean_dec(v_unused_78_);
v___x_70_ = v_x_65_;
v_isShared_71_ = v_isSharedCheck_77_;
goto v_resetjp_69_;
}
else
{
lean_inc(v_tail_68_);
lean_dec(v_x_65_);
v___x_70_ = lean_box(0);
v_isShared_71_ = v_isSharedCheck_77_;
goto v_resetjp_69_;
}
v_resetjp_69_:
{
lean_object* v_e_72_; lean_object* v___x_73_; lean_object* v___x_75_; 
v_e_72_ = lean_ctor_get(v_head_67_, 0);
lean_inc_ref(v_e_72_);
lean_dec_ref_known(v_head_67_, 1);
v___x_73_ = lp_physical__bridges_PhysicalBridges_IRBoundedDrift_gateEvents(v_tail_68_);
if (v_isShared_71_ == 0)
{
lean_ctor_set(v___x_70_, 1, v___x_73_);
lean_ctor_set(v___x_70_, 0, v_e_72_);
v___x_75_ = v___x_70_;
goto v_reusejp_74_;
}
else
{
lean_object* v_reuseFailAlloc_76_; 
v_reuseFailAlloc_76_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_76_, 0, v_e_72_);
lean_ctor_set(v_reuseFailAlloc_76_, 1, v___x_73_);
v___x_75_ = v_reuseFailAlloc_76_;
goto v_reusejp_74_;
}
v_reusejp_74_:
{
return v___x_75_;
}
}
}
else
{
lean_object* v_tail_79_; 
v_tail_79_ = lean_ctor_get(v_x_65_, 1);
lean_inc(v_tail_79_);
lean_dec_ref_known(v_x_65_, 2);
v_x_65_ = v_tail_79_;
goto _start;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_driftSum(lean_object* v_x_81_){
_start:
{
if (lean_obj_tag(v_x_81_) == 0)
{
lean_object* v___x_82_; 
v___x_82_ = lean_unsigned_to_nat(0u);
return v___x_82_;
}
else
{
lean_object* v_head_83_; 
v_head_83_ = lean_ctor_get(v_x_81_, 0);
if (lean_obj_tag(v_head_83_) == 0)
{
lean_object* v_tail_84_; 
v_tail_84_ = lean_ctor_get(v_x_81_, 1);
v_x_81_ = v_tail_84_;
goto _start;
}
else
{
lean_object* v_tail_86_; lean_object* v_amount_87_; lean_object* v___x_88_; lean_object* v___x_89_; 
v_tail_86_ = lean_ctor_get(v_x_81_, 1);
v_amount_87_ = lean_ctor_get(v_head_83_, 0);
v___x_88_ = lp_physical__bridges_PhysicalBridges_IRBoundedDrift_driftSum(v_tail_86_);
v___x_89_ = lean_nat_add(v_amount_87_, v___x_88_);
lean_dec(v___x_88_);
return v___x_89_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_driftSum___boxed(lean_object* v_x_90_){
_start:
{
lean_object* v_res_91_; 
v_res_91_ = lp_physical__bridges_PhysicalBridges_IRBoundedDrift_driftSum(v_x_90_);
lean_dec(v_x_90_);
return v_res_91_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRBoundedDrift_run_spec__0(lean_object* v_impact_92_, lean_object* v_x_93_, lean_object* v_x_94_){
_start:
{
if (lean_obj_tag(v_x_94_) == 0)
{
lean_dec_ref(v_impact_92_);
return v_x_93_;
}
else
{
lean_object* v_head_95_; lean_object* v_tail_96_; lean_object* v___x_97_; 
v_head_95_ = lean_ctor_get(v_x_94_, 0);
lean_inc(v_head_95_);
v_tail_96_ = lean_ctor_get(v_x_94_, 1);
lean_inc(v_tail_96_);
lean_dec_ref_known(v_x_94_, 2);
lean_inc_ref(v_impact_92_);
v___x_97_ = lp_physical__bridges_PhysicalBridges_IRBoundedDrift_execute(v_impact_92_, v_x_93_, v_head_95_);
v_x_93_ = v___x_97_;
v_x_94_ = v_tail_96_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_run(lean_object* v_impact_99_, lean_object* v_s_100_, lean_object* v_trace_101_){
_start:
{
lean_object* v___x_102_; 
v___x_102_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRBoundedDrift_run_spec__0(v_impact_99_, v_s_100_, v_trace_101_);
return v___x_102_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRBoundedDrift_0__PhysicalBridges_IRBoundedDrift_execute_match__1_splitter___redArg(lean_object* v_x_103_, lean_object* v_h__1_104_, lean_object* v_h__2_105_){
_start:
{
if (lean_obj_tag(v_x_103_) == 0)
{
lean_object* v_e_106_; lean_object* v___x_107_; 
lean_dec(v_h__2_105_);
v_e_106_ = lean_ctor_get(v_x_103_, 0);
lean_inc_ref(v_e_106_);
lean_dec_ref_known(v_x_103_, 1);
v___x_107_ = lean_apply_1(v_h__1_104_, v_e_106_);
return v___x_107_;
}
else
{
lean_object* v_amount_108_; lean_object* v___x_109_; 
lean_dec(v_h__1_104_);
v_amount_108_ = lean_ctor_get(v_x_103_, 0);
lean_inc(v_amount_108_);
lean_dec_ref_known(v_x_103_, 1);
v___x_109_ = lean_apply_1(v_h__2_105_, v_amount_108_);
return v___x_109_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRBoundedDrift_0__PhysicalBridges_IRBoundedDrift_execute_match__1_splitter(lean_object* v_motive_110_, lean_object* v_x_111_, lean_object* v_h__1_112_, lean_object* v_h__2_113_){
_start:
{
if (lean_obj_tag(v_x_111_) == 0)
{
lean_object* v_e_114_; lean_object* v___x_115_; 
lean_dec(v_h__2_113_);
v_e_114_ = lean_ctor_get(v_x_111_, 0);
lean_inc_ref(v_e_114_);
lean_dec_ref_known(v_x_111_, 1);
v___x_115_ = lean_apply_1(v_h__1_112_, v_e_114_);
return v___x_115_;
}
else
{
lean_object* v_amount_116_; lean_object* v___x_117_; 
lean_dec(v_h__1_112_);
v_amount_116_ = lean_ctor_get(v_x_111_, 0);
lean_inc(v_amount_116_);
lean_dec_ref_known(v_x_111_, 1);
v___x_117_ = lean_apply_1(v_h__2_113_, v_amount_116_);
return v___x_117_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRBoundedDrift_0__PhysicalBridges_IRBoundedDrift_gateEvents_match__1_splitter___redArg(lean_object* v_x_118_, lean_object* v_h__1_119_, lean_object* v_h__2_120_, lean_object* v_h__3_121_){
_start:
{
if (lean_obj_tag(v_x_118_) == 0)
{
lean_object* v___x_122_; lean_object* v___x_123_; 
lean_dec(v_h__3_121_);
lean_dec(v_h__2_120_);
v___x_122_ = lean_box(0);
v___x_123_ = lean_apply_1(v_h__1_119_, v___x_122_);
return v___x_123_;
}
else
{
lean_object* v_head_124_; 
lean_dec(v_h__1_119_);
v_head_124_ = lean_ctor_get(v_x_118_, 0);
lean_inc(v_head_124_);
if (lean_obj_tag(v_head_124_) == 0)
{
lean_object* v_tail_125_; lean_object* v_e_126_; lean_object* v___x_127_; 
lean_dec(v_h__3_121_);
v_tail_125_ = lean_ctor_get(v_x_118_, 1);
lean_inc(v_tail_125_);
lean_dec_ref_known(v_x_118_, 2);
v_e_126_ = lean_ctor_get(v_head_124_, 0);
lean_inc_ref(v_e_126_);
lean_dec_ref_known(v_head_124_, 1);
v___x_127_ = lean_apply_2(v_h__2_120_, v_e_126_, v_tail_125_);
return v___x_127_;
}
else
{
lean_object* v_tail_128_; lean_object* v_amount_129_; lean_object* v___x_130_; 
lean_dec(v_h__2_120_);
v_tail_128_ = lean_ctor_get(v_x_118_, 1);
lean_inc(v_tail_128_);
lean_dec_ref_known(v_x_118_, 2);
v_amount_129_ = lean_ctor_get(v_head_124_, 0);
lean_inc(v_amount_129_);
lean_dec_ref_known(v_head_124_, 1);
v___x_130_ = lean_apply_2(v_h__3_121_, v_amount_129_, v_tail_128_);
return v___x_130_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRBoundedDrift_0__PhysicalBridges_IRBoundedDrift_gateEvents_match__1_splitter(lean_object* v_motive_131_, lean_object* v_x_132_, lean_object* v_h__1_133_, lean_object* v_h__2_134_, lean_object* v_h__3_135_){
_start:
{
if (lean_obj_tag(v_x_132_) == 0)
{
lean_object* v___x_136_; lean_object* v___x_137_; 
lean_dec(v_h__3_135_);
lean_dec(v_h__2_134_);
v___x_136_ = lean_box(0);
v___x_137_ = lean_apply_1(v_h__1_133_, v___x_136_);
return v___x_137_;
}
else
{
lean_object* v_head_138_; 
lean_dec(v_h__1_133_);
v_head_138_ = lean_ctor_get(v_x_132_, 0);
lean_inc(v_head_138_);
if (lean_obj_tag(v_head_138_) == 0)
{
lean_object* v_tail_139_; lean_object* v_e_140_; lean_object* v___x_141_; 
lean_dec(v_h__3_135_);
v_tail_139_ = lean_ctor_get(v_x_132_, 1);
lean_inc(v_tail_139_);
lean_dec_ref_known(v_x_132_, 2);
v_e_140_ = lean_ctor_get(v_head_138_, 0);
lean_inc_ref(v_e_140_);
lean_dec_ref_known(v_head_138_, 1);
v___x_141_ = lean_apply_2(v_h__2_134_, v_e_140_, v_tail_139_);
return v___x_141_;
}
else
{
lean_object* v_tail_142_; lean_object* v_amount_143_; lean_object* v___x_144_; 
lean_dec(v_h__2_134_);
v_tail_142_ = lean_ctor_get(v_x_132_, 1);
lean_inc(v_tail_142_);
lean_dec_ref_known(v_x_132_, 2);
v_amount_143_ = lean_ctor_get(v_head_138_, 0);
lean_inc(v_amount_143_);
lean_dec_ref_known(v_head_138_, 1);
v___x_144_ = lean_apply_2(v_h__3_135_, v_amount_143_, v_tail_142_);
return v___x_144_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_total(lean_object* v_s_145_){
_start:
{
lean_object* v_controlled_146_; lean_object* v_outside_147_; lean_object* v_physical_148_; lean_object* v___x_149_; 
v_controlled_146_ = lean_ctor_get(v_s_145_, 0);
v_outside_147_ = lean_ctor_get(v_s_145_, 1);
v_physical_148_ = lean_ctor_get(v_controlled_146_, 1);
v___x_149_ = lean_nat_add(v_physical_148_, v_outside_147_);
return v___x_149_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedDrift_total___boxed(lean_object* v_s_150_){
_start:
{
lean_object* v_res_151_; 
v_res_151_ = lp_physical__bridges_PhysicalBridges_IRBoundedDrift_total(v_s_150_);
lean_dec_ref(v_s_150_);
return v_res_151_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRInstrument(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRBoundedDrift(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRInstrument(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
