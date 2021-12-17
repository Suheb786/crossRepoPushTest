import 'package:json_annotation/json_annotation.dart';

part 'add_beneficiary_request.g.dart';

@JsonSerializable()
class AddBeneficiaryRequest {
  @JsonKey(name: "NickName")
  final String? nickName;
  @JsonKey(name: "FullName")
  final String? fullName;
  @JsonKey(name: "AccountNo")
  final String? accountNo;
  @JsonKey(name: "Iban")
  final String? iBan;
  @JsonKey(name: "BankName")
  final String? bankName;
  @JsonKey(name: "Purpose")
  final String? purpose;
  @JsonKey(name: "PurposeDetails")
  final String? purposeDetails;
  @JsonKey(name: "Image")
  final String? image;
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  AddBeneficiaryRequest({
    this.nickName,
    this.fullName,
    this.accountNo,
    this.iBan,
    this.bankName,
    this.purpose,
    this.purposeDetails,
    this.image,
    this.getToken: true,
    required this.baseData,
  });

  factory AddBeneficiaryRequest.fromJson(Map<String, dynamic> json) =>
      _$AddBeneficiaryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddBeneficiaryRequestToJson(this);
}
