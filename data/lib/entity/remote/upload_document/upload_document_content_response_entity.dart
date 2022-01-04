import 'package:domain/model/upload_document/file_upload_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_document_content_response_entity.g.dart';

@JsonSerializable()
class UploadDocumentContentResponseEntity
    implements
        BaseLayerDataTransformer<UploadDocumentContentResponseEntity,
            FileUploadContent> {
  @JsonKey(name: "documentId")
  final String? documentId;

  UploadDocumentContentResponseEntity({this.documentId});

  factory UploadDocumentContentResponseEntity.fromJson(
      Map<String, dynamic> json) =>
      _$UploadDocumentContentResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UploadDocumentContentResponseEntityToJson(this);

  @override
  UploadDocumentContentResponseEntity restore(FileUploadContent response) {
    return UploadDocumentContentResponseEntity();
  }

  @override
  FileUploadContent transform() {
    return FileUploadContent(documentId: this.documentId);
  }
}
