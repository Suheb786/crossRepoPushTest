import 'package:domain/constants/enum/credit_card_call_status_enum.dart';
import 'package:domain/constants/enum/freeze_card_status_enum.dart';
import 'package:domain/constants/enum/primary_secondary_card_enum.dart';
import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "dashboard_card_entity.g.dart";

@JsonSerializable()
class DashboardCardEntity
    implements BaseLayerDataTransformer<DashboardCardEntity, CreditCard> {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "availableBalance")
  final num? availableBalance;
  @JsonKey(name: "minDue")
  final num? minDue;
  @JsonKey(name: "totalAmount")
  final num? totalAmount;
  @JsonKey(name: "cardNumber")
  final String? cardNumber;
  @JsonKey(name: "expiryDate")
  final String? expiryDate;
  @JsonKey(name: "cvv")
  final String? cvv;
  @JsonKey(name: "maxLimit")
  final num? maxLimit;
  @JsonKey(name: "creditlimit")
  final String? creditLimit;
  @JsonKey(name: "usedbalance")
  final String? usedBalance;
  @JsonKey(name: "isCreditDelivered")
  final bool? isCreditDelivered;
  @JsonKey(name: "creditCardActivated")
  final String? creditCardActivatedDate;
  @JsonKey(name: "creditDeliveredDatetime")
  final String? creditDeliveredDatetime;
  @JsonKey(name: "isApplied")
  final bool? isApplied;
  @JsonKey(name: "cardId")
  final String? cardId;
  @JsonKey(name: "isSupCard")
  final bool? isSupCard;
  @JsonKey(name: "primarysecondarycard")
  final String? primarySecondaryCard;
  @JsonKey(name: "cardCode")
  final String? cardCode;
  @JsonKey(name: "paymentDueAmount")
  final dynamic paymentDueAmount;
  @JsonKey(name: "isCompleted")
  final bool? isCompleted;
  @JsonKey(name: "nextpaymentdate")
  final String? nextPaymentDate;
  @JsonKey(name: "cardStatus")
  final String? cardStatus;
  @JsonKey(name: "minimumSettlement")
  final num? minimumSettlement;
  @JsonKey(name: "callStatus")
  final String? callStatus;
  @JsonKey(name: "isCallPending")
  final bool? isCallPending;
  @JsonKey(name: "parentId")
  final String? parentId;

  DashboardCardEntity(
      {this.name: "",
      this.availableBalance: 0.0,
      this.minDue: 0.0,
      this.totalAmount: 0.0,
      this.cardNumber: "",
      this.expiryDate: "",
      this.maxLimit: 0.0,
      this.cvv: "",
      this.usedBalance,
      this.isSupCard,
      this.creditCardActivatedDate,
      this.isApplied,
      this.isCreditDelivered,
      this.creditDeliveredDatetime,
      this.creditLimit,
      this.cardId,
      this.primarySecondaryCard,
      this.cardCode,
      this.paymentDueAmount,
      this.isCompleted: false,
      this.nextPaymentDate: "",
      this.cardStatus: "",
      this.minimumSettlement: 0,
      this.callStatus: "",
      this.isCallPending: false,
      this.parentId: ""});

  factory DashboardCardEntity.fromJson(Map<String, dynamic> json) =>
      _$DashboardCardEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardCardEntityToJson(this);

  @override
  DashboardCardEntity restore(CreditCard response) {
    return DashboardCardEntity();
  }

  @override
  CreditCard transform() {
    return CreditCard(
        cardNumber: this.cardNumber != null ? this.cardNumber! : "",
        expiryDate: this.expiryDate ?? '',
        cvv: this.cvv != null ? (this.cvv!.isNotEmpty ? this.cvv : "") : "",
        minDue: this.minDue ?? 0.000,
        availableBalance: this.availableBalance ?? 0.000,
        maxLimit: this.maxLimit ?? 0.000,
        name: this.name ?? '',
        totalAmount: this.totalAmount ?? 0.000,
        cardId: this.cardId ?? '',
        creditLimit: this.creditLimit ?? '',
        creditDeliveredDatetime: this.creditDeliveredDatetime ?? '',
        isApplied: this.isApplied ?? false,
        creditCardActivatedDate: this.creditCardActivatedDate ?? '',
        isCreditDelivered: this.isCreditDelivered ?? false,
        isSupCard: this.isSupCard ?? false,
        primarySecondaryCard: this.primarySecondaryCard != null
            ? this.primarySecondaryCard!.fromPrimarySecondaryCard()
            : PrimarySecondaryCardEnum.NONE,
        usedBalance: this.usedBalance ?? '',
        cardCode: this.cardCode ?? '',
        isCompleted: this.isCompleted ?? false,
        paymentDueAmount:
            this.paymentDueAmount != null ? this.paymentDueAmount : '0.0',
        nextPaymentDate:
            this.nextPaymentDate != null ? this.nextPaymentDate : '',
        cardStatus: this.cardStatus!.fromFreezeCardStatusValue(),
        minimumSettlement: this.minimumSettlement ?? 0,
        callStatus: this.callStatus!.fromCreditCardCallStatusValue(),
        isCallPending: this.isCallPending ?? false,
        parentId: this.parentId ?? '');
  }
}
