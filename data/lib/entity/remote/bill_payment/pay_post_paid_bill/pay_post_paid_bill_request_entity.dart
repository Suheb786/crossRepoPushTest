import 'package:json_annotation/json_annotation.dart';

part 'pay_post_paid_bill_request_entity.g.dart';

@JsonSerializable()
class PayPostPaidBillRequestEntity {
  @JsonKey(name: "billList")
  dynamic billerList;
  @JsonKey(name: "accountNo")
  String? accountNo;
  @JsonKey(name: "totalAmount")
  String? totalAmount;
  @JsonKey(name: "fee")
  String? fee;
  @JsonKey(name: "currencyCode")
  String? currencyCode;
  @JsonKey(name: "isNewBiller")
  bool? isNewBiller;
  @JsonKey(name: "isCreditCardPayment")
  bool? isCreditCardPayment;
  @JsonKey(name: "otpCode")
  String? otpCode;
  @JsonKey(name: "NickName")
  String? nickName;
  @JsonKey(name: "CardId")
  String? CardId;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  PayPostPaidBillRequestEntity(
      {this.billerList,
      this.accountNo,
      this.totalAmount,
      this.fee,
      this.currencyCode,
      this.otpCode,
      this.isCreditCardPayment,
      this.isNewBiller,
      this.CardId,
      this.nickName,
      this.getToken: true,
      required this.baseData});

  factory PayPostPaidBillRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$PayPostPaidBillRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PayPostPaidBillRequestEntityToJson(this);
}
