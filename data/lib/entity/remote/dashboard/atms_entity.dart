import 'package:domain/model/dashboard/get_atms/atm_content_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "atms_entity.g.dart";

@JsonSerializable()
class AtmsEntity implements BaseLayerDataTransformer<AtmsEntity, AtmContentData> {
  @JsonKey(name: "bankName")
  final String? bankName;
  @JsonKey(name: "bankAddress")
  final String? bankAddress;
  @JsonKey(name: "country")
  final String? country;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "longitude")
  final String? longitude;
  @JsonKey(name: "latitude")
  final String? latitude;

  AtmsEntity({this.bankName, this.bankAddress, this.country, this.city, this.longitude, this.latitude});

  factory AtmsEntity.fromJson(Map<String, dynamic> json) => _$AtmsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AtmsEntityToJson(this);

  @override
  AtmsEntity restore(AtmContentData response) {
    return AtmsEntity();
  }

  @override
  AtmContentData transform() {
    return AtmContentData(
        bankName: this.bankName,
        city: this.city,
        longitude: this.longitude,
        latitude: this.latitude,
        country: this.country,
        bankAddress: this.bankAddress);
  }
}
