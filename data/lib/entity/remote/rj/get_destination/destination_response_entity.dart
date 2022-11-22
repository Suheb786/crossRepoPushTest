import 'package:data/entity/remote/rj/get_destination/destination_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/rj/destination_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "destination_response_entity.g.dart";

@JsonSerializable()
class DestinationResponseEntity
    implements BaseLayerDataTransformer<DestinationResponseEntity, DestinationResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  DestinationResponseEntity({this.response});

  factory DestinationResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$DestinationResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationResponseEntityToJson(this);

  @override
  DestinationResponseEntity restore(DestinationResponse response) {
    return DestinationResponseEntity();
  }

  @override
  DestinationResponse transform() {
    return DestinationResponse(
        destinationContent: DestinationContentEntity.fromJson(response!.content).transform());
  }
}
