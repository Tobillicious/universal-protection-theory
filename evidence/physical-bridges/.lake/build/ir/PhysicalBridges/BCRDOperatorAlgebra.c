// Lean compiler output
// Module: PhysicalBridges.BCRDOperatorAlgebra
// Imports: public import Init public meta import Init public import PhysicalBridges.FrozenBCRDEvents public import PhysicalBridges.BCRDActualRelationalFrame
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
lean_object* lean_nat_to_int(lean_object*);
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_BCRDOperatorAlgebra_diagonal___closed__0_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_BCRDOperatorAlgebra_diagonal___closed__0;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDOperatorAlgebra_diagonal(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDOperatorAlgebra_diagonal___boxed(lean_object*, lean_object*, lean_object*);
static lean_object* _init_lp_physical__bridges_PhysicalBridges_BCRDOperatorAlgebra_diagonal___closed__0(void){
_start:
{
lean_object* v___x_1_; lean_object* v___x_2_; 
v___x_1_ = lean_unsigned_to_nat(0u);
v___x_2_ = lean_nat_to_int(v___x_1_);
return v___x_2_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDOperatorAlgebra_diagonal(lean_object* v_s_3_, lean_object* v_i_4_, lean_object* v_j_5_){
_start:
{
uint8_t v___x_6_; 
v___x_6_ = lean_nat_dec_eq(v_i_4_, v_j_5_);
if (v___x_6_ == 0)
{
lean_object* v___x_7_; 
lean_dec(v_i_4_);
lean_dec_ref(v_s_3_);
v___x_7_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_BCRDOperatorAlgebra_diagonal___closed__0, &lp_physical__bridges_PhysicalBridges_BCRDOperatorAlgebra_diagonal___closed__0_once, _init_lp_physical__bridges_PhysicalBridges_BCRDOperatorAlgebra_diagonal___closed__0);
return v___x_7_;
}
else
{
lean_object* v___x_8_; 
v___x_8_ = lean_apply_1(v_s_3_, v_i_4_);
return v___x_8_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_BCRDOperatorAlgebra_diagonal___boxed(lean_object* v_s_9_, lean_object* v_i_10_, lean_object* v_j_11_){
_start:
{
lean_object* v_res_12_; 
v_res_12_ = lp_physical__bridges_PhysicalBridges_BCRDOperatorAlgebra_diagonal(v_s_9_, v_i_10_, v_j_11_);
lean_dec(v_j_11_);
return v_res_12_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_FrozenBCRDEvents(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_BCRDOperatorAlgebra(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_BCRDActualRelationalFrame(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
