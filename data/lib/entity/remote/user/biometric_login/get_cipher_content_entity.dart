import 'package:domain/model/user/biometric_login/get_cipher_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_cipher_content_entity.g.dart';

@JsonSerializable()
class GetCipherContentEntity implements BaseLayerDataTransformer<GetCipherContentEntity, GetCipherContent> {
  @JsonKey(name: "cipher")
  final String? cipher;

  GetCipherContentEntity({this.cipher = ""});

  factory GetCipherContentEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCipherContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCipherContentEntityToJson(this);

  @override
  GetCipherContentEntity restore(GetCipherContent response) {
    return GetCipherContentEntity();
  }

  @override
  GetCipherContent transform() {
    return GetCipherContent(cipher: this.cipher);
  }
}
