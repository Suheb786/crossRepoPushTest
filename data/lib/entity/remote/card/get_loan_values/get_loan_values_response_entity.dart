import 'package:data/entity/remote/card/get_loan_values/get_loan_values_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/card/get_loan_values/get_loan_values_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_loan_values_response_entity.g.dart";

@JsonSerializable()
class GetLoanValuesResponseEntity
    implements BaseLayerDataTransformer<GetLoanValuesResponseEntity, GetLoanValuesResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetLoanValuesResponseEntity({this.response});

  factory GetLoanValuesResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetLoanValuesResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetLoanValuesResponseEntityToJson(this);

  @override
  GetLoanValuesResponseEntity restore(GetLoanValuesResponse response) {
    return GetLoanValuesResponseEntity();
  }

  @override
  GetLoanValuesResponse transform() {
    return GetLoanValuesResponse(
        getLoanValuesContent: GetLoanValuesContentEntity.fromJson(this.response!.content).transform());
  }
}
