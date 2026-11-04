// Lean compiler output
// Module: PhysicalBridges.IRDurableEpoch
// Imports: public import Init public meta import Init public import PhysicalBridges.IRFinalApplyFence
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
lean_object* lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_hold(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
lean_object* lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_deliver(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_commitHold(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_commitHold___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_restart(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_deliver(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorIdx(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_commitHold_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_commitHold_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_restart_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_restart_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_deliver_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_deliver_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_step(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_step___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRDurableEpoch_run_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRDurableEpoch_run_spec__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_run(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_run___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRDurableEpoch_0__PhysicalBridges_IRDurableEpoch_step_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRDurableEpoch_0__PhysicalBridges_IRDurableEpoch_step_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_volatileOnlyHold(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_volatileOnlyHold___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_commitHold(lean_object* v_s_1_, lean_object* v_g_2_){
_start:
{
lean_object* v_durableFloor_3_; lean_object* v_live_4_; lean_object* v___x_6_; uint8_t v_isShared_7_; uint8_t v_isSharedCheck_17_; 
v_durableFloor_3_ = lean_ctor_get(v_s_1_, 0);
v_live_4_ = lean_ctor_get(v_s_1_, 1);
v_isSharedCheck_17_ = !lean_is_exclusive(v_s_1_);
if (v_isSharedCheck_17_ == 0)
{
v___x_6_ = v_s_1_;
v_isShared_7_ = v_isSharedCheck_17_;
goto v_resetjp_5_;
}
else
{
lean_inc(v_live_4_);
lean_inc(v_durableFloor_3_);
lean_dec(v_s_1_);
v___x_6_ = lean_box(0);
v_isShared_7_ = v_isSharedCheck_17_;
goto v_resetjp_5_;
}
v_resetjp_5_:
{
lean_object* v___y_9_; lean_object* v___x_14_; lean_object* v___x_15_; uint8_t v___x_16_; 
v___x_14_ = lean_unsigned_to_nat(1u);
v___x_15_ = lean_nat_add(v_g_2_, v___x_14_);
v___x_16_ = lean_nat_dec_le(v_durableFloor_3_, v___x_15_);
if (v___x_16_ == 0)
{
lean_dec(v___x_15_);
v___y_9_ = v_durableFloor_3_;
goto v___jp_8_;
}
else
{
lean_dec(v_durableFloor_3_);
v___y_9_ = v___x_15_;
goto v___jp_8_;
}
v___jp_8_:
{
lean_object* v___x_10_; lean_object* v___x_12_; 
v___x_10_ = lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_hold(v_live_4_, v_g_2_);
if (v_isShared_7_ == 0)
{
lean_ctor_set(v___x_6_, 1, v___x_10_);
lean_ctor_set(v___x_6_, 0, v___y_9_);
v___x_12_ = v___x_6_;
goto v_reusejp_11_;
}
else
{
lean_object* v_reuseFailAlloc_13_; 
v_reuseFailAlloc_13_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_13_, 0, v___y_9_);
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
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_commitHold___boxed(lean_object* v_s_18_, lean_object* v_g_19_){
_start:
{
lean_object* v_res_20_; 
v_res_20_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_commitHold(v_s_18_, v_g_19_);
lean_dec(v_g_19_);
return v_res_20_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_restart(lean_object* v_s_21_){
_start:
{
lean_object* v_live_22_; lean_object* v_durableFloor_23_; lean_object* v___x_25_; uint8_t v_isShared_26_; uint8_t v_isSharedCheck_40_; 
v_live_22_ = lean_ctor_get(v_s_21_, 1);
v_durableFloor_23_ = lean_ctor_get(v_s_21_, 0);
v_isSharedCheck_40_ = !lean_is_exclusive(v_s_21_);
if (v_isSharedCheck_40_ == 0)
{
v___x_25_ = v_s_21_;
v_isShared_26_ = v_isSharedCheck_40_;
goto v_resetjp_24_;
}
else
{
lean_inc(v_live_22_);
lean_inc(v_durableFloor_23_);
lean_dec(v_s_21_);
v___x_25_ = lean_box(0);
v_isShared_26_ = v_isSharedCheck_40_;
goto v_resetjp_24_;
}
v_resetjp_24_:
{
lean_object* v_pending_27_; lean_object* v_landed_28_; lean_object* v___x_30_; uint8_t v_isShared_31_; uint8_t v_isSharedCheck_38_; 
v_pending_27_ = lean_ctor_get(v_live_22_, 1);
v_landed_28_ = lean_ctor_get(v_live_22_, 2);
v_isSharedCheck_38_ = !lean_is_exclusive(v_live_22_);
if (v_isSharedCheck_38_ == 0)
{
lean_object* v_unused_39_; 
v_unused_39_ = lean_ctor_get(v_live_22_, 0);
lean_dec(v_unused_39_);
v___x_30_ = v_live_22_;
v_isShared_31_ = v_isSharedCheck_38_;
goto v_resetjp_29_;
}
else
{
lean_inc(v_landed_28_);
lean_inc(v_pending_27_);
lean_dec(v_live_22_);
v___x_30_ = lean_box(0);
v_isShared_31_ = v_isSharedCheck_38_;
goto v_resetjp_29_;
}
v_resetjp_29_:
{
lean_object* v___x_33_; 
lean_inc(v_durableFloor_23_);
if (v_isShared_31_ == 0)
{
lean_ctor_set(v___x_30_, 0, v_durableFloor_23_);
v___x_33_ = v___x_30_;
goto v_reusejp_32_;
}
else
{
lean_object* v_reuseFailAlloc_37_; 
v_reuseFailAlloc_37_ = lean_alloc_ctor(0, 3, 0);
lean_ctor_set(v_reuseFailAlloc_37_, 0, v_durableFloor_23_);
lean_ctor_set(v_reuseFailAlloc_37_, 1, v_pending_27_);
lean_ctor_set(v_reuseFailAlloc_37_, 2, v_landed_28_);
v___x_33_ = v_reuseFailAlloc_37_;
goto v_reusejp_32_;
}
v_reusejp_32_:
{
lean_object* v___x_35_; 
if (v_isShared_26_ == 0)
{
lean_ctor_set(v___x_25_, 1, v___x_33_);
v___x_35_ = v___x_25_;
goto v_reusejp_34_;
}
else
{
lean_object* v_reuseFailAlloc_36_; 
v_reuseFailAlloc_36_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_36_, 0, v_durableFloor_23_);
lean_ctor_set(v_reuseFailAlloc_36_, 1, v___x_33_);
v___x_35_ = v_reuseFailAlloc_36_;
goto v_reusejp_34_;
}
v_reusejp_34_:
{
return v___x_35_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_deliver(lean_object* v_s_41_){
_start:
{
lean_object* v_durableFloor_42_; lean_object* v_live_43_; lean_object* v___x_45_; uint8_t v_isShared_46_; uint8_t v_isSharedCheck_51_; 
v_durableFloor_42_ = lean_ctor_get(v_s_41_, 0);
v_live_43_ = lean_ctor_get(v_s_41_, 1);
v_isSharedCheck_51_ = !lean_is_exclusive(v_s_41_);
if (v_isSharedCheck_51_ == 0)
{
v___x_45_ = v_s_41_;
v_isShared_46_ = v_isSharedCheck_51_;
goto v_resetjp_44_;
}
else
{
lean_inc(v_live_43_);
lean_inc(v_durableFloor_42_);
lean_dec(v_s_41_);
v___x_45_ = lean_box(0);
v_isShared_46_ = v_isSharedCheck_51_;
goto v_resetjp_44_;
}
v_resetjp_44_:
{
lean_object* v___x_47_; lean_object* v___x_49_; 
v___x_47_ = lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_deliver(v_live_43_);
if (v_isShared_46_ == 0)
{
lean_ctor_set(v___x_45_, 1, v___x_47_);
v___x_49_ = v___x_45_;
goto v_reusejp_48_;
}
else
{
lean_object* v_reuseFailAlloc_50_; 
v_reuseFailAlloc_50_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_50_, 0, v_durableFloor_42_);
lean_ctor_set(v_reuseFailAlloc_50_, 1, v___x_47_);
v___x_49_ = v_reuseFailAlloc_50_;
goto v_reusejp_48_;
}
v_reusejp_48_:
{
return v___x_49_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorIdx(lean_object* v_x_52_){
_start:
{
switch(lean_obj_tag(v_x_52_))
{
case 0:
{
lean_object* v___x_53_; 
v___x_53_ = lean_unsigned_to_nat(0u);
return v___x_53_;
}
case 1:
{
lean_object* v___x_54_; 
v___x_54_ = lean_unsigned_to_nat(1u);
return v___x_54_;
}
default: 
{
lean_object* v___x_55_; 
v___x_55_ = lean_unsigned_to_nat(2u);
return v___x_55_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorIdx___boxed(lean_object* v_x_56_){
_start:
{
lean_object* v_res_57_; 
v_res_57_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorIdx(v_x_56_);
lean_dec(v_x_56_);
return v_res_57_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim___redArg(lean_object* v_t_58_, lean_object* v_k_59_){
_start:
{
if (lean_obj_tag(v_t_58_) == 0)
{
lean_object* v_g_60_; lean_object* v___x_61_; 
v_g_60_ = lean_ctor_get(v_t_58_, 0);
lean_inc(v_g_60_);
lean_dec_ref_known(v_t_58_, 1);
v___x_61_ = lean_apply_1(v_k_59_, v_g_60_);
return v___x_61_;
}
else
{
lean_dec(v_t_58_);
return v_k_59_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim(lean_object* v_motive_62_, lean_object* v_ctorIdx_63_, lean_object* v_t_64_, lean_object* v_h_65_, lean_object* v_k_66_){
_start:
{
lean_object* v___x_67_; 
v___x_67_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim___redArg(v_t_64_, v_k_66_);
return v___x_67_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim___boxed(lean_object* v_motive_68_, lean_object* v_ctorIdx_69_, lean_object* v_t_70_, lean_object* v_h_71_, lean_object* v_k_72_){
_start:
{
lean_object* v_res_73_; 
v_res_73_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim(v_motive_68_, v_ctorIdx_69_, v_t_70_, v_h_71_, v_k_72_);
lean_dec(v_ctorIdx_69_);
return v_res_73_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_commitHold_elim___redArg(lean_object* v_t_74_, lean_object* v_commitHold_75_){
_start:
{
lean_object* v___x_76_; 
v___x_76_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim___redArg(v_t_74_, v_commitHold_75_);
return v___x_76_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_commitHold_elim(lean_object* v_motive_77_, lean_object* v_t_78_, lean_object* v_h_79_, lean_object* v_commitHold_80_){
_start:
{
lean_object* v___x_81_; 
v___x_81_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim___redArg(v_t_78_, v_commitHold_80_);
return v___x_81_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_restart_elim___redArg(lean_object* v_t_82_, lean_object* v_restart_83_){
_start:
{
lean_object* v___x_84_; 
v___x_84_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim___redArg(v_t_82_, v_restart_83_);
return v___x_84_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_restart_elim(lean_object* v_motive_85_, lean_object* v_t_86_, lean_object* v_h_87_, lean_object* v_restart_88_){
_start:
{
lean_object* v___x_89_; 
v___x_89_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim___redArg(v_t_86_, v_restart_88_);
return v___x_89_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_deliver_elim___redArg(lean_object* v_t_90_, lean_object* v_deliver_91_){
_start:
{
lean_object* v___x_92_; 
v___x_92_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim___redArg(v_t_90_, v_deliver_91_);
return v___x_92_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_deliver_elim(lean_object* v_motive_93_, lean_object* v_t_94_, lean_object* v_h_95_, lean_object* v_deliver_96_){
_start:
{
lean_object* v___x_97_; 
v___x_97_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_Cmd_ctorElim___redArg(v_t_94_, v_deliver_96_);
return v___x_97_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_step(lean_object* v_s_98_, lean_object* v_x_99_){
_start:
{
switch(lean_obj_tag(v_x_99_))
{
case 0:
{
lean_object* v_g_100_; lean_object* v___x_101_; 
v_g_100_ = lean_ctor_get(v_x_99_, 0);
v___x_101_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_commitHold(v_s_98_, v_g_100_);
return v___x_101_;
}
case 1:
{
lean_object* v___x_102_; 
v___x_102_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_restart(v_s_98_);
return v___x_102_;
}
default: 
{
lean_object* v___x_103_; 
v___x_103_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_deliver(v_s_98_);
return v___x_103_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_step___boxed(lean_object* v_s_104_, lean_object* v_x_105_){
_start:
{
lean_object* v_res_106_; 
v_res_106_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_step(v_s_104_, v_x_105_);
lean_dec(v_x_105_);
return v_res_106_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRDurableEpoch_run_spec__0(lean_object* v_x_107_, lean_object* v_x_108_){
_start:
{
if (lean_obj_tag(v_x_108_) == 0)
{
return v_x_107_;
}
else
{
lean_object* v_head_109_; lean_object* v_tail_110_; lean_object* v___x_111_; 
v_head_109_ = lean_ctor_get(v_x_108_, 0);
v_tail_110_ = lean_ctor_get(v_x_108_, 1);
v___x_111_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_step(v_x_107_, v_head_109_);
v_x_107_ = v___x_111_;
v_x_108_ = v_tail_110_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRDurableEpoch_run_spec__0___boxed(lean_object* v_x_113_, lean_object* v_x_114_){
_start:
{
lean_object* v_res_115_; 
v_res_115_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRDurableEpoch_run_spec__0(v_x_113_, v_x_114_);
lean_dec(v_x_114_);
return v_res_115_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_run(lean_object* v_s_116_, lean_object* v_cmds_117_){
_start:
{
lean_object* v___x_118_; 
v___x_118_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRDurableEpoch_run_spec__0(v_s_116_, v_cmds_117_);
return v___x_118_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_run___boxed(lean_object* v_s_119_, lean_object* v_cmds_120_){
_start:
{
lean_object* v_res_121_; 
v_res_121_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_run(v_s_119_, v_cmds_120_);
lean_dec(v_cmds_120_);
return v_res_121_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRDurableEpoch_0__PhysicalBridges_IRDurableEpoch_step_match__1_splitter___redArg(lean_object* v_x_122_, lean_object* v_h__1_123_, lean_object* v_h__2_124_, lean_object* v_h__3_125_){
_start:
{
switch(lean_obj_tag(v_x_122_))
{
case 0:
{
lean_object* v_g_126_; lean_object* v___x_127_; 
lean_dec(v_h__3_125_);
lean_dec(v_h__2_124_);
v_g_126_ = lean_ctor_get(v_x_122_, 0);
lean_inc(v_g_126_);
lean_dec_ref_known(v_x_122_, 1);
v___x_127_ = lean_apply_1(v_h__1_123_, v_g_126_);
return v___x_127_;
}
case 1:
{
lean_object* v___x_128_; lean_object* v___x_129_; 
lean_dec(v_h__3_125_);
lean_dec(v_h__1_123_);
v___x_128_ = lean_box(0);
v___x_129_ = lean_apply_1(v_h__2_124_, v___x_128_);
return v___x_129_;
}
default: 
{
lean_object* v___x_130_; lean_object* v___x_131_; 
lean_dec(v_h__2_124_);
lean_dec(v_h__1_123_);
v___x_130_ = lean_box(0);
v___x_131_ = lean_apply_1(v_h__3_125_, v___x_130_);
return v___x_131_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRDurableEpoch_0__PhysicalBridges_IRDurableEpoch_step_match__1_splitter(lean_object* v_motive_132_, lean_object* v_x_133_, lean_object* v_h__1_134_, lean_object* v_h__2_135_, lean_object* v_h__3_136_){
_start:
{
switch(lean_obj_tag(v_x_133_))
{
case 0:
{
lean_object* v_g_137_; lean_object* v___x_138_; 
lean_dec(v_h__3_136_);
lean_dec(v_h__2_135_);
v_g_137_ = lean_ctor_get(v_x_133_, 0);
lean_inc(v_g_137_);
lean_dec_ref_known(v_x_133_, 1);
v___x_138_ = lean_apply_1(v_h__1_134_, v_g_137_);
return v___x_138_;
}
case 1:
{
lean_object* v___x_139_; lean_object* v___x_140_; 
lean_dec(v_h__3_136_);
lean_dec(v_h__1_134_);
v___x_139_ = lean_box(0);
v___x_140_ = lean_apply_1(v_h__2_135_, v___x_139_);
return v___x_140_;
}
default: 
{
lean_object* v___x_141_; lean_object* v___x_142_; 
lean_dec(v_h__2_135_);
lean_dec(v_h__1_134_);
v___x_141_ = lean_box(0);
v___x_142_ = lean_apply_1(v_h__3_136_, v___x_141_);
return v___x_142_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_volatileOnlyHold(lean_object* v_s_143_, lean_object* v_g_144_){
_start:
{
lean_object* v_durableFloor_145_; lean_object* v_live_146_; lean_object* v___x_148_; uint8_t v_isShared_149_; uint8_t v_isSharedCheck_154_; 
v_durableFloor_145_ = lean_ctor_get(v_s_143_, 0);
v_live_146_ = lean_ctor_get(v_s_143_, 1);
v_isSharedCheck_154_ = !lean_is_exclusive(v_s_143_);
if (v_isSharedCheck_154_ == 0)
{
v___x_148_ = v_s_143_;
v_isShared_149_ = v_isSharedCheck_154_;
goto v_resetjp_147_;
}
else
{
lean_inc(v_live_146_);
lean_inc(v_durableFloor_145_);
lean_dec(v_s_143_);
v___x_148_ = lean_box(0);
v_isShared_149_ = v_isSharedCheck_154_;
goto v_resetjp_147_;
}
v_resetjp_147_:
{
lean_object* v___x_150_; lean_object* v___x_152_; 
v___x_150_ = lp_physical__bridges_PhysicalBridges_IRFinalApplyFence_hold(v_live_146_, v_g_144_);
if (v_isShared_149_ == 0)
{
lean_ctor_set(v___x_148_, 1, v___x_150_);
v___x_152_ = v___x_148_;
goto v_reusejp_151_;
}
else
{
lean_object* v_reuseFailAlloc_153_; 
v_reuseFailAlloc_153_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_153_, 0, v_durableFloor_145_);
lean_ctor_set(v_reuseFailAlloc_153_, 1, v___x_150_);
v___x_152_ = v_reuseFailAlloc_153_;
goto v_reusejp_151_;
}
v_reusejp_151_:
{
return v___x_152_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRDurableEpoch_volatileOnlyHold___boxed(lean_object* v_s_155_, lean_object* v_g_156_){
_start:
{
lean_object* v_res_157_; 
v_res_157_ = lp_physical__bridges_PhysicalBridges_IRDurableEpoch_volatileOnlyHold(v_s_155_, v_g_156_);
lean_dec(v_g_156_);
return v_res_157_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRFinalApplyFence(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRDurableEpoch(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRFinalApplyFence(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
