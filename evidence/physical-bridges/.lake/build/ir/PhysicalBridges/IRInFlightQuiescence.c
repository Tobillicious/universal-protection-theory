// Lean compiler output
// Module: PhysicalBridges.IRInFlightQuiescence
// Imports: public import Init public meta import Init public import PhysicalBridges.IRAtomicQuiescence
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
lean_object* l_List_appendTR___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_close(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_close___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_send(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_arrive(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_deliver(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorIdx(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_close_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_close_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_send_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_send_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_arrive_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_arrive_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_deliver_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_deliver_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_step(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRInFlightQuiescence_run_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_run(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInFlightQuiescence_0__PhysicalBridges_IRInFlightQuiescence_step_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInFlightQuiescence_0__PhysicalBridges_IRInFlightQuiescence_step_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_close(lean_object* v_s_1_, lean_object* v_g_2_){
_start:
{
lean_object* v_gate_3_; lean_object* v_inFlight_4_; lean_object* v_pending_5_; lean_object* v_landed_6_; lean_object* v___x_8_; uint8_t v_isShared_9_; uint8_t v_isSharedCheck_18_; 
v_gate_3_ = lean_ctor_get(v_s_1_, 0);
v_inFlight_4_ = lean_ctor_get(v_s_1_, 1);
v_pending_5_ = lean_ctor_get(v_s_1_, 2);
v_landed_6_ = lean_ctor_get(v_s_1_, 3);
v_isSharedCheck_18_ = !lean_is_exclusive(v_s_1_);
if (v_isSharedCheck_18_ == 0)
{
v___x_8_ = v_s_1_;
v_isShared_9_ = v_isSharedCheck_18_;
goto v_resetjp_7_;
}
else
{
lean_inc(v_landed_6_);
lean_inc(v_pending_5_);
lean_inc(v_inFlight_4_);
lean_inc(v_gate_3_);
lean_dec(v_s_1_);
v___x_8_ = lean_box(0);
v_isShared_9_ = v_isSharedCheck_18_;
goto v_resetjp_7_;
}
v_resetjp_7_:
{
lean_object* v___x_10_; lean_object* v___x_11_; lean_object* v___x_12_; lean_object* v___x_13_; uint8_t v___x_14_; lean_object* v___x_16_; 
v___x_10_ = lean_unsigned_to_nat(1u);
v___x_11_ = lean_nat_add(v_g_2_, v___x_10_);
v___x_12_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_12_, 0, v___x_11_);
v___x_13_ = lp_physical__bridges_UPTFence_apply(v_gate_3_, v___x_12_);
lean_dec_ref_known(v___x_12_, 1);
v___x_14_ = 1;
if (v_isShared_9_ == 0)
{
lean_ctor_set(v___x_8_, 0, v___x_13_);
v___x_16_ = v___x_8_;
goto v_reusejp_15_;
}
else
{
lean_object* v_reuseFailAlloc_17_; 
v_reuseFailAlloc_17_ = lean_alloc_ctor(0, 4, 1);
lean_ctor_set(v_reuseFailAlloc_17_, 0, v___x_13_);
lean_ctor_set(v_reuseFailAlloc_17_, 1, v_inFlight_4_);
lean_ctor_set(v_reuseFailAlloc_17_, 2, v_pending_5_);
lean_ctor_set(v_reuseFailAlloc_17_, 3, v_landed_6_);
v___x_16_ = v_reuseFailAlloc_17_;
goto v_reusejp_15_;
}
v_reusejp_15_:
{
lean_ctor_set_uint8(v___x_16_, sizeof(void*)*4, v___x_14_);
return v___x_16_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_close___boxed(lean_object* v_s_19_, lean_object* v_g_20_){
_start:
{
lean_object* v_res_21_; 
v_res_21_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_close(v_s_19_, v_g_20_);
lean_dec(v_g_20_);
return v_res_21_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_send(lean_object* v_s_22_, lean_object* v_impact_23_){
_start:
{
uint8_t v_closed_24_; 
v_closed_24_ = lean_ctor_get_uint8(v_s_22_, sizeof(void*)*4);
if (v_closed_24_ == 0)
{
lean_object* v_gate_25_; lean_object* v_inFlight_26_; lean_object* v_pending_27_; lean_object* v_landed_28_; lean_object* v___x_30_; uint8_t v_isShared_31_; uint8_t v_isSharedCheck_38_; 
v_gate_25_ = lean_ctor_get(v_s_22_, 0);
v_inFlight_26_ = lean_ctor_get(v_s_22_, 1);
v_pending_27_ = lean_ctor_get(v_s_22_, 2);
v_landed_28_ = lean_ctor_get(v_s_22_, 3);
v_isSharedCheck_38_ = !lean_is_exclusive(v_s_22_);
if (v_isSharedCheck_38_ == 0)
{
v___x_30_ = v_s_22_;
v_isShared_31_ = v_isSharedCheck_38_;
goto v_resetjp_29_;
}
else
{
lean_inc(v_landed_28_);
lean_inc(v_pending_27_);
lean_inc(v_inFlight_26_);
lean_inc(v_gate_25_);
lean_dec(v_s_22_);
v___x_30_ = lean_box(0);
v_isShared_31_ = v_isSharedCheck_38_;
goto v_resetjp_29_;
}
v_resetjp_29_:
{
lean_object* v___x_32_; lean_object* v___x_33_; lean_object* v___x_34_; lean_object* v___x_36_; 
v___x_32_ = lean_box(0);
v___x_33_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v___x_33_, 0, v_impact_23_);
lean_ctor_set(v___x_33_, 1, v___x_32_);
v___x_34_ = l_List_appendTR___redArg(v_inFlight_26_, v___x_33_);
if (v_isShared_31_ == 0)
{
lean_ctor_set(v___x_30_, 1, v___x_34_);
v___x_36_ = v___x_30_;
goto v_reusejp_35_;
}
else
{
lean_object* v_reuseFailAlloc_37_; 
v_reuseFailAlloc_37_ = lean_alloc_ctor(0, 4, 1);
lean_ctor_set(v_reuseFailAlloc_37_, 0, v_gate_25_);
lean_ctor_set(v_reuseFailAlloc_37_, 1, v___x_34_);
lean_ctor_set(v_reuseFailAlloc_37_, 2, v_pending_27_);
lean_ctor_set(v_reuseFailAlloc_37_, 3, v_landed_28_);
lean_ctor_set_uint8(v_reuseFailAlloc_37_, sizeof(void*)*4, v_closed_24_);
v___x_36_ = v_reuseFailAlloc_37_;
goto v_reusejp_35_;
}
v_reusejp_35_:
{
return v___x_36_;
}
}
}
else
{
lean_dec(v_impact_23_);
return v_s_22_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_arrive(lean_object* v_s_39_){
_start:
{
lean_object* v_inFlight_40_; 
v_inFlight_40_ = lean_ctor_get(v_s_39_, 1);
lean_inc(v_inFlight_40_);
if (lean_obj_tag(v_inFlight_40_) == 0)
{
return v_s_39_;
}
else
{
lean_object* v_gate_41_; uint8_t v_closed_42_; lean_object* v_pending_43_; lean_object* v_landed_44_; lean_object* v___x_46_; uint8_t v_isShared_47_; uint8_t v_isSharedCheck_60_; 
v_gate_41_ = lean_ctor_get(v_s_39_, 0);
v_closed_42_ = lean_ctor_get_uint8(v_s_39_, sizeof(void*)*4);
v_pending_43_ = lean_ctor_get(v_s_39_, 2);
v_landed_44_ = lean_ctor_get(v_s_39_, 3);
v_isSharedCheck_60_ = !lean_is_exclusive(v_s_39_);
if (v_isSharedCheck_60_ == 0)
{
lean_object* v_unused_61_; 
v_unused_61_ = lean_ctor_get(v_s_39_, 1);
lean_dec(v_unused_61_);
v___x_46_ = v_s_39_;
v_isShared_47_ = v_isSharedCheck_60_;
goto v_resetjp_45_;
}
else
{
lean_inc(v_landed_44_);
lean_inc(v_pending_43_);
lean_inc(v_gate_41_);
lean_dec(v_s_39_);
v___x_46_ = lean_box(0);
v_isShared_47_ = v_isSharedCheck_60_;
goto v_resetjp_45_;
}
v_resetjp_45_:
{
lean_object* v_head_48_; lean_object* v_tail_49_; lean_object* v___x_51_; uint8_t v_isShared_52_; uint8_t v_isSharedCheck_59_; 
v_head_48_ = lean_ctor_get(v_inFlight_40_, 0);
v_tail_49_ = lean_ctor_get(v_inFlight_40_, 1);
v_isSharedCheck_59_ = !lean_is_exclusive(v_inFlight_40_);
if (v_isSharedCheck_59_ == 0)
{
v___x_51_ = v_inFlight_40_;
v_isShared_52_ = v_isSharedCheck_59_;
goto v_resetjp_50_;
}
else
{
lean_inc(v_tail_49_);
lean_inc(v_head_48_);
lean_dec(v_inFlight_40_);
v___x_51_ = lean_box(0);
v_isShared_52_ = v_isSharedCheck_59_;
goto v_resetjp_50_;
}
v_resetjp_50_:
{
lean_object* v___x_54_; 
if (v_isShared_52_ == 0)
{
lean_ctor_set(v___x_51_, 1, v_pending_43_);
v___x_54_ = v___x_51_;
goto v_reusejp_53_;
}
else
{
lean_object* v_reuseFailAlloc_58_; 
v_reuseFailAlloc_58_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_58_, 0, v_head_48_);
lean_ctor_set(v_reuseFailAlloc_58_, 1, v_pending_43_);
v___x_54_ = v_reuseFailAlloc_58_;
goto v_reusejp_53_;
}
v_reusejp_53_:
{
lean_object* v___x_56_; 
if (v_isShared_47_ == 0)
{
lean_ctor_set(v___x_46_, 2, v___x_54_);
lean_ctor_set(v___x_46_, 1, v_tail_49_);
v___x_56_ = v___x_46_;
goto v_reusejp_55_;
}
else
{
lean_object* v_reuseFailAlloc_57_; 
v_reuseFailAlloc_57_ = lean_alloc_ctor(0, 4, 1);
lean_ctor_set(v_reuseFailAlloc_57_, 0, v_gate_41_);
lean_ctor_set(v_reuseFailAlloc_57_, 1, v_tail_49_);
lean_ctor_set(v_reuseFailAlloc_57_, 2, v___x_54_);
lean_ctor_set(v_reuseFailAlloc_57_, 3, v_landed_44_);
lean_ctor_set_uint8(v_reuseFailAlloc_57_, sizeof(void*)*4, v_closed_42_);
v___x_56_ = v_reuseFailAlloc_57_;
goto v_reusejp_55_;
}
v_reusejp_55_:
{
return v___x_56_;
}
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_deliver(lean_object* v_s_62_){
_start:
{
lean_object* v_pending_63_; 
v_pending_63_ = lean_ctor_get(v_s_62_, 2);
if (lean_obj_tag(v_pending_63_) == 0)
{
return v_s_62_;
}
else
{
lean_object* v_gate_64_; uint8_t v_closed_65_; lean_object* v_inFlight_66_; lean_object* v_landed_67_; lean_object* v___x_69_; uint8_t v_isShared_70_; uint8_t v_isSharedCheck_77_; 
lean_inc_ref(v_pending_63_);
v_gate_64_ = lean_ctor_get(v_s_62_, 0);
v_closed_65_ = lean_ctor_get_uint8(v_s_62_, sizeof(void*)*4);
v_inFlight_66_ = lean_ctor_get(v_s_62_, 1);
v_landed_67_ = lean_ctor_get(v_s_62_, 3);
v_isSharedCheck_77_ = !lean_is_exclusive(v_s_62_);
if (v_isSharedCheck_77_ == 0)
{
lean_object* v_unused_78_; 
v_unused_78_ = lean_ctor_get(v_s_62_, 2);
lean_dec(v_unused_78_);
v___x_69_ = v_s_62_;
v_isShared_70_ = v_isSharedCheck_77_;
goto v_resetjp_68_;
}
else
{
lean_inc(v_landed_67_);
lean_inc(v_inFlight_66_);
lean_inc(v_gate_64_);
lean_dec(v_s_62_);
v___x_69_ = lean_box(0);
v_isShared_70_ = v_isSharedCheck_77_;
goto v_resetjp_68_;
}
v_resetjp_68_:
{
lean_object* v_head_71_; lean_object* v_tail_72_; lean_object* v___x_73_; lean_object* v___x_75_; 
v_head_71_ = lean_ctor_get(v_pending_63_, 0);
lean_inc(v_head_71_);
v_tail_72_ = lean_ctor_get(v_pending_63_, 1);
lean_inc(v_tail_72_);
lean_dec_ref_known(v_pending_63_, 2);
v___x_73_ = lean_nat_add(v_landed_67_, v_head_71_);
lean_dec(v_head_71_);
lean_dec(v_landed_67_);
if (v_isShared_70_ == 0)
{
lean_ctor_set(v___x_69_, 3, v___x_73_);
lean_ctor_set(v___x_69_, 2, v_tail_72_);
v___x_75_ = v___x_69_;
goto v_reusejp_74_;
}
else
{
lean_object* v_reuseFailAlloc_76_; 
v_reuseFailAlloc_76_ = lean_alloc_ctor(0, 4, 1);
lean_ctor_set(v_reuseFailAlloc_76_, 0, v_gate_64_);
lean_ctor_set(v_reuseFailAlloc_76_, 1, v_inFlight_66_);
lean_ctor_set(v_reuseFailAlloc_76_, 2, v_tail_72_);
lean_ctor_set(v_reuseFailAlloc_76_, 3, v___x_73_);
lean_ctor_set_uint8(v_reuseFailAlloc_76_, sizeof(void*)*4, v_closed_65_);
v___x_75_ = v_reuseFailAlloc_76_;
goto v_reusejp_74_;
}
v_reusejp_74_:
{
return v___x_75_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorIdx(lean_object* v_x_79_){
_start:
{
switch(lean_obj_tag(v_x_79_))
{
case 0:
{
lean_object* v___x_80_; 
v___x_80_ = lean_unsigned_to_nat(0u);
return v___x_80_;
}
case 1:
{
lean_object* v___x_81_; 
v___x_81_ = lean_unsigned_to_nat(1u);
return v___x_81_;
}
case 2:
{
lean_object* v___x_82_; 
v___x_82_ = lean_unsigned_to_nat(2u);
return v___x_82_;
}
default: 
{
lean_object* v___x_83_; 
v___x_83_ = lean_unsigned_to_nat(3u);
return v___x_83_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorIdx___boxed(lean_object* v_x_84_){
_start:
{
lean_object* v_res_85_; 
v_res_85_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorIdx(v_x_84_);
lean_dec(v_x_84_);
return v_res_85_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim___redArg(lean_object* v_t_86_, lean_object* v_k_87_){
_start:
{
switch(lean_obj_tag(v_t_86_))
{
case 0:
{
lean_object* v_generation_88_; lean_object* v___x_89_; 
v_generation_88_ = lean_ctor_get(v_t_86_, 0);
lean_inc(v_generation_88_);
lean_dec_ref_known(v_t_86_, 1);
v___x_89_ = lean_apply_1(v_k_87_, v_generation_88_);
return v___x_89_;
}
case 1:
{
lean_object* v_impact_90_; lean_object* v___x_91_; 
v_impact_90_ = lean_ctor_get(v_t_86_, 0);
lean_inc(v_impact_90_);
lean_dec_ref_known(v_t_86_, 1);
v___x_91_ = lean_apply_1(v_k_87_, v_impact_90_);
return v___x_91_;
}
default: 
{
lean_dec(v_t_86_);
return v_k_87_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim(lean_object* v_motive_92_, lean_object* v_ctorIdx_93_, lean_object* v_t_94_, lean_object* v_h_95_, lean_object* v_k_96_){
_start:
{
lean_object* v___x_97_; 
v___x_97_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim___redArg(v_t_94_, v_k_96_);
return v___x_97_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim___boxed(lean_object* v_motive_98_, lean_object* v_ctorIdx_99_, lean_object* v_t_100_, lean_object* v_h_101_, lean_object* v_k_102_){
_start:
{
lean_object* v_res_103_; 
v_res_103_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim(v_motive_98_, v_ctorIdx_99_, v_t_100_, v_h_101_, v_k_102_);
lean_dec(v_ctorIdx_99_);
return v_res_103_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_close_elim___redArg(lean_object* v_t_104_, lean_object* v_close_105_){
_start:
{
lean_object* v___x_106_; 
v___x_106_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim___redArg(v_t_104_, v_close_105_);
return v___x_106_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_close_elim(lean_object* v_motive_107_, lean_object* v_t_108_, lean_object* v_h_109_, lean_object* v_close_110_){
_start:
{
lean_object* v___x_111_; 
v___x_111_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim___redArg(v_t_108_, v_close_110_);
return v___x_111_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_send_elim___redArg(lean_object* v_t_112_, lean_object* v_send_113_){
_start:
{
lean_object* v___x_114_; 
v___x_114_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim___redArg(v_t_112_, v_send_113_);
return v___x_114_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_send_elim(lean_object* v_motive_115_, lean_object* v_t_116_, lean_object* v_h_117_, lean_object* v_send_118_){
_start:
{
lean_object* v___x_119_; 
v___x_119_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim___redArg(v_t_116_, v_send_118_);
return v___x_119_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_arrive_elim___redArg(lean_object* v_t_120_, lean_object* v_arrive_121_){
_start:
{
lean_object* v___x_122_; 
v___x_122_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim___redArg(v_t_120_, v_arrive_121_);
return v___x_122_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_arrive_elim(lean_object* v_motive_123_, lean_object* v_t_124_, lean_object* v_h_125_, lean_object* v_arrive_126_){
_start:
{
lean_object* v___x_127_; 
v___x_127_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim___redArg(v_t_124_, v_arrive_126_);
return v___x_127_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_deliver_elim___redArg(lean_object* v_t_128_, lean_object* v_deliver_129_){
_start:
{
lean_object* v___x_130_; 
v___x_130_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim___redArg(v_t_128_, v_deliver_129_);
return v___x_130_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_deliver_elim(lean_object* v_motive_131_, lean_object* v_t_132_, lean_object* v_h_133_, lean_object* v_deliver_134_){
_start:
{
lean_object* v___x_135_; 
v___x_135_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_Cmd_ctorElim___redArg(v_t_132_, v_deliver_134_);
return v___x_135_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_step(lean_object* v_s_136_, lean_object* v_x_137_){
_start:
{
switch(lean_obj_tag(v_x_137_))
{
case 0:
{
lean_object* v_generation_138_; lean_object* v___x_139_; 
v_generation_138_ = lean_ctor_get(v_x_137_, 0);
lean_inc(v_generation_138_);
lean_dec_ref_known(v_x_137_, 1);
v___x_139_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_close(v_s_136_, v_generation_138_);
lean_dec(v_generation_138_);
return v___x_139_;
}
case 1:
{
lean_object* v_impact_140_; lean_object* v___x_141_; 
v_impact_140_ = lean_ctor_get(v_x_137_, 0);
lean_inc(v_impact_140_);
lean_dec_ref_known(v_x_137_, 1);
v___x_141_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_send(v_s_136_, v_impact_140_);
return v___x_141_;
}
case 2:
{
lean_object* v___x_142_; 
v___x_142_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_arrive(v_s_136_);
return v___x_142_;
}
default: 
{
lean_object* v___x_143_; 
v___x_143_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_deliver(v_s_136_);
return v___x_143_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRInFlightQuiescence_run_spec__0(lean_object* v_x_144_, lean_object* v_x_145_){
_start:
{
if (lean_obj_tag(v_x_145_) == 0)
{
return v_x_144_;
}
else
{
lean_object* v_head_146_; lean_object* v_tail_147_; lean_object* v___x_148_; 
v_head_146_ = lean_ctor_get(v_x_145_, 0);
lean_inc(v_head_146_);
v_tail_147_ = lean_ctor_get(v_x_145_, 1);
lean_inc(v_tail_147_);
lean_dec_ref_known(v_x_145_, 2);
v___x_148_ = lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_step(v_x_144_, v_head_146_);
v_x_144_ = v___x_148_;
v_x_145_ = v_tail_147_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInFlightQuiescence_run(lean_object* v_s_150_, lean_object* v_cmds_151_){
_start:
{
lean_object* v___x_152_; 
v___x_152_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRInFlightQuiescence_run_spec__0(v_s_150_, v_cmds_151_);
return v___x_152_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInFlightQuiescence_0__PhysicalBridges_IRInFlightQuiescence_step_match__1_splitter___redArg(lean_object* v_x_153_, lean_object* v_h__1_154_, lean_object* v_h__2_155_, lean_object* v_h__3_156_, lean_object* v_h__4_157_){
_start:
{
switch(lean_obj_tag(v_x_153_))
{
case 0:
{
lean_object* v_generation_158_; lean_object* v___x_159_; 
lean_dec(v_h__4_157_);
lean_dec(v_h__3_156_);
lean_dec(v_h__2_155_);
v_generation_158_ = lean_ctor_get(v_x_153_, 0);
lean_inc(v_generation_158_);
lean_dec_ref_known(v_x_153_, 1);
v___x_159_ = lean_apply_1(v_h__1_154_, v_generation_158_);
return v___x_159_;
}
case 1:
{
lean_object* v_impact_160_; lean_object* v___x_161_; 
lean_dec(v_h__4_157_);
lean_dec(v_h__3_156_);
lean_dec(v_h__1_154_);
v_impact_160_ = lean_ctor_get(v_x_153_, 0);
lean_inc(v_impact_160_);
lean_dec_ref_known(v_x_153_, 1);
v___x_161_ = lean_apply_1(v_h__2_155_, v_impact_160_);
return v___x_161_;
}
case 2:
{
lean_object* v___x_162_; lean_object* v___x_163_; 
lean_dec(v_h__4_157_);
lean_dec(v_h__2_155_);
lean_dec(v_h__1_154_);
v___x_162_ = lean_box(0);
v___x_163_ = lean_apply_1(v_h__3_156_, v___x_162_);
return v___x_163_;
}
default: 
{
lean_object* v___x_164_; lean_object* v___x_165_; 
lean_dec(v_h__3_156_);
lean_dec(v_h__2_155_);
lean_dec(v_h__1_154_);
v___x_164_ = lean_box(0);
v___x_165_ = lean_apply_1(v_h__4_157_, v___x_164_);
return v___x_165_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInFlightQuiescence_0__PhysicalBridges_IRInFlightQuiescence_step_match__1_splitter(lean_object* v_motive_166_, lean_object* v_x_167_, lean_object* v_h__1_168_, lean_object* v_h__2_169_, lean_object* v_h__3_170_, lean_object* v_h__4_171_){
_start:
{
switch(lean_obj_tag(v_x_167_))
{
case 0:
{
lean_object* v_generation_172_; lean_object* v___x_173_; 
lean_dec(v_h__4_171_);
lean_dec(v_h__3_170_);
lean_dec(v_h__2_169_);
v_generation_172_ = lean_ctor_get(v_x_167_, 0);
lean_inc(v_generation_172_);
lean_dec_ref_known(v_x_167_, 1);
v___x_173_ = lean_apply_1(v_h__1_168_, v_generation_172_);
return v___x_173_;
}
case 1:
{
lean_object* v_impact_174_; lean_object* v___x_175_; 
lean_dec(v_h__4_171_);
lean_dec(v_h__3_170_);
lean_dec(v_h__1_168_);
v_impact_174_ = lean_ctor_get(v_x_167_, 0);
lean_inc(v_impact_174_);
lean_dec_ref_known(v_x_167_, 1);
v___x_175_ = lean_apply_1(v_h__2_169_, v_impact_174_);
return v___x_175_;
}
case 2:
{
lean_object* v___x_176_; lean_object* v___x_177_; 
lean_dec(v_h__4_171_);
lean_dec(v_h__2_169_);
lean_dec(v_h__1_168_);
v___x_176_ = lean_box(0);
v___x_177_ = lean_apply_1(v_h__3_170_, v___x_176_);
return v___x_177_;
}
default: 
{
lean_object* v___x_178_; lean_object* v___x_179_; 
lean_dec(v_h__3_170_);
lean_dec(v_h__2_169_);
lean_dec(v_h__1_168_);
v___x_178_ = lean_box(0);
v___x_179_ = lean_apply_1(v_h__4_171_, v___x_178_);
return v___x_179_;
}
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRAtomicQuiescence(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRInFlightQuiescence(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRAtomicQuiescence(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
