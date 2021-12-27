import 'package:data/entity/remote/dashboard/dashboard_account_entity.dart';
import 'package:data/entity/remote/dashboard/dashboard_card_entity.dart';
import 'package:data/entity/remote/dashboard/dashboard_debit_card_entity.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "dashboard_data_entity.g.dart";

@JsonSerializable()
class DashboardDataEntity
    implements
        BaseLayerDataTransformer<DashboardDataEntity, GetDashboardDataContent> {
  @JsonKey(name: "account")
  final DashboardAccountEntity? account;
  @JsonKey(name: "creditCard")
  final DashboardCardEntity? creditCard;
  @JsonKey(name: "debitCard")
  final DashboardDebitCardEntity? debitCard;
  @JsonKey(name: "isApplied")
  final bool? isApplied;
  @JsonKey(name: "isCreditDelivered")
  final dynamic? isCreditDelivered;
  @JsonKey(name: "isDebitDelivered")
  final dynamic? isDebitDelivered;
  @JsonKey(name: "debitCardActivated")
  final dynamic? debitCardActivated;
  @JsonKey(name: "creditCardActivated")
  final String? creditCardActivated;
  @JsonKey(name: "youJoinedBlink")
  final DateTime? blinkJoinedDate;
  @JsonKey(name: "blinkWasBorn")
  final DateTime? blinkBornDate;
  @JsonKey(name: "debitDeliveredDatetime")
  final dynamic? debitDeliveredDatetime;
  @JsonKey(name: "creditDeliveredDatetime")
  final dynamic? creditDeliveredDatetime;

  DashboardDataEntity(
      {this.account,
      this.creditCard,
      this.blinkBornDate,
      this.blinkJoinedDate,
      this.debitCardActivated,
      this.isApplied,
      this.isDebitDelivered,
      this.creditCardActivated,
      this.isCreditDelivered,
      this.debitCard,
      this.debitDeliveredDatetime,
      this.creditDeliveredDatetime});

  factory DashboardDataEntity.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataEntityToJson(this);

  @override
  DashboardDataEntity restore(GetDashboardDataContent response) {
    return DashboardDataEntity();
  }

  @override
  GetDashboardDataContent transform() {
    return GetDashboardDataContent(
        account: this.account!.transform(),
        creditCard: this.creditCard!.transform(),
        debitCard: this.debitCard!.transform(),
        isApplied: this.isApplied,
        isCreditDelivered: this.isCreditDelivered,
        isDebitDelivered: this.isDebitDelivered,
        creditCardActivated: this.creditCardActivated,
        debitCardActivated: this.debitCardActivated,
        blinkWasBorn: this.blinkBornDate,
        youJoinedBlink: this.blinkJoinedDate,
        debitDeliveredDatetime: this.debitDeliveredDatetime,
        creditDeliveredDatetime: this.creditDeliveredDatetime);
  }
}
