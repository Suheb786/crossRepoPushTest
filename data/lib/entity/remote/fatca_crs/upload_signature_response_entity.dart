import 'package:domain/model/fatca_crs/upload_signature_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_signature_response_entity.g.dart';

@JsonSerializable()
class UploadSignatureResponseEntity extends BaseLayerDataTransformer<
    UploadSignatureResponseEntity, UploadSignatureResponse> {
  @JsonKey(name: "code")
  final int? code;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "content")
  final String? content;
  @JsonKey(name: "exceptionMessage")
  final String? exceptionMessage;
  @JsonKey(name: "id")
  final String? id;

  UploadSignatureResponseEntity(
      {this.code,
      this.content,
      this.exceptionMessage,
      this.message,
      this.token,
      this.id});

  factory UploadSignatureResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UploadSignatureResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UploadSignatureResponseEntityToJson(this);

  @override
  UploadSignatureResponse transform() {
    return UploadSignatureResponse(id: this.content);
  }
}
