import 'package:domain/model/rj/destinations.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "destination_entity.g.dart";

@JsonSerializable()
class DestinationEntity implements BaseLayerDataTransformer<DestinationEntity, Destinations> {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "code")
  final String? code;
  @JsonKey(name: "countryName")
  final String? countryName;
  @JsonKey(name: "cityName")
  final String? cityName;
  @JsonKey(name: "airportName")
  final String? airportName;

  DestinationEntity({this.name, this.code, this.countryName, this.cityName, this.airportName});

  factory DestinationEntity.fromJson(Map<String, dynamic> json) => _$DestinationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationEntityToJson(this);

  @override
  DestinationEntity restore(Destinations response) {
    return DestinationEntity();
  }

  @override
  Destinations transform() {
    return Destinations(
        name: this.name ?? '',
        code: this.code ?? '',
        airportName: this.airportName ?? '',
        cityName: this.cityName ?? '',
        countryName: this.countryName ?? '');
  }
}
