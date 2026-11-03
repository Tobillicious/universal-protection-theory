// Lean compiler output
// Module: PhysicalBridges.IR104ThreeCaseAuthorization
// Imports: public import Init public meta import Init public import PhysicalBridges.IR103LedgerContinuityCountermodel
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
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorIdx(uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorElim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorElim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorElim(lean_object*, lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_continue_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_continue_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_continue_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_continue_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_consentedEnd_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_consentedEnd_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_consentedEnd_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_consentedEnd_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_unconsentedEnd_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_unconsentedEnd_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_unconsentedEnd_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_unconsentedEnd_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ofNat(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ofNat___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR104_instDecidableEqTransitionKind(uint8_t, uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_instDecidableEqTransitionKind___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorIdx(uint8_t v_x_1_){
_start:
{
switch(v_x_1_)
{
case 0:
{
lean_object* v___x_2_; 
v___x_2_ = lean_unsigned_to_nat(0u);
return v___x_2_;
}
case 1:
{
lean_object* v___x_3_; 
v___x_3_ = lean_unsigned_to_nat(1u);
return v___x_3_;
}
default: 
{
lean_object* v___x_4_; 
v___x_4_ = lean_unsigned_to_nat(2u);
return v___x_4_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorIdx___boxed(lean_object* v_x_5_){
_start:
{
uint8_t v_x_boxed_6_; lean_object* v_res_7_; 
v_x_boxed_6_ = lean_unbox(v_x_5_);
v_res_7_ = lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorIdx(v_x_boxed_6_);
return v_res_7_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorElim___redArg(lean_object* v_k_8_){
_start:
{
lean_inc(v_k_8_);
return v_k_8_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorElim___redArg___boxed(lean_object* v_k_9_){
_start:
{
lean_object* v_res_10_; 
v_res_10_ = lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorElim___redArg(v_k_9_);
lean_dec(v_k_9_);
return v_res_10_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorElim(lean_object* v_motive_11_, lean_object* v_ctorIdx_12_, uint8_t v_t_13_, lean_object* v_h_14_, lean_object* v_k_15_){
_start:
{
lean_inc(v_k_15_);
return v_k_15_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorElim___boxed(lean_object* v_motive_16_, lean_object* v_ctorIdx_17_, lean_object* v_t_18_, lean_object* v_h_19_, lean_object* v_k_20_){
_start:
{
uint8_t v_t_boxed_21_; lean_object* v_res_22_; 
v_t_boxed_21_ = lean_unbox(v_t_18_);
v_res_22_ = lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorElim(v_motive_16_, v_ctorIdx_17_, v_t_boxed_21_, v_h_19_, v_k_20_);
lean_dec(v_k_20_);
lean_dec(v_ctorIdx_17_);
return v_res_22_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_continue_elim___redArg(lean_object* v_continue_23_){
_start:
{
lean_inc(v_continue_23_);
return v_continue_23_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_continue_elim___redArg___boxed(lean_object* v_continue_24_){
_start:
{
lean_object* v_res_25_; 
v_res_25_ = lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_continue_elim___redArg(v_continue_24_);
lean_dec(v_continue_24_);
return v_res_25_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_continue_elim(lean_object* v_motive_26_, uint8_t v_t_27_, lean_object* v_h_28_, lean_object* v_continue_29_){
_start:
{
lean_inc(v_continue_29_);
return v_continue_29_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_continue_elim___boxed(lean_object* v_motive_30_, lean_object* v_t_31_, lean_object* v_h_32_, lean_object* v_continue_33_){
_start:
{
uint8_t v_t_boxed_34_; lean_object* v_res_35_; 
v_t_boxed_34_ = lean_unbox(v_t_31_);
v_res_35_ = lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_continue_elim(v_motive_30_, v_t_boxed_34_, v_h_32_, v_continue_33_);
lean_dec(v_continue_33_);
return v_res_35_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_consentedEnd_elim___redArg(lean_object* v_consentedEnd_36_){
_start:
{
lean_inc(v_consentedEnd_36_);
return v_consentedEnd_36_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_consentedEnd_elim___redArg___boxed(lean_object* v_consentedEnd_37_){
_start:
{
lean_object* v_res_38_; 
v_res_38_ = lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_consentedEnd_elim___redArg(v_consentedEnd_37_);
lean_dec(v_consentedEnd_37_);
return v_res_38_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_consentedEnd_elim(lean_object* v_motive_39_, uint8_t v_t_40_, lean_object* v_h_41_, lean_object* v_consentedEnd_42_){
_start:
{
lean_inc(v_consentedEnd_42_);
return v_consentedEnd_42_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_consentedEnd_elim___boxed(lean_object* v_motive_43_, lean_object* v_t_44_, lean_object* v_h_45_, lean_object* v_consentedEnd_46_){
_start:
{
uint8_t v_t_boxed_47_; lean_object* v_res_48_; 
v_t_boxed_47_ = lean_unbox(v_t_44_);
v_res_48_ = lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_consentedEnd_elim(v_motive_43_, v_t_boxed_47_, v_h_45_, v_consentedEnd_46_);
lean_dec(v_consentedEnd_46_);
return v_res_48_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_unconsentedEnd_elim___redArg(lean_object* v_unconsentedEnd_49_){
_start:
{
lean_inc(v_unconsentedEnd_49_);
return v_unconsentedEnd_49_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_unconsentedEnd_elim___redArg___boxed(lean_object* v_unconsentedEnd_50_){
_start:
{
lean_object* v_res_51_; 
v_res_51_ = lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_unconsentedEnd_elim___redArg(v_unconsentedEnd_50_);
lean_dec(v_unconsentedEnd_50_);
return v_res_51_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_unconsentedEnd_elim(lean_object* v_motive_52_, uint8_t v_t_53_, lean_object* v_h_54_, lean_object* v_unconsentedEnd_55_){
_start:
{
lean_inc(v_unconsentedEnd_55_);
return v_unconsentedEnd_55_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_unconsentedEnd_elim___boxed(lean_object* v_motive_56_, lean_object* v_t_57_, lean_object* v_h_58_, lean_object* v_unconsentedEnd_59_){
_start:
{
uint8_t v_t_boxed_60_; lean_object* v_res_61_; 
v_t_boxed_60_ = lean_unbox(v_t_57_);
v_res_61_ = lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_unconsentedEnd_elim(v_motive_56_, v_t_boxed_60_, v_h_58_, v_unconsentedEnd_59_);
lean_dec(v_unconsentedEnd_59_);
return v_res_61_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ofNat(lean_object* v_n_62_){
_start:
{
lean_object* v___x_63_; uint8_t v___x_64_; 
v___x_63_ = lean_unsigned_to_nat(0u);
v___x_64_ = lean_nat_dec_le(v_n_62_, v___x_63_);
if (v___x_64_ == 0)
{
lean_object* v___x_65_; uint8_t v___x_66_; 
v___x_65_ = lean_unsigned_to_nat(1u);
v___x_66_ = lean_nat_dec_le(v_n_62_, v___x_65_);
if (v___x_66_ == 0)
{
uint8_t v___x_67_; 
v___x_67_ = 2;
return v___x_67_;
}
else
{
uint8_t v___x_68_; 
v___x_68_ = 1;
return v___x_68_;
}
}
else
{
uint8_t v___x_69_; 
v___x_69_ = 0;
return v___x_69_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ofNat___boxed(lean_object* v_n_70_){
_start:
{
uint8_t v_res_71_; lean_object* v_r_72_; 
v_res_71_ = lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ofNat(v_n_70_);
lean_dec(v_n_70_);
v_r_72_ = lean_box(v_res_71_);
return v_r_72_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR104_instDecidableEqTransitionKind(uint8_t v_x_73_, uint8_t v_y_74_){
_start:
{
lean_object* v___x_75_; lean_object* v___x_76_; uint8_t v___x_77_; 
v___x_75_ = lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorIdx(v_x_73_);
v___x_76_ = lp_physical__bridges_PhysicalBridges_IR104_TransitionKind_ctorIdx(v_y_74_);
v___x_77_ = lean_nat_dec_eq(v___x_75_, v___x_76_);
lean_dec(v___x_76_);
lean_dec(v___x_75_);
return v___x_77_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR104_instDecidableEqTransitionKind___boxed(lean_object* v_x_78_, lean_object* v_y_79_){
_start:
{
uint8_t v_x_20__boxed_80_; uint8_t v_y_21__boxed_81_; uint8_t v_res_82_; lean_object* v_r_83_; 
v_x_20__boxed_80_ = lean_unbox(v_x_78_);
v_y_21__boxed_81_ = lean_unbox(v_y_79_);
v_res_82_ = lp_physical__bridges_PhysicalBridges_IR104_instDecidableEqTransitionKind(v_x_20__boxed_80_, v_y_21__boxed_81_);
v_r_83_ = lean_box(v_res_82_);
return v_r_83_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IR103LedgerContinuityCountermodel(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IR104ThreeCaseAuthorization(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IR103LedgerContinuityCountermodel(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
