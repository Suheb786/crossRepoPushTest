import 'package:data/entity/remote/rj/get_flight_details/flight_details_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/rj/get_flight_detail/flight_detail_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "flight_details_response_entity.g.dart";

@JsonSerializable()
class FlightDetailsResponseEntity
    implements BaseLayerDataTransformer<FlightDetailsResponseEntity, FlightDetailResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  FlightDetailsResponseEntity({this.response});

  factory FlightDetailsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$FlightDetailsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FlightDetailsResponseEntityToJson(this);

  @override
  FlightDetailsResponseEntity restore(FlightDetailResponse response) {
    return FlightDetailsResponseEntity();
  }

  @override
  FlightDetailResponse transform() {
    return FlightDetailResponse(
        flightDetailContent: FlightDetailsContentEntity.fromJson(this.response!.content).transform());
  }
}
