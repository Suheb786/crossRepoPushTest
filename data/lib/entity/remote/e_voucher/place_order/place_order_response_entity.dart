import 'package:domain/model/e_voucher/place_order.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../user/response_entity.dart';

part 'place_order_response_entity.g.dart';

@JsonSerializable()
class PlaceOrderResponseEntity extends BaseLayerDataTransformer<PlaceOrderResponseEntity, PlaceOrder> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  PlaceOrderResponseEntity(this.response);

  factory PlaceOrderResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOrderResponseEntityToJson(this);

  @override
  PlaceOrder transform() {
    return response?.content != null
        ? PlaceOrderContentEntity.fromJson(response?.content as Map<String, dynamic>).transform()
        : PlaceOrder();
  }
}

@JsonSerializable()
class PlaceOrderContentEntity extends BaseLayerDataTransformer<PlaceOrderContentEntity, PlaceOrder> {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'customerName')
  String customerName;

  @JsonKey(name: 'deliveryChannel')
  String deliveryChannel;

  @JsonKey(name: 'emailAddress')
  String? emailAddress;

  @JsonKey(name: 'smsMobileNumber')
  String? smsMobileNumber;

  @JsonKey(name: 'referenceNo')
  String referenceNo;

  @JsonKey(name: 'creationDate')
  String creationDate;

  @JsonKey(name: 'placementDate')
  String placementDate;
  @JsonKey(name: "lineItems")
  List<LineItemEntity> lineItems;

  PlaceOrderContentEntity({
    required this.id,
    required this.customerName,
    required this.deliveryChannel,
    required this.emailAddress,
    required this.smsMobileNumber,
    required this.referenceNo,
    required this.creationDate,
    required this.placementDate,
    required this.lineItems,
  });

  factory PlaceOrderContentEntity.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOrderContentEntityToJson(this);

  @override
  PlaceOrder transform() {
    return PlaceOrder(
      emailAddress: this.emailAddress,
      smsMobileNumber: this.smsMobileNumber,
      id: this.id,
      customerName: this.customerName,
      deliveryChannel: this.deliveryChannel,
      referenceNo: this.referenceNo,
      creationDate: this.creationDate,
      placementDate: this.placementDate,
      lineItems: this.lineItems.map((e) => e.transform()).toList(),
    );
  }
}

@JsonSerializable()
class LineItemEntity extends BaseLayerDataTransformer<LineItemEntity, LineItem> {
  @JsonKey(name: 'lineNumber')
  int lineNumber;

  @JsonKey(name: 'cardItemId')
  String cardItemId;

  @JsonKey(name: 'cardItemName')
  String? cardItemName;

  @JsonKey(name: 'value')
  double value;

  @JsonKey(name: 'currency')
  String currency;

  @JsonKey(name: 'certificateGenerationKey')
  String certificateGenerationKey;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'claimURL')
  String claimURL;

  @JsonKey(name: 'settlementCurrency')
  String settlementCurrency;

  @JsonKey(name: 'exchangeRate')
  String exchangeRate;

  @JsonKey(name: 'settlementPrice')
  String settlementPrice;

  @JsonKey(name: 'netPrice')
  String netPrice;

  LineItemEntity({
    required this.lineNumber,
    required this.cardItemId,
    required this.cardItemName,
    required this.value,
    required this.currency,
    required this.certificateGenerationKey,
    required this.status,
    required this.claimURL,
    required this.settlementCurrency,
    required this.exchangeRate,
    required this.settlementPrice,
    required this.netPrice,
  });

  factory LineItemEntity.fromJson(Map<String, dynamic> json) => _$LineItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LineItemEntityToJson(this);

  @override
  LineItem transform() {
    return LineItem(
      lineNumber: this.lineNumber,
      cardItemId: this.cardItemId,
      value: this.value,
      currency: this.currency,
      certificateGenerationKey: this.certificateGenerationKey,
      status: this.status,
      claimURL: this.claimURL,
      settlementCurrency: this.settlementCurrency,
      exchangeRate: this.exchangeRate,
      settlementPrice: this.settlementPrice,
      netPrice: this.netPrice,
      cardItemName: this.cardItemName,
    );
  }
}
