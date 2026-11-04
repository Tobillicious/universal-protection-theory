// Lean compiler output
// Module: PhysicalBridges.IRA1PacketJournalJoin
// Imports: public import Init public meta import Init public import PhysicalBridges.IRA1DurableJournal
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
uint8_t lp_physical__bridges_PhysicalBridges_IRA1CausalField_fieldPermit(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketIngress_ingest(lean_object*, lean_object*, lean_object*);
lean_object* lp_physical__bridges_PhysicalBridges_IRA1DurableJournal_step(lean_object*, lean_object*);
extern lean_object* lp_physical__bridges_PhysicalBridges_IRA1DurableJournal_emptyJournal;
extern lean_object* lp_physical__bridges_PhysicalBridges_IRA1CausalField_exampleSession;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_commitIngress(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_commitIngress___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_unsafeQueuedIngress(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_unsafeQueuedIngress___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_reboot(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorIdx(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorElim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorElim(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_packet_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_packet_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_reboot_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_reboot_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_jointStep(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_jointStep___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1PacketJournalJoin_run_spec__0(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1PacketJournalJoin_run_spec__0___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_run(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_run___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_emptyJoint___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_emptyJoint___closed__0;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_emptyJoint;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_commitIngress(lean_object* v_authCheck_1_, lean_object* v_env_2_, lean_object* v_s_3_, lean_object* v_p_4_, lean_object* v_t_5_){
_start:
{
lean_object* v_session_6_; lean_object* v_journal_7_; uint8_t v___x_8_; 
v_session_6_ = lean_ctor_get(v_s_3_, 0);
v_journal_7_ = lean_ctor_get(v_s_3_, 1);
lean_inc_ref(v_p_4_);
lean_inc_ref(v_authCheck_1_);
v___x_8_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_fieldPermit(v_authCheck_1_, v_env_2_, v_session_6_, v_p_4_, v_t_5_);
if (v___x_8_ == 0)
{
lean_dec_ref(v_p_4_);
lean_dec_ref(v_authCheck_1_);
return v_s_3_;
}
else
{
lean_object* v___x_10_; uint8_t v_isShared_11_; uint8_t v_isSharedCheck_21_; 
lean_inc_ref(v_journal_7_);
lean_inc_ref(v_session_6_);
v_isSharedCheck_21_ = !lean_is_exclusive(v_s_3_);
if (v_isSharedCheck_21_ == 0)
{
lean_object* v_unused_22_; lean_object* v_unused_23_; 
v_unused_22_ = lean_ctor_get(v_s_3_, 1);
lean_dec(v_unused_22_);
v_unused_23_ = lean_ctor_get(v_s_3_, 0);
lean_dec(v_unused_23_);
v___x_10_ = v_s_3_;
v_isShared_11_ = v_isSharedCheck_21_;
goto v_resetjp_9_;
}
else
{
lean_dec(v_s_3_);
v___x_10_ = lean_box(0);
v_isShared_11_ = v_isSharedCheck_21_;
goto v_resetjp_9_;
}
v_resetjp_9_:
{
lean_object* v_payload_12_; lean_object* v___x_13_; lean_object* v___x_14_; lean_object* v___x_15_; lean_object* v___x_16_; lean_object* v___x_17_; lean_object* v___x_19_; 
v_payload_12_ = lean_ctor_get(v_p_4_, 2);
lean_inc(v_payload_12_);
v___x_13_ = lp_physical__bridges_PhysicalBridges_IRA1PacketIngress_ingest(v_authCheck_1_, v_session_6_, v_p_4_);
v___x_14_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_14_, 0, v_payload_12_);
v___x_15_ = lp_physical__bridges_PhysicalBridges_IRA1DurableJournal_step(v_journal_7_, v___x_14_);
lean_dec_ref_known(v___x_14_, 1);
v___x_16_ = lean_box(1);
v___x_17_ = lp_physical__bridges_PhysicalBridges_IRA1DurableJournal_step(v___x_15_, v___x_16_);
if (v_isShared_11_ == 0)
{
lean_ctor_set(v___x_10_, 1, v___x_17_);
lean_ctor_set(v___x_10_, 0, v___x_13_);
v___x_19_ = v___x_10_;
goto v_reusejp_18_;
}
else
{
lean_object* v_reuseFailAlloc_20_; 
v_reuseFailAlloc_20_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_20_, 0, v___x_13_);
lean_ctor_set(v_reuseFailAlloc_20_, 1, v___x_17_);
v___x_19_ = v_reuseFailAlloc_20_;
goto v_reusejp_18_;
}
v_reusejp_18_:
{
return v___x_19_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_commitIngress___boxed(lean_object* v_authCheck_24_, lean_object* v_env_25_, lean_object* v_s_26_, lean_object* v_p_27_, lean_object* v_t_28_){
_start:
{
lean_object* v_res_29_; 
v_res_29_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_commitIngress(v_authCheck_24_, v_env_25_, v_s_26_, v_p_27_, v_t_28_);
lean_dec_ref(v_t_28_);
lean_dec_ref(v_env_25_);
return v_res_29_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_unsafeQueuedIngress(lean_object* v_authCheck_30_, lean_object* v_env_31_, lean_object* v_s_32_, lean_object* v_p_33_, lean_object* v_t_34_){
_start:
{
lean_object* v_session_35_; lean_object* v_journal_36_; uint8_t v___x_37_; 
v_session_35_ = lean_ctor_get(v_s_32_, 0);
v_journal_36_ = lean_ctor_get(v_s_32_, 1);
lean_inc_ref(v_p_33_);
lean_inc_ref(v_authCheck_30_);
v___x_37_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_fieldPermit(v_authCheck_30_, v_env_31_, v_session_35_, v_p_33_, v_t_34_);
if (v___x_37_ == 0)
{
lean_dec_ref(v_p_33_);
lean_dec_ref(v_authCheck_30_);
return v_s_32_;
}
else
{
lean_object* v___x_39_; uint8_t v_isShared_40_; uint8_t v_isSharedCheck_48_; 
lean_inc_ref(v_journal_36_);
lean_inc_ref(v_session_35_);
v_isSharedCheck_48_ = !lean_is_exclusive(v_s_32_);
if (v_isSharedCheck_48_ == 0)
{
lean_object* v_unused_49_; lean_object* v_unused_50_; 
v_unused_49_ = lean_ctor_get(v_s_32_, 1);
lean_dec(v_unused_49_);
v_unused_50_ = lean_ctor_get(v_s_32_, 0);
lean_dec(v_unused_50_);
v___x_39_ = v_s_32_;
v_isShared_40_ = v_isSharedCheck_48_;
goto v_resetjp_38_;
}
else
{
lean_dec(v_s_32_);
v___x_39_ = lean_box(0);
v_isShared_40_ = v_isSharedCheck_48_;
goto v_resetjp_38_;
}
v_resetjp_38_:
{
lean_object* v_payload_41_; lean_object* v___x_42_; lean_object* v___x_43_; lean_object* v___x_44_; lean_object* v___x_46_; 
v_payload_41_ = lean_ctor_get(v_p_33_, 2);
lean_inc(v_payload_41_);
v___x_42_ = lp_physical__bridges_PhysicalBridges_IRA1PacketIngress_ingest(v_authCheck_30_, v_session_35_, v_p_33_);
v___x_43_ = lean_alloc_ctor(0, 1, 0);
lean_ctor_set(v___x_43_, 0, v_payload_41_);
v___x_44_ = lp_physical__bridges_PhysicalBridges_IRA1DurableJournal_step(v_journal_36_, v___x_43_);
lean_dec_ref_known(v___x_43_, 1);
if (v_isShared_40_ == 0)
{
lean_ctor_set(v___x_39_, 1, v___x_44_);
lean_ctor_set(v___x_39_, 0, v___x_42_);
v___x_46_ = v___x_39_;
goto v_reusejp_45_;
}
else
{
lean_object* v_reuseFailAlloc_47_; 
v_reuseFailAlloc_47_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_47_, 0, v___x_42_);
lean_ctor_set(v_reuseFailAlloc_47_, 1, v___x_44_);
v___x_46_ = v_reuseFailAlloc_47_;
goto v_reusejp_45_;
}
v_reusejp_45_:
{
return v___x_46_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_unsafeQueuedIngress___boxed(lean_object* v_authCheck_51_, lean_object* v_env_52_, lean_object* v_s_53_, lean_object* v_p_54_, lean_object* v_t_55_){
_start:
{
lean_object* v_res_56_; 
v_res_56_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_unsafeQueuedIngress(v_authCheck_51_, v_env_52_, v_s_53_, v_p_54_, v_t_55_);
lean_dec_ref(v_t_55_);
lean_dec_ref(v_env_52_);
return v_res_56_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_reboot(lean_object* v_s_57_){
_start:
{
lean_object* v_session_58_; lean_object* v_journal_59_; lean_object* v___x_61_; uint8_t v_isShared_62_; uint8_t v_isSharedCheck_68_; 
v_session_58_ = lean_ctor_get(v_s_57_, 0);
v_journal_59_ = lean_ctor_get(v_s_57_, 1);
v_isSharedCheck_68_ = !lean_is_exclusive(v_s_57_);
if (v_isSharedCheck_68_ == 0)
{
v___x_61_ = v_s_57_;
v_isShared_62_ = v_isSharedCheck_68_;
goto v_resetjp_60_;
}
else
{
lean_inc(v_journal_59_);
lean_inc(v_session_58_);
lean_dec(v_s_57_);
v___x_61_ = lean_box(0);
v_isShared_62_ = v_isSharedCheck_68_;
goto v_resetjp_60_;
}
v_resetjp_60_:
{
lean_object* v___x_63_; lean_object* v___x_64_; lean_object* v___x_66_; 
v___x_63_ = lean_box(2);
v___x_64_ = lp_physical__bridges_PhysicalBridges_IRA1DurableJournal_step(v_journal_59_, v___x_63_);
if (v_isShared_62_ == 0)
{
lean_ctor_set(v___x_61_, 1, v___x_64_);
v___x_66_ = v___x_61_;
goto v_reusejp_65_;
}
else
{
lean_object* v_reuseFailAlloc_67_; 
v_reuseFailAlloc_67_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_67_, 0, v_session_58_);
lean_ctor_set(v_reuseFailAlloc_67_, 1, v___x_64_);
v___x_66_ = v_reuseFailAlloc_67_;
goto v_reusejp_65_;
}
v_reusejp_65_:
{
return v___x_66_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorIdx(lean_object* v_x_69_){
_start:
{
if (lean_obj_tag(v_x_69_) == 0)
{
lean_object* v___x_70_; 
v___x_70_ = lean_unsigned_to_nat(0u);
return v___x_70_;
}
else
{
lean_object* v___x_71_; 
v___x_71_ = lean_unsigned_to_nat(1u);
return v___x_71_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorIdx___boxed(lean_object* v_x_72_){
_start:
{
lean_object* v_res_73_; 
v_res_73_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorIdx(v_x_72_);
lean_dec(v_x_72_);
return v_res_73_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorElim___redArg(lean_object* v_t_74_, lean_object* v_k_75_){
_start:
{
if (lean_obj_tag(v_t_74_) == 0)
{
lean_object* v_p_76_; lean_object* v_transit_77_; lean_object* v___x_78_; 
v_p_76_ = lean_ctor_get(v_t_74_, 0);
lean_inc_ref(v_p_76_);
v_transit_77_ = lean_ctor_get(v_t_74_, 1);
lean_inc_ref(v_transit_77_);
lean_dec_ref_known(v_t_74_, 2);
v___x_78_ = lean_apply_2(v_k_75_, v_p_76_, v_transit_77_);
return v___x_78_;
}
else
{
return v_k_75_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorElim(lean_object* v_motive_79_, lean_object* v_ctorIdx_80_, lean_object* v_t_81_, lean_object* v_h_82_, lean_object* v_k_83_){
_start:
{
lean_object* v___x_84_; 
v___x_84_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorElim___redArg(v_t_81_, v_k_83_);
return v___x_84_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorElim___boxed(lean_object* v_motive_85_, lean_object* v_ctorIdx_86_, lean_object* v_t_87_, lean_object* v_h_88_, lean_object* v_k_89_){
_start:
{
lean_object* v_res_90_; 
v_res_90_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorElim(v_motive_85_, v_ctorIdx_86_, v_t_87_, v_h_88_, v_k_89_);
lean_dec(v_ctorIdx_86_);
return v_res_90_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_packet_elim___redArg(lean_object* v_t_91_, lean_object* v_packet_92_){
_start:
{
lean_object* v___x_93_; 
v___x_93_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorElim___redArg(v_t_91_, v_packet_92_);
return v___x_93_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_packet_elim(lean_object* v_motive_94_, lean_object* v_t_95_, lean_object* v_h_96_, lean_object* v_packet_97_){
_start:
{
lean_object* v___x_98_; 
v___x_98_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorElim___redArg(v_t_95_, v_packet_97_);
return v___x_98_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_reboot_elim___redArg(lean_object* v_t_99_, lean_object* v_reboot_100_){
_start:
{
lean_object* v___x_101_; 
v___x_101_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorElim___redArg(v_t_99_, v_reboot_100_);
return v___x_101_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_reboot_elim(lean_object* v_motive_102_, lean_object* v_t_103_, lean_object* v_h_104_, lean_object* v_reboot_105_){
_start:
{
lean_object* v___x_106_; 
v___x_106_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_JointEvent_ctorElim___redArg(v_t_103_, v_reboot_105_);
return v___x_106_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_jointStep(lean_object* v_authCheck_107_, lean_object* v_env_108_, lean_object* v_s_109_, lean_object* v_x_110_){
_start:
{
if (lean_obj_tag(v_x_110_) == 0)
{
lean_object* v_p_111_; lean_object* v_transit_112_; lean_object* v___x_113_; 
v_p_111_ = lean_ctor_get(v_x_110_, 0);
lean_inc_ref(v_p_111_);
v_transit_112_ = lean_ctor_get(v_x_110_, 1);
lean_inc_ref(v_transit_112_);
lean_dec_ref_known(v_x_110_, 2);
v___x_113_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_commitIngress(v_authCheck_107_, v_env_108_, v_s_109_, v_p_111_, v_transit_112_);
lean_dec_ref(v_transit_112_);
return v___x_113_;
}
else
{
lean_object* v___x_114_; 
lean_dec_ref(v_authCheck_107_);
v___x_114_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_reboot(v_s_109_);
return v___x_114_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_jointStep___boxed(lean_object* v_authCheck_115_, lean_object* v_env_116_, lean_object* v_s_117_, lean_object* v_x_118_){
_start:
{
lean_object* v_res_119_; 
v_res_119_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_jointStep(v_authCheck_115_, v_env_116_, v_s_117_, v_x_118_);
lean_dec_ref(v_env_116_);
return v_res_119_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1PacketJournalJoin_run_spec__0(lean_object* v_authCheck_120_, lean_object* v_env_121_, lean_object* v_x_122_, lean_object* v_x_123_){
_start:
{
if (lean_obj_tag(v_x_123_) == 0)
{
lean_dec_ref(v_authCheck_120_);
return v_x_122_;
}
else
{
lean_object* v_head_124_; lean_object* v_tail_125_; lean_object* v___x_126_; 
v_head_124_ = lean_ctor_get(v_x_123_, 0);
lean_inc(v_head_124_);
v_tail_125_ = lean_ctor_get(v_x_123_, 1);
lean_inc(v_tail_125_);
lean_dec_ref_known(v_x_123_, 2);
lean_inc_ref(v_authCheck_120_);
v___x_126_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_jointStep(v_authCheck_120_, v_env_121_, v_x_122_, v_head_124_);
v_x_122_ = v___x_126_;
v_x_123_ = v_tail_125_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1PacketJournalJoin_run_spec__0___boxed(lean_object* v_authCheck_128_, lean_object* v_env_129_, lean_object* v_x_130_, lean_object* v_x_131_){
_start:
{
lean_object* v_res_132_; 
v_res_132_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1PacketJournalJoin_run_spec__0(v_authCheck_128_, v_env_129_, v_x_130_, v_x_131_);
lean_dec_ref(v_env_129_);
return v_res_132_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_run(lean_object* v_authCheck_133_, lean_object* v_env_134_, lean_object* v_s_135_, lean_object* v_events_136_){
_start:
{
lean_object* v___x_137_; 
v___x_137_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1PacketJournalJoin_run_spec__0(v_authCheck_133_, v_env_134_, v_s_135_, v_events_136_);
return v___x_137_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_run___boxed(lean_object* v_authCheck_138_, lean_object* v_env_139_, lean_object* v_s_140_, lean_object* v_events_141_){
_start:
{
lean_object* v_res_142_; 
v_res_142_ = lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_run(v_authCheck_138_, v_env_139_, v_s_140_, v_events_141_);
lean_dec_ref(v_env_139_);
return v_res_142_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_emptyJoint___closed__0(void){
_start:
{
lean_object* v___x_143_; lean_object* v___x_144_; lean_object* v___x_145_; 
v___x_143_ = lp_physical__bridges_PhysicalBridges_IRA1DurableJournal_emptyJournal;
v___x_144_ = lp_physical__bridges_PhysicalBridges_IRA1CausalField_exampleSession;
v___x_145_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_145_, 0, v___x_144_);
lean_ctor_set(v___x_145_, 1, v___x_143_);
return v___x_145_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_emptyJoint(void){
_start:
{
lean_object* v___x_146_; 
v___x_146_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_emptyJoint___closed__0, &lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_emptyJoint___closed__0_once, _init_lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_emptyJoint___closed__0);
return v___x_146_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRA1DurableJournal(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRA1DurableJournal(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_emptyJoint = _init_lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_emptyJoint();
lean_mark_persistent(lp_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin_emptyJoint);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
