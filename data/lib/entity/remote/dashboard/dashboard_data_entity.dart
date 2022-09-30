import 'package:data/entity/remote/dashboard/dashboard_account_entity.dart';
import 'package:data/entity/remote/dashboard/dashboard_card_entity.dart';
import 'package:data/entity/remote/dashboard/dashboard_debit_card_entity.dart';
import 'package:data/entity/remote/dashboard/dashboard_features_entity.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "dashboard_data_entity.g.dart";

@JsonSerializable()
class DashboardDataEntity implements BaseLayerDataTransformer<DashboardDataEntity, GetDashboardDataContent> {
  @JsonKey(name: "account")
  final DashboardAccountEntity? account;
  @JsonKey(name: "creditCard")
  final List<DashboardCardEntity>? creditCard;
  @JsonKey(name: "debitCard")
  final List<DashboardDebitCardEntity>? debitCard;
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;
  @JsonKey(name: "mobileCode")
  final String? mobileCode;
  @JsonKey(name: "features")
  final DashboardFeaturesEntity? dashboardFeatures;
  @JsonKey(name: "youJoinedBlink")
  final DateTime? blinkJoinedDate;
  @JsonKey(name: "blinkWasBorn")
  final DateTime? blinkBornDate;
  @JsonKey(name: "somethingWrong")
  final bool? somethingWrong;
  @JsonKey(name: "debitCardSomethingWrong")
  final bool? debitCardSomethingWrong;
  @JsonKey(name: "isCreditCard")
  final bool? isCreditCard;

  DashboardDataEntity({
    this.account,
    this.creditCard,
    this.mobileNumber: "",
    this.blinkBornDate,
    this.blinkJoinedDate,
    this.mobileCode: "",
    this.somethingWrong: false,
    this.debitCardSomethingWrong: false,
    this.isCreditCard: true,
    this.dashboardFeatures,
    this.debitCard,
  });

  factory DashboardDataEntity.fromJson(Map<String, dynamic> json) => _$DashboardDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataEntityToJson(this);

  @override
  DashboardDataEntity restore(GetDashboardDataContent response) {
    return DashboardDataEntity();
  }

  @override
  GetDashboardDataContent transform() {
    return GetDashboardDataContent(
        account: this.account!.transform(),
        creditCard: this.creditCard!.map((e) => e.transform()).toList(),
        debitCard: this.debitCard!.map((e) => e.transform()).toList(),
        blinkWasBorn: this.blinkBornDate,
        youJoinedBlink: this.blinkJoinedDate,
        mobileNumber: this.mobileNumber,
        somethingWrong: this.somethingWrong,
        debitCardSomethingWrong: this.debitCardSomethingWrong ?? false,
        mobileCode: this.mobileCode,
        isCreditCard: this.isCreditCard ?? true,
        dashboardFeatures: this.dashboardFeatures?.transform());
  }
}
