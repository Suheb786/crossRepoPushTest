import 'package:domain/model/e_voucher/voucher_line_item.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_line_item_entity.g.dart';

@JsonSerializable()
class VoucherLineItemEntity implements BaseLayerDataTransformer<VoucherLineItemEntity, VoucherLineItem> {
  @JsonKey(name: "lineNumber")
  int? lineNumber;

  @JsonKey(name: "cardItemId")
  String? cardItemId;

  @JsonKey(name: "value")
  num? value;

  @JsonKey(name: "status", defaultValue: '')
  String? status;

  @JsonKey(name: "claimURL", defaultValue: '')
  String? claimURL;

  @JsonKey(name: "cardItemName", defaultValue: '')
  String? cardItemName;

  @JsonKey(name: "currency", defaultValue: '')
  String? currency;

  VoucherLineItemEntity({
    this.lineNumber,
    this.cardItemId,
    this.value,
    this.status,
    this.claimURL,
    this.cardItemName,
    this.currency,
  });

  factory VoucherLineItemEntity.fromJson(Map<String, dynamic> json) => _$VoucherLineItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherLineItemEntityToJson(this);

  @override
  VoucherLineItemEntity restore(VoucherLineItem data) {
    throw UnimplementedError();
  }

  @override
  VoucherLineItem transform() {
    return VoucherLineItem(
      lineNumber: this.lineNumber,
      cardItemId: this.cardItemId,
      value: this.value,
      status: this.status,
      claimURL: this.claimURL,
      cardItemName: this.cardItemName,
      currency: this.currency,
    );
  }
}
