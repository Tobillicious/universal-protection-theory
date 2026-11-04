// Lean compiler output
// Module: PhysicalBridges.CathedralFirstEventForcing
// Imports: public import Init public meta import Init public import PhysicalBridges.IR96DisturbanceSimulation
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
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_CathedralFirstEventForcing_hiddenInternalLoss___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*0 + 8, .m_other = 0, .m_tag = 0}, .m_objs = {LEAN_SCALAR_PTR_LITERAL(1, 0, 1, 0, 0, 0, 0, 0)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_CathedralFirstEventForcing_hiddenInternalLoss___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_CathedralFirstEventForcing_hiddenInternalLoss___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_CathedralFirstEventForcing_hiddenInternalLoss = (const lean_object*)&lp_physical__bridges_PhysicalBridges_CathedralFirstEventForcing_hiddenInternalLoss___closed__0_value;
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IR96DisturbanceSimulation(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_CathedralFirstEventForcing(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IR96DisturbanceSimulation(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
