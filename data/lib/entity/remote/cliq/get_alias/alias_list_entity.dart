import 'package:data/entity/remote/cliq/get_alias/account_list_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/cliq/getAlias/alias_list.dart';
part 'alias_list_entity.g.dart';

@JsonSerializable()
class AliasListEntity
    extends BaseLayerDataTransformer<AliasListEntity, AliasList> {
  @JsonKey(
    name: "aliasID",
    defaultValue: "",
  )
  final String? aliasID;
  @JsonKey(
    name: "aliasName",
    defaultValue: "",
  )
  final String? aliasName;
  @JsonKey(
    name: "aliasType",
    defaultValue: "",
  )
  final String? aliasType;
  @JsonKey(
    name: "status",
    defaultValue: "",
  )
  final String? status;
  @JsonKey(
    name: "accounts",
    defaultValue: [],
  )
  final List<AccountListEntity>? accounts;

  AliasListEntity({
    required this.aliasID,
    required this.aliasName,
    required this.aliasType,
    required this.status,
    required this.accounts,
  });
  factory AliasListEntity.fromJson(Map<String, dynamic> json) =>
      _$AliasListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AliasListEntityToJson(this);
  @override
  AliasListEntity restore(AliasList data) {
    // TODO: implement restore
    return super.restore(data);
  }

  @override
  AliasList transform() {
    return AliasList(
        accounts:
            this.accounts?.map((e) => e.transform()).toList() ?? List.empty(),
        aliasID: this.aliasID,
        aliasName: this.aliasName,
        aliasType: this.aliasType,
        status: this.status);
  }
}
