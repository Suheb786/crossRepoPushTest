import 'package:data/entity/remote/user/generate_key_pair/generate_key_pair_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/user/generate_key_pair/generate_key_pair_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generate_key_pair_response_entity.g.dart';

@JsonSerializable()
class GenerateKeyPairResponseEntity
    implements BaseLayerDataTransformer<GenerateKeyPairResponseEntity, GenerateKeyPairResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GenerateKeyPairResponseEntity(this.response);

  factory GenerateKeyPairResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GenerateKeyPairResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateKeyPairResponseEntityToJson(this);

  @override
  GenerateKeyPairResponseEntity restore(GenerateKeyPairResponse data) {
    throw UnimplementedError();
  }

  @override
  GenerateKeyPairResponse transform() {
    return GenerateKeyPairResponse(
        content:
            GenerateKeyPairContentEntity.fromJson(response!.content as Map<String, dynamic>).transform());
  }
}
