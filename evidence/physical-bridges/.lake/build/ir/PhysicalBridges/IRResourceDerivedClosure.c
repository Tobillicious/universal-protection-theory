// Lean compiler output
// Module: PhysicalBridges.IRResourceDerivedClosure
// Imports: public import Init public meta import Init public import PhysicalBridges.IRCoupledFinitaryTwoStage
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
lean_object* l_List_reverse___redArg(lean_object*);
lean_object* lean_nat_add(lean_object*, lean_object*);
lean_object* l_instDecidableEqNat___boxed(lean_object*, lean_object*);
uint8_t l_instDecidableEqProd___redArg(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1_spec__1(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1_spec__1___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_mapTR_loop___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__0(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_charge(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___lam__0(uint8_t, uint8_t);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___lam__0___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___lam__0___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___closed__0_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 0}, .m_objs = {((lean_object*)(((size_t)(0) << 1) | 1)),((lean_object*)(((size_t)(0) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 0}, .m_objs = {((lean_object*)(((size_t)(1) << 1) | 1)),((lean_object*)(((size_t)(0) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___closed__2_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_unitCapacity___redArg();
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_unitCapacity___redArg___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_unitCapacity(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_unitCapacity___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1_spec__1(lean_object* v_init_1_, lean_object* v_x_2_){
_start:
{
if (lean_obj_tag(v_x_2_) == 0)
{
lean_inc(v_init_1_);
return v_init_1_;
}
else
{
lean_object* v_head_3_; lean_object* v_tail_4_; lean_object* v___x_5_; lean_object* v___x_6_; 
v_head_3_ = lean_ctor_get(v_x_2_, 0);
v_tail_4_ = lean_ctor_get(v_x_2_, 1);
v___x_5_ = lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1_spec__1(v_init_1_, v_tail_4_);
v___x_6_ = lean_nat_add(v_head_3_, v___x_5_);
lean_dec(v___x_5_);
return v___x_6_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1_spec__1___boxed(lean_object* v_init_7_, lean_object* v_x_8_){
_start:
{
lean_object* v_res_9_; 
v_res_9_ = lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1_spec__1(v_init_7_, v_x_8_);
lean_dec(v_x_8_);
lean_dec(v_init_7_);
return v_res_9_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1(lean_object* v_l_10_){
_start:
{
lean_object* v___x_11_; lean_object* v___x_12_; 
v___x_11_ = lean_unsigned_to_nat(0u);
v___x_12_ = lp_physical__bridges_List_foldr___at___00List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1_spec__1(v___x_11_, v_l_10_);
return v___x_12_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1___boxed(lean_object* v_l_13_){
_start:
{
lean_object* v_res_14_; 
v_res_14_ = lp_physical__bridges_List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1(v_l_13_);
lean_dec(v_l_13_);
return v_res_14_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_mapTR_loop___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__0(lean_object* v___x_15_, lean_object* v_a_16_, lean_object* v_a_17_){
_start:
{
if (lean_obj_tag(v_a_16_) == 0)
{
lean_object* v___x_18_; 
lean_dec_ref(v___x_15_);
v___x_18_ = l_List_reverse___redArg(v_a_17_);
return v___x_18_;
}
else
{
lean_object* v_head_19_; lean_object* v_tail_20_; lean_object* v___x_22_; uint8_t v_isShared_23_; uint8_t v_isSharedCheck_29_; 
v_head_19_ = lean_ctor_get(v_a_16_, 0);
v_tail_20_ = lean_ctor_get(v_a_16_, 1);
v_isSharedCheck_29_ = !lean_is_exclusive(v_a_16_);
if (v_isSharedCheck_29_ == 0)
{
v___x_22_ = v_a_16_;
v_isShared_23_ = v_isSharedCheck_29_;
goto v_resetjp_21_;
}
else
{
lean_inc(v_tail_20_);
lean_inc(v_head_19_);
lean_dec(v_a_16_);
v___x_22_ = lean_box(0);
v_isShared_23_ = v_isSharedCheck_29_;
goto v_resetjp_21_;
}
v_resetjp_21_:
{
lean_object* v___x_24_; lean_object* v___x_26_; 
lean_inc_ref(v___x_15_);
v___x_24_ = lean_apply_1(v___x_15_, v_head_19_);
if (v_isShared_23_ == 0)
{
lean_ctor_set(v___x_22_, 1, v_a_17_);
lean_ctor_set(v___x_22_, 0, v___x_24_);
v___x_26_ = v___x_22_;
goto v_reusejp_25_;
}
else
{
lean_object* v_reuseFailAlloc_28_; 
v_reuseFailAlloc_28_ = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(v_reuseFailAlloc_28_, 0, v___x_24_);
lean_ctor_set(v_reuseFailAlloc_28_, 1, v_a_17_);
v___x_26_ = v_reuseFailAlloc_28_;
goto v_reusejp_25_;
}
v_reusejp_25_:
{
v_a_16_ = v_tail_20_;
v_a_17_ = v___x_26_;
goto _start;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_charge(lean_object* v_weight_30_, lean_object* v_r_31_, lean_object* v_xs_32_){
_start:
{
lean_object* v___x_33_; lean_object* v___x_34_; lean_object* v___x_35_; lean_object* v___x_36_; 
v___x_33_ = lean_apply_1(v_weight_30_, v_r_31_);
v___x_34_ = lean_box(0);
v___x_35_ = lp_physical__bridges_List_mapTR_loop___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__0(v___x_33_, v_xs_32_, v___x_34_);
v___x_36_ = lp_physical__bridges_List_sum___at___00PhysicalBridges_IRResourceDerivedClosure_charge_spec__1(v___x_35_);
lean_dec(v___x_35_);
return v___x_36_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___lam__0(uint8_t v___y_37_, uint8_t v___y_38_){
_start:
{
if (v___y_38_ == 0)
{
if (v___y_37_ == 0)
{
uint8_t v___x_39_; 
v___x_39_ = 1;
return v___x_39_;
}
else
{
return v___y_38_;
}
}
else
{
return v___y_37_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___lam__0___boxed(lean_object* v___y_40_, lean_object* v___y_41_){
_start:
{
uint8_t v___y_206__boxed_42_; uint8_t v___y_207__boxed_43_; uint8_t v_res_44_; lean_object* v_r_45_; 
v___y_206__boxed_42_ = lean_unbox(v___y_40_);
v___y_207__boxed_43_ = lean_unbox(v___y_41_);
v_res_44_ = lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___lam__0(v___y_206__boxed_42_, v___y_207__boxed_43_);
v_r_45_ = lean_box(v_res_44_);
return v_r_45_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg(lean_object* v_f_55_){
_start:
{
lean_object* v___f_56_; lean_object* v___x_57_; lean_object* v___x_58_; lean_object* v___x_59_; uint8_t v___x_60_; 
v___f_56_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___closed__0));
v___x_57_ = lean_alloc_closure((void*)(l_instDecidableEqNat___boxed), 2, 0);
v___x_58_ = lean_unsigned_to_nat(0u);
v___x_59_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___closed__1));
lean_inc_ref(v_f_55_);
lean_inc_ref(v___x_57_);
v___x_60_ = l_instDecidableEqProd___redArg(v___f_56_, v___x_57_, v_f_55_, v___x_59_);
if (v___x_60_ == 0)
{
lean_object* v___x_61_; uint8_t v___x_62_; 
v___x_61_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg___closed__2));
v___x_62_ = l_instDecidableEqProd___redArg(v___f_56_, v___x_57_, v_f_55_, v___x_61_);
if (v___x_62_ == 0)
{
return v___x_58_;
}
else
{
lean_object* v___x_63_; 
v___x_63_ = lean_unsigned_to_nat(1u);
return v___x_63_;
}
}
else
{
lean_object* v___x_64_; 
lean_dec_ref(v___x_57_);
lean_dec_ref(v_f_55_);
v___x_64_ = lean_unsigned_to_nat(1u);
return v___x_64_;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost(lean_object* v___r_65_, lean_object* v_f_66_){
_start:
{
lean_object* v___x_67_; 
v___x_67_ = lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___redArg(v_f_66_);
return v___x_67_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost___boxed(lean_object* v___r_68_, lean_object* v_f_69_){
_start:
{
lean_object* v_res_70_; 
v_res_70_ = lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_sharedCost(v___r_68_, v_f_69_);
lean_dec(v___r_68_);
return v_res_70_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_unitCapacity___redArg(){
_start:
{
lean_object* v___x_72_; 
v___x_72_ = lean_unsigned_to_nat(1u);
return v___x_72_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_unitCapacity___redArg___boxed(lean_object* v___dummy_73_){
_start:
{
lean_object* v_res_74_; 
v_res_74_ = lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_unitCapacity___redArg();
return v_res_74_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_unitCapacity(lean_object* v___r_75_){
_start:
{
lean_object* v___x_76_; 
v___x_76_ = lean_unsigned_to_nat(1u);
return v___x_76_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_unitCapacity___boxed(lean_object* v___r_77_){
_start:
{
lean_object* v_res_78_; 
v_res_78_ = lp_physical__bridges_PhysicalBridges_IRResourceDerivedClosure_unitCapacity(v___r_77_);
lean_dec(v___r_77_);
return v_res_78_;
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRCoupledFinitaryTwoStage(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRResourceDerivedClosure(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRCoupledFinitaryTwoStage(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
