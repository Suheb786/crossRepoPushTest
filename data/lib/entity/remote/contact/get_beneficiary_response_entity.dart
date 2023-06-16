import 'package:data/entity/remote/contact/beneficiary_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_beneficiary_response_entity.g.dart";

@JsonSerializable()
class GetBeneficiaryResponseEntity
    extends BaseLayerDataTransformer<GetBeneficiaryResponseEntity, GetBeneficiaryListResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? responseEntity;

  GetBeneficiaryResponseEntity({this.responseEntity});

  factory GetBeneficiaryResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetBeneficiaryResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetBeneficiaryResponseEntityToJson(this);

  @override
  GetBeneficiaryResponseEntity restore(GetBeneficiaryListResponse response) {
    return GetBeneficiaryResponseEntity();
  }

  @override
  GetBeneficiaryListResponse transform() {
    return GetBeneficiaryListResponse(
        beneficiaryList: (this.responseEntity?.content as List<dynamic>)
            .map((e) => BeneficiaryEntity.fromJson(e).transform())
            .toList());
  }
}
