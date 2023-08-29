import 'package:domain/model/sub_account/account_to_account_transfer.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_to_account_transfer_entity.g.dart';

@JsonSerializable()
class AccountToAccountTransferEntity
    implements BaseLayerDataTransformer<AccountToAccountTransferEntity, AccountToAccountTransfer> {
  @JsonKey(name: 'amount')
  final double transferAmount;

  @JsonKey(name: 'name')
  final String accountName;

  @JsonKey(name: 'iban')
  final String accountIban;

  @JsonKey(name: 'transferDate')
  final String transferDateTime;

  @JsonKey(name: 'reference')
  final String transferReference;

  AccountToAccountTransferEntity({
    required this.transferAmount,
    required this.accountName,
    required this.accountIban,
    required this.transferDateTime,
    required this.transferReference,
  });

  factory AccountToAccountTransferEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountToAccountTransferEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToAccountTransferEntityToJson(this);

  @override
  AccountToAccountTransferEntity restore(AccountToAccountTransfer data) {
    // TODO: implement restore
    throw UnimplementedError();
  }

  @override
  AccountToAccountTransfer transform() {
    return AccountToAccountTransfer(
      amount: this.transferAmount,
      iban: this.accountIban,
      name: this.accountName,
      reference: this.transferReference,
      transferDate: this.transferDateTime,
    );
  }
}
