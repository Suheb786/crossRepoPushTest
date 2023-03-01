import 'package:json_annotation/json_annotation.dart';

part 'create_account_request_entity.g.dart';

@JsonSerializable()
class CreateAccountRequestEntity {
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "cif")
  final String? cif;
  @JsonKey(name: "customer")
  final Map<String, dynamic>? customerDetailsEntity;
  @JsonKey(name: "account")
  final Map<String, dynamic>? account;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CreateAccountRequestEntity(
      {this.getToken: true, this.cif, this.customerDetailsEntity, this.account, required this.baseData});

  factory CreateAccountRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountRequestEntityToJson(this);
}
