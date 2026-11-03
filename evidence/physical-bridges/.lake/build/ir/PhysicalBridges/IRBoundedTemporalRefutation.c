// Lean compiler output
// Module: PhysicalBridges.IRBoundedTemporalRefutation
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
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_request(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_request___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_served(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_served___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_neverServed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_neverServed___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_servicedAfter(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_servicedAfter___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_request(lean_object* v_h_1_, lean_object* v_n_2_){
_start:
{
lean_object* v___x_3_; lean_object* v_fst_4_; uint8_t v___x_5_; 
v___x_3_ = lean_apply_1(v_h_1_, v_n_2_);
v_fst_4_ = lean_ctor_get(v___x_3_, 0);
lean_inc(v_fst_4_);
lean_dec_ref(v___x_3_);
v___x_5_ = lean_unbox(v_fst_4_);
lean_dec(v_fst_4_);
return v___x_5_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_request___boxed(lean_object* v_h_6_, lean_object* v_n_7_){
_start:
{
uint8_t v_res_8_; lean_object* v_r_9_; 
v_res_8_ = lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_request(v_h_6_, v_n_7_);
v_r_9_ = lean_box(v_res_8_);
return v_r_9_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_served(lean_object* v_h_10_, lean_object* v_n_11_){
_start:
{
lean_object* v___x_12_; lean_object* v_snd_13_; uint8_t v___x_14_; 
v___x_12_ = lean_apply_1(v_h_10_, v_n_11_);
v_snd_13_ = lean_ctor_get(v___x_12_, 1);
lean_inc(v_snd_13_);
lean_dec_ref(v___x_12_);
v___x_14_ = lean_unbox(v_snd_13_);
lean_dec(v_snd_13_);
return v___x_14_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_served___boxed(lean_object* v_h_15_, lean_object* v_n_16_){
_start:
{
uint8_t v_res_17_; lean_object* v_r_18_; 
v_res_17_ = lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_served(v_h_15_, v_n_16_);
v_r_18_ = lean_box(v_res_17_);
return v_r_18_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_neverServed(lean_object* v_n_19_){
_start:
{
lean_object* v___x_20_; uint8_t v___x_21_; uint8_t v___x_22_; lean_object* v___x_23_; lean_object* v___x_24_; lean_object* v___x_25_; 
v___x_20_ = lean_unsigned_to_nat(0u);
v___x_21_ = lean_nat_dec_eq(v_n_19_, v___x_20_);
v___x_22_ = 0;
v___x_23_ = lean_box(v___x_21_);
v___x_24_ = lean_box(v___x_22_);
v___x_25_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_25_, 0, v___x_23_);
lean_ctor_set(v___x_25_, 1, v___x_24_);
return v___x_25_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_neverServed___boxed(lean_object* v_n_26_){
_start:
{
lean_object* v_res_27_; 
v_res_27_ = lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_neverServed(v_n_26_);
lean_dec(v_n_26_);
return v_res_27_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_servicedAfter(lean_object* v_cutoff_28_, lean_object* v_n_29_){
_start:
{
lean_object* v___x_30_; uint8_t v___x_31_; uint8_t v___x_32_; lean_object* v___x_33_; lean_object* v___x_34_; lean_object* v___x_35_; 
v___x_30_ = lean_unsigned_to_nat(0u);
v___x_31_ = lean_nat_dec_eq(v_n_29_, v___x_30_);
v___x_32_ = lean_nat_dec_le(v_cutoff_28_, v_n_29_);
v___x_33_ = lean_box(v___x_31_);
v___x_34_ = lean_box(v___x_32_);
v___x_35_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_35_, 0, v___x_33_);
lean_ctor_set(v___x_35_, 1, v___x_34_);
return v___x_35_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_servicedAfter___boxed(lean_object* v_cutoff_36_, lean_object* v_n_37_){
_start:
{
lean_object* v_res_38_; 
v_res_38_ = lp_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation_servicedAfter(v_cutoff_36_, v_n_37_);
lean_dec(v_n_37_);
lean_dec(v_cutoff_36_);
return v_res_38_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRBoundedTemporalRefutation(uint8_t builtin) {
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
