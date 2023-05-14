import 'package:json_annotation/json_annotation.dart';

part "transfer_request_entity.g.dart";

@JsonSerializable()
class TransferRequestEntity {
  @JsonKey(name: "BeneficiaryId")
  final String? beneficiaryId;
  @JsonKey(name: "OtpCode")
  final String? otpCode;
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
  @JsonKey(name: "RecipientName")
  final String? recipientName;
  @JsonKey(name: "RecipientAddress")
  final String? recipientAddress;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  TransferRequestEntity(
      {required this.baseData,
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
      this.otpCode= "",
      this.recipientName,
      this.recipientAddress}) {
    print("this constructor called");
  }

  factory TransferRequestEntity.fromJson(Map<String, dynamic> json) => _$TransferRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransferRequestEntityToJson(this);
}
