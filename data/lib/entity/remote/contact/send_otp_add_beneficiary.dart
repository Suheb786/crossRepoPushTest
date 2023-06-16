import 'package:json_annotation/json_annotation.dart';

part 'send_otp_add_beneficiary.g.dart';

@JsonSerializable()
class SendOTPAddBeneficiaryRequest {
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  SendOTPAddBeneficiaryRequest({
    this.getToken = true,
    required this.baseData,
  });

  factory SendOTPAddBeneficiaryRequest.fromJson(Map<String, dynamic> json) =>
      _$SendOTPAddBeneficiaryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendOTPAddBeneficiaryRequestToJson(this);
}
