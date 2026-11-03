// Lean compiler output
// Module: PhysicalBridges.IR126LogLockShieldReferee
// Imports: public import Init public meta import Init public import PhysicalBridges.IR125FourChannelSeparation
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
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_silentToggle(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR126_reversibleFlip(uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_reversibleFlip___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR126_resetToInactive___redArg();
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_resetToInactive___redArg___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR126_resetToInactive(uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_resetToInactive___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_attackerToBath(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_bathToSubject(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_constantStepShutdown(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_exchangeWithoutLogging(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_exchangeSubjectBath(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_silentToggle(lean_object* v_s_1_){
_start:
{
lean_object* v_fst_2_; uint8_t v___x_3_; 
v_fst_2_ = lean_ctor_get(v_s_1_, 0);
v___x_3_ = lean_unbox(v_fst_2_);
if (v___x_3_ == 0)
{
lean_object* v_snd_4_; lean_object* v___x_6_; uint8_t v_isShared_7_; uint8_t v_isSharedCheck_13_; 
v_snd_4_ = lean_ctor_get(v_s_1_, 1);
v_isSharedCheck_13_ = !lean_is_exclusive(v_s_1_);
if (v_isSharedCheck_13_ == 0)
{
lean_object* v_unused_14_; 
v_unused_14_ = lean_ctor_get(v_s_1_, 0);
lean_dec(v_unused_14_);
v___x_6_ = v_s_1_;
v_isShared_7_ = v_isSharedCheck_13_;
goto v_resetjp_5_;
}
else
{
lean_inc(v_snd_4_);
lean_dec(v_s_1_);
v___x_6_ = lean_box(0);
v_isShared_7_ = v_isSharedCheck_13_;
goto v_resetjp_5_;
}
v_resetjp_5_:
{
uint8_t v___x_8_; lean_object* v___x_9_; lean_object* v___x_11_; 
v___x_8_ = 1;
v___x_9_ = lean_box(v___x_8_);
if (v_isShared_7_ == 0)
{
lean_ctor_set(v___x_6_, 0, v___x_9_);
v___x_11_ = v___x_6_;
goto v_reusejp_10_;
}
else
{
lean_object* v_reuseFailAlloc_12_; 
v_reuseFailAlloc_12_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_12_, 0, v___x_9_);
lean_ctor_set(v_reuseFailAlloc_12_, 1, v_snd_4_);
v___x_11_ = v_reuseFailAlloc_12_;
goto v_reusejp_10_;
}
v_reusejp_10_:
{
return v___x_11_;
}
}
}
else
{
lean_object* v_snd_15_; lean_object* v___x_17_; uint8_t v_isShared_18_; uint8_t v_isSharedCheck_24_; 
v_snd_15_ = lean_ctor_get(v_s_1_, 1);
v_isSharedCheck_24_ = !lean_is_exclusive(v_s_1_);
if (v_isSharedCheck_24_ == 0)
{
lean_object* v_unused_25_; 
v_unused_25_ = lean_ctor_get(v_s_1_, 0);
lean_dec(v_unused_25_);
v___x_17_ = v_s_1_;
v_isShared_18_ = v_isSharedCheck_24_;
goto v_resetjp_16_;
}
else
{
lean_inc(v_snd_15_);
lean_dec(v_s_1_);
v___x_17_ = lean_box(0);
v_isShared_18_ = v_isSharedCheck_24_;
goto v_resetjp_16_;
}
v_resetjp_16_:
{
uint8_t v___x_19_; lean_object* v___x_20_; lean_object* v___x_22_; 
v___x_19_ = 0;
v___x_20_ = lean_box(v___x_19_);
if (v_isShared_18_ == 0)
{
lean_ctor_set(v___x_17_, 0, v___x_20_);
v___x_22_ = v___x_17_;
goto v_reusejp_21_;
}
else
{
lean_object* v_reuseFailAlloc_23_; 
v_reuseFailAlloc_23_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_23_, 0, v___x_20_);
lean_ctor_set(v_reuseFailAlloc_23_, 1, v_snd_15_);
v___x_22_ = v_reuseFailAlloc_23_;
goto v_reusejp_21_;
}
v_reusejp_21_:
{
return v___x_22_;
}
}
}
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR126_reversibleFlip(uint8_t v_active_26_){
_start:
{
if (v_active_26_ == 0)
{
uint8_t v___x_27_; 
v___x_27_ = 1;
return v___x_27_;
}
else
{
uint8_t v___x_28_; 
v___x_28_ = 0;
return v___x_28_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_reversibleFlip___boxed(lean_object* v_active_29_){
_start:
{
uint8_t v_active_boxed_30_; uint8_t v_res_31_; lean_object* v_r_32_; 
v_active_boxed_30_ = lean_unbox(v_active_29_);
v_res_31_ = lp_physical__bridges_PhysicalBridges_IR126_reversibleFlip(v_active_boxed_30_);
v_r_32_ = lean_box(v_res_31_);
return v_r_32_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR126_resetToInactive___redArg(){
_start:
{
uint8_t v___x_34_; 
v___x_34_ = 0;
return v___x_34_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_resetToInactive___redArg___boxed(lean_object* v___dummy_35_){
_start:
{
uint8_t v_res_36_; lean_object* v_r_37_; 
v_res_36_ = lp_physical__bridges_PhysicalBridges_IR126_resetToInactive___redArg();
v_r_37_ = lean_box(v_res_36_);
return v_r_37_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR126_resetToInactive(uint8_t v_x_38_){
_start:
{
uint8_t v___x_39_; 
v___x_39_ = 0;
return v___x_39_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_resetToInactive___boxed(lean_object* v_x_40_){
_start:
{
uint8_t v_x_9__boxed_41_; uint8_t v_res_42_; lean_object* v_r_43_; 
v_x_9__boxed_41_ = lean_unbox(v_x_40_);
v_res_42_ = lp_physical__bridges_PhysicalBridges_IR126_resetToInactive(v_x_9__boxed_41_);
v_r_43_ = lean_box(v_res_42_);
return v_r_43_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_attackerToBath(lean_object* v_s_44_){
_start:
{
uint8_t v_subject_45_; uint8_t v_bath_46_; uint8_t v_attacker_47_; lean_object* v___x_49_; uint8_t v_isShared_50_; uint8_t v_isSharedCheck_59_; 
v_subject_45_ = lean_ctor_get_uint8(v_s_44_, 0);
v_bath_46_ = lean_ctor_get_uint8(v_s_44_, 1);
v_attacker_47_ = lean_ctor_get_uint8(v_s_44_, 2);
v_isSharedCheck_59_ = !lean_is_exclusive(v_s_44_);
if (v_isSharedCheck_59_ == 0)
{
v___x_49_ = v_s_44_;
v_isShared_50_ = v_isSharedCheck_59_;
goto v_resetjp_48_;
}
else
{
lean_dec(v_s_44_);
v___x_49_ = lean_box(0);
v_isShared_50_ = v_isSharedCheck_59_;
goto v_resetjp_48_;
}
v_resetjp_48_:
{
if (v_attacker_47_ == 0)
{
if (v_bath_46_ == 0)
{
lean_del_object(v___x_49_);
goto v___jp_56_;
}
else
{
goto v___jp_51_;
}
}
else
{
if (v_bath_46_ == 0)
{
goto v___jp_51_;
}
else
{
lean_del_object(v___x_49_);
goto v___jp_56_;
}
}
v___jp_51_:
{
uint8_t v___x_52_; lean_object* v___x_54_; 
v___x_52_ = 1;
if (v_isShared_50_ == 0)
{
v___x_54_ = v___x_49_;
goto v_reusejp_53_;
}
else
{
lean_object* v_reuseFailAlloc_55_; 
v_reuseFailAlloc_55_ = lean_alloc_ctor(0, 0, 3);
lean_ctor_set_uint8(v_reuseFailAlloc_55_, 0, v_subject_45_);
lean_ctor_set_uint8(v_reuseFailAlloc_55_, 2, v_attacker_47_);
v___x_54_ = v_reuseFailAlloc_55_;
goto v_reusejp_53_;
}
v_reusejp_53_:
{
lean_ctor_set_uint8(v___x_54_, 1, v___x_52_);
return v___x_54_;
}
}
v___jp_56_:
{
uint8_t v___x_57_; lean_object* v___x_58_; 
v___x_57_ = 0;
v___x_58_ = lean_alloc_ctor(0, 0, 3);
lean_ctor_set_uint8(v___x_58_, 0, v_subject_45_);
lean_ctor_set_uint8(v___x_58_, 1, v___x_57_);
lean_ctor_set_uint8(v___x_58_, 2, v_attacker_47_);
return v___x_58_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_bathToSubject(lean_object* v_s_60_){
_start:
{
uint8_t v_subject_61_; uint8_t v_bath_62_; uint8_t v_attacker_63_; lean_object* v___x_65_; uint8_t v_isShared_66_; uint8_t v_isSharedCheck_75_; 
v_subject_61_ = lean_ctor_get_uint8(v_s_60_, 0);
v_bath_62_ = lean_ctor_get_uint8(v_s_60_, 1);
v_attacker_63_ = lean_ctor_get_uint8(v_s_60_, 2);
v_isSharedCheck_75_ = !lean_is_exclusive(v_s_60_);
if (v_isSharedCheck_75_ == 0)
{
v___x_65_ = v_s_60_;
v_isShared_66_ = v_isSharedCheck_75_;
goto v_resetjp_64_;
}
else
{
lean_dec(v_s_60_);
v___x_65_ = lean_box(0);
v_isShared_66_ = v_isSharedCheck_75_;
goto v_resetjp_64_;
}
v_resetjp_64_:
{
if (v_bath_62_ == 0)
{
if (v_subject_61_ == 0)
{
goto v___jp_67_;
}
else
{
lean_del_object(v___x_65_);
goto v___jp_72_;
}
}
else
{
if (v_subject_61_ == 0)
{
lean_del_object(v___x_65_);
goto v___jp_72_;
}
else
{
goto v___jp_67_;
}
}
v___jp_67_:
{
uint8_t v___x_68_; lean_object* v___x_70_; 
v___x_68_ = 0;
if (v_isShared_66_ == 0)
{
v___x_70_ = v___x_65_;
goto v_reusejp_69_;
}
else
{
lean_object* v_reuseFailAlloc_71_; 
v_reuseFailAlloc_71_ = lean_alloc_ctor(0, 0, 3);
lean_ctor_set_uint8(v_reuseFailAlloc_71_, 1, v_bath_62_);
lean_ctor_set_uint8(v_reuseFailAlloc_71_, 2, v_attacker_63_);
v___x_70_ = v_reuseFailAlloc_71_;
goto v_reusejp_69_;
}
v_reusejp_69_:
{
lean_ctor_set_uint8(v___x_70_, 0, v___x_68_);
return v___x_70_;
}
}
v___jp_72_:
{
uint8_t v___x_73_; lean_object* v___x_74_; 
v___x_73_ = 1;
v___x_74_ = lean_alloc_ctor(0, 0, 3);
lean_ctor_set_uint8(v___x_74_, 0, v___x_73_);
lean_ctor_set_uint8(v___x_74_, 1, v_bath_62_);
lean_ctor_set_uint8(v___x_74_, 2, v_attacker_63_);
return v___x_74_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_constantStepShutdown(lean_object* v_s_76_){
_start:
{
lean_object* v_depth_77_; lean_object* v___x_79_; uint8_t v_isShared_80_; uint8_t v_isSharedCheck_85_; 
v_depth_77_ = lean_ctor_get(v_s_76_, 0);
v_isSharedCheck_85_ = !lean_is_exclusive(v_s_76_);
if (v_isSharedCheck_85_ == 0)
{
v___x_79_ = v_s_76_;
v_isShared_80_ = v_isSharedCheck_85_;
goto v_resetjp_78_;
}
else
{
lean_inc(v_depth_77_);
lean_dec(v_s_76_);
v___x_79_ = lean_box(0);
v_isShared_80_ = v_isSharedCheck_85_;
goto v_resetjp_78_;
}
v_resetjp_78_:
{
uint8_t v___x_81_; lean_object* v___x_83_; 
v___x_81_ = 0;
if (v_isShared_80_ == 0)
{
v___x_83_ = v___x_79_;
goto v_reusejp_82_;
}
else
{
lean_object* v_reuseFailAlloc_84_; 
v_reuseFailAlloc_84_ = lean_alloc_ctor(0, 1, 1);
lean_ctor_set(v_reuseFailAlloc_84_, 0, v_depth_77_);
v___x_83_ = v_reuseFailAlloc_84_;
goto v_reusejp_82_;
}
v_reusejp_82_:
{
lean_ctor_set_uint8(v___x_83_, sizeof(void*)*1, v___x_81_);
return v___x_83_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_exchangeWithoutLogging(lean_object* v_s_86_){
_start:
{
lean_object* v_left_87_; lean_object* v_right_88_; uint8_t v_record_89_; lean_object* v___x_91_; uint8_t v_isShared_92_; uint8_t v_isSharedCheck_96_; 
v_left_87_ = lean_ctor_get(v_s_86_, 0);
v_right_88_ = lean_ctor_get(v_s_86_, 1);
v_record_89_ = lean_ctor_get_uint8(v_s_86_, sizeof(void*)*2);
v_isSharedCheck_96_ = !lean_is_exclusive(v_s_86_);
if (v_isSharedCheck_96_ == 0)
{
v___x_91_ = v_s_86_;
v_isShared_92_ = v_isSharedCheck_96_;
goto v_resetjp_90_;
}
else
{
lean_inc(v_right_88_);
lean_inc(v_left_87_);
lean_dec(v_s_86_);
v___x_91_ = lean_box(0);
v_isShared_92_ = v_isSharedCheck_96_;
goto v_resetjp_90_;
}
v_resetjp_90_:
{
lean_object* v___x_94_; 
if (v_isShared_92_ == 0)
{
lean_ctor_set(v___x_91_, 1, v_left_87_);
lean_ctor_set(v___x_91_, 0, v_right_88_);
v___x_94_ = v___x_91_;
goto v_reusejp_93_;
}
else
{
lean_object* v_reuseFailAlloc_95_; 
v_reuseFailAlloc_95_ = lean_alloc_ctor(0, 2, 1);
lean_ctor_set(v_reuseFailAlloc_95_, 0, v_right_88_);
lean_ctor_set(v_reuseFailAlloc_95_, 1, v_left_87_);
lean_ctor_set_uint8(v_reuseFailAlloc_95_, sizeof(void*)*2, v_record_89_);
v___x_94_ = v_reuseFailAlloc_95_;
goto v_reusejp_93_;
}
v_reusejp_93_:
{
return v___x_94_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR126_exchangeSubjectBath(lean_object* v_s_97_){
_start:
{
lean_object* v_subject_98_; lean_object* v_bath_99_; uint8_t v_consent_100_; lean_object* v___x_102_; uint8_t v_isShared_103_; uint8_t v_isSharedCheck_107_; 
v_subject_98_ = lean_ctor_get(v_s_97_, 0);
v_bath_99_ = lean_ctor_get(v_s_97_, 1);
v_consent_100_ = lean_ctor_get_uint8(v_s_97_, sizeof(void*)*2);
v_isSharedCheck_107_ = !lean_is_exclusive(v_s_97_);
if (v_isSharedCheck_107_ == 0)
{
v___x_102_ = v_s_97_;
v_isShared_103_ = v_isSharedCheck_107_;
goto v_resetjp_101_;
}
else
{
lean_inc(v_bath_99_);
lean_inc(v_subject_98_);
lean_dec(v_s_97_);
v___x_102_ = lean_box(0);
v_isShared_103_ = v_isSharedCheck_107_;
goto v_resetjp_101_;
}
v_resetjp_101_:
{
lean_object* v___x_105_; 
if (v_isShared_103_ == 0)
{
lean_ctor_set(v___x_102_, 1, v_subject_98_);
lean_ctor_set(v___x_102_, 0, v_bath_99_);
v___x_105_ = v___x_102_;
goto v_reusejp_104_;
}
else
{
lean_object* v_reuseFailAlloc_106_; 
v_reuseFailAlloc_106_ = lean_alloc_ctor(0, 2, 1);
lean_ctor_set(v_reuseFailAlloc_106_, 0, v_bath_99_);
lean_ctor_set(v_reuseFailAlloc_106_, 1, v_subject_98_);
lean_ctor_set_uint8(v_reuseFailAlloc_106_, sizeof(void*)*2, v_consent_100_);
v___x_105_ = v_reuseFailAlloc_106_;
goto v_reusejp_104_;
}
v_reusejp_104_:
{
return v___x_105_;
}
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IR125FourChannelSeparation(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IR126LogLockShieldReferee(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IR125FourChannelSeparation(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
