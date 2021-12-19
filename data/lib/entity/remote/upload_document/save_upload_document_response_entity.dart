import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/upload_document/save_upload_document_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'save_upload_document_response_entity.g.dart';

@JsonSerializable()
class SaveUploadDocumentResponseEntity
    implements
        BaseLayerDataTransformer<SaveUploadDocumentResponseEntity,
            SaveUploadDocumentResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  SaveUploadDocumentResponseEntity({this.response});

  factory SaveUploadDocumentResponseEntity.fromJson(
      Map<String, dynamic> json) =>
      _$SaveUploadDocumentResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SaveUploadDocumentResponseEntityToJson(this);

  @override
  SaveUploadDocumentResponseEntity restore(
      SaveUploadDocumentResponse response) {
    return SaveUploadDocumentResponseEntity();
  }

  @override
  SaveUploadDocumentResponse transform() {
    return SaveUploadDocumentResponse(isSuccess: response!.code == 1);
  }
}
