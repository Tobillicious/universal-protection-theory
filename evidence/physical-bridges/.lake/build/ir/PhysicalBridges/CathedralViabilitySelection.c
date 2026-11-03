// Lean compiler output
// Module: PhysicalBridges.CathedralViabilitySelection
// Imports: public import Init public meta import Init public import PhysicalBridges.IRInfiniteHistoryCompactness
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
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyNext___redArg(uint8_t, uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyNext___redArg___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyNext(uint8_t, uint8_t, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyNext___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_CathedralViabilitySelection_0__PhysicalBridges_IRInfiniteHistoryCompactness_stateAt_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_CathedralViabilitySelection_0__PhysicalBridges_IRInfiniteHistoryCompactness_stateAt_match__1_splitter___redArg___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_CathedralViabilitySelection_0__PhysicalBridges_IRInfiniteHistoryCompactness_stateAt_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_CathedralViabilitySelection_0__PhysicalBridges_IRInfiniteHistoryCompactness_stateAt_match__1_splitter___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyCycle(uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyCycle___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyNext___redArg(uint8_t v_s_1_, uint8_t v_action_2_){
_start:
{
if (v_action_2_ == 0)
{
return v_s_1_;
}
else
{
uint8_t v___x_3_; 
v___x_3_ = 0;
return v___x_3_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyNext___redArg___boxed(lean_object* v_s_4_, lean_object* v_action_5_){
_start:
{
uint8_t v_s_boxed_6_; uint8_t v_action_boxed_7_; uint8_t v_res_8_; lean_object* v_r_9_; 
v_s_boxed_6_ = lean_unbox(v_s_4_);
v_action_boxed_7_ = lean_unbox(v_action_5_);
v_res_8_ = lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyNext___redArg(v_s_boxed_6_, v_action_boxed_7_);
v_r_9_ = lean_box(v_res_8_);
return v_r_9_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyNext(uint8_t v_s_10_, uint8_t v_action_11_, lean_object* v_x_12_){
_start:
{
uint8_t v___x_13_; 
v___x_13_ = lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyNext___redArg(v_s_10_, v_action_11_);
return v___x_13_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyNext___boxed(lean_object* v_s_14_, lean_object* v_action_15_, lean_object* v_x_16_){
_start:
{
uint8_t v_s_boxed_17_; uint8_t v_action_boxed_18_; uint8_t v_res_19_; lean_object* v_r_20_; 
v_s_boxed_17_ = lean_unbox(v_s_14_);
v_action_boxed_18_ = lean_unbox(v_action_15_);
v_res_19_ = lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyNext(v_s_boxed_17_, v_action_boxed_18_, v_x_16_);
v_r_20_ = lean_box(v_res_19_);
return v_r_20_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_CathedralViabilitySelection_0__PhysicalBridges_IRInfiniteHistoryCompactness_stateAt_match__1_splitter___redArg(lean_object* v_x_21_, lean_object* v_h__1_22_, lean_object* v_h__2_23_){
_start:
{
lean_object* v_zero_24_; uint8_t v_isZero_25_; 
v_zero_24_ = lean_unsigned_to_nat(0u);
v_isZero_25_ = lean_nat_dec_eq(v_x_21_, v_zero_24_);
if (v_isZero_25_ == 1)
{
lean_object* v___x_26_; lean_object* v___x_27_; 
lean_dec(v_h__2_23_);
v___x_26_ = lean_box(0);
v___x_27_ = lean_apply_1(v_h__1_22_, v___x_26_);
return v___x_27_;
}
else
{
lean_object* v_one_28_; lean_object* v_n_29_; lean_object* v___x_30_; 
lean_dec(v_h__1_22_);
v_one_28_ = lean_unsigned_to_nat(1u);
v_n_29_ = lean_nat_sub(v_x_21_, v_one_28_);
v___x_30_ = lean_apply_1(v_h__2_23_, v_n_29_);
return v___x_30_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_CathedralViabilitySelection_0__PhysicalBridges_IRInfiniteHistoryCompactness_stateAt_match__1_splitter___redArg___boxed(lean_object* v_x_31_, lean_object* v_h__1_32_, lean_object* v_h__2_33_){
_start:
{
lean_object* v_res_34_; 
v_res_34_ = lp_physical__bridges___private_PhysicalBridges_CathedralViabilitySelection_0__PhysicalBridges_IRInfiniteHistoryCompactness_stateAt_match__1_splitter___redArg(v_x_31_, v_h__1_32_, v_h__2_33_);
lean_dec(v_x_31_);
return v_res_34_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_CathedralViabilitySelection_0__PhysicalBridges_IRInfiniteHistoryCompactness_stateAt_match__1_splitter(lean_object* v_motive_35_, lean_object* v_x_36_, lean_object* v_h__1_37_, lean_object* v_h__2_38_){
_start:
{
lean_object* v_zero_39_; uint8_t v_isZero_40_; 
v_zero_39_ = lean_unsigned_to_nat(0u);
v_isZero_40_ = lean_nat_dec_eq(v_x_36_, v_zero_39_);
if (v_isZero_40_ == 1)
{
lean_object* v___x_41_; lean_object* v___x_42_; 
lean_dec(v_h__2_38_);
v___x_41_ = lean_box(0);
v___x_42_ = lean_apply_1(v_h__1_37_, v___x_41_);
return v___x_42_;
}
else
{
lean_object* v_one_43_; lean_object* v_n_44_; lean_object* v___x_45_; 
lean_dec(v_h__1_37_);
v_one_43_ = lean_unsigned_to_nat(1u);
v_n_44_ = lean_nat_sub(v_x_36_, v_one_43_);
v___x_45_ = lean_apply_1(v_h__2_38_, v_n_44_);
return v___x_45_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_CathedralViabilitySelection_0__PhysicalBridges_IRInfiniteHistoryCompactness_stateAt_match__1_splitter___boxed(lean_object* v_motive_46_, lean_object* v_x_47_, lean_object* v_h__1_48_, lean_object* v_h__2_49_){
_start:
{
lean_object* v_res_50_; 
v_res_50_ = lp_physical__bridges___private_PhysicalBridges_CathedralViabilitySelection_0__PhysicalBridges_IRInfiniteHistoryCompactness_stateAt_match__1_splitter(v_motive_46_, v_x_47_, v_h__1_48_, v_h__2_49_);
lean_dec(v_x_47_);
return v_res_50_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyCycle(uint8_t v_s_51_){
_start:
{
if (v_s_51_ == 0)
{
uint8_t v___x_52_; 
v___x_52_ = 1;
return v___x_52_;
}
else
{
uint8_t v___x_53_; 
v___x_53_ = 0;
return v___x_53_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyCycle___boxed(lean_object* v_s_54_){
_start:
{
uint8_t v_s_boxed_55_; uint8_t v_res_56_; lean_object* v_r_57_; 
v_s_boxed_55_ = lean_unbox(v_s_54_);
v_res_56_ = lp_physical__bridges_PhysicalBridges_CathedralViabilitySelection_toyCycle(v_s_boxed_55_);
v_r_57_ = lean_box(v_res_56_);
return v_r_57_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_CathedralViabilitySelection(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
