import 'package:json_annotation/json_annotation.dart';

part "get_cipher_request_entity.g.dart";

@JsonSerializable()
class GetCipherRequestEntity {
  @JsonKey(name: "deviceid")
  final String? deviceId;
  @JsonKey(name: "userid")
  final String? userId;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetCipherRequestEntity({this.deviceId, required this.baseData, this.userId});

  factory GetCipherRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCipherRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCipherRequestEntityToJson(this);
}
