import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/e_voucher/get_voucher_details.dart';
part 'get_voucher_details_entity.g.dart';

@JsonSerializable()
class GetVoucherDetailsEntity extends BaseLayerDataTransformer<GetVoucherDetailsEntity, GetVoucherDetails> {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'usageInstructions')
  final String? usageInstructions;

  @JsonKey(name: 'termsAndConditions')
  final String? termsAndConditions;

  @JsonKey(name: 'giftCardInformation')
  final String? giftCardInformation;

  @JsonKey(name: 'brand')
  final String? brand;

  @JsonKey(name: 'currency')
  final String? currency;

  @JsonKey(name: 'fromValue')
  final double? fromValue;

  @JsonKey(name: 'toValue')
  final double? toValue;

  @JsonKey(name: 'cardFaceImage')
  final String? cardFaceImage;

  @JsonKey(name: 'cardFaceHash')
  final String? cardFaceHash;

  @JsonKey(name: 'productId')
  final double? productId;

  @JsonKey(name: 'categories')
  final List<String>? categories;

  @JsonKey(name: 'discount')
  final String? discount;

  @JsonKey(name: 'countryCode')
  final String? countryCode;

  @JsonKey(name: 'activationFees')
  final String? activationFees;

  @JsonKey(name: 'fulfillmentFees')
  final String? fulfillmentFees;

  @JsonKey(name: 'shippingFees')
  final String? shippingFees;

  @JsonKey(name: 'customizationFees')
  final String? customizationFees;

  @JsonKey(name: 'refundFees')
  final String? refundFees;

  @JsonKey(name: 'otherFees')
  final String? otherFees;

  @JsonKey(name: 'reconciliationCurrency')
  final String? reconciliationCurrency;

  @JsonKey(name: 'exchangeRate')
  final String? exchangeRate;

  GetVoucherDetailsEntity({
    this.id,
    this.name,
    this.usageInstructions,
    this.termsAndConditions,
    this.giftCardInformation,
    this.brand,
    this.currency,
    this.fromValue,
    this.toValue,
    this.cardFaceImage,
    this.cardFaceHash,
    this.productId,
    this.categories,
    this.discount,
    this.countryCode,
    this.activationFees,
    this.fulfillmentFees,
    this.shippingFees,
    this.customizationFees,
    this.refundFees,
    this.otherFees,
    this.reconciliationCurrency,
    this.exchangeRate,
  });

  factory GetVoucherDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$GetVoucherDetailsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetVoucherDetailsEntityToJson(this);

  @override
  GetVoucherDetails transform() {
    return GetVoucherDetails(
        id: this.id ?? "",
        name: this.name ?? "",
        usageInstructions: this.usageInstructions ?? "",
        termsAndConditions: this.termsAndConditions ?? "",
        brand: this.brand ?? "",
        currency: this.currency ?? "",
        fromValue: this.fromValue ?? 0.0,
        toValue: this.toValue ?? 0,
        cardFaceImage: this.cardFaceImage ?? "",
        cardFaceHash: this.cardFaceHash ?? "",
        productId: this.productId ?? 0,
        categories: this.categories ?? [],
        discount: this.discount ?? "",
        countryCode: this.countryCode ?? "",
        activationFees: this.activationFees ?? "",
        fulfillmentFees: this.fulfillmentFees ?? " ?? " "",
        shippingFees: this.shippingFees ?? "",
        customizationFees: this.customizationFees ?? "",
        refundFees: this.refundFees ?? "",
        otherFees: this.otherFees ?? "",
        reconciliationCurrency: this.reconciliationCurrency ?? "",
        exchangeRate: this.exchangeRate ?? "",
        giftCardInformation: this.giftCardInformation ?? "");
  }
}
