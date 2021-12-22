import 'package:json_annotation/json_annotation.dart';

part 'upload_beneficiary_image_request.g.dart';

@JsonSerializable()
class UploadBeneficiaryImageRequest {
  @JsonKey(name: "BeneficiaryID")
  final String beneficiaryID;
  @JsonKey(name: "Image")
  final String image;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  UploadBeneficiaryImageRequest({
    required this.beneficiaryID,
    required this.image,
    this.getToken: true,
    required this.baseData,
  });

  factory UploadBeneficiaryImageRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadBeneficiaryImageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UploadBeneficiaryImageRequestToJson(this);
}
