// Lean compiler output
// Module: PhysicalBridges.IRChannelInventory
// Imports: public import Init public meta import Init public import PhysicalBridges.IRAggregateBudget
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
lean_object* l_Nat_reprFast(lean_object*);
lean_object* l_Repr_addAppParen(lean_object*, lean_object*);
uint8_t lean_nat_dec_le(lean_object*, lean_object*);
lean_object* lean_nat_to_int(lean_object*);
uint8_t lean_nat_dec_eq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorIdx(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorIdx___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_authorised_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_authorised_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_environmental_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_environmental_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_latent_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_latent_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_bypass_elim___redArg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_bypass_elim(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRChannelInventory_instDecidableEqChannel_decEq(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instDecidableEqChannel_decEq___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRChannelInventory_instDecidableEqChannel(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instDecidableEqChannel___boxed(lean_object*, lean_object*);
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 54, .m_capacity = 54, .m_length = 53, .m_data = "PhysicalBridges.IRChannelInventory.Channel.authorised"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__0_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__1_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__0_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__1 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__1_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__2_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__1_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__2 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__2_value;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3;
static lean_once_cell_t lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4_once = LEAN_ONCE_CELL_INITIALIZER;
static lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__5_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 57, .m_capacity = 57, .m_length = 56, .m_data = "PhysicalBridges.IRChannelInventory.Channel.environmental"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__5 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__5_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__6_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__5_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__6 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__6_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__7_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__6_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__7 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__7_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__8_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 50, .m_capacity = 50, .m_length = 49, .m_data = "PhysicalBridges.IRChannelInventory.Channel.latent"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__8 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__8_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__9_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__8_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__9 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__9_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__10_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__9_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__10 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__10_value;
static const lean_string_object lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__11_value = {.m_header = {.m_rc = 0, .m_cs_sz = 0, .m_other = 0, .m_tag = 249}, .m_size = 50, .m_capacity = 50, .m_length = 49, .m_data = "PhysicalBridges.IRChannelInventory.Channel.bypass"};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__11 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__11_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__12_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*1 + 0, .m_other = 1, .m_tag = 3}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__11_value)}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__12 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__12_value;
static const lean_ctor_object lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__13_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_ctor_object) + sizeof(void*)*2 + 0, .m_other = 2, .m_tag = 5}, .m_objs = {((lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__12_value),((lean_object*)(((size_t)(1) << 1) | 1))}};
static const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__13 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__13_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___boxed(lean_object*, lean_object*);
static const lean_closure_object lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel___closed__0_value = {.m_header = {.m_rc = 0, .m_cs_sz = sizeof(lean_closure_object) + sizeof(void*)*0, .m_other = 0, .m_tag = 245}, .m_fun = (void*)lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___boxed, .m_arity = 2, .m_num_fixed = 0, .m_objs = {} };
static const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel___closed__0 = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel___closed__0_value;
LEAN_EXPORT const lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel = (const lean_object*)&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel___closed__0_value;
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_charge(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_charge___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_incompleteCharge(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_incompleteCharge___boxed(lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_apply(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_apply___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRChannelInventory_run_spec__0(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRChannelInventory_run_spec__0___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_run(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_run___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRChannelInventory_0__PhysicalBridges_IRChannelInventory_instReprChannel_repr_match__1_splitter___redArg(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRChannelInventory_0__PhysicalBridges_IRChannelInventory_instReprChannel_repr_match__1_splitter(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorIdx(lean_object* v_x_1_){
_start:
{
switch(lean_obj_tag(v_x_1_))
{
case 0:
{
lean_object* v___x_2_; 
v___x_2_ = lean_unsigned_to_nat(0u);
return v___x_2_;
}
case 1:
{
lean_object* v___x_3_; 
v___x_3_ = lean_unsigned_to_nat(1u);
return v___x_3_;
}
case 2:
{
lean_object* v___x_4_; 
v___x_4_ = lean_unsigned_to_nat(2u);
return v___x_4_;
}
default: 
{
lean_object* v___x_5_; 
v___x_5_ = lean_unsigned_to_nat(3u);
return v___x_5_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorIdx___boxed(lean_object* v_x_6_){
_start:
{
lean_object* v_res_7_; 
v_res_7_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorIdx(v_x_6_);
lean_dec_ref(v_x_6_);
return v_res_7_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim___redArg(lean_object* v_t_8_, lean_object* v_k_9_){
_start:
{
lean_object* v_weight_10_; lean_object* v___x_11_; 
v_weight_10_ = lean_ctor_get(v_t_8_, 0);
lean_inc(v_weight_10_);
lean_dec_ref(v_t_8_);
v___x_11_ = lean_apply_1(v_k_9_, v_weight_10_);
return v___x_11_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim(lean_object* v_motive_12_, lean_object* v_ctorIdx_13_, lean_object* v_t_14_, lean_object* v_h_15_, lean_object* v_k_16_){
_start:
{
lean_object* v___x_17_; 
v___x_17_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim___redArg(v_t_14_, v_k_16_);
return v___x_17_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim___boxed(lean_object* v_motive_18_, lean_object* v_ctorIdx_19_, lean_object* v_t_20_, lean_object* v_h_21_, lean_object* v_k_22_){
_start:
{
lean_object* v_res_23_; 
v_res_23_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim(v_motive_18_, v_ctorIdx_19_, v_t_20_, v_h_21_, v_k_22_);
lean_dec(v_ctorIdx_19_);
return v_res_23_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_authorised_elim___redArg(lean_object* v_t_24_, lean_object* v_authorised_25_){
_start:
{
lean_object* v___x_26_; 
v___x_26_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim___redArg(v_t_24_, v_authorised_25_);
return v___x_26_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_authorised_elim(lean_object* v_motive_27_, lean_object* v_t_28_, lean_object* v_h_29_, lean_object* v_authorised_30_){
_start:
{
lean_object* v___x_31_; 
v___x_31_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim___redArg(v_t_28_, v_authorised_30_);
return v___x_31_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_environmental_elim___redArg(lean_object* v_t_32_, lean_object* v_environmental_33_){
_start:
{
lean_object* v___x_34_; 
v___x_34_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim___redArg(v_t_32_, v_environmental_33_);
return v___x_34_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_environmental_elim(lean_object* v_motive_35_, lean_object* v_t_36_, lean_object* v_h_37_, lean_object* v_environmental_38_){
_start:
{
lean_object* v___x_39_; 
v___x_39_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim___redArg(v_t_36_, v_environmental_38_);
return v___x_39_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_latent_elim___redArg(lean_object* v_t_40_, lean_object* v_latent_41_){
_start:
{
lean_object* v___x_42_; 
v___x_42_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim___redArg(v_t_40_, v_latent_41_);
return v___x_42_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_latent_elim(lean_object* v_motive_43_, lean_object* v_t_44_, lean_object* v_h_45_, lean_object* v_latent_46_){
_start:
{
lean_object* v___x_47_; 
v___x_47_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim___redArg(v_t_44_, v_latent_46_);
return v___x_47_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_bypass_elim___redArg(lean_object* v_t_48_, lean_object* v_bypass_49_){
_start:
{
lean_object* v___x_50_; 
v___x_50_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim___redArg(v_t_48_, v_bypass_49_);
return v___x_50_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_bypass_elim(lean_object* v_motive_51_, lean_object* v_t_52_, lean_object* v_h_53_, lean_object* v_bypass_54_){
_start:
{
lean_object* v___x_55_; 
v___x_55_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_Channel_ctorElim___redArg(v_t_52_, v_bypass_54_);
return v___x_55_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRChannelInventory_instDecidableEqChannel_decEq(lean_object* v_x_56_, lean_object* v_x_57_){
_start:
{
switch(lean_obj_tag(v_x_56_))
{
case 0:
{
if (lean_obj_tag(v_x_57_) == 0)
{
lean_object* v_weight_58_; lean_object* v_weight_59_; uint8_t v___x_60_; 
v_weight_58_ = lean_ctor_get(v_x_56_, 0);
v_weight_59_ = lean_ctor_get(v_x_57_, 0);
v___x_60_ = lean_nat_dec_eq(v_weight_58_, v_weight_59_);
return v___x_60_;
}
else
{
uint8_t v___x_61_; 
v___x_61_ = 0;
return v___x_61_;
}
}
case 1:
{
if (lean_obj_tag(v_x_57_) == 1)
{
lean_object* v_weight_62_; lean_object* v_weight_63_; uint8_t v___x_64_; 
v_weight_62_ = lean_ctor_get(v_x_56_, 0);
v_weight_63_ = lean_ctor_get(v_x_57_, 0);
v___x_64_ = lean_nat_dec_eq(v_weight_62_, v_weight_63_);
return v___x_64_;
}
else
{
uint8_t v___x_65_; 
v___x_65_ = 0;
return v___x_65_;
}
}
case 2:
{
if (lean_obj_tag(v_x_57_) == 2)
{
lean_object* v_weight_66_; lean_object* v_weight_67_; uint8_t v___x_68_; 
v_weight_66_ = lean_ctor_get(v_x_56_, 0);
v_weight_67_ = lean_ctor_get(v_x_57_, 0);
v___x_68_ = lean_nat_dec_eq(v_weight_66_, v_weight_67_);
return v___x_68_;
}
else
{
uint8_t v___x_69_; 
v___x_69_ = 0;
return v___x_69_;
}
}
default: 
{
if (lean_obj_tag(v_x_57_) == 3)
{
lean_object* v_weight_70_; lean_object* v_weight_71_; uint8_t v___x_72_; 
v_weight_70_ = lean_ctor_get(v_x_56_, 0);
v_weight_71_ = lean_ctor_get(v_x_57_, 0);
v___x_72_ = lean_nat_dec_eq(v_weight_70_, v_weight_71_);
return v___x_72_;
}
else
{
uint8_t v___x_73_; 
v___x_73_ = 0;
return v___x_73_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instDecidableEqChannel_decEq___boxed(lean_object* v_x_74_, lean_object* v_x_75_){
_start:
{
uint8_t v_res_76_; lean_object* v_r_77_; 
v_res_76_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_instDecidableEqChannel_decEq(v_x_74_, v_x_75_);
lean_dec_ref(v_x_75_);
lean_dec_ref(v_x_74_);
v_r_77_ = lean_box(v_res_76_);
return v_r_77_;
}
}
LEAN_EXPORT uint8_t lp_physical__bridges_PhysicalBridges_IRChannelInventory_instDecidableEqChannel(lean_object* v_x_78_, lean_object* v_x_79_){
_start:
{
uint8_t v___x_80_; 
v___x_80_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_instDecidableEqChannel_decEq(v_x_78_, v_x_79_);
return v___x_80_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instDecidableEqChannel___boxed(lean_object* v_x_81_, lean_object* v_x_82_){
_start:
{
uint8_t v_res_83_; lean_object* v_r_84_; 
v_res_83_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_instDecidableEqChannel(v_x_81_, v_x_82_);
lean_dec_ref(v_x_82_);
lean_dec_ref(v_x_81_);
v_r_84_ = lean_box(v_res_83_);
return v_r_84_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3(void){
_start:
{
lean_object* v___x_91_; lean_object* v___x_92_; 
v___x_91_ = lean_unsigned_to_nat(2u);
v___x_92_ = lean_nat_to_int(v___x_91_);
return v___x_92_;
}
}
static lean_object* _init_lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4(void){
_start:
{
lean_object* v___x_93_; lean_object* v___x_94_; 
v___x_93_ = lean_unsigned_to_nat(1u);
v___x_94_ = lean_nat_to_int(v___x_93_);
return v___x_94_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr(lean_object* v_x_113_, lean_object* v_prec_114_){
_start:
{
switch(lean_obj_tag(v_x_113_))
{
case 0:
{
lean_object* v_weight_115_; lean_object* v___x_117_; uint8_t v_isShared_118_; uint8_t v_isSharedCheck_135_; 
v_weight_115_ = lean_ctor_get(v_x_113_, 0);
v_isSharedCheck_135_ = !lean_is_exclusive(v_x_113_);
if (v_isSharedCheck_135_ == 0)
{
v___x_117_ = v_x_113_;
v_isShared_118_ = v_isSharedCheck_135_;
goto v_resetjp_116_;
}
else
{
lean_inc(v_weight_115_);
lean_dec(v_x_113_);
v___x_117_ = lean_box(0);
v_isShared_118_ = v_isSharedCheck_135_;
goto v_resetjp_116_;
}
v_resetjp_116_:
{
lean_object* v___y_120_; lean_object* v___x_131_; uint8_t v___x_132_; 
v___x_131_ = lean_unsigned_to_nat(1024u);
v___x_132_ = lean_nat_dec_le(v___x_131_, v_prec_114_);
if (v___x_132_ == 0)
{
lean_object* v___x_133_; 
v___x_133_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3, &lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3_once, _init_lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3);
v___y_120_ = v___x_133_;
goto v___jp_119_;
}
else
{
lean_object* v___x_134_; 
v___x_134_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4, &lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4_once, _init_lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4);
v___y_120_ = v___x_134_;
goto v___jp_119_;
}
v___jp_119_:
{
lean_object* v___x_121_; lean_object* v___x_122_; lean_object* v___x_124_; 
v___x_121_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__2));
v___x_122_ = l_Nat_reprFast(v_weight_115_);
if (v_isShared_118_ == 0)
{
lean_ctor_set_tag(v___x_117_, 3);
lean_ctor_set(v___x_117_, 0, v___x_122_);
v___x_124_ = v___x_117_;
goto v_reusejp_123_;
}
else
{
lean_object* v_reuseFailAlloc_130_; 
v_reuseFailAlloc_130_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v_reuseFailAlloc_130_, 0, v___x_122_);
v___x_124_ = v_reuseFailAlloc_130_;
goto v_reusejp_123_;
}
v_reusejp_123_:
{
lean_object* v___x_125_; lean_object* v___x_126_; uint8_t v___x_127_; lean_object* v___x_128_; lean_object* v___x_129_; 
v___x_125_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_125_, 0, v___x_121_);
lean_ctor_set(v___x_125_, 1, v___x_124_);
lean_inc(v___y_120_);
v___x_126_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_126_, 0, v___y_120_);
lean_ctor_set(v___x_126_, 1, v___x_125_);
v___x_127_ = 0;
v___x_128_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_128_, 0, v___x_126_);
lean_ctor_set_uint8(v___x_128_, sizeof(void*)*1, v___x_127_);
v___x_129_ = l_Repr_addAppParen(v___x_128_, v_prec_114_);
return v___x_129_;
}
}
}
}
case 1:
{
lean_object* v_weight_136_; lean_object* v___x_138_; uint8_t v_isShared_139_; uint8_t v_isSharedCheck_156_; 
v_weight_136_ = lean_ctor_get(v_x_113_, 0);
v_isSharedCheck_156_ = !lean_is_exclusive(v_x_113_);
if (v_isSharedCheck_156_ == 0)
{
v___x_138_ = v_x_113_;
v_isShared_139_ = v_isSharedCheck_156_;
goto v_resetjp_137_;
}
else
{
lean_inc(v_weight_136_);
lean_dec(v_x_113_);
v___x_138_ = lean_box(0);
v_isShared_139_ = v_isSharedCheck_156_;
goto v_resetjp_137_;
}
v_resetjp_137_:
{
lean_object* v___y_141_; lean_object* v___x_152_; uint8_t v___x_153_; 
v___x_152_ = lean_unsigned_to_nat(1024u);
v___x_153_ = lean_nat_dec_le(v___x_152_, v_prec_114_);
if (v___x_153_ == 0)
{
lean_object* v___x_154_; 
v___x_154_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3, &lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3_once, _init_lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3);
v___y_141_ = v___x_154_;
goto v___jp_140_;
}
else
{
lean_object* v___x_155_; 
v___x_155_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4, &lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4_once, _init_lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4);
v___y_141_ = v___x_155_;
goto v___jp_140_;
}
v___jp_140_:
{
lean_object* v___x_142_; lean_object* v___x_143_; lean_object* v___x_145_; 
v___x_142_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__7));
v___x_143_ = l_Nat_reprFast(v_weight_136_);
if (v_isShared_139_ == 0)
{
lean_ctor_set_tag(v___x_138_, 3);
lean_ctor_set(v___x_138_, 0, v___x_143_);
v___x_145_ = v___x_138_;
goto v_reusejp_144_;
}
else
{
lean_object* v_reuseFailAlloc_151_; 
v_reuseFailAlloc_151_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v_reuseFailAlloc_151_, 0, v___x_143_);
v___x_145_ = v_reuseFailAlloc_151_;
goto v_reusejp_144_;
}
v_reusejp_144_:
{
lean_object* v___x_146_; lean_object* v___x_147_; uint8_t v___x_148_; lean_object* v___x_149_; lean_object* v___x_150_; 
v___x_146_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_146_, 0, v___x_142_);
lean_ctor_set(v___x_146_, 1, v___x_145_);
lean_inc(v___y_141_);
v___x_147_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_147_, 0, v___y_141_);
lean_ctor_set(v___x_147_, 1, v___x_146_);
v___x_148_ = 0;
v___x_149_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_149_, 0, v___x_147_);
lean_ctor_set_uint8(v___x_149_, sizeof(void*)*1, v___x_148_);
v___x_150_ = l_Repr_addAppParen(v___x_149_, v_prec_114_);
return v___x_150_;
}
}
}
}
case 2:
{
lean_object* v_weight_157_; lean_object* v___x_159_; uint8_t v_isShared_160_; uint8_t v_isSharedCheck_177_; 
v_weight_157_ = lean_ctor_get(v_x_113_, 0);
v_isSharedCheck_177_ = !lean_is_exclusive(v_x_113_);
if (v_isSharedCheck_177_ == 0)
{
v___x_159_ = v_x_113_;
v_isShared_160_ = v_isSharedCheck_177_;
goto v_resetjp_158_;
}
else
{
lean_inc(v_weight_157_);
lean_dec(v_x_113_);
v___x_159_ = lean_box(0);
v_isShared_160_ = v_isSharedCheck_177_;
goto v_resetjp_158_;
}
v_resetjp_158_:
{
lean_object* v___y_162_; lean_object* v___x_173_; uint8_t v___x_174_; 
v___x_173_ = lean_unsigned_to_nat(1024u);
v___x_174_ = lean_nat_dec_le(v___x_173_, v_prec_114_);
if (v___x_174_ == 0)
{
lean_object* v___x_175_; 
v___x_175_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3, &lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3_once, _init_lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3);
v___y_162_ = v___x_175_;
goto v___jp_161_;
}
else
{
lean_object* v___x_176_; 
v___x_176_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4, &lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4_once, _init_lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4);
v___y_162_ = v___x_176_;
goto v___jp_161_;
}
v___jp_161_:
{
lean_object* v___x_163_; lean_object* v___x_164_; lean_object* v___x_166_; 
v___x_163_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__10));
v___x_164_ = l_Nat_reprFast(v_weight_157_);
if (v_isShared_160_ == 0)
{
lean_ctor_set_tag(v___x_159_, 3);
lean_ctor_set(v___x_159_, 0, v___x_164_);
v___x_166_ = v___x_159_;
goto v_reusejp_165_;
}
else
{
lean_object* v_reuseFailAlloc_172_; 
v_reuseFailAlloc_172_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v_reuseFailAlloc_172_, 0, v___x_164_);
v___x_166_ = v_reuseFailAlloc_172_;
goto v_reusejp_165_;
}
v_reusejp_165_:
{
lean_object* v___x_167_; lean_object* v___x_168_; uint8_t v___x_169_; lean_object* v___x_170_; lean_object* v___x_171_; 
v___x_167_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_167_, 0, v___x_163_);
lean_ctor_set(v___x_167_, 1, v___x_166_);
lean_inc(v___y_162_);
v___x_168_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_168_, 0, v___y_162_);
lean_ctor_set(v___x_168_, 1, v___x_167_);
v___x_169_ = 0;
v___x_170_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_170_, 0, v___x_168_);
lean_ctor_set_uint8(v___x_170_, sizeof(void*)*1, v___x_169_);
v___x_171_ = l_Repr_addAppParen(v___x_170_, v_prec_114_);
return v___x_171_;
}
}
}
}
default: 
{
lean_object* v_weight_178_; lean_object* v___x_180_; uint8_t v_isShared_181_; uint8_t v_isSharedCheck_198_; 
v_weight_178_ = lean_ctor_get(v_x_113_, 0);
v_isSharedCheck_198_ = !lean_is_exclusive(v_x_113_);
if (v_isSharedCheck_198_ == 0)
{
v___x_180_ = v_x_113_;
v_isShared_181_ = v_isSharedCheck_198_;
goto v_resetjp_179_;
}
else
{
lean_inc(v_weight_178_);
lean_dec(v_x_113_);
v___x_180_ = lean_box(0);
v_isShared_181_ = v_isSharedCheck_198_;
goto v_resetjp_179_;
}
v_resetjp_179_:
{
lean_object* v___y_183_; lean_object* v___x_194_; uint8_t v___x_195_; 
v___x_194_ = lean_unsigned_to_nat(1024u);
v___x_195_ = lean_nat_dec_le(v___x_194_, v_prec_114_);
if (v___x_195_ == 0)
{
lean_object* v___x_196_; 
v___x_196_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3, &lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3_once, _init_lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__3);
v___y_183_ = v___x_196_;
goto v___jp_182_;
}
else
{
lean_object* v___x_197_; 
v___x_197_ = lean_obj_once(&lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4, &lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4_once, _init_lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__4);
v___y_183_ = v___x_197_;
goto v___jp_182_;
}
v___jp_182_:
{
lean_object* v___x_184_; lean_object* v___x_185_; lean_object* v___x_187_; 
v___x_184_ = ((lean_object*)(lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___closed__13));
v___x_185_ = l_Nat_reprFast(v_weight_178_);
if (v_isShared_181_ == 0)
{
lean_ctor_set(v___x_180_, 0, v___x_185_);
v___x_187_ = v___x_180_;
goto v_reusejp_186_;
}
else
{
lean_object* v_reuseFailAlloc_193_; 
v_reuseFailAlloc_193_ = lean_alloc_ctor(3, 1, 0);
lean_ctor_set(v_reuseFailAlloc_193_, 0, v___x_185_);
v___x_187_ = v_reuseFailAlloc_193_;
goto v_reusejp_186_;
}
v_reusejp_186_:
{
lean_object* v___x_188_; lean_object* v___x_189_; uint8_t v___x_190_; lean_object* v___x_191_; lean_object* v___x_192_; 
v___x_188_ = lean_alloc_ctor(5, 2, 0);
lean_ctor_set(v___x_188_, 0, v___x_184_);
lean_ctor_set(v___x_188_, 1, v___x_187_);
lean_inc(v___y_183_);
v___x_189_ = lean_alloc_ctor(4, 2, 0);
lean_ctor_set(v___x_189_, 0, v___y_183_);
lean_ctor_set(v___x_189_, 1, v___x_188_);
v___x_190_ = 0;
v___x_191_ = lean_alloc_ctor(6, 1, 1);
lean_ctor_set(v___x_191_, 0, v___x_189_);
lean_ctor_set_uint8(v___x_191_, sizeof(void*)*1, v___x_190_);
v___x_192_ = l_Repr_addAppParen(v___x_191_, v_prec_114_);
return v___x_192_;
}
}
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr___boxed(lean_object* v_x_199_, lean_object* v_prec_200_){
_start:
{
lean_object* v_res_201_; 
v_res_201_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_instReprChannel_repr(v_x_199_, v_prec_200_);
lean_dec(v_prec_200_);
return v_res_201_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_charge(lean_object* v_x_204_){
_start:
{
lean_object* v_weight_205_; 
v_weight_205_ = lean_ctor_get(v_x_204_, 0);
lean_inc(v_weight_205_);
return v_weight_205_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_charge___boxed(lean_object* v_x_206_){
_start:
{
lean_object* v_res_207_; 
v_res_207_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_charge(v_x_206_);
lean_dec_ref(v_x_206_);
return v_res_207_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_incompleteCharge(lean_object* v_x_208_){
_start:
{
switch(lean_obj_tag(v_x_208_))
{
case 0:
{
lean_object* v_weight_209_; 
v_weight_209_ = lean_ctor_get(v_x_208_, 0);
lean_inc(v_weight_209_);
return v_weight_209_;
}
case 1:
{
lean_object* v_weight_210_; 
v_weight_210_ = lean_ctor_get(v_x_208_, 0);
lean_inc(v_weight_210_);
return v_weight_210_;
}
default: 
{
lean_object* v___x_211_; 
v___x_211_ = lean_unsigned_to_nat(0u);
return v___x_211_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_incompleteCharge___boxed(lean_object* v_x_212_){
_start:
{
lean_object* v_res_213_; 
v_res_213_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_incompleteCharge(v_x_212_);
lean_dec_ref(v_x_212_);
return v_res_213_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_apply(lean_object* v_s_214_, lean_object* v_e_215_){
_start:
{
lean_object* v_physical_216_; lean_object* v_accounted_217_; lean_object* v___x_219_; uint8_t v_isShared_220_; uint8_t v_isSharedCheck_229_; 
v_physical_216_ = lean_ctor_get(v_s_214_, 0);
v_accounted_217_ = lean_ctor_get(v_s_214_, 1);
v_isSharedCheck_229_ = !lean_is_exclusive(v_s_214_);
if (v_isSharedCheck_229_ == 0)
{
v___x_219_ = v_s_214_;
v_isShared_220_ = v_isSharedCheck_229_;
goto v_resetjp_218_;
}
else
{
lean_inc(v_accounted_217_);
lean_inc(v_physical_216_);
lean_dec(v_s_214_);
v___x_219_ = lean_box(0);
v_isShared_220_ = v_isSharedCheck_229_;
goto v_resetjp_218_;
}
v_resetjp_218_:
{
lean_object* v___y_222_; lean_object* v_weight_228_; 
v_weight_228_ = lean_ctor_get(v_e_215_, 0);
v___y_222_ = v_weight_228_;
goto v___jp_221_;
v___jp_221_:
{
lean_object* v___x_223_; lean_object* v___x_224_; lean_object* v___x_226_; 
v___x_223_ = lean_nat_add(v_physical_216_, v___y_222_);
lean_dec(v_physical_216_);
v___x_224_ = lean_nat_add(v_accounted_217_, v___y_222_);
lean_dec(v_accounted_217_);
if (v_isShared_220_ == 0)
{
lean_ctor_set(v___x_219_, 1, v___x_224_);
lean_ctor_set(v___x_219_, 0, v___x_223_);
v___x_226_ = v___x_219_;
goto v_reusejp_225_;
}
else
{
lean_object* v_reuseFailAlloc_227_; 
v_reuseFailAlloc_227_ = lean_alloc_ctor(0, 2, 0);
lean_ctor_set(v_reuseFailAlloc_227_, 0, v___x_223_);
lean_ctor_set(v_reuseFailAlloc_227_, 1, v___x_224_);
v___x_226_ = v_reuseFailAlloc_227_;
goto v_reusejp_225_;
}
v_reusejp_225_:
{
return v___x_226_;
}
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_apply___boxed(lean_object* v_s_230_, lean_object* v_e_231_){
_start:
{
lean_object* v_res_232_; 
v_res_232_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_apply(v_s_230_, v_e_231_);
lean_dec_ref(v_e_231_);
return v_res_232_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRChannelInventory_run_spec__0(lean_object* v_x_233_, lean_object* v_x_234_){
_start:
{
if (lean_obj_tag(v_x_234_) == 0)
{
return v_x_233_;
}
else
{
lean_object* v_head_235_; lean_object* v_tail_236_; lean_object* v___x_237_; 
v_head_235_ = lean_ctor_get(v_x_234_, 0);
v_tail_236_ = lean_ctor_get(v_x_234_, 1);
v___x_237_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_apply(v_x_233_, v_head_235_);
v_x_233_ = v___x_237_;
v_x_234_ = v_tail_236_;
goto _start;
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRChannelInventory_run_spec__0___boxed(lean_object* v_x_239_, lean_object* v_x_240_){
_start:
{
lean_object* v_res_241_; 
v_res_241_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRChannelInventory_run_spec__0(v_x_239_, v_x_240_);
lean_dec(v_x_240_);
return v_res_241_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_run(lean_object* v_s_242_, lean_object* v_trace_243_){
_start:
{
lean_object* v___x_244_; 
v___x_244_ = lp_physical__bridges_List_foldl___at___00PhysicalBridges_IRChannelInventory_run_spec__0(v_s_242_, v_trace_243_);
return v___x_244_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges_PhysicalBridges_IRChannelInventory_run___boxed(lean_object* v_s_245_, lean_object* v_trace_246_){
_start:
{
lean_object* v_res_247_; 
v_res_247_ = lp_physical__bridges_PhysicalBridges_IRChannelInventory_run(v_s_245_, v_trace_246_);
lean_dec(v_trace_246_);
return v_res_247_;
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRChannelInventory_0__PhysicalBridges_IRChannelInventory_instReprChannel_repr_match__1_splitter___redArg(lean_object* v_x_248_, lean_object* v_h__1_249_, lean_object* v_h__2_250_, lean_object* v_h__3_251_, lean_object* v_h__4_252_){
_start:
{
switch(lean_obj_tag(v_x_248_))
{
case 0:
{
lean_object* v_weight_253_; lean_object* v___x_254_; 
lean_dec(v_h__4_252_);
lean_dec(v_h__3_251_);
lean_dec(v_h__2_250_);
v_weight_253_ = lean_ctor_get(v_x_248_, 0);
lean_inc(v_weight_253_);
lean_dec_ref_known(v_x_248_, 1);
v___x_254_ = lean_apply_1(v_h__1_249_, v_weight_253_);
return v___x_254_;
}
case 1:
{
lean_object* v_weight_255_; lean_object* v___x_256_; 
lean_dec(v_h__4_252_);
lean_dec(v_h__3_251_);
lean_dec(v_h__1_249_);
v_weight_255_ = lean_ctor_get(v_x_248_, 0);
lean_inc(v_weight_255_);
lean_dec_ref_known(v_x_248_, 1);
v___x_256_ = lean_apply_1(v_h__2_250_, v_weight_255_);
return v___x_256_;
}
case 2:
{
lean_object* v_weight_257_; lean_object* v___x_258_; 
lean_dec(v_h__4_252_);
lean_dec(v_h__2_250_);
lean_dec(v_h__1_249_);
v_weight_257_ = lean_ctor_get(v_x_248_, 0);
lean_inc(v_weight_257_);
lean_dec_ref_known(v_x_248_, 1);
v___x_258_ = lean_apply_1(v_h__3_251_, v_weight_257_);
return v___x_258_;
}
default: 
{
lean_object* v_weight_259_; lean_object* v___x_260_; 
lean_dec(v_h__3_251_);
lean_dec(v_h__2_250_);
lean_dec(v_h__1_249_);
v_weight_259_ = lean_ctor_get(v_x_248_, 0);
lean_inc(v_weight_259_);
lean_dec_ref_known(v_x_248_, 1);
v___x_260_ = lean_apply_1(v_h__4_252_, v_weight_259_);
return v___x_260_;
}
}
}
}
LEAN_EXPORT lean_object* lp_physical__bridges___private_PhysicalBridges_IRChannelInventory_0__PhysicalBridges_IRChannelInventory_instReprChannel_repr_match__1_splitter(lean_object* v_motive_261_, lean_object* v_x_262_, lean_object* v_h__1_263_, lean_object* v_h__2_264_, lean_object* v_h__3_265_, lean_object* v_h__4_266_){
_start:
{
switch(lean_obj_tag(v_x_262_))
{
case 0:
{
lean_object* v_weight_267_; lean_object* v___x_268_; 
lean_dec(v_h__4_266_);
lean_dec(v_h__3_265_);
lean_dec(v_h__2_264_);
v_weight_267_ = lean_ctor_get(v_x_262_, 0);
lean_inc(v_weight_267_);
lean_dec_ref_known(v_x_262_, 1);
v___x_268_ = lean_apply_1(v_h__1_263_, v_weight_267_);
return v___x_268_;
}
case 1:
{
lean_object* v_weight_269_; lean_object* v___x_270_; 
lean_dec(v_h__4_266_);
lean_dec(v_h__3_265_);
lean_dec(v_h__1_263_);
v_weight_269_ = lean_ctor_get(v_x_262_, 0);
lean_inc(v_weight_269_);
lean_dec_ref_known(v_x_262_, 1);
v___x_270_ = lean_apply_1(v_h__2_264_, v_weight_269_);
return v___x_270_;
}
case 2:
{
lean_object* v_weight_271_; lean_object* v___x_272_; 
lean_dec(v_h__4_266_);
lean_dec(v_h__2_264_);
lean_dec(v_h__1_263_);
v_weight_271_ = lean_ctor_get(v_x_262_, 0);
lean_inc(v_weight_271_);
lean_dec_ref_known(v_x_262_, 1);
v___x_272_ = lean_apply_1(v_h__3_265_, v_weight_271_);
return v___x_272_;
}
default: 
{
lean_object* v_weight_273_; lean_object* v___x_274_; 
lean_dec(v_h__3_265_);
lean_dec(v_h__2_264_);
lean_dec(v_h__1_263_);
v_weight_273_ = lean_ctor_get(v_x_262_, 0);
lean_inc(v_weight_273_);
lean_dec_ref_known(v_x_262_, 1);
v___x_274_ = lean_apply_1(v_h__4_266_, v_weight_273_);
return v___x_274_;
}
}
}
}
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_Init(uint8_t builtin);
lean_object* initialize_physical__bridges_PhysicalBridges_IRAggregateBudget(uint8_t builtin);
void lean_initialize_runtime_module();
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_physical__bridges_PhysicalBridges_IRChannelInventory(uint8_t builtin) {
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
res = initialize_physical__bridges_PhysicalBridges_IRAggregateBudget(builtin);
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
