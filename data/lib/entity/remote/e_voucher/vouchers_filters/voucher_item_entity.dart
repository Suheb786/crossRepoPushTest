import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_item_entity.g.dart';

@JsonSerializable()
class VoucherItemEntity implements BaseLayerDataTransformer<VoucherItemEntity, VoucherItem> {
  @JsonKey(name: "id", defaultValue: '')
  String? id;
  @JsonKey(name: "name", defaultValue: '')
  String? name;
  @JsonKey(name: "usageInstructions", defaultValue: '')
  String? usageInstructions;
  @JsonKey(name: "termsAndConditions", defaultValue: '')
  String? termsAndConditions;
  @JsonKey(name: "giftCardInformation", defaultValue: '')
  String? giftCardInformation;
  @JsonKey(name: "brand", defaultValue: '')
  String? brand;
  @JsonKey(name: "currency", defaultValue: '')
  String? currency;
  @JsonKey(name: "fromValue", defaultValue: 0.0)
  num? fromValue;
  @JsonKey(name: "toValue", defaultValue: 0.0)
  num? toValue;
  @JsonKey(name: "cardFaceImage", defaultValue: '')
  String? cardFaceImage;
  @JsonKey(name: "cardFaceHash", defaultValue: '')
  String? cardFaceHash;
  @JsonKey(name: "productId", defaultValue: 0.0)
  num? productId;
  @JsonKey(name: "categories", defaultValue: [])
  List<String>? categories;
  @JsonKey(name: "discount", defaultValue: '')
  String? discount;
  @JsonKey(name: "countryCode", defaultValue: '')
  String? countryCode;

  VoucherItemEntity({
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
  });

  factory VoucherItemEntity.fromJson(Map<String, dynamic> json) => _$VoucherItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherItemEntityToJson(this);

  @override
  VoucherItemEntity restore(VoucherItem data) {
    throw UnimplementedError();
  }

  @override
  VoucherItem transform() {
    return VoucherItem(
      id: this.id ?? '',
      name: this.name ?? '',
      usageInstructions: this.usageInstructions ?? '',
      termsAndConditions: this.termsAndConditions ?? '',
      giftCardInformation: this.giftCardInformation ?? '',
      brand: this.brand ?? '',
      currency: this.currency ?? '',
      fromValue: this.fromValue ?? 0.0,
      toValue: this.toValue ?? 0.0,
      cardFaceImage: this.cardFaceImage ?? '',
      cardFaceHash: this.cardFaceHash ?? '',
      productId: this.productId ?? 0.0,
      categories: this.categories ?? [],
      discount: this.discount ?? '',
      countryCode: this.countryCode ?? '',
    );
  }
}
