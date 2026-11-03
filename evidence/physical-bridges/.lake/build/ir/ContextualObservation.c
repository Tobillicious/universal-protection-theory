// Lean compiler output
// Module: ContextualObservation
// Imports: public import Init public meta import Init
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
lean_object* l_instDecidableEqNat___boxed(lean_object*, lean_object*);
uint8_t l_instDecidableEqList___redArg(lean_object*, lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00CodexObservation_after_spec__0___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_after___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_after(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00CodexObservation_after_spec__0(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_CodexObservation_instDecidableEqSink_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_instDecidableEqSink_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_CodexObservation_instDecidableEqSink(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_instDecidableEqSink___boxed(lean_object*, lean_object*);
static const lean_ctor_object lp_physical__bridges_CodexObservation_crash___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(7) << 1) | 1)),((lean_object*)(((size_t)(0) << 1) | 1))}};
static const lean_object* lp_physical__bridges_CodexObservation_crash___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_CodexObservation_crash___redArg___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_crash___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_crash(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_observe(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_observe___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_cachedStep(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_cachedStep___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00CodexObservation_after_spec__0___redArg(lean_object* v_step_1_, lean_object* v_x_2_, lean_object* v_x_3_){
_start:
{
if (lean_obj_tag(v_x_3_) == 0)
{
lean_dec(v_step_1_);
return v_x_2_;
}
else
{
lean_object* v_head_4_; lean_object* v_tail_5_; lean_object* v___x_6_; 
v_head_4_ = lean_ctor_get(v_x_3_, 0);
lean_inc(v_head_4_);
v_tail_5_ = lean_ctor_get(v_x_3_, 1);
lean_inc(v_tail_5_);
lean_dec_ref_known(v_x_3_, 2);
lean_inc(v_step_1_);
v___x_6_ = lean_apply_2(v_step_1_, v_x_2_, v_head_4_);
v_x_2_ = v___x_6_;
v_x_3_ = v_tail_5_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_after___redArg(lean_object* v_step_8_, lean_object* v_s_9_, lean_object* v_word_10_){
_start:
{
lean_object* v___x_11_; 
v___x_11_ = lp_physical__bridges_List_foldl___at___00CodexObservation_after_spec__0___redArg(v_step_8_, v_s_9_, v_word_10_);
return v___x_11_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_after(lean_object* v_S_12_, lean_object* v_A_13_, lean_object* v_step_14_, lean_object* v_s_15_, lean_object* v_word_16_){
_start:
{
lean_object* v___x_17_; 
v___x_17_ = lp_physical__bridges_List_foldl___at___00CodexObservation_after_spec__0___redArg(v_step_14_, v_s_15_, v_word_16_);
return v___x_17_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00CodexObservation_after_spec__0(lean_object* v_S_18_, lean_object* v_A_19_, lean_object* v_step_20_, lean_object* v_x_21_, lean_object* v_x_22_){
_start:
{
lean_object* v___x_23_; 
v___x_23_ = lp_physical__bridges_List_foldl___at___00CodexObservation_after_spec__0___redArg(v_step_20_, v_x_21_, v_x_22_);
return v___x_23_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_CodexObservation_instDecidableEqSink_decEq(lean_object* v_x_24_, lean_object* v_x_25_){
_start:
{
uint8_t v_idPresent_26_; lean_object* v_out_27_; uint8_t v_idPresent_28_; lean_object* v_out_29_; 
v_idPresent_26_ = lean_ctor_get_uint8(v_x_24_, sizeof(void*)*1);
v_out_27_ = lean_ctor_get(v_x_24_, 0);
lean_inc(v_out_27_);
lean_dec_ref(v_x_24_);
v_idPresent_28_ = lean_ctor_get_uint8(v_x_25_, sizeof(void*)*1);
v_out_29_ = lean_ctor_get(v_x_25_, 0);
lean_inc(v_out_29_);
lean_dec_ref(v_x_25_);
if (v_idPresent_28_ == 0)
{
if (v_idPresent_26_ == 0)
{
goto v___jp_30_;
}
else
{
lean_dec(v_out_29_);
lean_dec(v_out_27_);
return v_idPresent_28_;
}
}
else
{
if (v_idPresent_26_ == 0)
{
lean_dec(v_out_29_);
lean_dec(v_out_27_);
return v_idPresent_26_;
}
else
{
goto v___jp_30_;
}
}
v___jp_30_:
{
lean_object* v___x_31_; uint8_t v___x_32_; 
v___x_31_ = lean_alloc_closure((void*)(l_instDecidableEqNat___boxed), 2, 0);
v___x_32_ = l_instDecidableEqList___redArg(v___x_31_, v_out_27_, v_out_29_);
return v___x_32_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_instDecidableEqSink_decEq___boxed(lean_object* v_x_33_, lean_object* v_x_34_){
_start:
{
uint8_t v_res_35_; lean_object* v_r_36_; 
v_res_35_ = lp_physical__bridges_CodexObservation_instDecidableEqSink_decEq(v_x_33_, v_x_34_);
v_r_36_ = lean_box(v_res_35_);
return v_r_36_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_CodexObservation_instDecidableEqSink(lean_object* v_x_37_, lean_object* v_x_38_){
_start:
{
uint8_t v___x_39_; 
v___x_39_ = lp_physical__bridges_CodexObservation_instDecidableEqSink_decEq(v_x_37_, v_x_38_);
return v___x_39_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_instDecidableEqSink___boxed(lean_object* v_x_40_, lean_object* v_x_41_){
_start:
{
uint8_t v_res_42_; lean_object* v_r_43_; 
v_res_42_ = lp_physical__bridges_CodexObservation_instDecidableEqSink(v_x_40_, v_x_41_);
v_r_43_ = lean_box(v_res_42_);
return v_r_43_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_crash___redArg(lean_object* v_s_47_){
_start:
{
uint8_t v_idPresent_48_; 
v_idPresent_48_ = lean_ctor_get_uint8(v_s_47_, sizeof(void*)*1);
if (v_idPresent_48_ == 0)
{
lean_object* v_out_49_; lean_object* v___x_51_; uint8_t v_isShared_52_; uint8_t v_isSharedCheck_59_; 
v_out_49_ = lean_ctor_get(v_s_47_, 0);
v_isSharedCheck_59_ = !lean_is_exclusive(v_s_47_);
if (v_isSharedCheck_59_ == 0)
{
v___x_51_ = v_s_47_;
v_isShared_52_ = v_isSharedCheck_59_;
goto v_resetjp_50_;
}
else
{
lean_inc(v_out_49_);
lean_dec(v_s_47_);
v___x_51_ = lean_box(0);
v_isShared_52_ = v_isSharedCheck_59_;
goto v_resetjp_50_;
}
v_resetjp_50_:
{
uint8_t v___x_53_; lean_object* v___x_54_; lean_object* v___x_55_; lean_object* v___x_57_; 
v___x_53_ = 1;
v___x_54_ = ((lean_object*)(lp_physical__bridges_CodexObservation_crash___redArg___closed__0));
v___x_55_ = l_List_appendTR___redArg(v_out_49_, v___x_54_);
if (v_isShared_52_ == 0)
{
lean_ctor_set(v___x_51_, 0, v___x_55_);
v___x_57_ = v___x_51_;
goto v_reusejp_56_;
}
else
{
lean_object* v_reuseFailAlloc_58_; 
v_reuseFailAlloc_58_ = lean_alloc_ctor(0, 1, 1);
lean_ctor_set(v_reuseFailAlloc_58_, 0, v___x_55_);
v___x_57_ = v_reuseFailAlloc_58_;
goto v_reusejp_56_;
}
v_reusejp_56_:
{
lean_ctor_set_uint8(v___x_57_, sizeof(void*)*1, v___x_53_);
return v___x_57_;
}
}
}
else
{
return v_s_47_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_crash(lean_object* v_s_60_, lean_object* v_x_61_){
_start:
{
lean_object* v___x_62_; 
v___x_62_ = lp_physical__bridges_CodexObservation_crash___redArg(v_s_60_);
return v___x_62_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_observe(lean_object* v_s_63_){
_start:
{
lean_object* v_out_64_; 
v_out_64_ = lean_ctor_get(v_s_63_, 0);
lean_inc(v_out_64_);
return v_out_64_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_observe___boxed(lean_object* v_s_65_){
_start:
{
lean_object* v_res_66_; 
v_res_66_ = lp_physical__bridges_CodexObservation_observe(v_s_65_);
lean_dec_ref(v_s_65_);
return v_res_66_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_cachedStep(lean_object* v_s_67_, lean_object* v_a_68_){
_start:
{
lean_object* v_fst_69_; lean_object* v_snd_70_; lean_object* v___x_72_; uint8_t v_isShared_73_; uint8_t v_isSharedCheck_86_; 
v_fst_69_ = lean_ctor_get(v_s_67_, 0);
v_snd_70_ = lean_ctor_get(v_s_67_, 1);
v_isSharedCheck_86_ = !lean_is_exclusive(v_s_67_);
if (v_isSharedCheck_86_ == 0)
{
v___x_72_ = v_s_67_;
v_isShared_73_ = v_isSharedCheck_86_;
goto v_resetjp_71_;
}
else
{
lean_inc(v_snd_70_);
lean_inc(v_fst_69_);
lean_dec(v_s_67_);
v___x_72_ = lean_box(0);
v_isShared_73_ = v_isSharedCheck_86_;
goto v_resetjp_71_;
}
v_resetjp_71_:
{
lean_object* v___x_74_; uint8_t v___x_75_; 
v___x_74_ = lean_nat_add(v_fst_69_, v_a_68_);
lean_dec(v_fst_69_);
v___x_75_ = lean_unbox(v_snd_70_);
lean_dec(v_snd_70_);
if (v___x_75_ == 0)
{
uint8_t v___x_76_; lean_object* v___x_77_; lean_object* v___x_79_; 
v___x_76_ = 1;
v___x_77_ = lean_box(v___x_76_);
if (v_isShared_73_ == 0)
{
lean_ctor_set(v___x_72_, 1, v___x_77_);
lean_ctor_set(v___x_72_, 0, v___x_74_);
v___x_79_ = v___x_72_;
goto v_reusejp_78_;
}
else
{
lean_object* v_reuseFailAlloc_80_; 
v_reuseFailAlloc_80_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_80_, 0, v___x_74_);
lean_ctor_set(v_reuseFailAlloc_80_, 1, v___x_77_);
v___x_79_ = v_reuseFailAlloc_80_;
goto v_reusejp_78_;
}
v_reusejp_78_:
{
return v___x_79_;
}
}
else
{
uint8_t v___x_81_; lean_object* v___x_82_; lean_object* v___x_84_; 
v___x_81_ = 0;
v___x_82_ = lean_box(v___x_81_);
if (v_isShared_73_ == 0)
{
lean_ctor_set(v___x_72_, 1, v___x_82_);
lean_ctor_set(v___x_72_, 0, v___x_74_);
v___x_84_ = v___x_72_;
goto v_reusejp_83_;
}
else
{
lean_object* v_reuseFailAlloc_85_; 
v_reuseFailAlloc_85_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_85_, 0, v___x_74_);
lean_ctor_set(v_reuseFailAlloc_85_, 1, v___x_82_);
v___x_84_ = v_reuseFailAlloc_85_;
goto v_reusejp_83_;
}
v_reusejp_83_:
{
return v___x_84_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_CodexObservation_cachedStep___boxed(lean_object* v_s_87_, lean_object* v_a_88_){
_start:
{
lean_object* v_res_89_; 
v_res_89_ = lp_physical__bridges_CodexObservation_cachedStep(v_s_87_, v_a_88_);
lean_dec(v_a_88_);
return v_res_89_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_ContextualObservation(uint8_t builtin) {
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
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
