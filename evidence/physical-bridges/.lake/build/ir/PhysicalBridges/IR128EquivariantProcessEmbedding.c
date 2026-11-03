// Lean compiler output
// Module: PhysicalBridges.IR128EquivariantProcessEmbedding
// Imports: public import Init public meta import Init public import PhysicalBridges.IR96DisturbanceSimulation
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
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_iterate___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_iterate___redArg___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_iterate(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_iterate___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg___lam__0(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg___lam__0___boxed(lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg___lam__0___boxed, .m_arity = 1, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg();
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_composeEmbedding___redArg___lam__0(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_composeEmbedding___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_composeEmbedding(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_composeEmbedding___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IR128EquivariantProcessEmbedding_0__PhysicalBridges_IR128_iterate_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IR128EquivariantProcessEmbedding_0__PhysicalBridges_IR128_iterate_match__1_splitter___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IR128EquivariantProcessEmbedding_0__PhysicalBridges_IR128_iterate_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IR128EquivariantProcessEmbedding_0__PhysicalBridges_IR128_iterate_match__1_splitter___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_iterate___redArg(lean_object* v_f_1_, lean_object* v_x_2_, lean_object* v_x_3_){
_start:
{
lean_object* v_zero_4_; uint8_t v_isZero_5_; 
v_zero_4_ = lean_unsigned_to_nat(0u);
v_isZero_5_ = lean_nat_dec_eq(v_x_2_, v_zero_4_);
if (v_isZero_5_ == 1)
{
lean_dec(v_f_1_);
lean_inc(v_x_3_);
return v_x_3_;
}
else
{
lean_object* v_one_6_; lean_object* v_n_7_; lean_object* v___x_8_; lean_object* v___x_9_; 
v_one_6_ = lean_unsigned_to_nat(1u);
v_n_7_ = lean_nat_sub(v_x_2_, v_one_6_);
lean_inc(v_f_1_);
v___x_8_ = lp_physical__bridges_PhysicalBridges_IR128_iterate___redArg(v_f_1_, v_n_7_, v_x_3_);
lean_dec(v_n_7_);
v___x_9_ = lean_apply_1(v_f_1_, v___x_8_);
return v___x_9_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_iterate___redArg___boxed(lean_object* v_f_10_, lean_object* v_x_11_, lean_object* v_x_12_){
_start:
{
lean_object* v_res_13_; 
v_res_13_ = lp_physical__bridges_PhysicalBridges_IR128_iterate___redArg(v_f_10_, v_x_11_, v_x_12_);
lean_dec(v_x_12_);
lean_dec(v_x_11_);
return v_res_13_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_iterate(lean_object* v_X_14_, lean_object* v_f_15_, lean_object* v_x_16_, lean_object* v_x_17_){
_start:
{
lean_object* v___x_18_; 
v___x_18_ = lp_physical__bridges_PhysicalBridges_IR128_iterate___redArg(v_f_15_, v_x_16_, v_x_17_);
return v___x_18_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_iterate___boxed(lean_object* v_X_19_, lean_object* v_f_20_, lean_object* v_x_21_, lean_object* v_x_22_){
_start:
{
lean_object* v_res_23_; 
v_res_23_ = lp_physical__bridges_PhysicalBridges_IR128_iterate(v_X_19_, v_f_20_, v_x_21_, v_x_22_);
lean_dec(v_x_22_);
lean_dec(v_x_21_);
return v_res_23_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg___lam__0(lean_object* v___y_24_){
_start:
{
lean_inc(v___y_24_);
return v___y_24_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg___lam__0___boxed(lean_object* v___y_25_){
_start:
{
lean_object* v_res_26_; 
v_res_26_ = lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg___lam__0(v___y_25_);
lean_dec(v___y_25_);
return v_res_26_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg(){
_start:
{
lean_object* v___f_29_; 
v___f_29_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg___closed__0));
return v___f_29_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg___boxed(lean_object* v___dummy_30_){
_start:
{
lean_object* v_res_31_; 
v_res_31_ = lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg();
return v_res_31_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding(lean_object* v_X_32_, lean_object* v_s_33_){
_start:
{
lean_object* v___f_34_; 
v___f_34_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___redArg___closed__0));
return v___f_34_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding___boxed(lean_object* v_X_35_, lean_object* v_s_36_){
_start:
{
lean_object* v_res_37_; 
v_res_37_ = lp_physical__bridges_PhysicalBridges_IR128_identityEmbedding(v_X_35_, v_s_36_);
lean_dec(v_s_36_);
return v_res_37_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_composeEmbedding___redArg___lam__0(lean_object* v_e_38_, lean_object* v_f_39_, lean_object* v_x_40_){
_start:
{
lean_object* v___x_41_; lean_object* v___x_42_; 
v___x_41_ = lean_apply_1(v_e_38_, v_x_40_);
v___x_42_ = lean_apply_1(v_f_39_, v___x_41_);
return v___x_42_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_composeEmbedding___redArg(lean_object* v_e_43_, lean_object* v_f_44_){
_start:
{
lean_object* v___f_45_; 
v___f_45_ = lean_alloc_closure((void*)(lp_physical__bridges_PhysicalBridges_IR128_composeEmbedding___redArg___lam__0), 3, 2);
lean_closure_set(v___f_45_, 0, v_e_43_);
lean_closure_set(v___f_45_, 1, v_f_44_);
return v___f_45_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_composeEmbedding(lean_object* v_X_46_, lean_object* v_Y_47_, lean_object* v_Z_48_, lean_object* v_s_49_, lean_object* v_t_50_, lean_object* v_v_51_, lean_object* v_e_52_, lean_object* v_f_53_){
_start:
{
lean_object* v___f_54_; 
v___f_54_ = lean_alloc_closure((void*)(lp_physical__bridges_PhysicalBridges_IR128_composeEmbedding___redArg___lam__0), 3, 2);
lean_closure_set(v___f_54_, 0, v_e_52_);
lean_closure_set(v___f_54_, 1, v_f_53_);
return v___f_54_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR128_composeEmbedding___boxed(lean_object* v_X_55_, lean_object* v_Y_56_, lean_object* v_Z_57_, lean_object* v_s_58_, lean_object* v_t_59_, lean_object* v_v_60_, lean_object* v_e_61_, lean_object* v_f_62_){
_start:
{
lean_object* v_res_63_; 
v_res_63_ = lp_physical__bridges_PhysicalBridges_IR128_composeEmbedding(v_X_55_, v_Y_56_, v_Z_57_, v_s_58_, v_t_59_, v_v_60_, v_e_61_, v_f_62_);
lean_dec(v_v_60_);
lean_dec(v_t_59_);
lean_dec(v_s_58_);
return v_res_63_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IR128EquivariantProcessEmbedding_0__PhysicalBridges_IR128_iterate_match__1_splitter___redArg(lean_object* v_x_64_, lean_object* v_x_65_, lean_object* v_h__1_66_, lean_object* v_h__2_67_){
_start:
{
lean_object* v_zero_68_; uint8_t v_isZero_69_; 
v_zero_68_ = lean_unsigned_to_nat(0u);
v_isZero_69_ = lean_nat_dec_eq(v_x_64_, v_zero_68_);
if (v_isZero_69_ == 1)
{
lean_object* v___x_70_; 
lean_dec(v_h__2_67_);
v___x_70_ = lean_apply_1(v_h__1_66_, v_x_65_);
return v___x_70_;
}
else
{
lean_object* v_one_71_; lean_object* v_n_72_; lean_object* v___x_73_; 
lean_dec(v_h__1_66_);
v_one_71_ = lean_unsigned_to_nat(1u);
v_n_72_ = lean_nat_sub(v_x_64_, v_one_71_);
v___x_73_ = lean_apply_2(v_h__2_67_, v_n_72_, v_x_65_);
return v___x_73_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IR128EquivariantProcessEmbedding_0__PhysicalBridges_IR128_iterate_match__1_splitter___redArg___boxed(lean_object* v_x_74_, lean_object* v_x_75_, lean_object* v_h__1_76_, lean_object* v_h__2_77_){
_start:
{
lean_object* v_res_78_; 
v_res_78_ = lp_physical__bridges___private_PhysicalBridges_IR128EquivariantProcessEmbedding_0__PhysicalBridges_IR128_iterate_match__1_splitter___redArg(v_x_74_, v_x_75_, v_h__1_76_, v_h__2_77_);
lean_dec(v_x_74_);
return v_res_78_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IR128EquivariantProcessEmbedding_0__PhysicalBridges_IR128_iterate_match__1_splitter(lean_object* v_X_79_, lean_object* v_motive_80_, lean_object* v_x_81_, lean_object* v_x_82_, lean_object* v_h__1_83_, lean_object* v_h__2_84_){
_start:
{
lean_object* v_zero_85_; uint8_t v_isZero_86_; 
v_zero_85_ = lean_unsigned_to_nat(0u);
v_isZero_86_ = lean_nat_dec_eq(v_x_81_, v_zero_85_);
if (v_isZero_86_ == 1)
{
lean_object* v___x_87_; 
lean_dec(v_h__2_84_);
v___x_87_ = lean_apply_1(v_h__1_83_, v_x_82_);
return v___x_87_;
}
else
{
lean_object* v_one_88_; lean_object* v_n_89_; lean_object* v___x_90_; 
lean_dec(v_h__1_83_);
v_one_88_ = lean_unsigned_to_nat(1u);
v_n_89_ = lean_nat_sub(v_x_81_, v_one_88_);
v___x_90_ = lean_apply_2(v_h__2_84_, v_n_89_, v_x_82_);
return v___x_90_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IR128EquivariantProcessEmbedding_0__PhysicalBridges_IR128_iterate_match__1_splitter___boxed(lean_object* v_X_91_, lean_object* v_motive_92_, lean_object* v_x_93_, lean_object* v_x_94_, lean_object* v_h__1_95_, lean_object* v_h__2_96_){
_start:
{
lean_object* v_res_97_; 
v_res_97_ = lp_physical__bridges___private_PhysicalBridges_IR128EquivariantProcessEmbedding_0__PhysicalBridges_IR128_iterate_match__1_splitter(v_X_91_, v_motive_92_, v_x_93_, v_x_94_, v_h__1_95_, v_h__2_96_);
lean_dec(v_x_93_);
return v_res_97_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IR96DisturbanceSimulation(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IR128EquivariantProcessEmbedding(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IR96DisturbanceSimulation(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
