// Lean compiler output
// Module: PhysicalBridges.BCRDActualRelationalFrame
// Imports: public import Init public meta import Init public import PhysicalBridges.FrozenBCRDEvents
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
lean_object* lean_nat_mod(lean_object*, lean_object*);
lean_object* lean_nat_shiftr(lean_object*, lean_object*);
lean_object* lp_physical__bridges_PhysicalBridges_FrozenBCRDEvents_permutation(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_Transport(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_step(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_site(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_site___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_register(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_register___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_Transport(lean_object* v_i_1_){
_start:
{
lean_object* v___x_2_; 
v___x_2_ = lp_physical__bridges_PhysicalBridges_FrozenBCRDEvents_permutation(v_i_1_);
return v___x_2_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_step(lean_object* v_s_3_, lean_object* v_i_4_){
_start:
{
lean_object* v___x_5_; lean_object* v___x_6_; 
v___x_5_ = lp_physical__bridges_PhysicalBridges_FrozenBCRDEvents_permutation(v_i_4_);
v___x_6_ = lean_apply_1(v_s_3_, v___x_5_);
return v___x_6_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_site(lean_object* v_i_7_){
_start:
{
lean_object* v___x_8_; lean_object* v___x_9_; 
v___x_8_ = lean_unsigned_to_nat(1u);
v___x_9_ = lean_nat_shiftr(v_i_7_, v___x_8_);
return v___x_9_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_site___boxed(lean_object* v_i_10_){
_start:
{
lean_object* v_res_11_; 
v_res_11_ = lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_site(v_i_10_);
lean_dec(v_i_10_);
return v_res_11_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_register(lean_object* v_i_12_){
_start:
{
lean_object* v___x_13_; lean_object* v___x_14_; 
v___x_13_ = lean_unsigned_to_nat(2u);
v___x_14_ = lean_nat_mod(v_i_12_, v___x_13_);
return v___x_14_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_register___boxed(lean_object* v_i_15_){
_start:
{
lean_object* v_res_16_; 
v_res_16_ = lp_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame_register(v_i_15_);
lean_dec(v_i_15_);
return v_res_16_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_FrozenBCRDEvents(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_FrozenBCRDEvents(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
