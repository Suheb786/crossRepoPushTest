import 'package:domain/model/manage_contacts/beneficiary_request_money_contact.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'beneficiary_favorite_contact_entity.dart';
import 'beneficiary_other_contact_entity.dart';

part 'beneficiary_request_money_contact_entity.g.dart';

@JsonSerializable()
class BeneficiaryRequestMoneyContactEntity
    extends BaseLayerDataTransformer<BeneficiaryRequestMoneyContactEntity, BeneficiaryRequestMoneyContact> {
  @JsonKey(name: "favoriteContacts", defaultValue: [])
  final List<BeneficiaryFavoriteContactEntity>? beneficiaryFavoriteContactEntity;
  @JsonKey(name: "otherContacts", defaultValue: [])
  final List<BeneficiaryOtherContactEntity>? beneficiaryOtherContactEntity;

  BeneficiaryRequestMoneyContactEntity(
      {this.beneficiaryFavoriteContactEntity, this.beneficiaryOtherContactEntity});

  factory BeneficiaryRequestMoneyContactEntity.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryRequestMoneyContactEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryRequestMoneyContactEntityToJson(this);

  @override
  BeneficiaryRequestMoneyContact transform() {
    return BeneficiaryRequestMoneyContact(
        beneficiaryFavoriteContact: beneficiaryFavoriteContactEntity?.map((e) => e.transform()).toList(),
        beneficiaryOtherContact: beneficiaryOtherContactEntity?.map((e) => e.transform()).toList());
  }
}
