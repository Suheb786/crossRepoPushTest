import 'package:domain/model/e_voucher/country_code.dart';

class VoucherItem {
  final String id;
  final String name;
  final String usageInstructions;
  final String termsAndConditions;
  final String giftCardInformation;
  final String brand;
  final String currency;
  final num fromValue;
  final num toValue;
  final String cardFaceImage;
  final String cardFaceHash;
  final num productId;
  final List<String> categories;
  final String discount;
  final CountryCode countryCode;
  final String reconciliationCurrency;
  final String exchangeRate;

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
    required this.exchangeRate,
    required this.reconciliationCurrency,
  });
}
