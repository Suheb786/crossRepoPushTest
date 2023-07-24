class VoucherItem {
  String id;
  String name;
  String usageInstructions;
  String termsAndConditions;
  String giftCardInformation;
  String brand;
  String currency;
  num fromValue;
  num toValue;
  String cardFaceImage;
  String cardFaceHash;
  num productId;
  List<String> categories;
  String discount;
  String countryCode;

  VoucherItem({
    required this.id,
    required this.name,
    required this.usageInstructions,
    required this.termsAndConditions,
    required this.giftCardInformation,
    required this.brand,
    required this.currency,
    required this.fromValue,
    required this.toValue,
    required this.cardFaceImage,
    required this.cardFaceHash,
    required this.productId,
    required this.categories,
    required this.discount,
    required this.countryCode,
  });
}
