import 'package:json_annotation/json_annotation.dart';

part 'save_upload_document_request_entity.g.dart';

@JsonSerializable()
class SaveUploadDocumentRequestEntity {
  @JsonKey(name: "ProofOfIncomeId")
  final String? proofOfIncomeId;
  @JsonKey(name: "ProofOfAddressId")
  final String? proofOfAddressId;
  @JsonKey(name: "ProofOfNationalityId")
  final String? proofOfNationalityId;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SaveUploadDocumentRequestEntity(
      {this.proofOfAddressId,
      this.proofOfIncomeId,
      this.proofOfNationalityId,
      this.getToken= true,
      required this.baseData});

  factory SaveUploadDocumentRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SaveUploadDocumentRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SaveUploadDocumentRequestEntityToJson(this);
}
