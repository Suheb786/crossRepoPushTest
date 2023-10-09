import 'package:json_annotation/json_annotation.dart';

part 'transfer_account_request_entity.g.dart';

@JsonSerializable()
class AccountToAccountTransferRequestEntity {
  @JsonKey(name: 'FromAccount')
  String? fromAccount;

  @JsonKey(name: 'ToAccount')
  String? toAccount;

  @JsonKey(name: 'TransferAmount')
  double? transferAmount;

  @JsonKey(name: 'GetToken')
  bool? getToken;
  @JsonKey(name: 'BaseClass')
  Map<String, dynamic>? baseClass;

  AccountToAccountTransferRequestEntity({
    required this.fromAccount,
    required this.toAccount,
    required this.getToken,
    required this.transferAmount,
    required this.baseClass,
  });

  factory AccountToAccountTransferRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountToAccountTransferRequestEntityFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToAccountTransferRequestEntityToJson(this);
}
