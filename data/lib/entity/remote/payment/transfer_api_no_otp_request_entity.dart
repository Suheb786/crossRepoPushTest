import 'package:json_annotation/json_annotation.dart';

part "transfer_api_no_otp_request_entity.g.dart";

@JsonSerializable()
class TransferApiNoOtpRequestEntity {
  @JsonKey(name: "BeneficiaryId")
  final String? beneficiaryId;
  @JsonKey(name: "TransferType")
  final String? transferType;
  @JsonKey(name: "BeneficiaryImage")
  final String? beneficiaryImage;
  @JsonKey(name: "IsFriend")
  final bool isFriend;
  @JsonKey(name: "ToAmount")
  final num toAmount;
  @JsonKey(name: "LocalEq")
  final num localEq;
  @JsonKey(name: "Memo")
  final String memo;
  @JsonKey(name: "ToAccount")
  final String toAccount;
  @JsonKey(name: "Type")
  final String? type;
  @JsonKey(name: "DetCustomerType")
  final String? detCustomerType;
  @JsonKey(name: "getToken")
  final bool getToken;
  @JsonKey(name: "NickName")
  final String? nickName;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  TransferApiNoOtpRequestEntity({
    required this.baseData,
    this.toAmount= 0,
    this.nickName= "",
    this.transferType= "",
    this.localEq= 0,
    this.beneficiaryImage= "",
    this.beneficiaryId= "",
    this.memo= "",
    this.toAccount= "",
    this.isFriend= false,
    this.type= "",
    this.detCustomerType= "",
    this.getToken= true,
  }) {
    print("this constructor called");
  }

  factory TransferApiNoOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$TransferApiNoOtpRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransferApiNoOtpRequestEntityToJson(this);
}
