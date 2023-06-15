import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/manage_contacts/beneficiary_search_contact.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'beneficiary_search_contact_entity.dart';

part 'beneficiary_search_contact_response_entity.g.dart';

@JsonSerializable()
class BeneficiarySearchContactResponseEntity
    extends BaseLayerDataTransformer<BeneficiarySearchContactResponseEntity, BeneficiarySearchContact> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  BeneficiarySearchContactResponseEntity(this.response);

  factory BeneficiarySearchContactResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$BeneficiarySearchContactResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiarySearchContactResponseEntityToJson(this);

  @override
  BeneficiarySearchContact transform() {
    return BeneficiarySearchContactEntity.fromJson(response?.content as Map<String, dynamic>).transform();
  }
}
