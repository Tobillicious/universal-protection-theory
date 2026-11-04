// Lean compiler output
// Module: PhysicalBridges.IRConcreteClockedStalls
// Imports: public import Init public meta import Init public import PhysicalBridges.IRClockedBoundedStalls
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
lean_object* lean_nat_sub(lean_object*, lean_object*);
lean_object* lean_nat_mul(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_step(lean_object*, uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_step___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_rank(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_rank___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_productive(uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_productive___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_clock(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_clock___boxed(lean_object*);
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_trace___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(1) << 1) | 1)),((lean_object*)(((size_t)(0) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_trace___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_trace___closed__0_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_trace___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(1) << 1) | 1)),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_trace___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_trace___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_trace___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_trace___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 1}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_trace___closed__1_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_trace___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_trace___closed__2_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_trace = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_trace___closed__2_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_step(lean_object* v_n_1_, uint8_t v_productive_2_){
_start:
{
if (v_productive_2_ == 0)
{
lean_inc(v_n_1_);
return v_n_1_;
}
else
{
lean_object* v___x_3_; lean_object* v___x_4_; 
v___x_3_ = lean_unsigned_to_nat(1u);
v___x_4_ = lean_nat_sub(v_n_1_, v___x_3_);
return v___x_4_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_step___boxed(lean_object* v_n_5_, lean_object* v_productive_6_){
_start:
{
uint8_t v_productive_boxed_7_; lean_object* v_res_8_; 
v_productive_boxed_7_ = lean_unbox(v_productive_6_);
v_res_8_ = lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_step(v_n_5_, v_productive_boxed_7_);
lean_dec(v_n_5_);
return v_res_8_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_rank(lean_object* v_n_9_){
_start:
{
lean_inc(v_n_9_);
return v_n_9_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_rank___boxed(lean_object* v_n_10_){
_start:
{
lean_object* v_res_11_; 
v_res_11_ = lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_rank(v_n_10_);
lean_dec(v_n_10_);
return v_res_11_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_productive(uint8_t v_e_12_){
_start:
{
return v_e_12_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_productive___boxed(lean_object* v_e_13_){
_start:
{
uint8_t v_e_boxed_14_; uint8_t v_res_15_; lean_object* v_r_16_; 
v_e_boxed_14_ = lean_unbox(v_e_13_);
v_res_15_ = lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_productive(v_e_boxed_14_);
v_r_16_ = lean_box(v_res_15_);
return v_r_16_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_clock(lean_object* v_n_17_){
_start:
{
lean_object* v___x_18_; lean_object* v___x_19_; 
v___x_18_ = lean_unsigned_to_nat(4u);
v___x_19_ = lean_nat_mul(v_n_17_, v___x_18_);
return v___x_19_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_clock___boxed(lean_object* v_n_20_){
_start:
{
lean_object* v_res_21_; 
v_res_21_ = lp_physical__bridges_PhysicalBridges_IRConcreteClockedStalls_clock(v_n_20_);
lean_dec(v_n_20_);
return v_res_21_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRClockedBoundedStalls(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRConcreteClockedStalls(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRClockedBoundedStalls(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
