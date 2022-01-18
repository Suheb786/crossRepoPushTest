import 'package:json_annotation/json_annotation.dart';

part "get_cipher_request_entity.g.dart";

@JsonSerializable()
class GetCipherRequestEntity {
  @JsonKey(name: "UniqueId")
  final String? uniqueId;

  // @JsonKey(name: "userid")
  // final String? userId;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetCipherRequestEntity({this.uniqueId, required this.baseData});

  factory GetCipherRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCipherRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCipherRequestEntityToJson(this);
}
