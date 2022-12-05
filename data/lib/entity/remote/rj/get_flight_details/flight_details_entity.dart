import 'package:domain/model/rj/get_flight_detail/flight_details.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "flight_details_entity.g.dart";

@JsonSerializable()
class FlightDetailsEntity implements BaseLayerDataTransformer<FlightDetailsEntity, FlightDetails> {
  @JsonKey(name: "flightNumber")
  final String? flightNumber;
  @JsonKey(name: "origin")
  final String? origin;
  @JsonKey(name: "destination")
  final String? destination;
  @JsonKey(name: "flightDate")
  final String? flightDate;

  FlightDetailsEntity({this.flightNumber, this.origin, this.destination, this.flightDate});

  factory FlightDetailsEntity.fromJson(Map<String, dynamic> json) => _$FlightDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FlightDetailsEntityToJson(this);

  @override
  FlightDetailsEntity restore(FlightDetails response) {
    return FlightDetailsEntity();
  }

  @override
  FlightDetails transform() {
    return FlightDetails(
        destination: this.destination ?? '',
        flightDate: this.flightDate ?? '',
        flightNumber: this.flightNumber ?? '',
        origin: this.origin ?? '');
  }
}
