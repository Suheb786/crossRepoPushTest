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
      this.primarySecondaryCard});

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
        expiryDate: this.expiryDate,
        cvv: this.cvv != null ? (this.cvv!.isNotEmpty ? this.cvv : "") : "",
        minDue: this.minDue,
        availableBalance: this.availableBalance,
        maxLimit: this.maxLimit,
        name: this.name,
        totalAmount: this.totalAmount,
        cardId: this.cardId,
        creditLimit: this.creditLimit,
        creditDeliveredDatetime: this.creditDeliveredDatetime,
        isApplied: this.isApplied,
        creditCardActivatedDate: this.creditCardActivatedDate,
        isCreditDelivered: this.isCreditDelivered,
        isSupCard: this.isSupCard,
        primarySecondaryCard: this.primarySecondaryCard,
        usedBalance: this.usedBalance);
  }
}
