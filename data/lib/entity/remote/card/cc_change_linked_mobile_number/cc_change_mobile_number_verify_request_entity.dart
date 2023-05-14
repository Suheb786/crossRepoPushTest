import 'package:json_annotation/json_annotation.dart';

part 'cc_change_mobile_number_verify_request_entity.g.dart';

@JsonSerializable()
class CcChangeMobileNumberVerifyRequestEntity {
  @JsonKey(name: "MobileCode")
  final String? mobileCode;
  @JsonKey(name: "MobileNumber")
  final String? mobileNumber;
  @JsonKey(name: "TokenizedPan")
  final String? tokenizedPan;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  CcChangeMobileNumberVerifyRequestEntity(
      {required this.baseData, this.getToken= true, this.mobileCode, this.mobileNumber, this.tokenizedPan});

  factory CcChangeMobileNumberVerifyRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CcChangeMobileNumberVerifyRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CcChangeMobileNumberVerifyRequestEntityToJson(this);
}
