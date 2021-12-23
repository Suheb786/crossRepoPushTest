import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/card/get_debit_years_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "debit_years_response_entity.g.dart";

@JsonSerializable()
class DebitYearsResponseEntity
    implements
        BaseLayerDataTransformer<DebitYearsResponseEntity,
            GetDebitYearsResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  DebitYearsResponseEntity({this.response});

  factory DebitYearsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$DebitYearsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DebitYearsResponseEntityToJson(this);

  @override
  DebitYearsResponseEntity restore(GetDebitYearsResponse response) {
    return DebitYearsResponseEntity();
  }

  @override
  GetDebitYearsResponse transform() {
    return GetDebitYearsResponse(
        years: (this.response!.content as List<dynamic>)
            .map((e) => e.toString())
            .toList());
  }
}
