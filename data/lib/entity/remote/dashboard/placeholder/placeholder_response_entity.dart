import 'package:data/entity/remote/dashboard/placeholder/placeholder_data_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/dashboard/get_placeholder/get_placeholder_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "placeholder_response_entity.g.dart";

@JsonSerializable()
class PlaceholderResponseEntity
    implements BaseLayerDataTransformer<PlaceholderResponseEntity, GetPlaceholderResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  PlaceholderResponseEntity({this.response});

  factory PlaceholderResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$PlaceholderResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceholderResponseEntityToJson(this);

  @override
  PlaceholderResponseEntity restore(GetPlaceholderResponse response) {
    return PlaceholderResponseEntity();
  }

  @override
  GetPlaceholderResponse transform() {
    return GetPlaceholderResponse(data: PlaceholderDataEntity.fromJson(this.response!.content).transform());
  }
}
