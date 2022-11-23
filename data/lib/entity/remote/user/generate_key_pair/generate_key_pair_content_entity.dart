import 'package:domain/model/user/generate_key_pair/generate_key_pair_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'generate_key_pair_content_entity.g.dart';

@JsonSerializable()
class GenerateKeyPairContentEntity
    implements BaseLayerDataTransformer<GenerateKeyPairContentEntity, GenerateKeyPairContent> {
  @JsonKey(name: "privatePEM")
  final String? privatePEM;
  @JsonKey(name: "publicPEM")
  final String? publicPEM;

  GenerateKeyPairContentEntity({this.privatePEM, this.publicPEM});

  factory GenerateKeyPairContentEntity.fromJson(Map<String, dynamic> json) =>
      _$GenerateKeyPairContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateKeyPairContentEntityToJson(this);

  @override
  GenerateKeyPairContentEntity restore(GenerateKeyPairContent response) {
    return GenerateKeyPairContentEntity();
  }

  @override
  GenerateKeyPairContent transform() {
    return GenerateKeyPairContent(privatePEM: this.privatePEM, publicPEM: this.publicPEM);
  }
}
