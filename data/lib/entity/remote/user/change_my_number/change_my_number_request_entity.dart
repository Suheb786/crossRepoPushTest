import 'package:json_annotation/json_annotation.dart';

part "change_my_number_request_entity.g.dart";

@JsonSerializable()
class ChangeMyNumberRequestEntity {
  @JsonKey(name: "MobileNumber")
  final String? mobileNo;
  @JsonKey(name: "MobileCode")
  final String? mobileCode;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  ChangeMyNumberRequestEntity({required this.baseData, this.getToken: true, this.mobileNo, this.mobileCode});

  factory ChangeMyNumberRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ChangeMyNumberRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeMyNumberRequestEntityToJson(this);
}
