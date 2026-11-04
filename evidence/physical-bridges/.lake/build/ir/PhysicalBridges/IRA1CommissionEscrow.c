// Lean compiler output
// Module: PhysicalBridges.IRA1CommissionEscrow
// Imports: public import Init public meta import Init public import PhysicalBridges.IREnergyReplenishment public import PhysicalBridges.IRA1PacketJournalJoin
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
lean_object* lean_nat_mul(lean_object*, lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CommissionEscrow_commissionPermit(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CommissionEscrow_commissionPermit___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRA1CommissionEscrow_commissionPermit(lean_object* v_escrow_1_, lean_object* v_initialCost_2_, lean_object* v_recurringCost_3_, lean_object* v_horizon_4_){
_start:
{
lean_object* v___x_5_; lean_object* v___x_6_; uint8_t v___x_7_; 
v___x_5_ = lean_nat_mul(v_horizon_4_, v_recurringCost_3_);
v___x_6_ = lean_nat_add(v_initialCost_2_, v___x_5_);
lean_dec(v___x_5_);
v___x_7_ = lean_nat_dec_le(v___x_6_, v_escrow_1_);
lean_dec(v___x_6_);
return v___x_7_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRA1CommissionEscrow_commissionPermit___boxed(lean_object* v_escrow_8_, lean_object* v_initialCost_9_, lean_object* v_recurringCost_10_, lean_object* v_horizon_11_){
_start:
{
uint8_t v_res_12_; lean_object* v_r_13_; 
v_res_12_ = lp_physical__bridges_PhysicalBridges_IRA1CommissionEscrow_commissionPermit(v_escrow_8_, v_initialCost_9_, v_recurringCost_10_, v_horizon_11_);
lean_dec(v_horizon_11_);
lean_dec(v_recurringCost_10_);
lean_dec(v_initialCost_9_);
lean_dec(v_escrow_8_);
v_r_13_ = lean_box(v_res_12_);
return v_r_13_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IREnergyReplenishment(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin(uint8_t builtin);
void lean_initialize();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRA1CommissionEscrow(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IREnergyReplenishment(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_physical__bridges_PhysicalBridges_IRA1PacketJournalJoin(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
