// Lean compiler output
// Module: PhysicalBridges.SummitSourceAutomorphismClose
// Imports: public import Init public meta import Init public import PhysicalBridges.SummitIntrinsicDefinability public import PhysicalBridges.FrozenBCRDEvents
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
lean_object* lp_physical__bridges_PhysicalBridges_FrozenBCRDEvents_permutation(lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_SummitSourceAutomorphismClose_sourceAutomorphism___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_FrozenBCRDEvents_permutation, .m_arity = 1, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_SummitSourceAutomorphismClose_sourceAutomorphism___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_SummitSourceAutomorphismClose_sourceAutomorphism___closed__0_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_SummitSourceAutomorphismClose_sourceAutomorphism___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 0}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_SummitSourceAutomorphismClose_sourceAutomorphism___closed__0_value),((lean_object*)&lp_physical__bridges_PhysicalBridges_SummitSourceAutomorphismClose_sourceAutomorphism___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_SummitSourceAutomorphismClose_sourceAutomorphism___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_SummitSourceAutomorphismClose_sourceAutomorphism___closed__1_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_SummitSourceAutomorphismClose_sourceAutomorphism = (const lean_object*)&lp_physical__bridges_PhysicalBridges_SummitSourceAutomorphismClose_sourceAutomorphism___closed__1_value;
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_SummitIntrinsicDefinability(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_FrozenBCRDEvents(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_SummitSourceAutomorphismClose(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_SummitIntrinsicDefinability(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_physical__bridges_PhysicalBridges_FrozenBCRDEvents(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
