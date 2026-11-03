// Lean compiler output
// Module: PhysicalBridges.IRA1Retirement
// Imports: public import Init public meta import Init public import PhysicalBridges.IRA1Delegation public import PhysicalBridges.IRInFlightQuiescence
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
lean_object* lean_nat_to_int(lean_object*);
lean_object* l_Bool_repr___redArg(uint8_t);
lean_object* l_Nat_reprFast(lean_object*);
lean_object* lean_string_length(lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = "{ "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__0_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 21, .m_capacity = 21, .m_length = 20, .m_data = "controllerTerminated"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__1_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__2_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__3_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__2_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__3 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__3_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__4_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 5, .m_capacity = 5, .m_length = 4, .m_data = " := "};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__4 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__4_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__4_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__5 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__5_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__3_value),((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__5_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__6 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__6_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__7_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__7;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 2, .m_capacity = 2, .m_length = 1, .m_data = ","};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__8 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__8_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__8_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__9 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__9_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 10, .m_capacity = 10, .m_length = 9, .m_data = "heldLocks"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__10 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__10_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__10_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__11 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__11_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__12_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__12;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__13_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 15, .m_capacity = 15, .m_length = 14, .m_data = "pendingEffects"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__13 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__13_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__14_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__13_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__14 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__14_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__15_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__15;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__16_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 16, .m_capacity = 16, .m_length = 15, .m_data = "inFlightEffects"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__16 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__16_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__17_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__16_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__17 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__17_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__18_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__18;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__19_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 20, .m_capacity = 20, .m_length = 19, .m_data = "handoffAcknowledged"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__19 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__19_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__20_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__19_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__20 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__20_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__21_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__21;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__22_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 16, .m_capacity = 16, .m_length = 15, .m_data = "custodyReleased"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__22 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__22_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__23_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__22_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__23 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__23_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__24_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 3, .m_capacity = 3, .m_length = 2, .m_data = " }"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__24 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__24_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__25_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__25;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__26_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__26;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__27_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__27 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__27_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__28_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__24_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__28 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__28_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState___closed__0_value;
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableEqControllerState_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableEqControllerState_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableEqControllerState(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableEqControllerState___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableReleaseReady(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableReleaseReady___boxed(lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_releasePermit(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_releasePermit___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorIdx(uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorElim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorElim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorElim(lean_object*, lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_terminateController_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_terminateController_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_terminateController_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_terminateController_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_unlockOne_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_unlockOne_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_unlockOne_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_unlockOne_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainPending_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainPending_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainPending_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainPending_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainInFlight_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainInFlight_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainInFlight_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainInFlight_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_recordHandoff_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_recordHandoff_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_recordHandoff_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_recordHandoff_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_releaseCustody_elim___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_releaseCustody_elim___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_releaseCustody_elim(lean_object*, uint8_t, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_releaseCustody_elim___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_step(lean_object*, uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_step___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRA1Retirement_0__PhysicalBridges_IRA1Retirement_step_match__1_splitter___redArg(uint8_t, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRA1Retirement_0__PhysicalBridges_IRA1Retirement_step_match__1_splitter___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRA1Retirement_0__PhysicalBridges_IRA1Retirement_step_match__1_splitter(lean_object*, uint8_t, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRA1Retirement_0__PhysicalBridges_IRA1Retirement_step_match__1_splitter___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1Retirement_run_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1Retirement_run_spec__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_run(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_run___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_weakRelease(lean_object*);
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRA1Retirement_emptyReadyController___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*3 + 8, .m_other = 3, .m_tag = 0}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)(((size_t)(0) << 1) | 1)),LEAN_SCALAR_PTR_LITERAL(0, 0, 0, 0, 0, 0, 0, 0)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_emptyReadyController___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_emptyReadyController___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_emptyReadyController = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRA1Retirement_emptyReadyController___closed__0_value;
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__7(void){
_start:
{
lean_object* v___x_14_; lean_object* v___x_15_; 
v___x_14_ = lean_unsigned_to_nat(24u);
v___x_15_ = lean_nat_to_int(v___x_14_);
return v___x_15_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__12(void){
_start:
{
lean_object* v___x_22_; lean_object* v___x_23_; 
v___x_22_ = lean_unsigned_to_nat(13u);
v___x_23_ = lean_nat_to_int(v___x_22_);
return v___x_23_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__15(void){
_start:
{
lean_object* v___x_27_; lean_object* v___x_28_; 
v___x_27_ = lean_unsigned_to_nat(18u);
v___x_28_ = lean_nat_to_int(v___x_27_);
return v___x_28_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__18(void){
_start:
{
lean_object* v___x_32_; lean_object* v___x_33_; 
v___x_32_ = lean_unsigned_to_nat(19u);
v___x_33_ = lean_nat_to_int(v___x_32_);
return v___x_33_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__21(void){
_start:
{
lean_object* v___x_37_; lean_object* v___x_38_; 
v___x_37_ = lean_unsigned_to_nat(23u);
v___x_38_ = lean_nat_to_int(v___x_37_);
return v___x_38_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__25(void){
_start:
{
lean_object* v___x_43_; lean_object* v___x_44_; 
v___x_43_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__0));
v___x_44_ = lean_string_length(v___x_43_);
return v___x_44_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__26(void){
_start:
{
lean_object* v___x_45_; lean_object* v___x_46_; 
v___x_45_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__25, &lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__25_once, _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__25);
v___x_46_ = lean_nat_to_int(v___x_45_);
return v___x_46_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg(lean_object* v_x_51_){
_start:
{
uint8_t v_controllerTerminated_52_; lean_object* v_heldLocks_53_; lean_object* v_pendingEffects_54_; lean_object* v_inFlightEffects_55_; uint8_t v_handoffAcknowledged_56_; uint8_t v_custodyReleased_57_; lean_object* v___x_58_; lean_object* v___x_59_; lean_object* v___x_60_; lean_object* v___x_61_; lean_object* v___x_62_; uint8_t v___x_63_; lean_object* v___x_64_; lean_object* v___x_65_; lean_object* v___x_66_; lean_object* v___x_67_; lean_object* v___x_68_; lean_object* v___x_69_; lean_object* v___x_70_; lean_object* v___x_71_; lean_object* v___x_72_; lean_object* v___x_73_; lean_object* v___x_74_; lean_object* v___x_75_; lean_object* v___x_76_; lean_object* v___x_77_; lean_object* v___x_78_; lean_object* v___x_79_; lean_object* v___x_80_; lean_object* v___x_81_; lean_object* v___x_82_; lean_object* v___x_83_; lean_object* v___x_84_; lean_object* v___x_85_; lean_object* v___x_86_; lean_object* v___x_87_; lean_object* v___x_88_; lean_object* v___x_89_; lean_object* v___x_90_; lean_object* v___x_91_; lean_object* v___x_92_; lean_object* v___x_93_; lean_object* v___x_94_; lean_object* v___x_95_; lean_object* v___x_96_; lean_object* v___x_97_; lean_object* v___x_98_; lean_object* v___x_99_; lean_object* v___x_100_; lean_object* v___x_101_; lean_object* v___x_102_; lean_object* v___x_103_; lean_object* v___x_104_; lean_object* v___x_105_; lean_object* v___x_106_; lean_object* v___x_107_; lean_object* v___x_108_; lean_object* v___x_109_; lean_object* v___x_110_; lean_object* v___x_111_; lean_object* v___x_112_; lean_object* v___x_113_; lean_object* v___x_114_; lean_object* v___x_115_; lean_object* v___x_116_; lean_object* v___x_117_; lean_object* v___x_118_; lean_object* v___x_119_; lean_object* v___x_120_; lean_object* v___x_121_; lean_object* v___x_122_; lean_object* v___x_123_; lean_object* v___x_124_; lean_object* v___x_125_; lean_object* v___x_126_; 
v_controllerTerminated_52_ = lean_ctor_get_uint8(v_x_51_, sizeof(void*)*3);
v_heldLocks_53_ = lean_ctor_get(v_x_51_, 0);
lean_inc(v_heldLocks_53_);
v_pendingEffects_54_ = lean_ctor_get(v_x_51_, 1);
lean_inc(v_pendingEffects_54_);
v_inFlightEffects_55_ = lean_ctor_get(v_x_51_, 2);
lean_inc(v_inFlightEffects_55_);
v_handoffAcknowledged_56_ = lean_ctor_get_uint8(v_x_51_, sizeof(void*)*3 + 1);
v_custodyReleased_57_ = lean_ctor_get_uint8(v_x_51_, sizeof(void*)*3 + 2);
lean_dec_ref(v_x_51_);
v___x_58_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__5));
v___x_59_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__6));
v___x_60_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__7, &lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__7_once, _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__7);
v___x_61_ = l_Bool_repr___redArg(v_controllerTerminated_52_);
v___x_62_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_62_, 0, v___x_60_);
lean_ctor_set(v___x_62_, 1, v___x_61_);
v___x_63_ = 0;
v___x_64_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_64_, 0, v___x_62_);
lean_ctor_set_uint8(v___x_64_, sizeof(void*)*1, v___x_63_);
v___x_65_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_65_, 0, v___x_59_);
lean_ctor_set(v___x_65_, 1, v___x_64_);
v___x_66_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__9));
v___x_67_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_67_, 0, v___x_65_);
lean_ctor_set(v___x_67_, 1, v___x_66_);
v___x_68_ = lean_box(1);
v___x_69_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_69_, 0, v___x_67_);
lean_ctor_set(v___x_69_, 1, v___x_68_);
v___x_70_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__11));
v___x_71_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_71_, 0, v___x_69_);
lean_ctor_set(v___x_71_, 1, v___x_70_);
v___x_72_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_72_, 0, v___x_71_);
lean_ctor_set(v___x_72_, 1, v___x_58_);
v___x_73_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__12, &lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__12_once, _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__12);
v___x_74_ = l_Nat_reprFast(v_heldLocks_53_);
v___x_75_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_75_, 0, v___x_74_);
v___x_76_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_76_, 0, v___x_73_);
lean_ctor_set(v___x_76_, 1, v___x_75_);
v___x_77_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_77_, 0, v___x_76_);
lean_ctor_set_uint8(v___x_77_, sizeof(void*)*1, v___x_63_);
v___x_78_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_78_, 0, v___x_72_);
lean_ctor_set(v___x_78_, 1, v___x_77_);
v___x_79_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_79_, 0, v___x_78_);
lean_ctor_set(v___x_79_, 1, v___x_66_);
v___x_80_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_80_, 0, v___x_79_);
lean_ctor_set(v___x_80_, 1, v___x_68_);
v___x_81_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__14));
v___x_82_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_82_, 0, v___x_80_);
lean_ctor_set(v___x_82_, 1, v___x_81_);
v___x_83_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_83_, 0, v___x_82_);
lean_ctor_set(v___x_83_, 1, v___x_58_);
v___x_84_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__15, &lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__15_once, _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__15);
v___x_85_ = l_Nat_reprFast(v_pendingEffects_54_);
v___x_86_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_86_, 0, v___x_85_);
v___x_87_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_87_, 0, v___x_84_);
lean_ctor_set(v___x_87_, 1, v___x_86_);
v___x_88_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_88_, 0, v___x_87_);
lean_ctor_set_uint8(v___x_88_, sizeof(void*)*1, v___x_63_);
v___x_89_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_89_, 0, v___x_83_);
lean_ctor_set(v___x_89_, 1, v___x_88_);
v___x_90_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_90_, 0, v___x_89_);
lean_ctor_set(v___x_90_, 1, v___x_66_);
v___x_91_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_91_, 0, v___x_90_);
lean_ctor_set(v___x_91_, 1, v___x_68_);
v___x_92_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__17));
v___x_93_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_93_, 0, v___x_91_);
lean_ctor_set(v___x_93_, 1, v___x_92_);
v___x_94_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_94_, 0, v___x_93_);
lean_ctor_set(v___x_94_, 1, v___x_58_);
v___x_95_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__18, &lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__18_once, _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__18);
v___x_96_ = l_Nat_reprFast(v_inFlightEffects_55_);
v___x_97_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v___x_97_, 0, v___x_96_);
v___x_98_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_98_, 0, v___x_95_);
lean_ctor_set(v___x_98_, 1, v___x_97_);
v___x_99_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_99_, 0, v___x_98_);
lean_ctor_set_uint8(v___x_99_, sizeof(void*)*1, v___x_63_);
v___x_100_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_100_, 0, v___x_94_);
lean_ctor_set(v___x_100_, 1, v___x_99_);
v___x_101_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_101_, 0, v___x_100_);
lean_ctor_set(v___x_101_, 1, v___x_66_);
v___x_102_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_102_, 0, v___x_101_);
lean_ctor_set(v___x_102_, 1, v___x_68_);
v___x_103_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__20));
v___x_104_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_104_, 0, v___x_102_);
lean_ctor_set(v___x_104_, 1, v___x_103_);
v___x_105_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_105_, 0, v___x_104_);
lean_ctor_set(v___x_105_, 1, v___x_58_);
v___x_106_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__21, &lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__21_once, _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__21);
v___x_107_ = l_Bool_repr___redArg(v_handoffAcknowledged_56_);
v___x_108_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_108_, 0, v___x_106_);
lean_ctor_set(v___x_108_, 1, v___x_107_);
v___x_109_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_109_, 0, v___x_108_);
lean_ctor_set_uint8(v___x_109_, sizeof(void*)*1, v___x_63_);
v___x_110_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_110_, 0, v___x_105_);
lean_ctor_set(v___x_110_, 1, v___x_109_);
v___x_111_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_111_, 0, v___x_110_);
lean_ctor_set(v___x_111_, 1, v___x_66_);
v___x_112_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_112_, 0, v___x_111_);
lean_ctor_set(v___x_112_, 1, v___x_68_);
v___x_113_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__23));
v___x_114_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_114_, 0, v___x_112_);
lean_ctor_set(v___x_114_, 1, v___x_113_);
v___x_115_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_115_, 0, v___x_114_);
lean_ctor_set(v___x_115_, 1, v___x_58_);
v___x_116_ = l_Bool_repr___redArg(v_custodyReleased_57_);
v___x_117_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_117_, 0, v___x_95_);
lean_ctor_set(v___x_117_, 1, v___x_116_);
v___x_118_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_118_, 0, v___x_117_);
lean_ctor_set_uint8(v___x_118_, sizeof(void*)*1, v___x_63_);
v___x_119_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_119_, 0, v___x_115_);
lean_ctor_set(v___x_119_, 1, v___x_118_);
v___x_120_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__26, &lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__26_once, _init_lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__26);
v___x_121_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__27));
v___x_122_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_122_, 0, v___x_121_);
lean_ctor_set(v___x_122_, 1, v___x_119_);
v___x_123_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg___closed__28));
v___x_124_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_124_, 0, v___x_122_);
lean_ctor_set(v___x_124_, 1, v___x_123_);
v___x_125_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_125_, 0, v___x_120_);
lean_ctor_set(v___x_125_, 1, v___x_124_);
v___x_126_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_126_, 0, v___x_125_);
lean_ctor_set_uint8(v___x_126_, sizeof(void*)*1, v___x_63_);
return v___x_126_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr(lean_object* v_x_127_, lean_object* v_prec_128_){
_start:
{
lean_object* v___x_129_; 
v___x_129_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___redArg(v_x_127_);
return v___x_129_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr___boxed(lean_object* v_x_130_, lean_object* v_prec_131_){
_start:
{
lean_object* v_res_132_; 
v_res_132_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_instReprControllerState_repr(v_x_130_, v_prec_131_);
lean_dec(v_prec_131_);
return v_res_132_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableEqControllerState_decEq(lean_object* v_x_135_, lean_object* v_x_136_){
_start:
{
uint8_t v_controllerTerminated_137_; lean_object* v_heldLocks_138_; lean_object* v_pendingEffects_139_; lean_object* v_inFlightEffects_140_; uint8_t v_handoffAcknowledged_141_; uint8_t v_custodyReleased_142_; uint8_t v_controllerTerminated_143_; lean_object* v_heldLocks_144_; lean_object* v_pendingEffects_145_; lean_object* v_inFlightEffects_146_; uint8_t v_handoffAcknowledged_147_; uint8_t v_custodyReleased_148_; uint8_t v___y_150_; 
v_controllerTerminated_137_ = lean_ctor_get_uint8(v_x_135_, sizeof(void*)*3);
v_heldLocks_138_ = lean_ctor_get(v_x_135_, 0);
v_pendingEffects_139_ = lean_ctor_get(v_x_135_, 1);
v_inFlightEffects_140_ = lean_ctor_get(v_x_135_, 2);
v_handoffAcknowledged_141_ = lean_ctor_get_uint8(v_x_135_, sizeof(void*)*3 + 1);
v_custodyReleased_142_ = lean_ctor_get_uint8(v_x_135_, sizeof(void*)*3 + 2);
v_controllerTerminated_143_ = lean_ctor_get_uint8(v_x_136_, sizeof(void*)*3);
v_heldLocks_144_ = lean_ctor_get(v_x_136_, 0);
v_pendingEffects_145_ = lean_ctor_get(v_x_136_, 1);
v_inFlightEffects_146_ = lean_ctor_get(v_x_136_, 2);
v_handoffAcknowledged_147_ = lean_ctor_get_uint8(v_x_136_, sizeof(void*)*3 + 1);
v_custodyReleased_148_ = lean_ctor_get_uint8(v_x_136_, sizeof(void*)*3 + 2);
if (v_controllerTerminated_143_ == 0)
{
if (v_controllerTerminated_137_ == 0)
{
goto v___jp_151_;
}
else
{
return v_controllerTerminated_143_;
}
}
else
{
if (v_controllerTerminated_137_ == 0)
{
return v_controllerTerminated_137_;
}
else
{
goto v___jp_151_;
}
}
v___jp_149_:
{
if (v___y_150_ == 0)
{
return v___y_150_;
}
else
{
if (v_custodyReleased_148_ == 0)
{
if (v_custodyReleased_142_ == 0)
{
return v___y_150_;
}
else
{
return v_custodyReleased_148_;
}
}
else
{
return v_custodyReleased_142_;
}
}
}
v___jp_151_:
{
uint8_t v___x_152_; 
v___x_152_ = lean_nat_dec_eq(v_heldLocks_138_, v_heldLocks_144_);
if (v___x_152_ == 0)
{
return v___x_152_;
}
else
{
uint8_t v___x_153_; 
v___x_153_ = lean_nat_dec_eq(v_pendingEffects_139_, v_pendingEffects_145_);
if (v___x_153_ == 0)
{
return v___x_153_;
}
else
{
uint8_t v___x_154_; 
v___x_154_ = lean_nat_dec_eq(v_inFlightEffects_140_, v_inFlightEffects_146_);
if (v___x_154_ == 0)
{
return v___x_154_;
}
else
{
if (v_handoffAcknowledged_147_ == 0)
{
if (v_handoffAcknowledged_141_ == 0)
{
v___y_150_ = v___x_154_;
goto v___jp_149_;
}
else
{
return v_handoffAcknowledged_147_;
}
}
else
{
v___y_150_ = v_handoffAcknowledged_141_;
goto v___jp_149_;
}
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableEqControllerState_decEq___boxed(lean_object* v_x_155_, lean_object* v_x_156_){
_start:
{
uint8_t v_res_157_; lean_object* v_r_158_; 
v_res_157_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableEqControllerState_decEq(v_x_155_, v_x_156_);
lean_dec_ref(v_x_156_);
lean_dec_ref(v_x_155_);
v_r_158_ = lean_box(v_res_157_);
return v_r_158_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableEqControllerState(lean_object* v_x_159_, lean_object* v_x_160_){
_start:
{
uint8_t v___x_161_; 
v___x_161_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableEqControllerState_decEq(v_x_159_, v_x_160_);
return v___x_161_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableEqControllerState___boxed(lean_object* v_x_162_, lean_object* v_x_163_){
_start:
{
uint8_t v_res_164_; lean_object* v_r_165_; 
v_res_164_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableEqControllerState(v_x_162_, v_x_163_);
lean_dec_ref(v_x_163_);
lean_dec_ref(v_x_162_);
v_r_165_ = lean_box(v_res_164_);
return v_r_165_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableReleaseReady(lean_object* v_s_166_){
_start:
{
uint8_t v_controllerTerminated_167_; 
v_controllerTerminated_167_ = lean_ctor_get_uint8(v_s_166_, sizeof(void*)*3);
if (v_controllerTerminated_167_ == 0)
{
return v_controllerTerminated_167_;
}
else
{
lean_object* v_heldLocks_168_; lean_object* v_pendingEffects_169_; lean_object* v_inFlightEffects_170_; uint8_t v_handoffAcknowledged_171_; lean_object* v___x_172_; uint8_t v___x_173_; 
v_heldLocks_168_ = lean_ctor_get(v_s_166_, 0);
v_pendingEffects_169_ = lean_ctor_get(v_s_166_, 1);
v_inFlightEffects_170_ = lean_ctor_get(v_s_166_, 2);
v_handoffAcknowledged_171_ = lean_ctor_get_uint8(v_s_166_, sizeof(void*)*3 + 1);
v___x_172_ = lean_unsigned_to_nat(0u);
v___x_173_ = lean_nat_dec_eq(v_heldLocks_168_, v___x_172_);
if (v___x_173_ == 0)
{
return v___x_173_;
}
else
{
uint8_t v___x_174_; 
v___x_174_ = lean_nat_dec_eq(v_pendingEffects_169_, v___x_172_);
if (v___x_174_ == 0)
{
return v___x_174_;
}
else
{
uint8_t v___x_175_; 
v___x_175_ = lean_nat_dec_eq(v_inFlightEffects_170_, v___x_172_);
if (v___x_175_ == 0)
{
return v___x_175_;
}
else
{
return v_handoffAcknowledged_171_;
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableReleaseReady___boxed(lean_object* v_s_176_){
_start:
{
uint8_t v_res_177_; lean_object* v_r_178_; 
v_res_177_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableReleaseReady(v_s_176_);
lean_dec_ref(v_s_176_);
v_r_178_ = lean_box(v_res_177_);
return v_r_178_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1Retirement_releasePermit(lean_object* v_s_179_){
_start:
{
uint8_t v___x_180_; 
v___x_180_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableReleaseReady(v_s_179_);
return v___x_180_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_releasePermit___boxed(lean_object* v_s_181_){
_start:
{
uint8_t v_res_182_; lean_object* v_r_183_; 
v_res_182_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_releasePermit(v_s_181_);
lean_dec_ref(v_s_181_);
v_r_183_ = lean_box(v_res_182_);
return v_r_183_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorIdx(uint8_t v_x_184_){
_start:
{
switch(v_x_184_)
{
case 0:
{
lean_object* v___x_185_; 
v___x_185_ = lean_unsigned_to_nat(0u);
return v___x_185_;
}
case 1:
{
lean_object* v___x_186_; 
v___x_186_ = lean_unsigned_to_nat(1u);
return v___x_186_;
}
case 2:
{
lean_object* v___x_187_; 
v___x_187_ = lean_unsigned_to_nat(2u);
return v___x_187_;
}
case 3:
{
lean_object* v___x_188_; 
v___x_188_ = lean_unsigned_to_nat(3u);
return v___x_188_;
}
case 4:
{
lean_object* v___x_189_; 
v___x_189_ = lean_unsigned_to_nat(4u);
return v___x_189_;
}
default: 
{
lean_object* v___x_190_; 
v___x_190_ = lean_unsigned_to_nat(5u);
return v___x_190_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorIdx___boxed(lean_object* v_x_191_){
_start:
{
uint8_t v_x_boxed_192_; lean_object* v_res_193_; 
v_x_boxed_192_ = lean_unbox(v_x_191_);
v_res_193_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorIdx(v_x_boxed_192_);
return v_res_193_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorElim___redArg(lean_object* v_k_194_){
_start:
{
lean_inc(v_k_194_);
return v_k_194_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorElim___redArg___boxed(lean_object* v_k_195_){
_start:
{
lean_object* v_res_196_; 
v_res_196_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorElim___redArg(v_k_195_);
lean_dec(v_k_195_);
return v_res_196_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorElim(lean_object* v_motive_197_, lean_object* v_ctorIdx_198_, uint8_t v_t_199_, lean_object* v_h_200_, lean_object* v_k_201_){
_start:
{
lean_inc(v_k_201_);
return v_k_201_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorElim___boxed(lean_object* v_motive_202_, lean_object* v_ctorIdx_203_, lean_object* v_t_204_, lean_object* v_h_205_, lean_object* v_k_206_){
_start:
{
uint8_t v_t_boxed_207_; lean_object* v_res_208_; 
v_t_boxed_207_ = lean_unbox(v_t_204_);
v_res_208_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_ctorElim(v_motive_202_, v_ctorIdx_203_, v_t_boxed_207_, v_h_205_, v_k_206_);
lean_dec(v_k_206_);
lean_dec(v_ctorIdx_203_);
return v_res_208_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_terminateController_elim___redArg(lean_object* v_terminateController_209_){
_start:
{
lean_inc(v_terminateController_209_);
return v_terminateController_209_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_terminateController_elim___redArg___boxed(lean_object* v_terminateController_210_){
_start:
{
lean_object* v_res_211_; 
v_res_211_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_terminateController_elim___redArg(v_terminateController_210_);
lean_dec(v_terminateController_210_);
return v_res_211_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_terminateController_elim(lean_object* v_motive_212_, uint8_t v_t_213_, lean_object* v_h_214_, lean_object* v_terminateController_215_){
_start:
{
lean_inc(v_terminateController_215_);
return v_terminateController_215_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_terminateController_elim___boxed(lean_object* v_motive_216_, lean_object* v_t_217_, lean_object* v_h_218_, lean_object* v_terminateController_219_){
_start:
{
uint8_t v_t_boxed_220_; lean_object* v_res_221_; 
v_t_boxed_220_ = lean_unbox(v_t_217_);
v_res_221_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_terminateController_elim(v_motive_216_, v_t_boxed_220_, v_h_218_, v_terminateController_219_);
lean_dec(v_terminateController_219_);
return v_res_221_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_unlockOne_elim___redArg(lean_object* v_unlockOne_222_){
_start:
{
lean_inc(v_unlockOne_222_);
return v_unlockOne_222_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_unlockOne_elim___redArg___boxed(lean_object* v_unlockOne_223_){
_start:
{
lean_object* v_res_224_; 
v_res_224_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_unlockOne_elim___redArg(v_unlockOne_223_);
lean_dec(v_unlockOne_223_);
return v_res_224_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_unlockOne_elim(lean_object* v_motive_225_, uint8_t v_t_226_, lean_object* v_h_227_, lean_object* v_unlockOne_228_){
_start:
{
lean_inc(v_unlockOne_228_);
return v_unlockOne_228_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_unlockOne_elim___boxed(lean_object* v_motive_229_, lean_object* v_t_230_, lean_object* v_h_231_, lean_object* v_unlockOne_232_){
_start:
{
uint8_t v_t_boxed_233_; lean_object* v_res_234_; 
v_t_boxed_233_ = lean_unbox(v_t_230_);
v_res_234_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_unlockOne_elim(v_motive_229_, v_t_boxed_233_, v_h_231_, v_unlockOne_232_);
lean_dec(v_unlockOne_232_);
return v_res_234_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainPending_elim___redArg(lean_object* v_drainPending_235_){
_start:
{
lean_inc(v_drainPending_235_);
return v_drainPending_235_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainPending_elim___redArg___boxed(lean_object* v_drainPending_236_){
_start:
{
lean_object* v_res_237_; 
v_res_237_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainPending_elim___redArg(v_drainPending_236_);
lean_dec(v_drainPending_236_);
return v_res_237_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainPending_elim(lean_object* v_motive_238_, uint8_t v_t_239_, lean_object* v_h_240_, lean_object* v_drainPending_241_){
_start:
{
lean_inc(v_drainPending_241_);
return v_drainPending_241_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainPending_elim___boxed(lean_object* v_motive_242_, lean_object* v_t_243_, lean_object* v_h_244_, lean_object* v_drainPending_245_){
_start:
{
uint8_t v_t_boxed_246_; lean_object* v_res_247_; 
v_t_boxed_246_ = lean_unbox(v_t_243_);
v_res_247_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainPending_elim(v_motive_242_, v_t_boxed_246_, v_h_244_, v_drainPending_245_);
lean_dec(v_drainPending_245_);
return v_res_247_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainInFlight_elim___redArg(lean_object* v_drainInFlight_248_){
_start:
{
lean_inc(v_drainInFlight_248_);
return v_drainInFlight_248_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainInFlight_elim___redArg___boxed(lean_object* v_drainInFlight_249_){
_start:
{
lean_object* v_res_250_; 
v_res_250_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainInFlight_elim___redArg(v_drainInFlight_249_);
lean_dec(v_drainInFlight_249_);
return v_res_250_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainInFlight_elim(lean_object* v_motive_251_, uint8_t v_t_252_, lean_object* v_h_253_, lean_object* v_drainInFlight_254_){
_start:
{
lean_inc(v_drainInFlight_254_);
return v_drainInFlight_254_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainInFlight_elim___boxed(lean_object* v_motive_255_, lean_object* v_t_256_, lean_object* v_h_257_, lean_object* v_drainInFlight_258_){
_start:
{
uint8_t v_t_boxed_259_; lean_object* v_res_260_; 
v_t_boxed_259_ = lean_unbox(v_t_256_);
v_res_260_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_drainInFlight_elim(v_motive_255_, v_t_boxed_259_, v_h_257_, v_drainInFlight_258_);
lean_dec(v_drainInFlight_258_);
return v_res_260_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_recordHandoff_elim___redArg(lean_object* v_recordHandoff_261_){
_start:
{
lean_inc(v_recordHandoff_261_);
return v_recordHandoff_261_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_recordHandoff_elim___redArg___boxed(lean_object* v_recordHandoff_262_){
_start:
{
lean_object* v_res_263_; 
v_res_263_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_recordHandoff_elim___redArg(v_recordHandoff_262_);
lean_dec(v_recordHandoff_262_);
return v_res_263_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_recordHandoff_elim(lean_object* v_motive_264_, uint8_t v_t_265_, lean_object* v_h_266_, lean_object* v_recordHandoff_267_){
_start:
{
lean_inc(v_recordHandoff_267_);
return v_recordHandoff_267_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_recordHandoff_elim___boxed(lean_object* v_motive_268_, lean_object* v_t_269_, lean_object* v_h_270_, lean_object* v_recordHandoff_271_){
_start:
{
uint8_t v_t_boxed_272_; lean_object* v_res_273_; 
v_t_boxed_272_ = lean_unbox(v_t_269_);
v_res_273_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_recordHandoff_elim(v_motive_268_, v_t_boxed_272_, v_h_270_, v_recordHandoff_271_);
lean_dec(v_recordHandoff_271_);
return v_res_273_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_releaseCustody_elim___redArg(lean_object* v_releaseCustody_274_){
_start:
{
lean_inc(v_releaseCustody_274_);
return v_releaseCustody_274_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_releaseCustody_elim___redArg___boxed(lean_object* v_releaseCustody_275_){
_start:
{
lean_object* v_res_276_; 
v_res_276_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_releaseCustody_elim___redArg(v_releaseCustody_275_);
lean_dec(v_releaseCustody_275_);
return v_res_276_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_releaseCustody_elim(lean_object* v_motive_277_, uint8_t v_t_278_, lean_object* v_h_279_, lean_object* v_releaseCustody_280_){
_start:
{
lean_inc(v_releaseCustody_280_);
return v_releaseCustody_280_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_releaseCustody_elim___boxed(lean_object* v_motive_281_, lean_object* v_t_282_, lean_object* v_h_283_, lean_object* v_releaseCustody_284_){
_start:
{
uint8_t v_t_boxed_285_; lean_object* v_res_286_; 
v_t_boxed_285_ = lean_unbox(v_t_282_);
v_res_286_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_Event_releaseCustody_elim(v_motive_281_, v_t_boxed_285_, v_h_283_, v_releaseCustody_284_);
lean_dec(v_releaseCustody_284_);
return v_res_286_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_step(lean_object* v_s_287_, uint8_t v_e_288_){
_start:
{
uint8_t v_custodyReleased_289_; 
v_custodyReleased_289_ = lean_ctor_get_uint8(v_s_287_, sizeof(void*)*3 + 2);
if (v_custodyReleased_289_ == 0)
{
uint8_t v_controllerTerminated_290_; lean_object* v_heldLocks_291_; lean_object* v_pendingEffects_292_; lean_object* v_inFlightEffects_293_; uint8_t v_handoffAcknowledged_294_; uint8_t v___x_295_; 
v_controllerTerminated_290_ = lean_ctor_get_uint8(v_s_287_, sizeof(void*)*3);
v_heldLocks_291_ = lean_ctor_get(v_s_287_, 0);
v_pendingEffects_292_ = lean_ctor_get(v_s_287_, 1);
v_inFlightEffects_293_ = lean_ctor_get(v_s_287_, 2);
v_handoffAcknowledged_294_ = lean_ctor_get_uint8(v_s_287_, sizeof(void*)*3 + 1);
v___x_295_ = 1;
switch(v_e_288_)
{
case 0:
{
lean_object* v___x_297_; uint8_t v_isShared_298_; uint8_t v_isSharedCheck_302_; 
lean_inc(v_inFlightEffects_293_);
lean_inc(v_pendingEffects_292_);
lean_inc(v_heldLocks_291_);
v_isSharedCheck_302_ = !lean_is_exclusive(v_s_287_);
if (v_isSharedCheck_302_ == 0)
{
lean_object* v_unused_303_; lean_object* v_unused_304_; lean_object* v_unused_305_; 
v_unused_303_ = lean_ctor_get(v_s_287_, 2);
lean_dec(v_unused_303_);
v_unused_304_ = lean_ctor_get(v_s_287_, 1);
lean_dec(v_unused_304_);
v_unused_305_ = lean_ctor_get(v_s_287_, 0);
lean_dec(v_unused_305_);
v___x_297_ = v_s_287_;
v_isShared_298_ = v_isSharedCheck_302_;
goto v_resetjp_296_;
}
else
{
lean_dec(v_s_287_);
v___x_297_ = lean_box(0);
v_isShared_298_ = v_isSharedCheck_302_;
goto v_resetjp_296_;
}
v_resetjp_296_:
{
lean_object* v___x_300_; 
if (v_isShared_298_ == 0)
{
v___x_300_ = v___x_297_;
goto v_reusejp_299_;
}
else
{
lean_object* v_reuseFailAlloc_301_; 
v_reuseFailAlloc_301_ = lean_alloc_ctor(0, 3, 3);
lean_ctor_set(v_reuseFailAlloc_301_, 0, v_heldLocks_291_);
lean_ctor_set(v_reuseFailAlloc_301_, 1, v_pendingEffects_292_);
lean_ctor_set(v_reuseFailAlloc_301_, 2, v_inFlightEffects_293_);
lean_ctor_set_uint8(v_reuseFailAlloc_301_, sizeof(void*)*3 + 1, v_handoffAcknowledged_294_);
lean_ctor_set_uint8(v_reuseFailAlloc_301_, sizeof(void*)*3 + 2, v_custodyReleased_289_);
v___x_300_ = v_reuseFailAlloc_301_;
goto v_reusejp_299_;
}
v_reusejp_299_:
{
lean_ctor_set_uint8(v___x_300_, sizeof(void*)*3, v___x_295_);
return v___x_300_;
}
}
}
case 1:
{
lean_object* v___x_307_; uint8_t v_isShared_308_; uint8_t v_isSharedCheck_314_; 
lean_inc(v_inFlightEffects_293_);
lean_inc(v_pendingEffects_292_);
lean_inc(v_heldLocks_291_);
v_isSharedCheck_314_ = !lean_is_exclusive(v_s_287_);
if (v_isSharedCheck_314_ == 0)
{
lean_object* v_unused_315_; lean_object* v_unused_316_; lean_object* v_unused_317_; 
v_unused_315_ = lean_ctor_get(v_s_287_, 2);
lean_dec(v_unused_315_);
v_unused_316_ = lean_ctor_get(v_s_287_, 1);
lean_dec(v_unused_316_);
v_unused_317_ = lean_ctor_get(v_s_287_, 0);
lean_dec(v_unused_317_);
v___x_307_ = v_s_287_;
v_isShared_308_ = v_isSharedCheck_314_;
goto v_resetjp_306_;
}
else
{
lean_dec(v_s_287_);
v___x_307_ = lean_box(0);
v_isShared_308_ = v_isSharedCheck_314_;
goto v_resetjp_306_;
}
v_resetjp_306_:
{
lean_object* v___x_309_; lean_object* v___x_310_; lean_object* v___x_312_; 
v___x_309_ = lean_unsigned_to_nat(1u);
v___x_310_ = lean_nat_sub(v_heldLocks_291_, v___x_309_);
lean_dec(v_heldLocks_291_);
if (v_isShared_308_ == 0)
{
lean_ctor_set(v___x_307_, 0, v___x_310_);
v___x_312_ = v___x_307_;
goto v_reusejp_311_;
}
else
{
lean_object* v_reuseFailAlloc_313_; 
v_reuseFailAlloc_313_ = lean_alloc_ctor(0, 3, 3);
lean_ctor_set(v_reuseFailAlloc_313_, 0, v___x_310_);
lean_ctor_set(v_reuseFailAlloc_313_, 1, v_pendingEffects_292_);
lean_ctor_set(v_reuseFailAlloc_313_, 2, v_inFlightEffects_293_);
lean_ctor_set_uint8(v_reuseFailAlloc_313_, sizeof(void*)*3, v_controllerTerminated_290_);
lean_ctor_set_uint8(v_reuseFailAlloc_313_, sizeof(void*)*3 + 1, v_handoffAcknowledged_294_);
lean_ctor_set_uint8(v_reuseFailAlloc_313_, sizeof(void*)*3 + 2, v_custodyReleased_289_);
v___x_312_ = v_reuseFailAlloc_313_;
goto v_reusejp_311_;
}
v_reusejp_311_:
{
return v___x_312_;
}
}
}
case 2:
{
lean_object* v___x_319_; uint8_t v_isShared_320_; uint8_t v_isSharedCheck_325_; 
lean_inc(v_inFlightEffects_293_);
lean_inc(v_heldLocks_291_);
v_isSharedCheck_325_ = !lean_is_exclusive(v_s_287_);
if (v_isSharedCheck_325_ == 0)
{
lean_object* v_unused_326_; lean_object* v_unused_327_; lean_object* v_unused_328_; 
v_unused_326_ = lean_ctor_get(v_s_287_, 2);
lean_dec(v_unused_326_);
v_unused_327_ = lean_ctor_get(v_s_287_, 1);
lean_dec(v_unused_327_);
v_unused_328_ = lean_ctor_get(v_s_287_, 0);
lean_dec(v_unused_328_);
v___x_319_ = v_s_287_;
v_isShared_320_ = v_isSharedCheck_325_;
goto v_resetjp_318_;
}
else
{
lean_dec(v_s_287_);
v___x_319_ = lean_box(0);
v_isShared_320_ = v_isSharedCheck_325_;
goto v_resetjp_318_;
}
v_resetjp_318_:
{
lean_object* v___x_321_; lean_object* v___x_323_; 
v___x_321_ = lean_unsigned_to_nat(0u);
if (v_isShared_320_ == 0)
{
lean_ctor_set(v___x_319_, 1, v___x_321_);
v___x_323_ = v___x_319_;
goto v_reusejp_322_;
}
else
{
lean_object* v_reuseFailAlloc_324_; 
v_reuseFailAlloc_324_ = lean_alloc_ctor(0, 3, 3);
lean_ctor_set(v_reuseFailAlloc_324_, 0, v_heldLocks_291_);
lean_ctor_set(v_reuseFailAlloc_324_, 1, v___x_321_);
lean_ctor_set(v_reuseFailAlloc_324_, 2, v_inFlightEffects_293_);
lean_ctor_set_uint8(v_reuseFailAlloc_324_, sizeof(void*)*3, v_controllerTerminated_290_);
lean_ctor_set_uint8(v_reuseFailAlloc_324_, sizeof(void*)*3 + 1, v_handoffAcknowledged_294_);
lean_ctor_set_uint8(v_reuseFailAlloc_324_, sizeof(void*)*3 + 2, v_custodyReleased_289_);
v___x_323_ = v_reuseFailAlloc_324_;
goto v_reusejp_322_;
}
v_reusejp_322_:
{
return v___x_323_;
}
}
}
case 3:
{
lean_object* v___x_330_; uint8_t v_isShared_331_; uint8_t v_isSharedCheck_336_; 
lean_inc(v_pendingEffects_292_);
lean_inc(v_heldLocks_291_);
v_isSharedCheck_336_ = !lean_is_exclusive(v_s_287_);
if (v_isSharedCheck_336_ == 0)
{
lean_object* v_unused_337_; lean_object* v_unused_338_; lean_object* v_unused_339_; 
v_unused_337_ = lean_ctor_get(v_s_287_, 2);
lean_dec(v_unused_337_);
v_unused_338_ = lean_ctor_get(v_s_287_, 1);
lean_dec(v_unused_338_);
v_unused_339_ = lean_ctor_get(v_s_287_, 0);
lean_dec(v_unused_339_);
v___x_330_ = v_s_287_;
v_isShared_331_ = v_isSharedCheck_336_;
goto v_resetjp_329_;
}
else
{
lean_dec(v_s_287_);
v___x_330_ = lean_box(0);
v_isShared_331_ = v_isSharedCheck_336_;
goto v_resetjp_329_;
}
v_resetjp_329_:
{
lean_object* v___x_332_; lean_object* v___x_334_; 
v___x_332_ = lean_unsigned_to_nat(0u);
if (v_isShared_331_ == 0)
{
lean_ctor_set(v___x_330_, 2, v___x_332_);
v___x_334_ = v___x_330_;
goto v_reusejp_333_;
}
else
{
lean_object* v_reuseFailAlloc_335_; 
v_reuseFailAlloc_335_ = lean_alloc_ctor(0, 3, 3);
lean_ctor_set(v_reuseFailAlloc_335_, 0, v_heldLocks_291_);
lean_ctor_set(v_reuseFailAlloc_335_, 1, v_pendingEffects_292_);
lean_ctor_set(v_reuseFailAlloc_335_, 2, v___x_332_);
lean_ctor_set_uint8(v_reuseFailAlloc_335_, sizeof(void*)*3, v_controllerTerminated_290_);
lean_ctor_set_uint8(v_reuseFailAlloc_335_, sizeof(void*)*3 + 1, v_handoffAcknowledged_294_);
lean_ctor_set_uint8(v_reuseFailAlloc_335_, sizeof(void*)*3 + 2, v_custodyReleased_289_);
v___x_334_ = v_reuseFailAlloc_335_;
goto v_reusejp_333_;
}
v_reusejp_333_:
{
return v___x_334_;
}
}
}
case 4:
{
lean_object* v___x_341_; uint8_t v_isShared_342_; uint8_t v_isSharedCheck_346_; 
lean_inc(v_inFlightEffects_293_);
lean_inc(v_pendingEffects_292_);
lean_inc(v_heldLocks_291_);
v_isSharedCheck_346_ = !lean_is_exclusive(v_s_287_);
if (v_isSharedCheck_346_ == 0)
{
lean_object* v_unused_347_; lean_object* v_unused_348_; lean_object* v_unused_349_; 
v_unused_347_ = lean_ctor_get(v_s_287_, 2);
lean_dec(v_unused_347_);
v_unused_348_ = lean_ctor_get(v_s_287_, 1);
lean_dec(v_unused_348_);
v_unused_349_ = lean_ctor_get(v_s_287_, 0);
lean_dec(v_unused_349_);
v___x_341_ = v_s_287_;
v_isShared_342_ = v_isSharedCheck_346_;
goto v_resetjp_340_;
}
else
{
lean_dec(v_s_287_);
v___x_341_ = lean_box(0);
v_isShared_342_ = v_isSharedCheck_346_;
goto v_resetjp_340_;
}
v_resetjp_340_:
{
lean_object* v___x_344_; 
if (v_isShared_342_ == 0)
{
v___x_344_ = v___x_341_;
goto v_reusejp_343_;
}
else
{
lean_object* v_reuseFailAlloc_345_; 
v_reuseFailAlloc_345_ = lean_alloc_ctor(0, 3, 3);
lean_ctor_set(v_reuseFailAlloc_345_, 0, v_heldLocks_291_);
lean_ctor_set(v_reuseFailAlloc_345_, 1, v_pendingEffects_292_);
lean_ctor_set(v_reuseFailAlloc_345_, 2, v_inFlightEffects_293_);
lean_ctor_set_uint8(v_reuseFailAlloc_345_, sizeof(void*)*3, v_controllerTerminated_290_);
lean_ctor_set_uint8(v_reuseFailAlloc_345_, sizeof(void*)*3 + 2, v_custodyReleased_289_);
v___x_344_ = v_reuseFailAlloc_345_;
goto v_reusejp_343_;
}
v_reusejp_343_:
{
lean_ctor_set_uint8(v___x_344_, sizeof(void*)*3 + 1, v___x_295_);
return v___x_344_;
}
}
}
default: 
{
uint8_t v___x_350_; 
v___x_350_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_instDecidableReleaseReady(v_s_287_);
if (v___x_350_ == 0)
{
return v_s_287_;
}
else
{
lean_object* v___x_352_; uint8_t v_isShared_353_; uint8_t v_isSharedCheck_357_; 
lean_inc(v_inFlightEffects_293_);
lean_inc(v_pendingEffects_292_);
lean_inc(v_heldLocks_291_);
v_isSharedCheck_357_ = !lean_is_exclusive(v_s_287_);
if (v_isSharedCheck_357_ == 0)
{
lean_object* v_unused_358_; lean_object* v_unused_359_; lean_object* v_unused_360_; 
v_unused_358_ = lean_ctor_get(v_s_287_, 2);
lean_dec(v_unused_358_);
v_unused_359_ = lean_ctor_get(v_s_287_, 1);
lean_dec(v_unused_359_);
v_unused_360_ = lean_ctor_get(v_s_287_, 0);
lean_dec(v_unused_360_);
v___x_352_ = v_s_287_;
v_isShared_353_ = v_isSharedCheck_357_;
goto v_resetjp_351_;
}
else
{
lean_dec(v_s_287_);
v___x_352_ = lean_box(0);
v_isShared_353_ = v_isSharedCheck_357_;
goto v_resetjp_351_;
}
v_resetjp_351_:
{
lean_object* v___x_355_; 
if (v_isShared_353_ == 0)
{
v___x_355_ = v___x_352_;
goto v_reusejp_354_;
}
else
{
lean_object* v_reuseFailAlloc_356_; 
v_reuseFailAlloc_356_ = lean_alloc_ctor(0, 3, 3);
lean_ctor_set(v_reuseFailAlloc_356_, 0, v_heldLocks_291_);
lean_ctor_set(v_reuseFailAlloc_356_, 1, v_pendingEffects_292_);
lean_ctor_set(v_reuseFailAlloc_356_, 2, v_inFlightEffects_293_);
lean_ctor_set_uint8(v_reuseFailAlloc_356_, sizeof(void*)*3, v_controllerTerminated_290_);
lean_ctor_set_uint8(v_reuseFailAlloc_356_, sizeof(void*)*3 + 1, v_handoffAcknowledged_294_);
v___x_355_ = v_reuseFailAlloc_356_;
goto v_reusejp_354_;
}
v_reusejp_354_:
{
lean_ctor_set_uint8(v___x_355_, sizeof(void*)*3 + 2, v___x_295_);
return v___x_355_;
}
}
}
}
}
}
else
{
return v_s_287_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_step___boxed(lean_object* v_s_361_, lean_object* v_e_362_){
_start:
{
uint8_t v_e_boxed_363_; lean_object* v_res_364_; 
v_e_boxed_363_ = lean_unbox(v_e_362_);
v_res_364_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_step(v_s_361_, v_e_boxed_363_);
return v_res_364_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRA1Retirement_0__PhysicalBridges_IRA1Retirement_step_match__1_splitter___redArg(uint8_t v_e_365_, lean_object* v_h__1_366_, lean_object* v_h__2_367_, lean_object* v_h__3_368_, lean_object* v_h__4_369_, lean_object* v_h__5_370_, lean_object* v_h__6_371_){
_start:
{
switch(v_e_365_)
{
case 0:
{
lean_object* v___x_372_; lean_object* v___x_373_; 
lean_dec(v_h__6_371_);
lean_dec(v_h__5_370_);
lean_dec(v_h__4_369_);
lean_dec(v_h__3_368_);
lean_dec(v_h__2_367_);
v___x_372_ = lean_box(0);
v___x_373_ = lean_apply_1(v_h__1_366_, v___x_372_);
return v___x_373_;
}
case 1:
{
lean_object* v___x_374_; lean_object* v___x_375_; 
lean_dec(v_h__6_371_);
lean_dec(v_h__5_370_);
lean_dec(v_h__4_369_);
lean_dec(v_h__3_368_);
lean_dec(v_h__1_366_);
v___x_374_ = lean_box(0);
v___x_375_ = lean_apply_1(v_h__2_367_, v___x_374_);
return v___x_375_;
}
case 2:
{
lean_object* v___x_376_; lean_object* v___x_377_; 
lean_dec(v_h__6_371_);
lean_dec(v_h__5_370_);
lean_dec(v_h__4_369_);
lean_dec(v_h__2_367_);
lean_dec(v_h__1_366_);
v___x_376_ = lean_box(0);
v___x_377_ = lean_apply_1(v_h__3_368_, v___x_376_);
return v___x_377_;
}
case 3:
{
lean_object* v___x_378_; lean_object* v___x_379_; 
lean_dec(v_h__6_371_);
lean_dec(v_h__5_370_);
lean_dec(v_h__3_368_);
lean_dec(v_h__2_367_);
lean_dec(v_h__1_366_);
v___x_378_ = lean_box(0);
v___x_379_ = lean_apply_1(v_h__4_369_, v___x_378_);
return v___x_379_;
}
case 4:
{
lean_object* v___x_380_; lean_object* v___x_381_; 
lean_dec(v_h__6_371_);
lean_dec(v_h__4_369_);
lean_dec(v_h__3_368_);
lean_dec(v_h__2_367_);
lean_dec(v_h__1_366_);
v___x_380_ = lean_box(0);
v___x_381_ = lean_apply_1(v_h__5_370_, v___x_380_);
return v___x_381_;
}
default: 
{
lean_object* v___x_382_; lean_object* v___x_383_; 
lean_dec(v_h__5_370_);
lean_dec(v_h__4_369_);
lean_dec(v_h__3_368_);
lean_dec(v_h__2_367_);
lean_dec(v_h__1_366_);
v___x_382_ = lean_box(0);
v___x_383_ = lean_apply_1(v_h__6_371_, v___x_382_);
return v___x_383_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRA1Retirement_0__PhysicalBridges_IRA1Retirement_step_match__1_splitter___redArg___boxed(lean_object* v_e_384_, lean_object* v_h__1_385_, lean_object* v_h__2_386_, lean_object* v_h__3_387_, lean_object* v_h__4_388_, lean_object* v_h__5_389_, lean_object* v_h__6_390_){
_start:
{
uint8_t v_e_60__boxed_391_; lean_object* v_res_392_; 
v_e_60__boxed_391_ = lean_unbox(v_e_384_);
v_res_392_ = lp_physical__bridges___private_PhysicalBridges_IRA1Retirement_0__PhysicalBridges_IRA1Retirement_step_match__1_splitter___redArg(v_e_60__boxed_391_, v_h__1_385_, v_h__2_386_, v_h__3_387_, v_h__4_388_, v_h__5_389_, v_h__6_390_);
return v_res_392_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRA1Retirement_0__PhysicalBridges_IRA1Retirement_step_match__1_splitter(lean_object* v_motive_393_, uint8_t v_e_394_, lean_object* v_h__1_395_, lean_object* v_h__2_396_, lean_object* v_h__3_397_, lean_object* v_h__4_398_, lean_object* v_h__5_399_, lean_object* v_h__6_400_){
_start:
{
switch(v_e_394_)
{
case 0:
{
lean_object* v___x_401_; lean_object* v___x_402_; 
lean_dec(v_h__6_400_);
lean_dec(v_h__5_399_);
lean_dec(v_h__4_398_);
lean_dec(v_h__3_397_);
lean_dec(v_h__2_396_);
v___x_401_ = lean_box(0);
v___x_402_ = lean_apply_1(v_h__1_395_, v___x_401_);
return v___x_402_;
}
case 1:
{
lean_object* v___x_403_; lean_object* v___x_404_; 
lean_dec(v_h__6_400_);
lean_dec(v_h__5_399_);
lean_dec(v_h__4_398_);
lean_dec(v_h__3_397_);
lean_dec(v_h__1_395_);
v___x_403_ = lean_box(0);
v___x_404_ = lean_apply_1(v_h__2_396_, v___x_403_);
return v___x_404_;
}
case 2:
{
lean_object* v___x_405_; lean_object* v___x_406_; 
lean_dec(v_h__6_400_);
lean_dec(v_h__5_399_);
lean_dec(v_h__4_398_);
lean_dec(v_h__2_396_);
lean_dec(v_h__1_395_);
v___x_405_ = lean_box(0);
v___x_406_ = lean_apply_1(v_h__3_397_, v___x_405_);
return v___x_406_;
}
case 3:
{
lean_object* v___x_407_; lean_object* v___x_408_; 
lean_dec(v_h__6_400_);
lean_dec(v_h__5_399_);
lean_dec(v_h__3_397_);
lean_dec(v_h__2_396_);
lean_dec(v_h__1_395_);
v___x_407_ = lean_box(0);
v___x_408_ = lean_apply_1(v_h__4_398_, v___x_407_);
return v___x_408_;
}
case 4:
{
lean_object* v___x_409_; lean_object* v___x_410_; 
lean_dec(v_h__6_400_);
lean_dec(v_h__4_398_);
lean_dec(v_h__3_397_);
lean_dec(v_h__2_396_);
lean_dec(v_h__1_395_);
v___x_409_ = lean_box(0);
v___x_410_ = lean_apply_1(v_h__5_399_, v___x_409_);
return v___x_410_;
}
default: 
{
lean_object* v___x_411_; lean_object* v___x_412_; 
lean_dec(v_h__5_399_);
lean_dec(v_h__4_398_);
lean_dec(v_h__3_397_);
lean_dec(v_h__2_396_);
lean_dec(v_h__1_395_);
v___x_411_ = lean_box(0);
v___x_412_ = lean_apply_1(v_h__6_400_, v___x_411_);
return v___x_412_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRA1Retirement_0__PhysicalBridges_IRA1Retirement_step_match__1_splitter___boxed(lean_object* v_motive_413_, lean_object* v_e_414_, lean_object* v_h__1_415_, lean_object* v_h__2_416_, lean_object* v_h__3_417_, lean_object* v_h__4_418_, lean_object* v_h__5_419_, lean_object* v_h__6_420_){
_start:
{
uint8_t v_e_87__boxed_421_; lean_object* v_res_422_; 
v_e_87__boxed_421_ = lean_unbox(v_e_414_);
v_res_422_ = lp_physical__bridges___private_PhysicalBridges_IRA1Retirement_0__PhysicalBridges_IRA1Retirement_step_match__1_splitter(v_motive_413_, v_e_87__boxed_421_, v_h__1_415_, v_h__2_416_, v_h__3_417_, v_h__4_418_, v_h__5_419_, v_h__6_420_);
return v_res_422_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1Retirement_run_spec__0(lean_object* v_x_423_, lean_object* v_x_424_){
_start:
{
if (lean_obj_tag(v_x_424_) == 0)
{
return v_x_423_;
}
else
{
lean_object* v_head_425_; lean_object* v_tail_426_; uint8_t v___x_427_; lean_object* v___x_428_; 
v_head_425_ = lean_ctor_get(v_x_424_, 0);
v_tail_426_ = lean_ctor_get(v_x_424_, 1);
v___x_427_ = lean_unbox(v_head_425_);
v___x_428_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_step(v_x_423_, v___x_427_);
v_x_423_ = v___x_428_;
v_x_424_ = v_tail_426_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1Retirement_run_spec__0___boxed(lean_object* v_x_430_, lean_object* v_x_431_){
_start:
{
lean_object* v_res_432_; 
v_res_432_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1Retirement_run_spec__0(v_x_430_, v_x_431_);
lean_dec(v_x_431_);
return v_res_432_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_run(lean_object* v_s_433_, lean_object* v_events_434_){
_start:
{
lean_object* v___x_435_; 
v___x_435_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRA1Retirement_run_spec__0(v_s_433_, v_events_434_);
return v___x_435_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_run___boxed(lean_object* v_s_436_, lean_object* v_events_437_){
_start:
{
lean_object* v_res_438_; 
v_res_438_ = lp_physical__bridges_PhysicalBridges_IRA1Retirement_run(v_s_436_, v_events_437_);
lean_dec(v_events_437_);
return v_res_438_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1Retirement_weakRelease(lean_object* v_s_439_){
_start:
{
uint8_t v_controllerTerminated_440_; 
v_controllerTerminated_440_ = lean_ctor_get_uint8(v_s_439_, sizeof(void*)*3);
if (v_controllerTerminated_440_ == 0)
{
return v_s_439_;
}
else
{
lean_object* v_heldLocks_441_; lean_object* v_pendingEffects_442_; lean_object* v_inFlightEffects_443_; uint8_t v_handoffAcknowledged_444_; lean_object* v___x_445_; uint8_t v___x_446_; 
v_heldLocks_441_ = lean_ctor_get(v_s_439_, 0);
v_pendingEffects_442_ = lean_ctor_get(v_s_439_, 1);
v_inFlightEffects_443_ = lean_ctor_get(v_s_439_, 2);
v_handoffAcknowledged_444_ = lean_ctor_get_uint8(v_s_439_, sizeof(void*)*3 + 1);
v___x_445_ = lean_unsigned_to_nat(0u);
v___x_446_ = lean_nat_dec_eq(v_heldLocks_441_, v___x_445_);
if (v___x_446_ == 0)
{
return v_s_439_;
}
else
{
lean_object* v___x_448_; uint8_t v_isShared_449_; uint8_t v_isSharedCheck_453_; 
lean_inc(v_inFlightEffects_443_);
lean_inc(v_pendingEffects_442_);
lean_inc(v_heldLocks_441_);
v_isSharedCheck_453_ = !lean_is_exclusive(v_s_439_);
if (v_isSharedCheck_453_ == 0)
{
lean_object* v_unused_454_; lean_object* v_unused_455_; lean_object* v_unused_456_; 
v_unused_454_ = lean_ctor_get(v_s_439_, 2);
lean_dec(v_unused_454_);
v_unused_455_ = lean_ctor_get(v_s_439_, 1);
lean_dec(v_unused_455_);
v_unused_456_ = lean_ctor_get(v_s_439_, 0);
lean_dec(v_unused_456_);
v___x_448_ = v_s_439_;
v_isShared_449_ = v_isSharedCheck_453_;
goto v_resetjp_447_;
}
else
{
lean_dec(v_s_439_);
v___x_448_ = lean_box(0);
v_isShared_449_ = v_isSharedCheck_453_;
goto v_resetjp_447_;
}
v_resetjp_447_:
{
lean_object* v___x_451_; 
if (v_isShared_449_ == 0)
{
v___x_451_ = v___x_448_;
goto v_reusejp_450_;
}
else
{
lean_object* v_reuseFailAlloc_452_; 
v_reuseFailAlloc_452_ = lean_alloc_ctor(0, 3, 3);
lean_ctor_set(v_reuseFailAlloc_452_, 0, v_heldLocks_441_);
lean_ctor_set(v_reuseFailAlloc_452_, 1, v_pendingEffects_442_);
lean_ctor_set(v_reuseFailAlloc_452_, 2, v_inFlightEffects_443_);
lean_ctor_set_uint8(v_reuseFailAlloc_452_, sizeof(void*)*3, v_controllerTerminated_440_);
lean_ctor_set_uint8(v_reuseFailAlloc_452_, sizeof(void*)*3 + 1, v_handoffAcknowledged_444_);
v___x_451_ = v_reuseFailAlloc_452_;
goto v_reusejp_450_;
}
v_reusejp_450_:
{
lean_ctor_set_uint8(v___x_451_, sizeof(void*)*3 + 2, v_controllerTerminated_440_);
return v___x_451_;
}
}
}
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRA1Delegation(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRInFlightQuiescence(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRA1Retirement(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRA1Delegation(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_physical__bridges_PhysicalBridges_IRInFlightQuiescence(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
