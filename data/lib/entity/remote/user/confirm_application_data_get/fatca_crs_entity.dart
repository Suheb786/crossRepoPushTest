import 'package:domain/model/user/confirm_application_data_get/fatca_crs_info.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fatca_crs_entity.g.dart';

@JsonSerializable()
class FatcaCrsEntity
    implements BaseLayerDataTransformer<FatcaCrsEntity, FatcaCrsInfo> {
  @JsonKey(name: "id")
  final int? id;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "companyId")
  final int? companyId;
  @JsonKey(name: "productId")
  final int? productId;
  @JsonKey(name: "accountId")
  final int? accountId;
  @JsonKey(name: "response1")
  final bool? response1;
  @JsonKey(name: "response2")
  final bool? response2;
  @JsonKey(name: "response3")
  final bool? response3;
  @JsonKey(name: "response4")
  final bool? response4;
  @JsonKey(name: "response5")
  final bool? response5;
  @JsonKey(name: "relationshipWithPEP")
  final String? relationshipWithPep;
  @JsonKey(name: "personName")
  final String? personName;
  @JsonKey(name: "personRole")
  final String? personRole;
  @JsonKey(name: "namePerIncomeTaxReturn")
  final dynamic? namePerIncomeTaxReturn;
  @JsonKey(name: "dob")
  final dynamic? dob;
  @JsonKey(name: "citizenShipCountry")
  final dynamic? citizenShipCountry;
  @JsonKey(name: "permanentResidenceAddress")
  final dynamic? permanentResidenceAddress;
  @JsonKey(name: "country")
  final dynamic? country;
  @JsonKey(name: "city")
  final dynamic? city;
  @JsonKey(name: "state")
  final dynamic? state;
  @JsonKey(name: "postCode")
  final dynamic? postCode;
  @JsonKey(name: "differentMailingAddress")
  final dynamic? differentMailingAddress;
  @JsonKey(name: "taxPayer")
  final dynamic? taxPayer;
  @JsonKey(name: "usTaxIdNo")
  final dynamic? usTaxIdNo;
  @JsonKey(name: "claimTaxTreatBenefits")
  final dynamic? claimTaxTreatBenefits;
  @JsonKey(name: "beneficialOwnerResident")
  final dynamic? beneficialOwnerResident;
  @JsonKey(name: "usTaxpayerIdNoOwner")
  final dynamic? usTaxpayerIdNoOwner;
  @JsonKey(name: "typeOfIncome")
  final dynamic? typeOfIncome;
  @JsonKey(name: "explanation")
  final dynamic? explanation;
  @JsonKey(name: "businessName")
  final dynamic? businessName;
  @JsonKey(name: "usAddress")
  final dynamic? usAddress;
  @JsonKey(name: "accountNo")
  final dynamic? accountNo;
  @JsonKey(name: "exemptPayeeCode")
  final dynamic? exemptPayeeCode;
  @JsonKey(name: "socialSecurityNo")
  final dynamic? socialSecurityNo;
  @JsonKey(name: "createBy")
  final String? createBy;
  @JsonKey(name: "createTime")
  final DateTime? createTime;
  @JsonKey(name: "createTerminal")
  final String? createTerminal;
  @JsonKey(name: "taxResidenceCountry")
  final String? taxResidenceCountry;

  FatcaCrsEntity({this.id,
    this.userId,
    this.companyId,
    this.productId,
    this.accountId,
    this.response1,
    this.response2,
    this.response3,
    this.response4,
    this.response5,
    this.relationshipWithPep,
    this.personName,
    this.personRole,
    this.namePerIncomeTaxReturn,
    this.dob,
    this.citizenShipCountry,
    this.permanentResidenceAddress,
    this.country,
    this.city,
    this.state,
    this.postCode,
    this.differentMailingAddress,
    this.taxPayer,
    this.usTaxIdNo,
    this.claimTaxTreatBenefits,
    this.beneficialOwnerResident,
    this.usTaxpayerIdNoOwner,
    this.typeOfIncome,
    this.explanation,
    this.businessName,
    this.usAddress,
    this.accountNo,
    this.exemptPayeeCode,
    this.socialSecurityNo,
    this.createBy,
    this.createTime,
    this.createTerminal,
    this.taxResidenceCountry});

  factory FatcaCrsEntity.fromJson(Map<String, dynamic> json) =>
      _$FatcaCrsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FatcaCrsEntityToJson(this);

  @override
  FatcaCrsEntity restore(FatcaCrsInfo data) {
    return FatcaCrsEntity(
        id: data.id,
        companyId: data.companyId,
        city: data.city,
        explanation: data.explanation,
        typeOfIncome: data.typeOfIncome,
        accountId: data.accountId,
        accountNo: data.accountNo,
        beneficialOwnerResident: data.beneficialOwnerResident,
        businessName: data.businessName,
        userId: data.userId,
        dob: data.dob,
        country: data.country,
        exemptPayeeCode: data.exemptPayeeCode,
        postCode: data.postCode,
        personRole: data.personRole,
        personName: data.personName,
        citizenShipCountry: data.citizenShipCountry,
        claimTaxTreatBenefits: data.claimTaxTreatBenefits,
        createBy: data.createBy,
        createTerminal: data.createTerminal,
        createTime: data.createTime,
        differentMailingAddress: data.differentMailingAddress,
        namePerIncomeTaxReturn: data.namePerIncomeTaxReturn,
        permanentResidenceAddress: data.permanentResidenceAddress,
        productId: data.productId,
        relationshipWithPep: data.relationshipWithPep,
        response1: data.response1,
        response2: data.response2,
        response3: data.response3,
        response4: data.response4,
        response5: data.response5,
        socialSecurityNo: data.socialSecurityNo,
        state: data.state,
        taxPayer: data.taxPayer,
        taxResidenceCountry: data.taxResidenceCountry,
        usAddress: data.usAddress,
        usTaxIdNo: data.usTaxIdNo,
        usTaxpayerIdNoOwner: data.usTaxpayerIdNoOwner);
  }

  @override
  FatcaCrsInfo transform() {
    return FatcaCrsInfo(
        id: this.id,
        companyId: this.companyId,
        city: this.city,
        explanation: this.explanation,
        typeOfIncome: this.typeOfIncome,
        accountId: this.accountId,
        accountNo: this.accountNo,
        beneficialOwnerResident: this.beneficialOwnerResident,
        businessName: this.businessName,
        userId: this.userId,
        dob: this.dob,
        country: this.country,
        exemptPayeeCode: this.exemptPayeeCode,
        postCode: this.postCode,
        personRole: this.personRole,
        personName: this.personName,
        citizenShipCountry: this.citizenShipCountry,
        claimTaxTreatBenefits: this.claimTaxTreatBenefits,
        createBy: this.createBy,
        createTerminal: this.createTerminal,
        createTime: this.createTime,
        differentMailingAddress: this.differentMailingAddress,
        namePerIncomeTaxReturn: this.namePerIncomeTaxReturn,
        permanentResidenceAddress: this.permanentResidenceAddress,
        productId: this.productId,
        relationshipWithPep: this.relationshipWithPep,
        response1: this.response1,
        response2: this.response2,
        response3: this.response3,
        response4: this.response4,
        response5: this.response5,
        socialSecurityNo: this.socialSecurityNo,
        state: this.state,
        taxPayer: this.taxPayer,
        taxResidenceCountry: this.taxResidenceCountry,
        usAddress: this.usAddress,
        usTaxIdNo: this.usTaxIdNo,
        usTaxpayerIdNoOwner: this.usTaxpayerIdNoOwner);
  }
}
