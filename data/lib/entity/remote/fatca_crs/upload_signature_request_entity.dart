import 'package:json_annotation/json_annotation.dart';

part 'upload_signature_request_entity.g.dart';

@JsonSerializable()
class UploadSignatureRequestEntity {
  @JsonKey(name: "Image")
  final String? image;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  UploadSignatureRequestEntity({this.image, required this.baseData});

  factory UploadSignatureRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$UploadSignatureRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UploadSignatureRequestEntityToJson(this);
}
