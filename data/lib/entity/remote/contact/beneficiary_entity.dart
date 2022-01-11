import 'package:data/entity/local/base/image_utils.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "beneficiary_entity.g.dart";

@JsonSerializable()
class BeneficiaryEntity
    extends BaseLayerDataTransformer<BeneficiaryEntity, Beneficiary> {
  @JsonKey(name: "nickName")
  final String? nickName;
  @JsonKey(name: "fullName")
  final String? fullName;
  @JsonKey(name: "profileImage")
  final String? profileImage;
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "accountNo")
  final String? accountNo;
  @JsonKey(name: "iban")
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
  @JsonKey(name: "beneType")
  final String? beneType;

  BeneficiaryEntity(
      {this.nickName: "",
      this.fullName: "",
      this.profileImage: "",
      this.beneficiaryAddress: "",
      this.accountNo: "",
      this.mobileNumber: "",
      this.purposeDetails: "",
      this.bankName: "",
      this.iban: "",
      this.purpose: "",
      this.id: "",
      this.beneType: ""});

  factory BeneficiaryEntity.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryEntityToJson(this);

  @override
  BeneficiaryEntity restore(Beneficiary response) {
    return BeneficiaryEntity();
  }

  @override
  Beneficiary transform() {
    return Beneficiary(
        id: this.id,
        bankName: this.bankName,
        nickName: this.nickName,
        fullName: this.fullName,
        imageUrl: this.profileImage != null
            ? ImageUtils.dataFromBase64String(this.profileImage!)
            : '',
        purpose: this.purpose,
        purposeDetails: this.purposeDetails,
        mobileNumber: this.mobileNumber,
        iban: this.iban,
        accountHolderName: this.fullName,
        accountNo: this.accountNo,
        beneficiaryAddress: this.beneficiaryAddress,
        beneType: this.beneType);
  }
}
