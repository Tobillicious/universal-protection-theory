// Lean compiler output
// Module: PhysicalBridges.IR129BoundaryInvisibleKernel
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
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR129_instDecidableEqTwoLinks_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR129_instDecidableEqTwoLinks_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR129_instDecidableEqTwoLinks(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR129_instDecidableEqTwoLinks___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR129_parity(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR129_parity___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR129_flipBoth(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR129_parityBoundaryReadout(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR129_parityBoundaryReadout___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR129_instDecidableEqTwoLinks_decEq(lean_object* v_x_1_, lean_object* v_x_2_){
_start:
{
uint8_t v_left_3_; uint8_t v_right_4_; uint8_t v_left_5_; uint8_t v_right_6_; uint8_t v___y_8_; 
v_left_3_ = lean_ctor_get_uint8(v_x_1_, 0);
v_right_4_ = lean_ctor_get_uint8(v_x_1_, 1);
v_left_5_ = lean_ctor_get_uint8(v_x_2_, 0);
v_right_6_ = lean_ctor_get_uint8(v_x_2_, 1);
if (v_left_5_ == 0)
{
if (v_left_3_ == 0)
{
uint8_t v___x_9_; 
v___x_9_ = 1;
v___y_8_ = v___x_9_;
goto v___jp_7_;
}
else
{
return v_left_5_;
}
}
else
{
if (v_left_3_ == 0)
{
return v_left_3_;
}
else
{
v___y_8_ = v_left_3_;
goto v___jp_7_;
}
}
v___jp_7_:
{
if (v_right_6_ == 0)
{
if (v_right_4_ == 0)
{
return v___y_8_;
}
else
{
return v_right_6_;
}
}
else
{
return v_right_4_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR129_instDecidableEqTwoLinks_decEq___boxed(lean_object* v_x_10_, lean_object* v_x_11_){
_start:
{
uint8_t v_res_12_; lean_object* v_r_13_; 
v_res_12_ = lp_physical__bridges_PhysicalBridges_IR129_instDecidableEqTwoLinks_decEq(v_x_10_, v_x_11_);
lean_dec_ref(v_x_11_);
lean_dec_ref(v_x_10_);
v_r_13_ = lean_box(v_res_12_);
return v_r_13_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR129_instDecidableEqTwoLinks(lean_object* v_x_14_, lean_object* v_x_15_){
_start:
{
uint8_t v___x_16_; 
v___x_16_ = lp_physical__bridges_PhysicalBridges_IR129_instDecidableEqTwoLinks_decEq(v_x_14_, v_x_15_);
return v___x_16_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR129_instDecidableEqTwoLinks___boxed(lean_object* v_x_17_, lean_object* v_x_18_){
_start:
{
uint8_t v_res_19_; lean_object* v_r_20_; 
v_res_19_ = lp_physical__bridges_PhysicalBridges_IR129_instDecidableEqTwoLinks(v_x_17_, v_x_18_);
lean_dec_ref(v_x_18_);
lean_dec_ref(v_x_17_);
v_r_20_ = lean_box(v_res_19_);
return v_r_20_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR129_parity(lean_object* v_s_21_){
_start:
{
uint8_t v_right_22_; 
v_right_22_ = lean_ctor_get_uint8(v_s_21_, 1);
if (v_right_22_ == 0)
{
uint8_t v_left_23_; 
v_left_23_ = lean_ctor_get_uint8(v_s_21_, 0);
return v_left_23_;
}
else
{
uint8_t v_left_24_; 
v_left_24_ = lean_ctor_get_uint8(v_s_21_, 0);
if (v_left_24_ == 0)
{
return v_right_22_;
}
else
{
uint8_t v___x_25_; 
v___x_25_ = 0;
return v___x_25_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR129_parity___boxed(lean_object* v_s_26_){
_start:
{
uint8_t v_res_27_; lean_object* v_r_28_; 
v_res_27_ = lp_physical__bridges_PhysicalBridges_IR129_parity(v_s_26_);
lean_dec_ref(v_s_26_);
v_r_28_ = lean_box(v_res_27_);
return v_r_28_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR129_flipBoth(lean_object* v_s_29_){
_start:
{
uint8_t v_left_30_; uint8_t v_right_31_; lean_object* v___x_33_; uint8_t v_isShared_34_; uint8_t v_isSharedCheck_47_; 
v_left_30_ = lean_ctor_get_uint8(v_s_29_, 0);
v_right_31_ = lean_ctor_get_uint8(v_s_29_, 1);
v_isSharedCheck_47_ = !lean_is_exclusive(v_s_29_);
if (v_isSharedCheck_47_ == 0)
{
v___x_33_ = v_s_29_;
v_isShared_34_ = v_isSharedCheck_47_;
goto v_resetjp_32_;
}
else
{
lean_dec(v_s_29_);
v___x_33_ = lean_box(0);
v_isShared_34_ = v_isSharedCheck_47_;
goto v_resetjp_32_;
}
v_resetjp_32_:
{
uint8_t v___y_36_; 
if (v_left_30_ == 0)
{
uint8_t v___x_45_; 
v___x_45_ = 1;
v___y_36_ = v___x_45_;
goto v___jp_35_;
}
else
{
uint8_t v___x_46_; 
v___x_46_ = 0;
v___y_36_ = v___x_46_;
goto v___jp_35_;
}
v___jp_35_:
{
if (v_right_31_ == 0)
{
uint8_t v___x_37_; lean_object* v___x_39_; 
v___x_37_ = 1;
if (v_isShared_34_ == 0)
{
v___x_39_ = v___x_33_;
goto v_reusejp_38_;
}
else
{
lean_object* v_reuseFailAlloc_40_; 
v_reuseFailAlloc_40_ = lean_alloc_ctor(0, 0, 2);
v___x_39_ = v_reuseFailAlloc_40_;
goto v_reusejp_38_;
}
v_reusejp_38_:
{
lean_ctor_set_uint8(v___x_39_, 0, v___y_36_);
lean_ctor_set_uint8(v___x_39_, 1, v___x_37_);
return v___x_39_;
}
}
else
{
uint8_t v___x_41_; lean_object* v___x_43_; 
v___x_41_ = 0;
if (v_isShared_34_ == 0)
{
v___x_43_ = v___x_33_;
goto v_reusejp_42_;
}
else
{
lean_object* v_reuseFailAlloc_44_; 
v_reuseFailAlloc_44_ = lean_alloc_ctor(0, 0, 2);
v___x_43_ = v_reuseFailAlloc_44_;
goto v_reusejp_42_;
}
v_reusejp_42_:
{
lean_ctor_set_uint8(v___x_43_, 0, v___y_36_);
lean_ctor_set_uint8(v___x_43_, 1, v___x_41_);
return v___x_43_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR129_parityBoundaryReadout(lean_object* v_o_48_, lean_object* v_s_49_){
_start:
{
uint8_t v___x_50_; lean_object* v___x_51_; lean_object* v___x_52_; 
v___x_50_ = lp_physical__bridges_PhysicalBridges_IR129_parity(v_s_49_);
v___x_51_ = lean_box(v___x_50_);
v___x_52_ = lean_apply_1(v_o_48_, v___x_51_);
return v___x_52_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR129_parityBoundaryReadout___boxed(lean_object* v_o_53_, lean_object* v_s_54_){
_start:
{
lean_object* v_res_55_; 
v_res_55_ = lp_physical__bridges_PhysicalBridges_IR129_parityBoundaryReadout(v_o_53_, v_s_54_);
lean_dec_ref(v_s_54_);
return v_res_55_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IR125FourChannelSeparation(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IR129BoundaryInvisibleKernel(uint8_t builtin) {
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
