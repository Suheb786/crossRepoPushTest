import 'package:domain/model/manage_contacts/beneficiary_send_money_contact.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'beneficiary_favorite_contact_entity.dart';
import 'beneficiary_other_contact_entity.dart';

part 'beneficiary_send_money_contact_entity.g.dart';

@JsonSerializable()
class BeneficiarySendMoneyContactEntity
    extends BaseLayerDataTransformer<BeneficiarySendMoneyContactEntity, BeneficiarySendMoneyContact> {
  @JsonKey(name: "favoriteContacts", defaultValue: [])
  final List<BeneficiaryFavoriteContactEntity>? beneficiaryFavoriteContactEntity;
  @JsonKey(name: "otherContacts", defaultValue: [])
  final List<BeneficiaryOtherContactEntity>? beneficiaryOtherContactEntity;

  BeneficiarySendMoneyContactEntity(
      {this.beneficiaryFavoriteContactEntity, this.beneficiaryOtherContactEntity});

  factory BeneficiarySendMoneyContactEntity.fromJson(Map<String, dynamic> json) =>
      _$BeneficiarySendMoneyContactEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiarySendMoneyContactEntityToJson(this);

  @override
  BeneficiarySendMoneyContact transform() {
    return BeneficiarySendMoneyContact(
        beneficiaryFavoriteContact: beneficiaryFavoriteContactEntity?.map((e) => e.transform()).toList(),
        beneficiaryOtherContact: beneficiaryOtherContactEntity?.map((e) => e.transform()).toList());
  }
}
