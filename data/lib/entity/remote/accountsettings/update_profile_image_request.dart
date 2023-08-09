import 'package:json_annotation/json_annotation.dart';

part 'update_profile_image_request.g.dart';

@JsonSerializable()
class UpdateProfileImageRequest {
  @JsonKey(name: "Image")
  final String image;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  UpdateProfileImageRequest({this.image = "", this.getToken = true, required this.baseData});

  factory UpdateProfileImageRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileImageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileImageRequestToJson(this);
}
