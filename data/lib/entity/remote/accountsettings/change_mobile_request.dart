import 'package:json_annotation/json_annotation.dart';

part 'change_mobile_request.g.dart';

@JsonSerializable()
class ChangeMobileRequest {
  @JsonKey(name: "MobileNo")
  final String mobile;
  @JsonKey(name: "MobileCode")
  final String mobileCode;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  ChangeMobileRequest({this.mobile= "", this.getToken= true, required this.baseData, this.mobileCode= ""});

  factory ChangeMobileRequest.fromJson(Map<String, dynamic> json) => _$ChangeMobileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeMobileRequestToJson(this);
}
