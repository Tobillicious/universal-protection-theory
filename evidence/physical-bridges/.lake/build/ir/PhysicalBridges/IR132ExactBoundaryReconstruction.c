// Lean compiler output
// Module: PhysicalBridges.IR132ExactBoundaryReconstruction
// Imports: public import Init public meta import Init public import PhysicalBridges.IR130SectorInputDetectability
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
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR132_toyBoundary(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR132_toyBoundary___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR132_toyBulk(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR132_toyBulk___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR132_encodeBoundaryCode(uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR132_encodeBoundaryCode___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR132_codeBoundary(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR132_codeBoundary___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR132_toyBoundary(lean_object* v_s_1_){
_start:
{
lean_object* v_snd_2_; uint8_t v___x_3_; 
v_snd_2_ = lean_ctor_get(v_s_1_, 1);
v___x_3_ = lean_unbox(v_snd_2_);
return v___x_3_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR132_toyBoundary___boxed(lean_object* v_s_4_){
_start:
{
uint8_t v_res_5_; lean_object* v_r_6_; 
v_res_5_ = lp_physical__bridges_PhysicalBridges_IR132_toyBoundary(v_s_4_);
lean_dec_ref(v_s_4_);
v_r_6_ = lean_box(v_res_5_);
return v_r_6_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR132_toyBulk(lean_object* v_s_7_){
_start:
{
lean_object* v_fst_8_; uint8_t v___x_9_; 
v_fst_8_ = lean_ctor_get(v_s_7_, 0);
v___x_9_ = lean_unbox(v_fst_8_);
return v___x_9_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR132_toyBulk___boxed(lean_object* v_s_10_){
_start:
{
uint8_t v_res_11_; lean_object* v_r_12_; 
v_res_11_ = lp_physical__bridges_PhysicalBridges_IR132_toyBulk(v_s_10_);
lean_dec_ref(v_s_10_);
v_r_12_ = lean_box(v_res_11_);
return v_r_12_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR132_encodeBoundaryCode(uint8_t v_logical_13_){
_start:
{
uint8_t v___x_14_; lean_object* v___x_15_; lean_object* v___x_16_; lean_object* v___x_17_; 
v___x_14_ = 0;
v___x_15_ = lean_box(v_logical_13_);
v___x_16_ = lean_box(v___x_14_);
v___x_17_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_17_, 0, v___x_15_);
lean_ctor_set(v___x_17_, 1, v___x_16_);
return v___x_17_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR132_encodeBoundaryCode___boxed(lean_object* v_logical_18_){
_start:
{
uint8_t v_logical_boxed_19_; lean_object* v_res_20_; 
v_logical_boxed_19_ = lean_unbox(v_logical_18_);
v_res_20_ = lp_physical__bridges_PhysicalBridges_IR132_encodeBoundaryCode(v_logical_boxed_19_);
return v_res_20_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR132_codeBoundary(lean_object* v_s_21_){
_start:
{
lean_object* v_fst_22_; uint8_t v___x_23_; 
v_fst_22_ = lean_ctor_get(v_s_21_, 0);
v___x_23_ = lean_unbox(v_fst_22_);
return v___x_23_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR132_codeBoundary___boxed(lean_object* v_s_24_){
_start:
{
uint8_t v_res_25_; lean_object* v_r_26_; 
v_res_25_ = lp_physical__bridges_PhysicalBridges_IR132_codeBoundary(v_s_24_);
lean_dec_ref(v_s_24_);
v_r_26_ = lean_box(v_res_25_);
return v_r_26_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IR130SectorInputDetectability(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IR132ExactBoundaryReconstruction(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IR130SectorInputDetectability(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
