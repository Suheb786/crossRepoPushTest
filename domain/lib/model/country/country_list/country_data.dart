class CountryData {
  CountryData({this.isoCode3,
    this.score,
    this.isoCode,
    this.phoneCode: "",
    this.countryName: "",
    this.isAllowedCountry,
    this.nationality,
    this.gfxCode,
    this.gfxIntCode,
    this.isRestrictedNationality,
    this.isGccCountry,
    this.isMobileAllowed,
    this.crossAllowed,
    this.crossIdAllowed,
    this.mobileMax: 12,
    this.mobileMin,
    this.idForensic,
    this.passportScan,
    this.isAllowedFatca,
    this.isNationalityAllowed,
    this.isIssuerAllowed,
    this.isSelected: false});

  final String? isoCode3;
  final dynamic? score;
  final String? isoCode;
  final String? phoneCode;
  final String? countryName;
  final bool? isAllowedCountry;
  final String? nationality;
  final String? gfxCode;
  final String? gfxIntCode;
  final bool? isRestrictedNationality;
  final bool? isGccCountry;
  final bool? isMobileAllowed;
  final bool? crossAllowed;
  final bool? crossIdAllowed;
  final int? mobileMax;
  final int? mobileMin;
  final bool? idForensic;
  final bool? passportScan;
  final bool? isAllowedFatca;
  final bool? isNationalityAllowed;
  final bool? isIssuerAllowed;
  bool isSelected;
}
