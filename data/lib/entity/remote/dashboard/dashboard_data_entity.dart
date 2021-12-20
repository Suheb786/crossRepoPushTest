import 'package:data/entity/remote/dashboard/dashboard_account_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "dashboard_data_entity.g.dart";

@JsonSerializable()
class DashboardDataEntity
    implements BaseLayerDataTransformer<DashboardDataEntity, String> {
  @JsonKey(name: "account")
  final DashboardAccountEntity? account;
  @JsonKey(name: "creditCard")
  final DashboardAccountEntity? creditCard;
  @JsonKey(name: "isApplied")
  final bool? isApplied;
  @JsonKey(name: "isDelivered")
  final bool? isDelivered;
  @JsonKey(name: "debitCardActivated")
  final bool? debitCardActivated;
  @JsonKey(name: "youJoinedBlink")
  final String? blinkJoinedDate;
  @JsonKey(name: "blinkWasBorn")
  final String? blinkBornDate;

  DashboardDataEntity(
      {this.account,
      this.creditCard,
      this.blinkBornDate,
      this.blinkJoinedDate,
      this.debitCardActivated,
      this.isApplied,
      this.isDelivered});

  factory DashboardDataEntity.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataEntityToJson(this);

  @override
  DashboardDataEntity restore(String response) {
    return DashboardDataEntity();
  }

  @override
  String transform() {
    return "";
  }
}
