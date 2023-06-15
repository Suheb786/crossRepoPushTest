import 'package:domain/model/manage_contacts/beneficiary_search_contact.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "beneficiary_search_contact_entity.g.dart";

@JsonSerializable()
class BeneficiarySearchContactEntity
    extends BaseLayerDataTransformer<BeneficiarySearchContactEntity, BeneficiarySearchContact> {
  @JsonKey(name: "id", defaultValue: '')
  final String? id;

  @JsonKey(name: "userId", defaultValue: '')
  final String? userId;

  @JsonKey(name: "type", defaultValue: '')
  final String? type;

  @JsonKey(name: "nickName", defaultValue: '')
  final String? nickName;

  @JsonKey(name: "alias", defaultValue: '')
  final String? alias;

  @JsonKey(name: "fullName", defaultValue: '')
  final String? fullName;

  @JsonKey(name: "accountNo", defaultValue: '')
  final String? accountNo;

  @JsonKey(name: "swiftCode", defaultValue: '')
  final String? swiftCode;

  @JsonKey(name: "sortCode", defaultValue: '')
  final String? sortCode;

  @JsonKey(name: "bankCode", defaultValue: '')
  final String? bankCode;

  @JsonKey(name: "countryCode", defaultValue: '')
  final String? countryCode;

  @JsonKey(name: "isVerified", defaultValue: false)
  final bool? isVerified;

  @JsonKey(name: "createTime", defaultValue: '')
  final String? createTime;

  @JsonKey(name: "createTerminal", defaultValue: '')
  final String? createTerminal;

  @JsonKey(name: "bankName", defaultValue: '')
  final String? bankName;

  @JsonKey(name: "addressLine1", defaultValue: '')
  final String? addressLine1;

  @JsonKey(name: "addressLine2", defaultValue: '')
  final String? addressLine2;

  @JsonKey(name: "addressLine3", defaultValue: '')
  final String? addressLine3;

  @JsonKey(name: "addressLine4", defaultValue: '')
  final String? addressLine4;

  @JsonKey(name: "beneficiaryAccountCurrency", defaultValue: '')
  final String? beneficiaryAccountCurrency;

  @JsonKey(name: "routingNo", defaultValue: '')
  final String? routingNo;

  @JsonKey(name: "ifscCode", defaultValue: '')
  final String? ifscCode;

  @JsonKey(name: "beneficiaryIban", defaultValue: '')
  final String? beneficiaryIban;

  @JsonKey(name: "beneficiaryType", defaultValue: '')
  final String? beneficiaryType;

  @JsonKey(name: "mobileNumber", defaultValue: '')
  final String? mobileNumber;

  @JsonKey(name: "image", defaultValue: '')
  final String? image;

  @JsonKey(name: "purpose", defaultValue: '')
  final String? purpose;
  @JsonKey(name: "purposeDetails", defaultValue: '')
  final String? purposeDetails;

  @JsonKey(name: "purposeParent", defaultValue: '')
  final String? purposeParent;

  @JsonKey(name: "purposeParentDetails", defaultValue: '')
  final String? purposeParentDetails;

  @JsonKey(name: "limit", defaultValue: 0.0)
  final num? limit;

  @JsonKey(name: "purposeType", defaultValue: '')
  final String? purposeType;

  @JsonKey(name: "detCustomerType", defaultValue: '')
  final String? detCustomerType;

  @JsonKey(name: "isFavorite", defaultValue: false)
  final bool? isFavorite;

  BeneficiarySearchContactEntity({
    this.id,
    this.userId,
    this.type,
    this.nickName,
    this.alias,
    this.fullName,
    this.accountNo,
    this.swiftCode,
    this.sortCode,
    this.bankCode,
    this.countryCode,
    this.isVerified,
    this.createTime,
    this.createTerminal,
    this.bankName,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.addressLine4,
    this.beneficiaryAccountCurrency,
    this.routingNo,
    this.ifscCode,
    this.beneficiaryIban,
    this.beneficiaryType,
    this.mobileNumber,
    this.image,
    this.purpose,
    this.purposeDetails,
    this.purposeParent,
    this.purposeParentDetails,
    this.limit,
    this.purposeType,
    this.detCustomerType,
    this.isFavorite,
  });

  factory BeneficiarySearchContactEntity.fromJson(Map<String, dynamic> json) =>
      _$BeneficiarySearchContactEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiarySearchContactEntityToJson(this);

  @override
  BeneficiarySearchContact transform() {
    return BeneficiarySearchContact(
      id: this.id,
      userId: this.userId,
      type: this.type,
      nickName: this.nickName,
      alias: this.alias,
      fullName: this.fullName,
      accountNo: this.accountNo,
      swiftCode: this.swiftCode,
      sortCode: this.sortCode,
      bankCode: this.bankCode,
      countryCode: this.countryCode,
      isVerified: this.isVerified,
      createTime: this.createTime,
      createTerminal: this.createTerminal,
      bankName: this.bankName,
      addressLine1: this.addressLine1,
      addressLine2: this.addressLine2,
      addressLine3: this.addressLine3,
      addressLine4: this.addressLine4,
      beneficiaryAccountCurrency: this.beneficiaryAccountCurrency,
      routingNo: this.routingNo,
      ifscCode: this.ifscCode,
      beneficiaryIban: this.beneficiaryIban,
      beneficiaryType: this.beneficiaryType,
      mobileNumber: this.mobileNumber,
      image: this.image,
      purpose: this.purpose,
      purposeDetails: this.purposeDetails,
      purposeParent: this.purposeParent,
      purposeParentDetails: this.purposeParentDetails,
      limit: this.limit,
      purposeType: this.purposeType,
      detCustomerType: this.detCustomerType,
      isFavorite: this.isFavorite,
    );
  }
}
