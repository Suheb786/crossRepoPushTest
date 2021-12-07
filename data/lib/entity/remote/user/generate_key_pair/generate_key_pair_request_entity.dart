import 'package:json_annotation/json_annotation.dart';

part "generate_key_pair_request_entity.g.dart";

@JsonSerializable()
class GenerateKeyPairRequestEntity {
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GenerateKeyPairRequestEntity({required this.baseData});

  factory GenerateKeyPairRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GenerateKeyPairRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateKeyPairRequestEntityToJson(this);
}
