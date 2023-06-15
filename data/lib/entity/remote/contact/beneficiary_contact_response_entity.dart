import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/manage_contacts/beneficiary_contact.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'beneficiary_contact_entity.dart';

part 'beneficiary_contact_response_entity.g.dart';

@JsonSerializable()
class BeneficiaryContactResponseEntity
    extends BaseLayerDataTransformer<BeneficiaryContactResponseEntity, BeneficiaryContact> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  BeneficiaryContactResponseEntity(this.response);

  factory BeneficiaryContactResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryContactResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryContactResponseEntityToJson(this);

  @override
  BeneficiaryContact transform() {
    return BeneficiaryContactEntity.fromJson(response?.content as Map<String, dynamic>).transform();
  }
}
