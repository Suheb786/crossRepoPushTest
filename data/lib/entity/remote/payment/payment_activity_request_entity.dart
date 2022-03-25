import 'package:json_annotation/json_annotation.dart';

part "payment_activity_request_entity.g.dart";

@JsonSerializable()
class PaymentActivityRequestEntity {
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "FilterDays")
  final int? filterDays;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic>? baseData;

  PaymentActivityRequestEntity(
      {this.getToken: true, this.baseData, this.filterDays: 30});

  factory PaymentActivityRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$PaymentActivityRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentActivityRequestEntityToJson(this);
}
