import 'package:json_annotation/json_annotation.dart';

part 'debit_card_limits_update_request_entity.g.dart';

@JsonSerializable()
class DebitCardSLimitsUpdateRequestEntity {
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "atmWithdrawal")
  final num? atmWithdrawal;
  @JsonKey(name: "merchantsPayments")
  final num? merchantsPayments;
  @JsonKey(name: "onlinePurchase")
  final num? onlinePurchase;
  @JsonKey(name: "contactLessPayments")
  final num? contactLessPayments;
  @JsonKey(name: "isAtmWithdrawal")
  final bool? isAtmWithdrawal;
  @JsonKey(name: "isMerchantsPayments")
  final bool? isMerchantsPayments;
  @JsonKey(name: "isOnlinePurchase")
  final bool? isOnlinePurchase;
  @JsonKey(name: "isContactLessPayments")
  final bool? isContactLessPayments;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseData;

  DebitCardSLimitsUpdateRequestEntity(
      {this.getToken: true,
      this.atmWithdrawal: 0,
      this.merchantsPayments: 0,
      this.onlinePurchase: 0,
      this.contactLessPayments: 0,
      this.isAtmWithdrawal: false,
      this.isMerchantsPayments: false,
      this.isOnlinePurchase: false,
      this.isContactLessPayments: false,
      this.baseData});

  factory DebitCardSLimitsUpdateRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      _$DebitCardSLimitsUpdateRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DebitCardSLimitsUpdateRequestEntityToJson(this);
}
