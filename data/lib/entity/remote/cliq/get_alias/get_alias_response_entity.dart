import 'package:data/entity/remote/cliq/get_alias/get_alias_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/getAlias/get_alias.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_alias_response_entity.g.dart';

@JsonSerializable()
class GetAliasResponseEntity extends BaseLayerDataTransformer<GetAliasResponseEntity, GetAlias> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetAliasResponseEntity(this.response);

  factory GetAliasResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAliasResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAliasResponseEntityToJson(this);

  @override
  GetAlias transform() {
    return GetAliasEntity.fromJson(response?.content as Map<String, dynamic>).transform();
  }
}
