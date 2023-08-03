import 'package:json_annotation/json_annotation.dart';

part "save_selfie_image_request.g.dart";

@JsonSerializable()
class SaveSelfieImageRequest {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "SelfeeImage")
  final String? selfieImage;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SaveSelfieImageRequest({required this.baseData, this.getToken = true, this.selfieImage});

  factory SaveSelfieImageRequest.fromJson(Map<String, dynamic> json) =>
      _$SaveSelfieImageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SaveSelfieImageRequestToJson(this);
}
