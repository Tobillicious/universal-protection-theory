// Lean compiler output
// Module: PhysicalBridges.IR105AuthorizationIndependence
// Imports: public import Init public meta import Init public import PhysicalBridges.IR104ThreeCaseAuthorization
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
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR105_instDecidableEqTransition_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR105_instDecidableEqTransition_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR105_instDecidableEqTransition(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR105_instDecidableEqTransition___boxed(lean_object*, lean_object*);
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IR105_forced___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*0 + 8, .m_other = 0, .m_tag = 0}, .m_objs = {LEAN_SCALAR_PTR_LITERAL(1, 1, 0, 0, 0, 0, 0, 0)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IR105_forced___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR105_forced___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IR105_forced = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IR105_forced___closed__0_value;
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR105_instDecidableEqTransition_decEq(lean_object* v_x_1_, lean_object* v_x_2_){
_start:
{
uint8_t v_accounted_3_; uint8_t v_subjectParticipated_4_; uint8_t v_authorized_5_; uint8_t v_subjectContinues_6_; uint8_t v_accounted_7_; uint8_t v_subjectParticipated_8_; uint8_t v_authorized_9_; uint8_t v_subjectContinues_10_; uint8_t v___y_12_; uint8_t v___y_14_; uint8_t v___y_16_; 
v_accounted_3_ = lean_ctor_get_uint8(v_x_1_, 0);
v_subjectParticipated_4_ = lean_ctor_get_uint8(v_x_1_, 1);
v_authorized_5_ = lean_ctor_get_uint8(v_x_1_, 2);
v_subjectContinues_6_ = lean_ctor_get_uint8(v_x_1_, 3);
v_accounted_7_ = lean_ctor_get_uint8(v_x_2_, 0);
v_subjectParticipated_8_ = lean_ctor_get_uint8(v_x_2_, 1);
v_authorized_9_ = lean_ctor_get_uint8(v_x_2_, 2);
v_subjectContinues_10_ = lean_ctor_get_uint8(v_x_2_, 3);
if (v_accounted_7_ == 0)
{
if (v_accounted_3_ == 0)
{
uint8_t v___x_17_; 
v___x_17_ = 1;
v___y_16_ = v___x_17_;
goto v___jp_15_;
}
else
{
return v_accounted_7_;
}
}
else
{
if (v_accounted_3_ == 0)
{
return v_accounted_3_;
}
else
{
v___y_16_ = v_accounted_3_;
goto v___jp_15_;
}
}
v___jp_11_:
{
if (v_subjectContinues_10_ == 0)
{
if (v_subjectContinues_6_ == 0)
{
return v___y_12_;
}
else
{
return v_subjectContinues_10_;
}
}
else
{
return v_subjectContinues_6_;
}
}
v___jp_13_:
{
if (v_authorized_9_ == 0)
{
if (v_authorized_5_ == 0)
{
v___y_12_ = v___y_14_;
goto v___jp_11_;
}
else
{
return v_authorized_9_;
}
}
else
{
if (v_authorized_5_ == 0)
{
return v_authorized_5_;
}
else
{
v___y_12_ = v_authorized_5_;
goto v___jp_11_;
}
}
}
v___jp_15_:
{
if (v_subjectParticipated_8_ == 0)
{
if (v_subjectParticipated_4_ == 0)
{
v___y_14_ = v___y_16_;
goto v___jp_13_;
}
else
{
return v_subjectParticipated_8_;
}
}
else
{
if (v_subjectParticipated_4_ == 0)
{
return v_subjectParticipated_4_;
}
else
{
v___y_14_ = v_subjectParticipated_4_;
goto v___jp_13_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR105_instDecidableEqTransition_decEq___boxed(lean_object* v_x_18_, lean_object* v_x_19_){
_start:
{
uint8_t v_res_20_; lean_object* v_r_21_; 
v_res_20_ = lp_physical__bridges_PhysicalBridges_IR105_instDecidableEqTransition_decEq(v_x_18_, v_x_19_);
lean_dec_ref(v_x_19_);
lean_dec_ref(v_x_18_);
v_r_21_ = lean_box(v_res_20_);
return v_r_21_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IR105_instDecidableEqTransition(lean_object* v_x_22_, lean_object* v_x_23_){
_start:
{
uint8_t v___x_24_; 
v___x_24_ = lp_physical__bridges_PhysicalBridges_IR105_instDecidableEqTransition_decEq(v_x_22_, v_x_23_);
return v___x_24_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR105_instDecidableEqTransition___boxed(lean_object* v_x_25_, lean_object* v_x_26_){
_start:
{
uint8_t v_res_27_; lean_object* v_r_28_; 
v_res_27_ = lp_physical__bridges_PhysicalBridges_IR105_instDecidableEqTransition(v_x_25_, v_x_26_);
lean_dec_ref(v_x_26_);
lean_dec_ref(v_x_25_);
v_r_28_ = lean_box(v_res_27_);
return v_r_28_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IR104ThreeCaseAuthorization(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IR105AuthorizationIndependence(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IR104ThreeCaseAuthorization(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
