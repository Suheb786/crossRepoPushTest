import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/cliq/getAlias/account_list.dart';
part 'account_list_entity.g.dart';

@JsonSerializable()
class AccountListEntity
    extends BaseLayerDataTransformer<AccountListEntity, AccountList> {
  @JsonKey(
    name: "accountID",
    defaultValue: "",
  )
  final String? accountID;
  @JsonKey(
    name: "identifier",
    defaultValue: "",
  )
  final String? identifier;
  @JsonKey(
    name: "isDefault",
    defaultValue: false,
  )
  final bool? isDefault;

  AccountListEntity({
    required this.accountID,
    required this.identifier,
    required this.isDefault,
  });
  factory AccountListEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AccountListEntityToJson(this);

  @override
  AccountListEntity restore(AccountList data) {
    return super.restore(data);
  }

  @override
  AccountList transform() {
    return AccountList(
        accountID: this.accountID,
        identifier: this.accountID,
        isDefault: this.isDefault);
  }
}
