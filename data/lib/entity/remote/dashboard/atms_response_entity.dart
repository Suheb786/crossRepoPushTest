import 'package:data/entity/remote/dashboard/atms_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "atms_response_entity.g.dart";

@JsonSerializable()
class AtmsResponseEntity
    implements BaseLayerDataTransformer<AtmsResponseEntity, List<String>> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  AtmsResponseEntity({this.response});

  factory AtmsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$AtmsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AtmsResponseEntityToJson(this);

  @override
  AtmsResponseEntity restore(List<String> response) {
    return AtmsResponseEntity();
  }

  @override
  List<String> transform() {
    return (this.response!.content as List<AtmsEntity>)
        .map((e) => e.transform())
        .toList();
  }
}
