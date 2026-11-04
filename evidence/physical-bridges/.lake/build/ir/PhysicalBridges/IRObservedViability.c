// Lean compiler output
// Module: PhysicalBridges.IRObservedViability
// Imports: public import Init public meta import Init public import PhysicalBridges.IRViability public import PhysicalBridges.IRObservablePermit
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
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenObserve___redArg();
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenObserve___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenObserve(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenObserve___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenNext___redArg(lean_object*, uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenNext___redArg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenNext(lean_object*, uint8_t, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenNext___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenObserve___redArg(){
_start:
{
lean_object* v___x_2_; 
v___x_2_ = lean_box(0);
return v___x_2_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenObserve___redArg___boxed(lean_object* v___dummy_3_){
_start:
{
lean_object* v_res_4_; 
v_res_4_ = lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenObserve___redArg();
return v_res_4_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenObserve(lean_object* v_x_5_){
_start:
{
lean_object* v___x_6_; 
v___x_6_ = lean_box(0);
return v___x_6_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenObserve___boxed(lean_object* v_x_7_){
_start:
{
lean_object* v_res_8_; 
v_res_8_ = lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenObserve(v_x_7_);
lean_dec(v_x_7_);
return v_res_8_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenNext___redArg(lean_object* v_s_9_, uint8_t v_a_10_){
_start:
{
lean_object* v___x_11_; uint8_t v___x_12_; 
v___x_11_ = lean_unsigned_to_nat(0u);
v___x_12_ = lean_nat_dec_eq(v_s_9_, v___x_11_);
if (v___x_12_ == 0)
{
lean_object* v___x_13_; uint8_t v___x_14_; 
v___x_13_ = lean_unsigned_to_nat(1u);
v___x_14_ = lean_nat_dec_eq(v_s_9_, v___x_13_);
if (v___x_14_ == 0)
{
lean_object* v___x_15_; 
v___x_15_ = lean_unsigned_to_nat(2u);
return v___x_15_;
}
else
{
if (v_a_10_ == 0)
{
lean_object* v___x_16_; 
v___x_16_ = lean_unsigned_to_nat(2u);
return v___x_16_;
}
else
{
return v___x_13_;
}
}
}
else
{
if (v_a_10_ == 0)
{
return v___x_11_;
}
else
{
lean_object* v___x_17_; 
v___x_17_ = lean_unsigned_to_nat(2u);
return v___x_17_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenNext___redArg___boxed(lean_object* v_s_18_, lean_object* v_a_19_){
_start:
{
uint8_t v_a_boxed_20_; lean_object* v_res_21_; 
v_a_boxed_20_ = lean_unbox(v_a_19_);
v_res_21_ = lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenNext___redArg(v_s_18_, v_a_boxed_20_);
lean_dec(v_s_18_);
return v_res_21_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenNext(lean_object* v_s_22_, uint8_t v_a_23_, lean_object* v_x_24_){
_start:
{
lean_object* v___x_25_; 
v___x_25_ = lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenNext___redArg(v_s_22_, v_a_23_);
return v___x_25_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenNext___boxed(lean_object* v_s_26_, lean_object* v_a_27_, lean_object* v_x_28_){
_start:
{
uint8_t v_a_boxed_29_; lean_object* v_res_30_; 
v_a_boxed_29_ = lean_unbox(v_a_27_);
v_res_30_ = lp_physical__bridges_PhysicalBridges_IRObservedViability_hiddenNext(v_s_26_, v_a_boxed_29_, v_x_28_);
lean_dec(v_s_26_);
return v_res_30_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRViability(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRObservablePermit(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRObservedViability(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRObservablePermit(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
