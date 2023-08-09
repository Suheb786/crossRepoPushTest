import 'package:json_annotation/json_annotation.dart';

part 'upload_document_request_entity.g.dart';

@JsonSerializable()
class UploadDocumentRequestEntity {
  @JsonKey(name: "DocumentBase64")
  final String? documentBase64;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  UploadDocumentRequestEntity({this.documentBase64, this.getToken = true, required this.baseData});

  factory UploadDocumentRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$UploadDocumentRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UploadDocumentRequestEntityToJson(this);
}
