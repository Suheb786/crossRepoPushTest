import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_data_entity.g.dart';

@JsonSerializable()
class CountryDataEntity
    implements BaseLayerDataTransformer<CountryDataEntity, CountryData> {
  @JsonKey(name: "isoCode3")
  final String? isoCode3;
  @JsonKey(name: "isoCode")
  final String? isoCode;
  @JsonKey(name: "phoneCode")
  final String? phoneCode;
  @JsonKey(name: "countryName")
  final String? countryName;
  @JsonKey(name: "isAllowedCountry")
  final bool? isAllowedCountry;
  @JsonKey(name: "nationality")
  final String? nationality;
  @JsonKey(name: "gfxCode")
  final String? gfxCode;
  @JsonKey(name: "isRestrictedNationality")
  final bool? isRestrictedNationality;
  @JsonKey(name: "isMobileAllowed")
  final bool? isMobileAllowed;
  @JsonKey(name: "isNationalityAllowed")
  final bool? isNationalityAllowed;
  @JsonKey(name: "isIssuerAllowed")
  final bool? isIssuerAllowed;

  CountryDataEntity(
      {this.isoCode3,
      this.isoCode,
      this.phoneCode,
      this.countryName,
      this.isAllowedCountry,
      this.nationality,
      this.gfxCode,
      this.isRestrictedNationality,
      this.isMobileAllowed,
      this.isNationalityAllowed,
      this.isIssuerAllowed});

  factory CountryDataEntity.fromJson(Map<String, dynamic> json) =>
      _$CountryDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CountryDataEntityToJson(this);

  @override
  CountryDataEntity restore(CountryData response) {
    return CountryDataEntity();
  }

  @override
  CountryData transform() {
    return CountryData(
        countryName: this.countryName,
        nationality: this.nationality,
        isoCode3: this.isoCode3,
        isoCode: this.isoCode,
        phoneCode: this.phoneCode,
        isAllowedCountry: this.isAllowedCountry,
        gfxCode: this.gfxCode,
        isRestrictedNationality: this.isRestrictedNationality,
        isMobileAllowed: this.isMobileAllowed,
        isNationalityAllowed: this.isNationalityAllowed,
        isIssuerAllowed: this.isIssuerAllowed);
  }
}
