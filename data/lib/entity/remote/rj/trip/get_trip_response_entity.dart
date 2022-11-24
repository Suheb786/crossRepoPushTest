import 'package:data/entity/remote/rj/trip/get_trip_content_data_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/rj/get_trip_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_trip_response_entity.g.dart";

@JsonSerializable()
class GetTripResponseEntity implements BaseLayerDataTransformer<GetTripResponseEntity, GetTripResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetTripResponseEntity({this.response});

  factory GetTripResponseEntity.fromJson(Map<String, dynamic> json) => _$GetTripResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetTripResponseEntityToJson(this);

  @override
  GetTripResponseEntity restore(GetTripResponse response) {
    return GetTripResponseEntity();
  }

  @override
  GetTripResponse transform() {
    return GetTripResponse(content: GetTripContentDataEntity.fromJson(response!.content).transform());
  }
}
