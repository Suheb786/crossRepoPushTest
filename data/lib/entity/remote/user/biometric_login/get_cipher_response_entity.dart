import 'package:data/entity/remote/user/biometric_login/get_cipher_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/user/biometric_login/get_cipher_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_cipher_response_entity.g.dart';

@JsonSerializable()
class GetCipherResponseEntity
    implements BaseLayerDataTransformer<GetCipherResponseEntity, GetCipherResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetCipherResponseEntity(this.response);

  factory GetCipherResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCipherResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCipherResponseEntityToJson(this);

  @override
  GetCipherResponseEntity restore(GetCipherResponse data) {
    throw UnimplementedError();
  }

  @override
  GetCipherResponse transform() {
    return GetCipherResponse(
        getCipherContent: GetCipherContentEntity.fromJson(this.response!.content).transform());
  }
}
