class VoucherRegionByCategories {
  String? isoCode3;
  String? isoCode;
  String? countryName;
  String? countryNameAR;

  VoucherRegionByCategories({
    this.isoCode3,
    this.isoCode,
    this.countryName,
    this.countryNameAR,
  });

  @override
  bool operator ==(other) {
    return (other is VoucherRegionByCategories) && other.isoCode == isoCode;
  }

  @override
  int get hashCode => isoCode.hashCode;
}
