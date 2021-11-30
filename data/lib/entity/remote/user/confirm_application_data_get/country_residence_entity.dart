import 'package:domain/model/user/confirm_application_data_get/country_residence_info.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_residence_entity.g.dart';

@JsonSerializable()
class CountryResidenceEntity
    implements
        BaseLayerDataTransformer<CountryResidenceEntity, CountryResidenceInfo> {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "residantCountry")
  final String? residantCountry;
  @JsonKey(name: "buildingName")
  final String? buildingName;
  @JsonKey(name: "streetName")
  final String? streetName;
  @JsonKey(name: "district")
  final String? district;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "perCountry")
  final String? perResidantCountry;
  @JsonKey(name: "perCity")
  final dynamic? perCity;
  @JsonKey(name: "createdOn")
  final DateTime? createdOn;
  @JsonKey(name: "isActive")
  final bool? isActive;

  CountryResidenceEntity(
      {this.id,
      this.userId,
      this.residantCountry,
      this.perCity,
      this.city,
      this.perResidantCountry,
      this.district,
      this.buildingName,
      this.streetName,
      this.createdOn,
      this.isActive});

  factory CountryResidenceEntity.fromJson(Map<String, dynamic> json) =>
      _$CountryResidenceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CountryResidenceEntityToJson(this);

  @override
  CountryResidenceEntity restore(CountryResidenceInfo response) {
    return CountryResidenceEntity(
        id: response.id,
        buildingName: response.buildingName,
        streetName: response.streetName,
        createdOn: response.createdOn,
        isActive: response.isActive,
        city: response.city,
        perResidantCountry: response.perResidantCountry,
        perCity: response.perCity,
        district: response.district,
        residantCountry: response.residantCountry,
        userId: response.userId);
  }

  @override
  CountryResidenceInfo transform() {
    return CountryResidenceInfo(
        id: this.id,
        buildingName: this.buildingName,
        streetName: this.streetName,
        createdOn: this.createdOn,
        isActive: this.isActive,
        district: this.district,
        city: this.city,
        perResidantCountry: this.perResidantCountry,
        perCity: this.perCity,
        residantCountry: this.residantCountry,
        userId: this.userId);
  }
}
