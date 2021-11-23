import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/user/get_token_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_token_response_entity.g.dart';

@JsonSerializable()
class GetTokenResponseEntity
    extends BaseLayerDataTransformer<GetTokenResponseEntity, GetTokenResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetTokenResponseEntity({this.response});

  factory GetTokenResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetTokenResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetTokenResponseEntityToJson(this);

  @override
  GetTokenResponse transform() {
    return GetTokenResponse(response: this.response!.transform());
  }
}
