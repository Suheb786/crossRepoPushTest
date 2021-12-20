import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "dashboard_card_entity.g.dart";

@JsonSerializable()
class DashboardCardEntity
    implements BaseLayerDataTransformer<DashboardCardEntity, String> {
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

  DashboardCardEntity(
      {this.accountTitle: "",
      this.availableBalance: 0.0,
      this.accountNo: "",
      this.iban: "",
      this.cardNo: ""});

  factory DashboardCardEntity.fromJson(Map<String, dynamic> json) =>
      _$DashboardCardEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardCardEntityToJson(this);

  @override
  DashboardCardEntity restore(String response) {
    return DashboardCardEntity();
  }

  @override
  String transform() {
    return "";
  }
}
