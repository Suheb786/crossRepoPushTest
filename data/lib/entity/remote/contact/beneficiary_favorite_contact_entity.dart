import 'package:data/entity/local/base/image_utils.dart';
import 'package:domain/model/manage_contacts/beneficiary_favorite_contact.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'beneficiary_favorite_contact_entity.g.dart';

@JsonSerializable()
class BeneficiaryFavoriteContactEntity
    extends BaseLayerDataTransformer<BeneficiaryFavoriteContactEntity, BeneficiaryFavoriteContact> {
  final String? id;
  final String? userId;
  final String? type;
  final String? nickName;
  final String? alias;
  final String? fullName;
  final String? accountNo;
  final String? swiftCode;
  final String? sortCode;
  final String? bankCode;
  final String? countryCode;
  final bool? isVerified;
  final String? createTime;
  final String? createTerminal;
  final String? bankName;
  final String? addressLine1;
  final String? addressLine2;
  final String? addressLine3;
  final String? addressLine4;
  final String? beneficiaryAccountCurrency;
  final String? routingNo;
  final String? ifscCode;
  final String? beneficiaryIban;
  final String? beneficiaryType;
  final String? mobileNumber;
  final String? image;
  final String? purpose;
  final String? purposeDetails;
  final String? purposeParent;
  final String? purposeParentDetails;
  final num? limit;
  final String? purposeType;
  final String? detCustomerType;
  final bool? isFavorite;
  final String? identifier;

  BeneficiaryFavoriteContactEntity(
      {this.id,
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
      this.identifier});

  factory BeneficiaryFavoriteContactEntity.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryFavoriteContactEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryFavoriteContactEntityToJson(this);

  @override
  BeneficiaryFavoriteContact transform() {
    return BeneficiaryFavoriteContact(
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
        image: this.image != null ? ImageUtils.dataFromBase64String(this.image!) : '',
        purpose: this.purpose,
        purposeDetails: this.purposeDetails,
        purposeParent: this.purposeParent,
        purposeParentDetails: this.purposeParentDetails,
        limit: this.limit,
        purposeType: this.purposeType,
        detCustomerType: this.detCustomerType,
        isFavorite: this.isFavorite,
        identifier: this.identifier ?? '');
  }
}
