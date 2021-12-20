import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "dashboard_account_entity.g.dart";

@JsonSerializable()
class DashboardAccountEntity
    implements BaseLayerDataTransformer<DashboardAccountEntity, String> {
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

  DashboardAccountEntity(
      {this.accountTitle: "",
      this.availableBalance: 0.0,
      this.accountNo: "",
      this.iban: "",
      this.cardNo: ""});

  factory DashboardAccountEntity.fromJson(Map<String, dynamic> json) =>
      _$DashboardAccountEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardAccountEntityToJson(this);

  @override
  DashboardAccountEntity restore(String response) {
    return DashboardAccountEntity();
  }

  @override
  String transform() {
    return "";
  }
}
