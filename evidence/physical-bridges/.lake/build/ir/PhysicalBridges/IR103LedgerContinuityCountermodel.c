// Lean compiler output
// Module: PhysicalBridges.IR103LedgerContinuityCountermodel
// Imports: public import Init public meta import Init public import PhysicalBridges.IR101ProtectedSector
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
lean_object* l_instDecidableEqNat___boxed(lean_object*, lean_object*);
uint8_t l_instDecidableEqList___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR103_instDecidableEqLedgerState_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR103_instDecidableEqLedgerState_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR103_instDecidableEqLedgerState(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR103_instDecidableEqLedgerState___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR103_instDecidableEqLedgerState_decEq(lean_object* v_x_1_, lean_object* v_x_2_){
_start:
{
lean_object* v_history_3_; uint8_t v_alive_4_; lean_object* v_history_5_; uint8_t v_alive_6_; lean_object* v___x_7_; uint8_t v___x_8_; 
v_history_3_ = lean_ctor_get(v_x_1_, 0);
lean_inc(v_history_3_);
v_alive_4_ = lean_ctor_get_uint8(v_x_1_, sizeof(void*)*1);
lean_dec_ref(v_x_1_);
v_history_5_ = lean_ctor_get(v_x_2_, 0);
lean_inc(v_history_5_);
v_alive_6_ = lean_ctor_get_uint8(v_x_2_, sizeof(void*)*1);
lean_dec_ref(v_x_2_);
v___x_7_ = lean_alloc_closure((void*)(l_instDecidableEqNat___boxed), 2, 0);
v___x_8_ = l_instDecidableEqList___redArg(v___x_7_, v_history_3_, v_history_5_);
if (v___x_8_ == 0)
{
return v___x_8_;
}
else
{
if (v_alive_6_ == 0)
{
if (v_alive_4_ == 0)
{
return v___x_8_;
}
else
{
return v_alive_6_;
}
}
else
{
return v_alive_4_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR103_instDecidableEqLedgerState_decEq___boxed(lean_object* v_x_9_, lean_object* v_x_10_){
_start:
{
uint8_t v_res_11_; lean_object* v_r_12_; 
v_res_11_ = lp_physical__bridges_PhysicalBridges_IR103_instDecidableEqLedgerState_decEq(v_x_9_, v_x_10_);
v_r_12_ = lean_box(v_res_11_);
return v_r_12_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR103_instDecidableEqLedgerState(lean_object* v_x_13_, lean_object* v_x_14_){
_start:
{
uint8_t v___x_15_; 
v___x_15_ = lp_physical__bridges_PhysicalBridges_IR103_instDecidableEqLedgerState_decEq(v_x_13_, v_x_14_);
return v___x_15_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR103_instDecidableEqLedgerState___boxed(lean_object* v_x_16_, lean_object* v_x_17_){
_start:
{
uint8_t v_res_18_; lean_object* v_r_19_; 
v_res_18_ = lp_physical__bridges_PhysicalBridges_IR103_instDecidableEqLedgerState(v_x_16_, v_x_17_);
v_r_19_ = lean_box(v_res_18_);
return v_r_19_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IR101ProtectedSector(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IR103LedgerContinuityCountermodel(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IR101ProtectedSector(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
