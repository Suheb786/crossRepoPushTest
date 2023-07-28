import 'package:domain/model/e_voucher/country_code.dart';

import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
part 'country_code_entity.g.dart';

@JsonSerializable()
class CountryCodeEntity implements BaseLayerDataTransformer<CountryCodeEntity, CountryCode> {
  @JsonKey(name: "isoCode3", defaultValue: '')
  String? isoCode3;
  @JsonKey(name: "score", defaultValue: 0)
  int? score;
  @JsonKey(name: "isoCode", defaultValue: '')
  String? isoCode;
  @JsonKey(name: "phoneCode", defaultValue: '')
  String? phoneCode;
  @JsonKey(name: "countryName", defaultValue: '')
  String? countryName;
  @JsonKey(name: "isAllowedCountry", defaultValue: false)
  bool? isAllowedCountry;
  @JsonKey(name: "nationality", defaultValue: '')
  String? nationality;
  @JsonKey(name: "gfxCode", defaultValue: '')
  String? gfxCode;
  @JsonKey(name: "gfxIntCode", defaultValue: '')
  String? gfxIntCode;
  @JsonKey(name: "isRestrictedNationality", defaultValue: false)
  bool? isRestrictedNationality;
  @JsonKey(name: "isGccCountry", defaultValue: false)
  bool? isGccCountry;
  @JsonKey(name: "isMobileAllowed", defaultValue: false)
  bool? isMobileAllowed;
  @JsonKey(name: "crossAllowed", defaultValue: false)
  bool? crossAllowed;
  @JsonKey(name: "crossIdAllowed", defaultValue: false)
  bool? crossIdAllowed;
  @JsonKey(name: "mobileMax", defaultValue: 0)
  int? mobileMax;
  @JsonKey(name: "mobileMin", defaultValue: 0)
  int? mobileMin;
  @JsonKey(name: "idForensic", defaultValue: false)
  bool? idForensic;
  @JsonKey(name: "passportScan", defaultValue: false)
  bool? passportScan;
  @JsonKey(name: "isAllowedFatca", defaultValue: false)
  bool? isAllowedFatca;
  @JsonKey(name: "isNationalityAllowed", defaultValue: false)
  bool? isNationalityAllowed;
  @JsonKey(name: "isIssuerAllowed", defaultValue: false)
  bool? isIssuerAllowed;
  @JsonKey(name: "countryNameAR", defaultValue: '')
  String? countryNameAR;

  CountryCodeEntity({
    this.isoCode3,
    this.score,
    this.isoCode,
    this.phoneCode,
    this.countryName,
    this.isAllowedCountry,
    this.nationality,
    this.gfxCode,
    this.gfxIntCode,
    this.isRestrictedNationality,
    this.isGccCountry,
    this.isMobileAllowed,
    this.crossAllowed,
    this.crossIdAllowed,
    this.mobileMax,
    this.mobileMin,
    this.idForensic,
    this.passportScan,
    this.isAllowedFatca,
    this.isNationalityAllowed,
    this.isIssuerAllowed,
    this.countryNameAR,
  });

  factory CountryCodeEntity.fromJson(Map<String, dynamic> json) => _$CountryCodeEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CountryCodeEntityToJson(this);

  @override
  CountryCodeEntity restore(CountryCode data) {
    // TODO: implement restore
    throw UnimplementedError();
  }

  @override
  CountryCode transform() {
    return CountryCode(
      isoCode3: this.isoCode3,
      score: this.score,
      phoneCode: this.phoneCode,
      countryName: this.countryName,
      isAllowedCountry: isAllowedCountry,
      nationality: this.nationality,
      gfxCode: this.gfxCode,
      gfxIntCode: this.gfxIntCode,
      isoCode: this.isoCode,
      isRestrictedNationality: this.isRestrictedNationality,
      isGccCountry: this.isGccCountry,
      isMobileAllowed: this.isMobileAllowed,
      crossAllowed: this.crossAllowed,
      crossIdAllowed: this.crossIdAllowed,
      mobileMax: this.mobileMax,
      mobileMin: this.mobileMin,
      idForensic: this.idForensic,
      passportScan: this.passportScan,
      isAllowedFatca: this.isAllowedFatca,
      isNationalityAllowed: this.isNationalityAllowed,
      isIssuerAllowed: this.isIssuerAllowed,
      countryNameAR: this.countryNameAR,
    );
  }
}
