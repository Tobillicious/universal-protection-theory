// Lean compiler output
// Module: PhysicalBridges.IREnergyReplenishment
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
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* lean_nat_sub(lean_object*, lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_drainingStep___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_drainingStep___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_drainingStep(lean_object*, uint8_t, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_drainingStep___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IREnergyReplenishment_0__PhysicalBridges_IRViability_Viable_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IREnergyReplenishment_0__PhysicalBridges_IRViability_Viable_match__1_splitter___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IREnergyReplenishment_0__PhysicalBridges_IRViability_Viable_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IREnergyReplenishment_0__PhysicalBridges_IRViability_Viable_match__1_splitter___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_suppliedStep___redArg(lean_object*, lean_object*, lean_object*, uint8_t, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_suppliedStep___redArg___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_suppliedStep(lean_object*, lean_object*, lean_object*, lean_object*, uint8_t, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_suppliedStep___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_intermittentSupply(uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_intermittentSupply___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_drainingStep___redArg(lean_object* v_energy_1_){
_start:
{
lean_object* v___x_2_; lean_object* v___x_3_; 
v___x_2_ = lean_unsigned_to_nat(1u);
v___x_3_ = lean_nat_sub(v_energy_1_, v___x_2_);
return v___x_3_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_drainingStep___redArg___boxed(lean_object* v_energy_4_){
_start:
{
lean_object* v_res_5_; 
v_res_5_ = lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_drainingStep___redArg(v_energy_4_);
lean_dec(v_energy_4_);
return v_res_5_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_drainingStep(lean_object* v_energy_6_, uint8_t v___action_7_, lean_object* v___disturbance_8_){
_start:
{
lean_object* v___x_9_; 
v___x_9_ = lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_drainingStep___redArg(v_energy_6_);
return v___x_9_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_drainingStep___boxed(lean_object* v_energy_10_, lean_object* v___action_11_, lean_object* v___disturbance_12_){
_start:
{
uint8_t v___action_boxed_13_; lean_object* v_res_14_; 
v___action_boxed_13_ = lean_unbox(v___action_11_);
v_res_14_ = lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_drainingStep(v_energy_10_, v___action_boxed_13_, v___disturbance_12_);
lean_dec(v_energy_10_);
return v_res_14_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IREnergyReplenishment_0__PhysicalBridges_IRViability_Viable_match__1_splitter___redArg(lean_object* v_x_15_, lean_object* v_x_16_, lean_object* v_h__1_17_, lean_object* v_h__2_18_){
_start:
{
lean_object* v_zero_19_; uint8_t v_isZero_20_; 
v_zero_19_ = lean_unsigned_to_nat(0u);
v_isZero_20_ = lean_nat_dec_eq(v_x_15_, v_zero_19_);
if (v_isZero_20_ == 1)
{
lean_object* v___x_21_; 
lean_dec(v_h__2_18_);
v___x_21_ = lean_apply_1(v_h__1_17_, v_x_16_);
return v___x_21_;
}
else
{
lean_object* v_one_22_; lean_object* v_n_23_; lean_object* v___x_24_; 
lean_dec(v_h__1_17_);
v_one_22_ = lean_unsigned_to_nat(1u);
v_n_23_ = lean_nat_sub(v_x_15_, v_one_22_);
v___x_24_ = lean_apply_2(v_h__2_18_, v_n_23_, v_x_16_);
return v___x_24_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IREnergyReplenishment_0__PhysicalBridges_IRViability_Viable_match__1_splitter___redArg___boxed(lean_object* v_x_25_, lean_object* v_x_26_, lean_object* v_h__1_27_, lean_object* v_h__2_28_){
_start:
{
lean_object* v_res_29_; 
v_res_29_ = lp_physical__bridges___private_PhysicalBridges_IREnergyReplenishment_0__PhysicalBridges_IRViability_Viable_match__1_splitter___redArg(v_x_25_, v_x_26_, v_h__1_27_, v_h__2_28_);
lean_dec(v_x_25_);
return v_res_29_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IREnergyReplenishment_0__PhysicalBridges_IRViability_Viable_match__1_splitter(lean_object* v_S_30_, lean_object* v_motive_31_, lean_object* v_x_32_, lean_object* v_x_33_, lean_object* v_h__1_34_, lean_object* v_h__2_35_){
_start:
{
lean_object* v_zero_36_; uint8_t v_isZero_37_; 
v_zero_36_ = lean_unsigned_to_nat(0u);
v_isZero_37_ = lean_nat_dec_eq(v_x_32_, v_zero_36_);
if (v_isZero_37_ == 1)
{
lean_object* v___x_38_; 
lean_dec(v_h__2_35_);
v___x_38_ = lean_apply_1(v_h__1_34_, v_x_33_);
return v___x_38_;
}
else
{
lean_object* v_one_39_; lean_object* v_n_40_; lean_object* v___x_41_; 
lean_dec(v_h__1_34_);
v_one_39_ = lean_unsigned_to_nat(1u);
v_n_40_ = lean_nat_sub(v_x_32_, v_one_39_);
v___x_41_ = lean_apply_2(v_h__2_35_, v_n_40_, v_x_33_);
return v___x_41_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IREnergyReplenishment_0__PhysicalBridges_IRViability_Viable_match__1_splitter___boxed(lean_object* v_S_42_, lean_object* v_motive_43_, lean_object* v_x_44_, lean_object* v_x_45_, lean_object* v_h__1_46_, lean_object* v_h__2_47_){
_start:
{
lean_object* v_res_48_; 
v_res_48_ = lp_physical__bridges___private_PhysicalBridges_IREnergyReplenishment_0__PhysicalBridges_IRViability_Viable_match__1_splitter(v_S_42_, v_motive_43_, v_x_44_, v_x_45_, v_h__1_46_, v_h__2_47_);
lean_dec(v_x_44_);
return v_res_48_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_suppliedStep___redArg(lean_object* v_supply_49_, lean_object* v_cost_50_, lean_object* v_energy_51_, uint8_t v_action_52_, lean_object* v_disturbance_53_){
_start:
{
lean_object* v___y_55_; 
if (v_action_52_ == 0)
{
lean_object* v___x_58_; 
lean_dec(v_disturbance_53_);
lean_dec_ref(v_supply_49_);
v___x_58_ = lean_unsigned_to_nat(0u);
v___y_55_ = v___x_58_;
goto v___jp_54_;
}
else
{
lean_object* v___x_59_; 
v___x_59_ = lean_apply_1(v_supply_49_, v_disturbance_53_);
v___y_55_ = v___x_59_;
goto v___jp_54_;
}
v___jp_54_:
{
lean_object* v___x_56_; lean_object* v___x_57_; 
v___x_56_ = lean_nat_add(v_energy_51_, v___y_55_);
lean_dec(v___y_55_);
v___x_57_ = lean_nat_sub(v___x_56_, v_cost_50_);
lean_dec(v___x_56_);
return v___x_57_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_suppliedStep___redArg___boxed(lean_object* v_supply_60_, lean_object* v_cost_61_, lean_object* v_energy_62_, lean_object* v_action_63_, lean_object* v_disturbance_64_){
_start:
{
uint8_t v_action_boxed_65_; lean_object* v_res_66_; 
v_action_boxed_65_ = lean_unbox(v_action_63_);
v_res_66_ = lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_suppliedStep___redArg(v_supply_60_, v_cost_61_, v_energy_62_, v_action_boxed_65_, v_disturbance_64_);
lean_dec(v_energy_62_);
lean_dec(v_cost_61_);
return v_res_66_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_suppliedStep(lean_object* v_D_67_, lean_object* v_supply_68_, lean_object* v_cost_69_, lean_object* v_energy_70_, uint8_t v_action_71_, lean_object* v_disturbance_72_){
_start:
{
lean_object* v___x_73_; 
v___x_73_ = lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_suppliedStep___redArg(v_supply_68_, v_cost_69_, v_energy_70_, v_action_71_, v_disturbance_72_);
return v___x_73_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_suppliedStep___boxed(lean_object* v_D_74_, lean_object* v_supply_75_, lean_object* v_cost_76_, lean_object* v_energy_77_, lean_object* v_action_78_, lean_object* v_disturbance_79_){
_start:
{
uint8_t v_action_boxed_80_; lean_object* v_res_81_; 
v_action_boxed_80_ = lean_unbox(v_action_78_);
v_res_81_ = lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_suppliedStep(v_D_74_, v_supply_75_, v_cost_76_, v_energy_77_, v_action_boxed_80_, v_disturbance_79_);
lean_dec(v_energy_77_);
lean_dec(v_cost_76_);
return v_res_81_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_intermittentSupply(uint8_t v_disturbance_82_){
_start:
{
if (v_disturbance_82_ == 0)
{
lean_object* v___x_83_; 
v___x_83_ = lean_unsigned_to_nat(0u);
return v___x_83_;
}
else
{
lean_object* v___x_84_; 
v___x_84_ = lean_unsigned_to_nat(1u);
return v___x_84_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_intermittentSupply___boxed(lean_object* v_disturbance_85_){
_start:
{
uint8_t v_disturbance_boxed_86_; lean_object* v_res_87_; 
v_disturbance_boxed_86_ = lean_unbox(v_disturbance_85_);
v_res_87_ = lp_physical__bridges_PhysicalBridges_IREnergyReplenishment_intermittentSupply(v_disturbance_boxed_86_);
return v_res_87_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRInfiniteHistoryCompactness(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IREnergyReplenishment(uint8_t builtin) {
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
