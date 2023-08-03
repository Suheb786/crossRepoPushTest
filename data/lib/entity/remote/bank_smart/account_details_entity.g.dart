// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_details_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDetailsEntity _$AccountDetailsEntityFromJson(
        Map<String, dynamic> json) =>
    AccountDetailsEntity(
      createBy: json['createBy'] as String?,
      ourBranchID: json['ourBranchID'] as String?,
      clientID: json['clientID'] as String?,
      productID: json['productID'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      countryID: json['countryID'] as String?,
      stateID: json['stateID'] as String?,
      cityID: json['cityID'] as String?,
      statementFrequency: json['statementFrequency'] as String?,
      holdMail: json['holdMail'] as int? ?? 0,
      zakatExemption: json['zakatExemption'] as int? ?? 0,
      introducerAccountNo: json['introducerAccountNo'] as String?,
      introducedBy: json['introducedBy'] as String?,
      introducerAddress: json['introducerAddress'] as String?,
      introducerCityID: json['introducerCityID'] as String?,
      introducerStateID: json['introducerStateID'] as String?,
      introducerCountryID: json['introducerCountryID'] as String?,
      modeOfOperation: json['modeOfOperation'] as String?,
      reminder: json['reminder'] as String?,
      notes: json['notes'] as String?,
      natureID: json['natureID'] as String?,
      relationshipCode: json['relationshipCode'] as String?,
      dontAllowDebitTran: json['dontAllowDebitTran'] as int? ?? 0,
      dontAllowCreditTran: json['dontAllowCreditTran'] as int? ?? 0,
      creditNeedsSupervision: json['creditNeedsSupervision'] as int? ?? 0,
      debitNeedsSupervision: json['debitNeedsSupervision'] as int? ?? 0,
      notServiceCharges: json['notServiceCharges'] as int? ?? 0,
      notStopPaymentCharges: json['notStopPaymentCharges'] as int? ?? 0,
      notChequeBookCharges: json['notChequeBookCharges'] as int? ?? 0,
      turnOver: json['turnOver'] as String?,
      noOfDrTrx: json['noOfDrTrx'] ?? 0,
      noOfCrTrx: json['noOfCrTrx'] ?? 0,
      drThresholdLimit: json['drThresholdLimit'] ?? 0,
      crThresholdLimit: json['crThresholdLimit'] ?? 0,
      productCash: json['productCash'] as int? ?? 0,
      productClearing: json['productClearing'] as int? ?? 0,
      productCollection: json['productCollection'] as int? ?? 0,
      productRemittance: json['productRemittance'] as int? ?? 0,
      productCross: json['productCross'] as int? ?? 0,
      productOthers: json['productOthers'] as int? ?? 0,
      productOthersDesc: json['productOthersDesc'] as String?,
      idType: json['idType'],
    );

Map<String, dynamic> _$AccountDetailsEntityToJson(
        AccountDetailsEntity instance) =>
    <String, dynamic>{
      'createBy': instance.createBy,
      'ourBranchID': instance.ourBranchID,
      'clientID': instance.clientID,
      'productID': instance.productID,
      'name': instance.name,
      'address': instance.address,
      'countryID': instance.countryID,
      'stateID': instance.stateID,
      'cityID': instance.cityID,
      'statementFrequency': instance.statementFrequency,
      'holdMail': instance.holdMail,
      'zakatExemption': instance.zakatExemption,
      'introducerAccountNo': instance.introducerAccountNo,
      'introducedBy': instance.introducedBy,
      'introducerAddress': instance.introducerAddress,
      'introducerCityID': instance.introducerCityID,
      'introducerStateID': instance.introducerStateID,
      'introducerCountryID': instance.introducerCountryID,
      'modeOfOperation': instance.modeOfOperation,
      'reminder': instance.reminder,
      'notes': instance.notes,
      'natureID': instance.natureID,
      'relationshipCode': instance.relationshipCode,
      'dontAllowCreditTran': instance.dontAllowCreditTran,
      'dontAllowDebitTran': instance.dontAllowDebitTran,
      'creditNeedsSupervision': instance.creditNeedsSupervision,
      'debitNeedsSupervision': instance.debitNeedsSupervision,
      'notServiceCharges': instance.notServiceCharges,
      'notStopPaymentCharges': instance.notStopPaymentCharges,
      'notChequeBookCharges': instance.notChequeBookCharges,
      'turnOver': instance.turnOver,
      'noOfDrTrx': instance.noOfDrTrx,
      'noOfCrTrx': instance.noOfCrTrx,
      'drThresholdLimit': instance.drThresholdLimit,
      'crThresholdLimit': instance.crThresholdLimit,
      'productCash': instance.productCash,
      'productClearing': instance.productClearing,
      'productCollection': instance.productCollection,
      'productRemittance': instance.productRemittance,
      'productCross': instance.productCross,
      'productOthers': instance.productOthers,
      'productOthersDesc': instance.productOthersDesc,
      'idType': instance.idType,
    };
