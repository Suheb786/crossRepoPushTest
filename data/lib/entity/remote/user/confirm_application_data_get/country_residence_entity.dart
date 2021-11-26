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
  @JsonKey(name: "homeAddress")
  final String? homeAddress;
  @JsonKey(name: "streetAddress")
  final String? streetAddress;
  @JsonKey(name: "perResidantCountry")
  final String? perResidantCountry;
  @JsonKey(name: "perHomeAddress")
  final dynamic? perHomeAddress;
  @JsonKey(name: "perStreetAddress")
  final dynamic? perStreetAddress;
  @JsonKey(name: "createdOn")
  final DateTime? createdOn;
  @JsonKey(name: "isActive")
  final bool? isActive;

  CountryResidenceEntity(
      {this.id,
      this.userId,
      this.residantCountry,
      this.homeAddress,
      this.streetAddress,
      this.perResidantCountry,
      this.perHomeAddress,
      this.perStreetAddress,
      this.createdOn,
      this.isActive});

  factory CountryResidenceEntity.fromJson(Map<String, dynamic> json) =>
      _$CountryResidenceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CountryResidenceEntityToJson(this);

  @override
  CountryResidenceEntity restore(CountryResidenceInfo response) {
    return CountryResidenceEntity(
        id: response.id,
        homeAddress: response.homeAddress,
        streetAddress: response.streetAddress,
        createdOn: response.createdOn,
        isActive: response.isActive,
        perHomeAddress: response.perHomeAddress,
        perResidantCountry: response.perResidantCountry,
        perStreetAddress: response.perStreetAddress,
        residantCountry: response.residantCountry,
        userId: response.userId);
  }

  @override
  CountryResidenceInfo transform() {
    return CountryResidenceInfo(
        id: this.id,
        homeAddress: this.homeAddress,
        streetAddress: this.streetAddress,
        createdOn: this.createdOn,
        isActive: this.isActive,
        perHomeAddress: this.perHomeAddress,
        perResidantCountry: this.perResidantCountry,
        perStreetAddress: this.perStreetAddress,
        residantCountry: this.residantCountry,
        userId: this.userId);
  }
}
