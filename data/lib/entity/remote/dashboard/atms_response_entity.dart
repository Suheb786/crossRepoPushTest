import 'package:data/entity/remote/dashboard/atms_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/dashboard/get_atms/get_atms_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "atms_response_entity.g.dart";

@JsonSerializable()
class AtmsResponseEntity implements BaseLayerDataTransformer<AtmsResponseEntity, GetATMResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  AtmsResponseEntity({this.response});

  factory AtmsResponseEntity.fromJson(Map<String, dynamic> json) => _$AtmsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AtmsResponseEntityToJson(this);

  @override
  AtmsResponseEntity restore(GetATMResponse response) {
    return AtmsResponseEntity();
  }

  @override
  GetATMResponse transform() {
    return GetATMResponse(
        atmContentData: (this.response!.content as List<dynamic>)
            .map((e) => AtmsEntity.fromJson(e).transform())
            .toList());
  }
}
