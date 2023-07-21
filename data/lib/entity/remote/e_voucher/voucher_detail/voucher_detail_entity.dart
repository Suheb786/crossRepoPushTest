import 'package:data/entity/remote/e_voucher/voucher_detail/voucher_line_item_entity.dart';
import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_detail_entity.g.dart';

@JsonSerializable()
class VoucherDetailEntity implements BaseLayerDataTransformer<VoucherDetailEntity, VoucherDetail> {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "customerName", defaultValue: '')
  String? customerName;
  @JsonKey(name: "cardImage", defaultValue: '')
  String? cardImage;
  @JsonKey(name: "deliveryChannel", defaultValue: '')
  String? deliveryChannel;
  @JsonKey(name: "emailAddress", defaultValue: '')
  String? emailAddress;
  @JsonKey(name: "referenceNo", defaultValue: '')
  String? referenceNo;
  @JsonKey(name: "creationDate", defaultValue: '')
  String? creationDate;
  @JsonKey(name: "lineItems", defaultValue: [])
  List<VoucherLineItemEntity>? lineItems;

  VoucherDetailEntity({
    this.id,
    this.customerName,
    this.cardImage,
    this.deliveryChannel,
    this.emailAddress,
    this.referenceNo,
    this.creationDate,
    this.lineItems,
  });

  factory VoucherDetailEntity.fromJson(Map<String, dynamic> json) => _$VoucherDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherDetailEntityToJson(this);

  @override
  VoucherDetailEntity restore(VoucherDetail data) {
    throw UnimplementedError();
  }

  @override
  VoucherDetail transform() {
    return VoucherDetail(
      id: this.id ?? '',
      cardImage: this.cardImage ?? '',
      customerName: this.customerName ?? '',
      deliveryChannel: this.deliveryChannel ?? '',
      emailAddress: this.emailAddress ?? '',
      referenceNo: this.referenceNo ?? '',
      creationDate: this.creationDate ?? '',
      lineItems: this.lineItems!.map((e) => e.transform()).toList(),
    );
  }
}
