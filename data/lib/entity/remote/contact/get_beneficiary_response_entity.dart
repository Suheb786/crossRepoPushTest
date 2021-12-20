import 'package:data/entity/remote/contact/beneficiary_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_beneficiary_response_entity.g.dart";

@JsonSerializable()
class GetBeneficiaryResponseEntity extends BaseLayerDataTransformer<
    GetBeneficiaryResponseEntity, List<String>> {
  @JsonKey(name: "response")
  final ResponseEntity? responseEntity;

  GetBeneficiaryResponseEntity({this.responseEntity});

  factory GetBeneficiaryResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetBeneficiaryResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetBeneficiaryResponseEntityToJson(this);

  @override
  GetBeneficiaryResponseEntity restore(List<String> response) {
    return GetBeneficiaryResponseEntity();
  }

  @override
  List<String> transform() {
    return BeneficiaryResponseEntity.fromJson(responseEntity!.content)
        .transform();
  }
}
