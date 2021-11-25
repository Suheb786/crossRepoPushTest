import 'package:data/entity/remote/upload_document/upload_document_content_response_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/upload_document/file_upload_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_document_response_entity.g.dart';

@JsonSerializable()
class UploadDocumentResponseEntity extends BaseLayerDataTransformer<
    UploadDocumentResponseEntity, FileUploadResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  UploadDocumentResponseEntity(this.response);

  factory UploadDocumentResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$UploadDocumentResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UploadDocumentResponseEntityToJson(this);

  @override
  FileUploadResponse transform() {
    return FileUploadResponse(
        fileUploadContent:
            UploadDocumentContentResponseEntity.fromJson(this.response!.content)
                .transform());
  }
}
