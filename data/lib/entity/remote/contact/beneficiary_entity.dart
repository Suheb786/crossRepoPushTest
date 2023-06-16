import 'package:data/entity/local/base/image_utils.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "beneficiary_entity.g.dart";

@JsonSerializable()
class BeneficiaryEntity extends BaseLayerDataTransformer<BeneficiaryEntity, Beneficiary> {
  @JsonKey(name: "nickName")
  final String? nickName;
  @JsonKey(name: "fullName")
  final String? fullName;
  @JsonKey(name: "image")
  final String? profileImage;
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "accountNo")
  final String? accountNo;
  @JsonKey(name: "beneficiaryIban")
  final String? iban;
  @JsonKey(name: "purpose")
  final String? purpose;
  @JsonKey(name: "purposeDetails")
  final String? purposeDetails;
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;
  @JsonKey(name: "beneficiaryAddress")
  final String? beneficiaryAddress;
  @JsonKey(name: "bankName")
  final String? bankName;
  @JsonKey(name: "beneficiaryType")
  final String? beneType;
  @JsonKey(name: "purposeType")
  final String? purposeType;
  @JsonKey(name: "purposeParent")
  final String? purposeParent;
  @JsonKey(name: "purposeParentDetails")
  final String? purposeParentDetails;
  @JsonKey(name: "limit")
  final num? limit;
  @JsonKey(name: "detCustomerType")
  final String? detCustomerType;

  BeneficiaryEntity(
      {this.nickName = "",
      this.fullName = "",
      this.profileImage = "",
      this.beneficiaryAddress = "",
      this.accountNo = "",
      this.mobileNumber = "",
      this.purposeDetails = "",
      this.bankName = "",
      this.iban = "",
      this.purpose = "",
      this.id = "",
      this.beneType = "",
      this.purposeType = "",
      this.detCustomerType = "",
      this.limit,
      this.purposeParent = "",
      this.purposeParentDetails = ""});

  factory BeneficiaryEntity.fromJson(Map<String, dynamic> json) => _$BeneficiaryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryEntityToJson(this);

  @override
  BeneficiaryEntity restore(Beneficiary response) {
    return BeneficiaryEntity();
  }

  @override
  Beneficiary transform() {
    return Beneficiary(
        id: this.id,
        bankName: this.bankName ?? '',
        nickName: this.nickName,
        fullName: this.fullName,
        imageUrl: this.profileImage != null ? ImageUtils.dataFromBase64String(this.profileImage!) : null,
        purpose: this.purpose,
        purposeDetails: this.purposeDetails,
        mobileNumber: this.mobileNumber,
        iban: this.iban,
        accountHolderName: this.fullName,
        accountNo: this.accountNo,
        beneficiaryAddress: this.beneficiaryAddress,
        purposeType: this.purposeType ?? "",
        detCustomerType: this.detCustomerType ?? "",
        beneType: this.beneType,
        limit: this.limit,
        purposeParent: this.purposeParent,
        purposeParentDetails: this.purposeParentDetails);
  }
}
