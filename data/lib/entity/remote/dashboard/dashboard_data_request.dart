import 'package:json_annotation/json_annotation.dart';

part "dashboard_data_request.g.dart";

@JsonSerializable()
class DashboardDataRequest {
  @JsonKey(name: "AccountId")
  final int accountId;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  DashboardDataRequest({required this.baseData, this.accountId: 1});

  factory DashboardDataRequest.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDataRequestToJson(this);
}
