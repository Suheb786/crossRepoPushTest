import 'package:json_annotation/json_annotation.dart';

part "activity_request_entity.g.dart";

@JsonSerializable()
class ActivityRequestEntity {
  @JsonKey(name: "NoOfDays")
  final num? noOfDays;
  @JsonKey(name: "IsDebit")
  final String? isDebit;
  @JsonKey(name: "getToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  ActivityRequestEntity({required this.baseData, this.getToken: true, this.noOfDays, this.isDebit});

  factory ActivityRequestEntity.fromJson(Map<String, dynamic> json) => _$ActivityRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRequestEntityToJson(this);
}
