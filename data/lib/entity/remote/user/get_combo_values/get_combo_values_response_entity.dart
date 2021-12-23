import 'package:data/entity/remote/user/get_combo_values/get_combo_values_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/user/get_combo_values/get_combo_values_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_combo_values_response_entity.g.dart";

@JsonSerializable()
class GetComboValuesResponseEntity extends BaseLayerDataTransformer<
    GetComboValuesResponseEntity,
    GetComboValuesResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetComboValuesResponseEntity({this.response});

  factory GetComboValuesResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetComboValuesResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetComboValuesResponseEntityToJson(this);

  @override
  GetComboValuesResponse transform() {
    return GetComboValuesResponse(
        getComboValuesContent:
        GetComboValuesContentEntity.fromJson(this.response!.content)
            .transform());
  }
}
