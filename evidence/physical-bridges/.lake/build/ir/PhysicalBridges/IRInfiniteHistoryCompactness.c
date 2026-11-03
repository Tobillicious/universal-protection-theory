// Lean compiler output
// Module: PhysicalBridges.IRInfiniteHistoryCompactness
// Imports: public import Init public meta import Init public import PhysicalBridges.IRViability
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
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_stateAt___redArg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_stateAt___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_stateAt(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_stateAt___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep___redArg___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep___redArg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInfiniteHistoryCompactness_0__PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInfiniteHistoryCompactness_0__PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep_match__1_splitter___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInfiniteHistoryCompactness_0__PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInfiniteHistoryCompactness_0__PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep_match__1_splitter___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_stateAt___redArg(lean_object* v_next_1_, lean_object* v_policy_2_, lean_object* v_stream_3_, lean_object* v_initial_4_, lean_object* v_x_5_){
_start:
{
lean_object* v_zero_6_; uint8_t v_isZero_7_; 
v_zero_6_ = lean_unsigned_to_nat(0u);
v_isZero_7_ = lean_nat_dec_eq(v_x_5_, v_zero_6_);
if (v_isZero_7_ == 1)
{
lean_dec(v_stream_3_);
lean_dec_ref(v_policy_2_);
lean_dec(v_next_1_);
lean_inc(v_initial_4_);
return v_initial_4_;
}
else
{
lean_object* v_one_8_; lean_object* v_n_9_; lean_object* v___x_10_; lean_object* v___x_11_; lean_object* v___x_12_; lean_object* v___x_13_; 
v_one_8_ = lean_unsigned_to_nat(1u);
v_n_9_ = lean_nat_sub(v_x_5_, v_one_8_);
lean_inc(v_stream_3_);
lean_inc_ref(v_policy_2_);
lean_inc(v_next_1_);
v___x_10_ = lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_stateAt___redArg(v_next_1_, v_policy_2_, v_stream_3_, v_initial_4_, v_n_9_);
lean_inc(v___x_10_);
v___x_11_ = lean_apply_1(v_policy_2_, v___x_10_);
v___x_12_ = lean_apply_1(v_stream_3_, v_n_9_);
v___x_13_ = lean_apply_3(v_next_1_, v___x_10_, v___x_11_, v___x_12_);
return v___x_13_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_stateAt___redArg___boxed(lean_object* v_next_14_, lean_object* v_policy_15_, lean_object* v_stream_16_, lean_object* v_initial_17_, lean_object* v_x_18_){
_start:
{
lean_object* v_res_19_; 
v_res_19_ = lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_stateAt___redArg(v_next_14_, v_policy_15_, v_stream_16_, v_initial_17_, v_x_18_);
lean_dec(v_x_18_);
lean_dec(v_initial_17_);
return v_res_19_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_stateAt(lean_object* v_S_20_, lean_object* v_D_21_, lean_object* v_next_22_, lean_object* v_policy_23_, lean_object* v_stream_24_, lean_object* v_initial_25_, lean_object* v_x_26_){
_start:
{
lean_object* v___x_27_; 
v___x_27_ = lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_stateAt___redArg(v_next_22_, v_policy_23_, v_stream_24_, v_initial_25_, v_x_26_);
return v___x_27_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_stateAt___boxed(lean_object* v_S_28_, lean_object* v_D_29_, lean_object* v_next_30_, lean_object* v_policy_31_, lean_object* v_stream_32_, lean_object* v_initial_33_, lean_object* v_x_34_){
_start:
{
lean_object* v_res_35_; 
v_res_35_ = lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_stateAt(v_S_28_, v_D_29_, v_next_30_, v_policy_31_, v_stream_32_, v_initial_33_, v_x_34_);
lean_dec(v_x_34_);
lean_dec(v_initial_33_);
return v_res_35_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep___redArg(lean_object* v_s_38_, lean_object* v_a_39_){
_start:
{
if (lean_obj_tag(v_s_38_) == 0)
{
lean_object* v___x_40_; lean_object* v___x_41_; lean_object* v___x_42_; 
v___x_40_ = lean_unsigned_to_nat(1u);
v___x_41_ = lean_nat_add(v_a_39_, v___x_40_);
v___x_42_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v___x_42_, 0, v___x_41_);
return v___x_42_;
}
else
{
lean_object* v_val_43_; lean_object* v___x_45_; uint8_t v_isShared_46_; uint8_t v_isSharedCheck_55_; 
v_val_43_ = lean_ctor_get(v_s_38_, 0);
v_isSharedCheck_55_ = !lean_is_exclusive(v_s_38_);
if (v_isSharedCheck_55_ == 0)
{
v___x_45_ = v_s_38_;
v_isShared_46_ = v_isSharedCheck_55_;
goto v_resetjp_44_;
}
else
{
lean_inc(v_val_43_);
lean_dec(v_s_38_);
v___x_45_ = lean_box(0);
v_isShared_46_ = v_isSharedCheck_55_;
goto v_resetjp_44_;
}
v_resetjp_44_:
{
lean_object* v_zero_47_; uint8_t v_isZero_48_; 
v_zero_47_ = lean_unsigned_to_nat(0u);
v_isZero_48_ = lean_nat_dec_eq(v_val_43_, v_zero_47_);
if (v_isZero_48_ == 1)
{
lean_object* v___x_49_; 
lean_del_object(v___x_45_);
lean_dec(v_val_43_);
v___x_49_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep___redArg___closed__0));
return v___x_49_;
}
else
{
lean_object* v_one_50_; lean_object* v_n_51_; lean_object* v___x_53_; 
v_one_50_ = lean_unsigned_to_nat(1u);
v_n_51_ = lean_nat_sub(v_val_43_, v_one_50_);
lean_dec(v_val_43_);
if (v_isShared_46_ == 0)
{
lean_ctor_set(v___x_45_, 0, v_n_51_);
v___x_53_ = v___x_45_;
goto v_reusejp_52_;
}
else
{
lean_object* v_reuseFailAlloc_54_; 
v_reuseFailAlloc_54_ = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(v_reuseFailAlloc_54_, 0, v_n_51_);
v___x_53_ = v_reuseFailAlloc_54_;
goto v_reusejp_52_;
}
v_reusejp_52_:
{
return v___x_53_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep___redArg___boxed(lean_object* v_s_56_, lean_object* v_a_57_){
_start:
{
lean_object* v_res_58_; 
v_res_58_ = lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep___redArg(v_s_56_, v_a_57_);
lean_dec(v_a_57_);
return v_res_58_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep(lean_object* v_s_59_, lean_object* v_a_60_, lean_object* v_x_61_){
_start:
{
lean_object* v___x_62_; 
v___x_62_ = lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep___redArg(v_s_59_, v_a_60_);
return v___x_62_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep___boxed(lean_object* v_s_63_, lean_object* v_a_64_, lean_object* v_x_65_){
_start:
{
lean_object* v_res_66_; 
v_res_66_ = lp_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep(v_s_63_, v_a_64_, v_x_65_);
lean_dec(v_a_64_);
return v_res_66_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInfiniteHistoryCompactness_0__PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep_match__1_splitter___redArg(lean_object* v_s_67_, lean_object* v_h__1_68_, lean_object* v_h__2_69_, lean_object* v_h__3_70_){
_start:
{
if (lean_obj_tag(v_s_67_) == 0)
{
lean_object* v___x_71_; lean_object* v___x_72_; 
lean_dec(v_h__3_70_);
lean_dec(v_h__2_69_);
v___x_71_ = lean_box(0);
v___x_72_ = lean_apply_1(v_h__1_68_, v___x_71_);
return v___x_72_;
}
else
{
lean_object* v_val_73_; lean_object* v_zero_74_; uint8_t v_isZero_75_; 
lean_dec(v_h__1_68_);
v_val_73_ = lean_ctor_get(v_s_67_, 0);
v_zero_74_ = lean_unsigned_to_nat(0u);
v_isZero_75_ = lean_nat_dec_eq(v_val_73_, v_zero_74_);
if (v_isZero_75_ == 1)
{
lean_object* v___x_76_; lean_object* v___x_77_; 
lean_dec(v_h__3_70_);
v___x_76_ = lean_box(0);
v___x_77_ = lean_apply_1(v_h__2_69_, v___x_76_);
return v___x_77_;
}
else
{
lean_object* v_one_78_; lean_object* v_n_79_; lean_object* v___x_80_; 
lean_dec(v_h__2_69_);
v_one_78_ = lean_unsigned_to_nat(1u);
v_n_79_ = lean_nat_sub(v_val_73_, v_one_78_);
v___x_80_ = lean_apply_1(v_h__3_70_, v_n_79_);
return v___x_80_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInfiniteHistoryCompactness_0__PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep_match__1_splitter___redArg___boxed(lean_object* v_s_81_, lean_object* v_h__1_82_, lean_object* v_h__2_83_, lean_object* v_h__3_84_){
_start:
{
lean_object* v_res_85_; 
v_res_85_ = lp_physical__bridges___private_PhysicalBridges_IRInfiniteHistoryCompactness_0__PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep_match__1_splitter___redArg(v_s_81_, v_h__1_82_, v_h__2_83_, v_h__3_84_);
lean_dec(v_s_81_);
return v_res_85_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInfiniteHistoryCompactness_0__PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep_match__1_splitter(lean_object* v_motive_86_, lean_object* v_s_87_, lean_object* v_h__1_88_, lean_object* v_h__2_89_, lean_object* v_h__3_90_){
_start:
{
if (lean_obj_tag(v_s_87_) == 0)
{
lean_object* v___x_91_; lean_object* v___x_92_; 
lean_dec(v_h__3_90_);
lean_dec(v_h__2_89_);
v___x_91_ = lean_box(0);
v___x_92_ = lean_apply_1(v_h__1_88_, v___x_91_);
return v___x_92_;
}
else
{
lean_object* v_val_93_; lean_object* v_zero_94_; uint8_t v_isZero_95_; 
lean_dec(v_h__1_88_);
v_val_93_ = lean_ctor_get(v_s_87_, 0);
v_zero_94_ = lean_unsigned_to_nat(0u);
v_isZero_95_ = lean_nat_dec_eq(v_val_93_, v_zero_94_);
if (v_isZero_95_ == 1)
{
lean_object* v___x_96_; lean_object* v___x_97_; 
lean_dec(v_h__3_90_);
v___x_96_ = lean_box(0);
v___x_97_ = lean_apply_1(v_h__2_89_, v___x_96_);
return v___x_97_;
}
else
{
lean_object* v_one_98_; lean_object* v_n_99_; lean_object* v___x_100_; 
lean_dec(v_h__2_89_);
v_one_98_ = lean_unsigned_to_nat(1u);
v_n_99_ = lean_nat_sub(v_val_93_, v_one_98_);
v___x_100_ = lean_apply_1(v_h__3_90_, v_n_99_);
return v___x_100_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRInfiniteHistoryCompactness_0__PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep_match__1_splitter___boxed(lean_object* v_motive_101_, lean_object* v_s_102_, lean_object* v_h__1_103_, lean_object* v_h__2_104_, lean_object* v_h__3_105_){
_start:
{
lean_object* v_res_106_; 
v_res_106_ = lp_physical__bridges___private_PhysicalBridges_IRInfiniteHistoryCompactness_0__PhysicalBridges_IRInfiniteHistoryCompactness_countdownStep_match__1_splitter(v_motive_101_, v_s_102_, v_h__1_103_, v_h__2_104_, v_h__3_105_);
lean_dec(v_s_102_);
return v_res_106_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRViability(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRViability(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
