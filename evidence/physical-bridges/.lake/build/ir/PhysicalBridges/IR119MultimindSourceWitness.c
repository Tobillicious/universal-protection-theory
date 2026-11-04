// Lean compiler output
// Module: PhysicalBridges.IR119MultimindSourceWitness
// Imports: public import Init public meta import Init public import PhysicalBridges.IR118InFlightBacklogBudget public import PhysicalBridges.IRHistoryProvenance
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
lean_object* lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_recordedStep___redArg(lean_object*, lean_object*, lean_object*);
lean_object* lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_physicalStep___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR119_appendEvent___redArg___lam__0(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR119_appendEvent___redArg___lam__1(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR119_appendEvent___redArg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR119_appendEvent(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR119_appendEvent___redArg___lam__0(lean_object* v_bank_1_, lean_object* v_event_2_, lean_object* v_m_3_){
_start:
{
lean_object* v_physical_4_; lean_object* v___x_5_; lean_object* v___x_6_; lean_object* v___x_7_; 
v_physical_4_ = lean_ctor_get(v_bank_1_, 0);
lean_inc_ref(v_physical_4_);
lean_dec_ref(v_bank_1_);
lean_inc(v_m_3_);
v___x_5_ = lean_apply_1(v_physical_4_, v_m_3_);
v___x_6_ = lean_apply_1(v_event_2_, v_m_3_);
v___x_7_ = lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_physicalStep___redArg(v___x_5_, v___x_6_);
return v___x_7_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR119_appendEvent___redArg___lam__1(lean_object* v_bank_8_, lean_object* v_event_9_, lean_object* v_encode_10_, lean_object* v_m_11_){
_start:
{
lean_object* v_recorded_12_; lean_object* v___x_13_; lean_object* v___x_14_; lean_object* v___x_15_; 
v_recorded_12_ = lean_ctor_get(v_bank_8_, 1);
lean_inc_ref(v_recorded_12_);
lean_dec_ref(v_bank_8_);
lean_inc(v_m_11_);
v___x_13_ = lean_apply_1(v_recorded_12_, v_m_11_);
v___x_14_ = lean_apply_1(v_event_9_, v_m_11_);
v___x_15_ = lp_physical__bridges_PhysicalBridges_IRHistoryProvenance_recordedStep___redArg(v_encode_10_, v___x_13_, v___x_14_);
return v___x_15_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR119_appendEvent___redArg(lean_object* v_encode_16_, lean_object* v_bank_17_, lean_object* v_event_18_){
_start:
{
lean_object* v___f_19_; lean_object* v___f_20_; lean_object* v___x_21_; 
lean_inc(v_event_18_);
lean_inc_ref(v_bank_17_);
v___f_19_ = lean_alloc_closure((void*)(lp_physical__bridges_PhysicalBridges_IR119_appendEvent___redArg___lam__0), 3, 2);
lean_closure_set(v___f_19_, 0, v_bank_17_);
lean_closure_set(v___f_19_, 1, v_event_18_);
v___f_20_ = lean_alloc_closure((void*)(lp_physical__bridges_PhysicalBridges_IR119_appendEvent___redArg___lam__1), 4, 3);
lean_closure_set(v___f_20_, 0, v_bank_17_);
lean_closure_set(v___f_20_, 1, v_event_18_);
lean_closure_set(v___f_20_, 2, v_encode_16_);
v___x_21_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v___x_21_, 0, v___f_19_);
lean_ctor_set(v___x_21_, 1, v___f_20_);
return v___x_21_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IR119_appendEvent(lean_object* v_Mind_22_, lean_object* v_Origin_23_, lean_object* v_E_24_, lean_object* v_Code_25_, lean_object* v_encode_26_, lean_object* v_bank_27_, lean_object* v_event_28_){
_start:
{
lean_object* v___x_29_; 
v___x_29_ = lp_physical__bridges_PhysicalBridges_IR119_appendEvent___redArg(v_encode_26_, v_bank_27_, v_event_28_);
return v___x_29_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IR118InFlightBacklogBudget(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRHistoryProvenance(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IR119MultimindSourceWitness(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IR118InFlightBacklogBudget(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_physical__bridges_PhysicalBridges_IRHistoryProvenance(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
