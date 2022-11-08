import 'package:json_annotation/json_annotation.dart';

part "add_user_wallet_detail_request_entity.g.dart";

@JsonSerializable()
class AddUserWalletDetailRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "WalletId")
  final String? walletId;
  @JsonKey(name: "EntrustWalletId")
  final String? entrustWalletId;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  AddUserWalletDetailRequestEntity(
      {this.getToken: true, this.walletId: "", this.entrustWalletId: "", required this.baseData});

  factory AddUserWalletDetailRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$AddUserWalletDetailRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddUserWalletDetailRequestEntityToJson(this);
}
