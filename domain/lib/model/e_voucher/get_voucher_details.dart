class GetVoucherDetails {
  final String id;
  final String name;
  final String usageInstructions;
  final String termsAndConditions;
  final String? giftCardInformation; // nullable but required parameter
  final String brand;
  final String currency;
  final double fromValue;
  final double toValue;
  final String cardFaceImage;
  final String cardFaceHash;
  final double productId;
  final List<String> categories;
  final String discount;
  final String countryCode;
  final String activationFees;
  final String fulfillmentFees;
  final String shippingFees;
  final String customizationFees;
  final String refundFees;
  final String otherFees;
  final String reconciliationCurrency;
  final String exchangeRate;

  GetVoucherDetails({
    required this.id,
    required this.name,
    required this.usageInstructions,
    required this.termsAndConditions,
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
    required this.activationFees,
    required this.fulfillmentFees,
    required this.shippingFees,
    required this.customizationFees,
    required this.refundFees,
    required this.otherFees,
    required this.reconciliationCurrency,
    required this.exchangeRate,
   required this.giftCardInformation,
  });
}
