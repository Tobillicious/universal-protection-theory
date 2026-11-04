// Lean compiler output
// Module: PhysicalBridges.IRConcreteBeliefExample
// Imports: public import Init public meta import Init public import PhysicalBridges.IRBeliefTrace
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
lean_object* lean_nat_add(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_observe___redArg();
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_observe___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_observe(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_observe___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_next___redArg(lean_object*, uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_next___redArg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_next(lean_object*, uint8_t, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_next___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_observe___redArg(){
_start:
{
lean_object* v___x_2_; 
v___x_2_ = lean_box(0);
return v___x_2_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_observe___redArg___boxed(lean_object* v___dummy_3_){
_start:
{
lean_object* v_res_4_; 
v_res_4_ = lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_observe___redArg();
return v_res_4_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_observe(lean_object* v_x_5_){
_start:
{
lean_object* v___x_6_; 
v___x_6_ = lean_box(0);
return v___x_6_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_observe___boxed(lean_object* v_x_7_){
_start:
{
lean_object* v_res_8_; 
v_res_8_ = lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_observe(v_x_7_);
lean_dec(v_x_7_);
return v_res_8_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_next___redArg(lean_object* v_s_9_, uint8_t v_a_10_){
_start:
{
if (v_a_10_ == 0)
{
lean_inc(v_s_9_);
return v_s_9_;
}
else
{
lean_object* v___x_11_; lean_object* v___x_12_; 
v___x_11_ = lean_unsigned_to_nat(1u);
v___x_12_ = lean_nat_add(v_s_9_, v___x_11_);
return v___x_12_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_next___redArg___boxed(lean_object* v_s_13_, lean_object* v_a_14_){
_start:
{
uint8_t v_a_boxed_15_; lean_object* v_res_16_; 
v_a_boxed_15_ = lean_unbox(v_a_14_);
v_res_16_ = lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_next___redArg(v_s_13_, v_a_boxed_15_);
lean_dec(v_s_13_);
return v_res_16_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_next(lean_object* v_s_17_, uint8_t v_a_18_, lean_object* v_x_19_){
_start:
{
lean_object* v___x_20_; 
v___x_20_ = lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_next___redArg(v_s_17_, v_a_18_);
return v___x_20_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_next___boxed(lean_object* v_s_21_, lean_object* v_a_22_, lean_object* v_x_23_){
_start:
{
uint8_t v_a_boxed_24_; lean_object* v_res_25_; 
v_a_boxed_24_ = lean_unbox(v_a_22_);
v_res_25_ = lp_physical__bridges_PhysicalBridges_IRConcreteBeliefExample_next(v_s_21_, v_a_boxed_24_, v_x_23_);
lean_dec(v_s_21_);
return v_res_25_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRBeliefTrace(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRConcreteBeliefExample(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRBeliefTrace(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
