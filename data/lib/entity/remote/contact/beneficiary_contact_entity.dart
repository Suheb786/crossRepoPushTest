import 'package:domain/model/manage_contacts/beneficiary_contact.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'beneficiary_request_money_contact_entity.dart';
import 'beneficiary_send_money_contact_entity.dart';

part 'beneficiary_contact_entity.g.dart';

@JsonSerializable()
class BeneficiaryContactEntity
    extends BaseLayerDataTransformer<BeneficiaryContactEntity, BeneficiaryContact> {
  @JsonKey(name: "sm")
  final BeneficiarySendMoneyContactEntity? beneficiarySendMoneyContactEntity;
  @JsonKey(name: "rtp")
  final BeneficiaryRequestMoneyContactEntity? beneficiaryRequestMoneyContactEntity;

  BeneficiaryContactEntity(
      {this.beneficiarySendMoneyContactEntity, this.beneficiaryRequestMoneyContactEntity});

  factory BeneficiaryContactEntity.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryContactEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryContactEntityToJson(this);

  @override
  BeneficiaryContact transform() {
    return BeneficiaryContact(
        beneficiaryRequestMoneyContact: beneficiaryRequestMoneyContactEntity?.transform(),
        beneficiarySendMoneyContact: beneficiarySendMoneyContactEntity?.transform());
  }
}
