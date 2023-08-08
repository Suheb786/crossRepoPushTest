import 'package:domain/constants/enum/account_status_enum.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "dashboard_account_entity.g.dart";

@JsonSerializable()
class DashboardAccountEntity implements BaseLayerDataTransformer<DashboardAccountEntity, Account> {
  @JsonKey(name: "accountTitle")
  final String? accountTitle;
  @JsonKey(name: "availableBalance")
  final num? availableBalance;
  @JsonKey(name: "accountNo")
  final String? accountNo;
  @JsonKey(name: "iban")
  final String? iban;
  @JsonKey(name: "cardNo")
  final String? cardNo;
  @JsonKey(name: "status")
  final String? status;

  DashboardAccountEntity({this.accountTitle = "",
    this.availableBalance = 0.0,
    this.accountNo = "",
    this.iban = "",
    this.cardNo = "",
    this.status = ""});

  factory DashboardAccountEntity.fromJson(Map<String, dynamic> json) =>
      _$DashboardAccountEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardAccountEntityToJson(this);

  @override
  DashboardAccountEntity restore(Account response) {
    return DashboardAccountEntity();
  }

  @override
  Account transform() {
    return Account(
        accountNo: this.accountNo,
        iban: this.iban,
        accountTitle: this.accountTitle,
        availableBalance: this.availableBalance?.toStringAsFixed(3),
        cardNo: this.cardNo,
        accountStatusEnum: this.status?.fromAccountStatusValue() ?? AccountStatusEnum.NONE);
  }
}
