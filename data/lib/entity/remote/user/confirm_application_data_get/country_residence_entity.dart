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
  @JsonKey(name: "cityID")
  final String? cityID;
  @JsonKey(name: "stateID")
  final String? stateID;
  @JsonKey(name: "buildingName")
  final String? buildingName;
  @JsonKey(name: "streetName")
  final String? streetName;
  @JsonKey(name: "area")
  final String? area;
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
  @JsonKey(name: "residantCountryName")
  final String? residentCountryName;
  @JsonKey(name: "perCountryName")
  final String? perResidentCountryName;
  @JsonKey(name: "perCityName")
  final String? perResidentCityName;

  CountryResidenceEntity(
      {this.id,
      this.userId,
      this.residantCountry,
      this.cityID,
      this.stateID,
      this.perCity,
      this.city,
      this.perResidantCountry,
      this.area,
      this.buildingName,
      this.streetName,
      this.createdOn,
      this.isActive,
      this.residentCountryName: "",
      this.perResidentCountryName: "",
      this.perResidentCityName: ""});

  factory CountryResidenceEntity.fromJson(Map<String, dynamic> json) =>
      _$CountryResidenceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CountryResidenceEntityToJson(this);

  @override
  CountryResidenceEntity restore(CountryResidenceInfo response) {
    return CountryResidenceEntity(
        id: response.id,
        cityID: response.cityId,
        stateID: response.stateId,
        buildingName: response.buildingName,
        streetName: response.streetName,
        createdOn: response.createdOn,
        isActive: response.isActive,
        city: response.city,
        perResidantCountry: response.perResidantCountry,
        perCity: response.perCity,
        area: response.area,
        residantCountry: response.residantCountry,
        userId: response.userId,
        residentCountryName: response.residentCountryName,
        perResidentCountryName: response.perResidentCountryName,
        perResidentCityName: response.perResidentCityName);
  }

  @override
  CountryResidenceInfo transform() {
    return CountryResidenceInfo(
        id: this.id,
        cityId: this.cityID,
        stateId: this.stateID,
        buildingName: this.buildingName,
        streetName: this.streetName,
        createdOn: this.createdOn,
        isActive: this.isActive,
        area: this.area,
        city: this.city,
        perResidantCountry: this.perResidantCountry,
        perCity: this.perCity,
        residantCountry: this.residantCountry,
        userId: this.userId,
        residentCountryName: this.residentCountryName ?? '',
        perResidentCityName: this.perResidentCityName ?? '',
        perResidentCountryName: this.perResidentCountryName ?? '');
  }
}
