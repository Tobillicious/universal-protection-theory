// Lean compiler output
// Module: PhysicalBridges.IRAtomicQuiescence
// Imports: public import Init public meta import Init public import PhysicalBridges.IRQuiescenceAck
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
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* lp_physical__bridges_UPTFence_apply(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_close(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_close___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_dispatch(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_deliver(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorIdx(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_close_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_close_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_dispatch_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_dispatch_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_deliver_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_deliver_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_step(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRAtomicQuiescence_run_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_run(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRAtomicQuiescence_0__PhysicalBridges_IRAtomicQuiescence_step_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRAtomicQuiescence_0__PhysicalBridges_IRAtomicQuiescence_step_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_close(lean_object* v_s_1_, lean_object* v_g_2_){
_start:
{
lean_object* v_gate_3_; lean_object* v_pending_4_; lean_object* v_landed_5_; lean_object* v___x_7_; uint8_t v_isShared_8_; uint8_t v_isSharedCheck_17_; 
v_gate_3_ = lean_ctor_get(v_s_1_, 0);
v_pending_4_ = lean_ctor_get(v_s_1_, 1);
v_landed_5_ = lean_ctor_get(v_s_1_, 2);
v_isSharedCheck_17_ = !lean_is_exclusive(v_s_1_);
if (v_isSharedCheck_17_ == 0)
{
v___x_7_ = v_s_1_;
v_isShared_8_ = v_isSharedCheck_17_;
goto v_resetjp_6_;
}
else
{
lean_inc(v_landed_5_);
lean_inc(v_pending_4_);
lean_inc(v_gate_3_);
lean_dec(v_s_1_);
v___x_7_ = lean_box(0);
v_isShared_8_ = v_isSharedCheck_17_;
goto v_resetjp_6_;
}
v_resetjp_6_:
{
lean_object* v___x_9_; lean_object* v___x_10_; lean_object* v___x_11_; lean_object* v___x_12_; uint8_t v___x_13_; lean_object* v___x_15_; 
v___x_9_ = lean_unsigned_to_nat(1u);
v___x_10_ = lean_nat_add(v_g_2_, v___x_9_);
v___x_11_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_11_, 0, v___x_10_);
v___x_12_ = lp_physical__bridges_UPTFence_apply(v_gate_3_, v___x_11_);
lean_dec_ref_known(v___x_11_, 1);
v___x_13_ = 1;
if (v_isShared_8_ == 0)
{
lean_ctor_set(v___x_7_, 0, v___x_12_);
v___x_15_ = v___x_7_;
goto v_reusejp_14_;
}
else
{
lean_object* v_reuseFailAlloc_16_; 
v_reuseFailAlloc_16_ = lean_alloc_ctor(0, 3, 1);
lean_ctor_set(v_reuseFailAlloc_16_, 0, v___x_12_);
lean_ctor_set(v_reuseFailAlloc_16_, 1, v_pending_4_);
lean_ctor_set(v_reuseFailAlloc_16_, 2, v_landed_5_);
v___x_15_ = v_reuseFailAlloc_16_;
goto v_reusejp_14_;
}
v_reusejp_14_:
{
lean_ctor_set_uint8(v___x_15_, sizeof(void*)*3, v___x_13_);
return v___x_15_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_close___boxed(lean_object* v_s_18_, lean_object* v_g_19_){
_start:
{
lean_object* v_res_20_; 
v_res_20_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_close(v_s_18_, v_g_19_);
lean_dec(v_g_19_);
return v_res_20_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_dispatch(lean_object* v_s_21_, lean_object* v_effect_22_){
_start:
{
uint8_t v_closed_23_; 
v_closed_23_ = lean_ctor_get_uint8(v_s_21_, sizeof(void*)*3);
if (v_closed_23_ == 0)
{
lean_object* v_gate_24_; lean_object* v_pending_25_; lean_object* v_landed_26_; lean_object* v___x_28_; uint8_t v_isShared_29_; uint8_t v_isSharedCheck_36_; 
v_gate_24_ = lean_ctor_get(v_s_21_, 0);
v_pending_25_ = lean_ctor_get(v_s_21_, 1);
v_landed_26_ = lean_ctor_get(v_s_21_, 2);
v_isSharedCheck_36_ = !lean_is_exclusive(v_s_21_);
if (v_isSharedCheck_36_ == 0)
{
v___x_28_ = v_s_21_;
v_isShared_29_ = v_isSharedCheck_36_;
goto v_resetjp_27_;
}
else
{
lean_inc(v_landed_26_);
lean_inc(v_pending_25_);
lean_inc(v_gate_24_);
lean_dec(v_s_21_);
v___x_28_ = lean_box(0);
v_isShared_29_ = v_isSharedCheck_36_;
goto v_resetjp_27_;
}
v_resetjp_27_:
{
lean_object* v___x_30_; lean_object* v___x_31_; lean_object* v___x_32_; lean_object* v___x_34_; 
v___x_30_ = lean_box(0);
v___x_31_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_31_, 0, v_effect_22_);
lean_ctor_set(v___x_31_, 1, v___x_30_);
v___x_32_ = l_List_appendTR___redArg(v_pending_25_, v___x_31_);
if (v_isShared_29_ == 0)
{
lean_ctor_set(v___x_28_, 1, v___x_32_);
v___x_34_ = v___x_28_;
goto v_reusejp_33_;
}
else
{
lean_object* v_reuseFailAlloc_35_; 
v_reuseFailAlloc_35_ = lean_alloc_ctor(0, 3, 1);
lean_ctor_set(v_reuseFailAlloc_35_, 0, v_gate_24_);
lean_ctor_set(v_reuseFailAlloc_35_, 1, v___x_32_);
lean_ctor_set(v_reuseFailAlloc_35_, 2, v_landed_26_);
lean_ctor_set_uint8(v_reuseFailAlloc_35_, sizeof(void*)*3, v_closed_23_);
v___x_34_ = v_reuseFailAlloc_35_;
goto v_reusejp_33_;
}
v_reusejp_33_:
{
return v___x_34_;
}
}
}
else
{
lean_dec(v_effect_22_);
return v_s_21_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_deliver(lean_object* v_s_37_){
_start:
{
lean_object* v_pending_38_; 
v_pending_38_ = lean_ctor_get(v_s_37_, 1);
if (lean_obj_tag(v_pending_38_) == 0)
{
return v_s_37_;
}
else
{
lean_object* v_gate_39_; uint8_t v_closed_40_; lean_object* v_landed_41_; lean_object* v___x_43_; uint8_t v_isShared_44_; uint8_t v_isSharedCheck_51_; 
lean_inc_ref(v_pending_38_);
v_gate_39_ = lean_ctor_get(v_s_37_, 0);
v_closed_40_ = lean_ctor_get_uint8(v_s_37_, sizeof(void*)*3);
v_landed_41_ = lean_ctor_get(v_s_37_, 2);
v_isSharedCheck_51_ = !lean_is_exclusive(v_s_37_);
if (v_isSharedCheck_51_ == 0)
{
lean_object* v_unused_52_; 
v_unused_52_ = lean_ctor_get(v_s_37_, 1);
lean_dec(v_unused_52_);
v___x_43_ = v_s_37_;
v_isShared_44_ = v_isSharedCheck_51_;
goto v_resetjp_42_;
}
else
{
lean_inc(v_landed_41_);
lean_inc(v_gate_39_);
lean_dec(v_s_37_);
v___x_43_ = lean_box(0);
v_isShared_44_ = v_isSharedCheck_51_;
goto v_resetjp_42_;
}
v_resetjp_42_:
{
lean_object* v_head_45_; lean_object* v_tail_46_; lean_object* v___x_47_; lean_object* v___x_49_; 
v_head_45_ = lean_ctor_get(v_pending_38_, 0);
lean_inc(v_head_45_);
v_tail_46_ = lean_ctor_get(v_pending_38_, 1);
lean_inc(v_tail_46_);
lean_dec_ref_known(v_pending_38_, 2);
v___x_47_ = lean_nat_add(v_landed_41_, v_head_45_);
lean_dec(v_head_45_);
lean_dec(v_landed_41_);
if (v_isShared_44_ == 0)
{
lean_ctor_set(v___x_43_, 2, v___x_47_);
lean_ctor_set(v___x_43_, 1, v_tail_46_);
v___x_49_ = v___x_43_;
goto v_reusejp_48_;
}
else
{
lean_object* v_reuseFailAlloc_50_; 
v_reuseFailAlloc_50_ = lean_alloc_ctor(0, 3, 1);
lean_ctor_set(v_reuseFailAlloc_50_, 0, v_gate_39_);
lean_ctor_set(v_reuseFailAlloc_50_, 1, v_tail_46_);
lean_ctor_set(v_reuseFailAlloc_50_, 2, v___x_47_);
lean_ctor_set_uint8(v_reuseFailAlloc_50_, sizeof(void*)*3, v_closed_40_);
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
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorIdx(lean_object* v_x_53_){
_start:
{
switch(lean_obj_tag(v_x_53_))
{
case 0:
{
lean_object* v___x_54_; 
v___x_54_ = lean_unsigned_to_nat(0u);
return v___x_54_;
}
case 1:
{
lean_object* v___x_55_; 
v___x_55_ = lean_unsigned_to_nat(1u);
return v___x_55_;
}
default: 
{
lean_object* v___x_56_; 
v___x_56_ = lean_unsigned_to_nat(2u);
return v___x_56_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorIdx___boxed(lean_object* v_x_57_){
_start:
{
lean_object* v_res_58_; 
v_res_58_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorIdx(v_x_57_);
lean_dec(v_x_57_);
return v_res_58_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim___redArg(lean_object* v_t_59_, lean_object* v_k_60_){
_start:
{
if (lean_obj_tag(v_t_59_) == 2)
{
return v_k_60_;
}
else
{
lean_object* v_generation_61_; lean_object* v___x_62_; 
v_generation_61_ = lean_ctor_get(v_t_59_, 0);
lean_inc(v_generation_61_);
lean_dec(v_t_59_);
v___x_62_ = lean_apply_1(v_k_60_, v_generation_61_);
return v___x_62_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim(lean_object* v_motive_63_, lean_object* v_ctorIdx_64_, lean_object* v_t_65_, lean_object* v_h_66_, lean_object* v_k_67_){
_start:
{
lean_object* v___x_68_; 
v___x_68_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim___redArg(v_t_65_, v_k_67_);
return v___x_68_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim___boxed(lean_object* v_motive_69_, lean_object* v_ctorIdx_70_, lean_object* v_t_71_, lean_object* v_h_72_, lean_object* v_k_73_){
_start:
{
lean_object* v_res_74_; 
v_res_74_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim(v_motive_69_, v_ctorIdx_70_, v_t_71_, v_h_72_, v_k_73_);
lean_dec(v_ctorIdx_70_);
return v_res_74_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_close_elim___redArg(lean_object* v_t_75_, lean_object* v_close_76_){
_start:
{
lean_object* v___x_77_; 
v___x_77_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim___redArg(v_t_75_, v_close_76_);
return v___x_77_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_close_elim(lean_object* v_motive_78_, lean_object* v_t_79_, lean_object* v_h_80_, lean_object* v_close_81_){
_start:
{
lean_object* v___x_82_; 
v___x_82_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim___redArg(v_t_79_, v_close_81_);
return v___x_82_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_dispatch_elim___redArg(lean_object* v_t_83_, lean_object* v_dispatch_84_){
_start:
{
lean_object* v___x_85_; 
v___x_85_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim___redArg(v_t_83_, v_dispatch_84_);
return v___x_85_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_dispatch_elim(lean_object* v_motive_86_, lean_object* v_t_87_, lean_object* v_h_88_, lean_object* v_dispatch_89_){
_start:
{
lean_object* v___x_90_; 
v___x_90_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim___redArg(v_t_87_, v_dispatch_89_);
return v___x_90_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_deliver_elim___redArg(lean_object* v_t_91_, lean_object* v_deliver_92_){
_start:
{
lean_object* v___x_93_; 
v___x_93_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim___redArg(v_t_91_, v_deliver_92_);
return v___x_93_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_deliver_elim(lean_object* v_motive_94_, lean_object* v_t_95_, lean_object* v_h_96_, lean_object* v_deliver_97_){
_start:
{
lean_object* v___x_98_; 
v___x_98_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_Cmd_ctorElim___redArg(v_t_95_, v_deliver_97_);
return v___x_98_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_step(lean_object* v_s_99_, lean_object* v_x_100_){
_start:
{
switch(lean_obj_tag(v_x_100_))
{
case 0:
{
lean_object* v_generation_101_; lean_object* v___x_102_; 
v_generation_101_ = lean_ctor_get(v_x_100_, 0);
lean_inc(v_generation_101_);
lean_dec_ref_known(v_x_100_, 1);
v___x_102_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_close(v_s_99_, v_generation_101_);
lean_dec(v_generation_101_);
return v___x_102_;
}
case 1:
{
lean_object* v_effect_103_; lean_object* v___x_104_; 
v_effect_103_ = lean_ctor_get(v_x_100_, 0);
lean_inc(v_effect_103_);
lean_dec_ref_known(v_x_100_, 1);
v___x_104_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_dispatch(v_s_99_, v_effect_103_);
return v___x_104_;
}
default: 
{
lean_object* v___x_105_; 
v___x_105_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_deliver(v_s_99_);
return v___x_105_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRAtomicQuiescence_run_spec__0(lean_object* v_x_106_, lean_object* v_x_107_){
_start:
{
if (lean_obj_tag(v_x_107_) == 0)
{
return v_x_106_;
}
else
{
lean_object* v_head_108_; lean_object* v_tail_109_; lean_object* v___x_110_; 
v_head_108_ = lean_ctor_get(v_x_107_, 0);
lean_inc(v_head_108_);
v_tail_109_ = lean_ctor_get(v_x_107_, 1);
lean_inc(v_tail_109_);
lean_dec_ref_known(v_x_107_, 2);
v___x_110_ = lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_step(v_x_106_, v_head_108_);
v_x_106_ = v___x_110_;
v_x_107_ = v_tail_109_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRAtomicQuiescence_run(lean_object* v_s_112_, lean_object* v_history_113_){
_start:
{
lean_object* v___x_114_; 
v___x_114_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRAtomicQuiescence_run_spec__0(v_s_112_, v_history_113_);
return v___x_114_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRAtomicQuiescence_0__PhysicalBridges_IRAtomicQuiescence_step_match__1_splitter___redArg(lean_object* v_x_115_, lean_object* v_h__1_116_, lean_object* v_h__2_117_, lean_object* v_h__3_118_){
_start:
{
switch(lean_obj_tag(v_x_115_))
{
case 0:
{
lean_object* v_generation_119_; lean_object* v___x_120_; 
lean_dec(v_h__3_118_);
lean_dec(v_h__2_117_);
v_generation_119_ = lean_ctor_get(v_x_115_, 0);
lean_inc(v_generation_119_);
lean_dec_ref_known(v_x_115_, 1);
v___x_120_ = lean_apply_1(v_h__1_116_, v_generation_119_);
return v___x_120_;
}
case 1:
{
lean_object* v_effect_121_; lean_object* v___x_122_; 
lean_dec(v_h__3_118_);
lean_dec(v_h__1_116_);
v_effect_121_ = lean_ctor_get(v_x_115_, 0);
lean_inc(v_effect_121_);
lean_dec_ref_known(v_x_115_, 1);
v___x_122_ = lean_apply_1(v_h__2_117_, v_effect_121_);
return v___x_122_;
}
default: 
{
lean_object* v___x_123_; lean_object* v___x_124_; 
lean_dec(v_h__2_117_);
lean_dec(v_h__1_116_);
v___x_123_ = lean_box(0);
v___x_124_ = lean_apply_1(v_h__3_118_, v___x_123_);
return v___x_124_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRAtomicQuiescence_0__PhysicalBridges_IRAtomicQuiescence_step_match__1_splitter(lean_object* v_motive_125_, lean_object* v_x_126_, lean_object* v_h__1_127_, lean_object* v_h__2_128_, lean_object* v_h__3_129_){
_start:
{
switch(lean_obj_tag(v_x_126_))
{
case 0:
{
lean_object* v_generation_130_; lean_object* v___x_131_; 
lean_dec(v_h__3_129_);
lean_dec(v_h__2_128_);
v_generation_130_ = lean_ctor_get(v_x_126_, 0);
lean_inc(v_generation_130_);
lean_dec_ref_known(v_x_126_, 1);
v___x_131_ = lean_apply_1(v_h__1_127_, v_generation_130_);
return v___x_131_;
}
case 1:
{
lean_object* v_effect_132_; lean_object* v___x_133_; 
lean_dec(v_h__3_129_);
lean_dec(v_h__1_127_);
v_effect_132_ = lean_ctor_get(v_x_126_, 0);
lean_inc(v_effect_132_);
lean_dec_ref_known(v_x_126_, 1);
v___x_133_ = lean_apply_1(v_h__2_128_, v_effect_132_);
return v___x_133_;
}
default: 
{
lean_object* v___x_134_; lean_object* v___x_135_; 
lean_dec(v_h__2_128_);
lean_dec(v_h__1_127_);
v___x_134_ = lean_box(0);
v___x_135_ = lean_apply_1(v_h__3_129_, v___x_134_);
return v___x_135_;
}
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRQuiescenceAck(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRAtomicQuiescence(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRQuiescenceAck(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
