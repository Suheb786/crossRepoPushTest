import 'package:data/entity/remote/cliq/get_alias/alias_list_entity.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_alias_entity.g.dart';

@JsonSerializable()
class GetAliasEntity extends BaseLayerDataTransformer<GetAliasEntity, GetAlias> {
  @JsonKey(name: "aliases")
  final List<AliasListEntity>? aliases;

  GetAliasEntity({
    required this.aliases,
  });

  factory GetAliasEntity.fromJson(Map<String, dynamic> json) => _$GetAliasEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAliasEntityToJson(this);

  @override
  GetAlias transform() {
    return GetAlias(
      this.aliases?.map((e) => e.transform()).toList() ?? List.empty(),
    );
  }
}
