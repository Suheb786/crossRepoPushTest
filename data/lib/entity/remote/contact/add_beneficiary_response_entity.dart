import 'package:domain/model/manage_contacts/add_beneficiary_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user/response_entity.dart';
import 'beneficiary_favorite_contact_entity.dart';

part 'add_beneficiary_response_entity.g.dart';

@JsonSerializable()
class AddBeneficiaryResponseEntity
    implements BaseLayerDataTransformer<AddBeneficiaryResponseEntity, AddBeneficiaryResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  AddBeneficiaryResponseEntity({this.response});

  factory AddBeneficiaryResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$AddBeneficiaryResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddBeneficiaryResponseEntityToJson(this);

  @override
  AddBeneficiaryResponseEntity restore(AddBeneficiaryResponse response) {
    return AddBeneficiaryResponseEntity();
  }

  @override
  AddBeneficiaryResponse transform() {
    return AddBeneficiaryResponse(
        BeneficiaryFavoriteContactEntity.fromJson(this.response!.content).transform());
  }
}
