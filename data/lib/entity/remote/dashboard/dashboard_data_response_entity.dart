import 'package:data/entity/remote/dashboard/dashboard_data_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "dashboard_data_response_entity.g.dart";

@JsonSerializable()
class DashboardDataResponseEntity
    implements BaseLayerDataTransformer<DashboardDataResponseEntity, String> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  DashboardDataResponseEntity({this.response});

  factory DashboardDataResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataResponseEntityToJson(this);

  @override
  DashboardDataResponseEntity restore(String response) {
    return DashboardDataResponseEntity();
  }

  @override
  String transform() {
    return DashboardDataEntity.fromJson(this.response!.content).transform();
  }
}
