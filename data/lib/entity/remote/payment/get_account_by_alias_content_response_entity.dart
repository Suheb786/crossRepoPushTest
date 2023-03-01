import 'package:data/entity/remote/payment/get_account_by_alias_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_account_by_alias_content_response_entity.g.dart";

@JsonSerializable()
class GetAccountByAliasContentResponseEntity
    implements
        BaseLayerDataTransformer<GetAccountByAliasContentResponseEntity, GetAccountByAliasContentResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetAccountByAliasContentResponseEntity({this.response});

  factory GetAccountByAliasContentResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAccountByAliasContentResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountByAliasContentResponseEntityToJson(this);

  @override
  GetAccountByAliasContentResponseEntity restore(GetAccountByAliasContentResponse response) {
    return GetAccountByAliasContentResponseEntity();
  }

  @override
  GetAccountByAliasContentResponse transform() {
    return GetAccountByAliasContentResponse(
        getAccountByAliasContent:
            GetAccountByAliasContentEntity.fromJson(this.response!.content).transform());
  }
}
