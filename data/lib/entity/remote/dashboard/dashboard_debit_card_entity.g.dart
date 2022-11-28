// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_debit_card_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardDebitCardEntity _$DashboardDebitCardEntityFromJson(
    Map<String, dynamic> json) {
  return DashboardDebitCardEntity(
    accountTitle: json['accountTitle'] as String?,
    cvv: json['cvv'] as String?,
    expiryDate: json['expiryDate'] as String?,
    cardNumber: json['cardNumber'] as String?,
    linkedAccountNumber: json['linkedAccountNumber'] as String?,
    debitDeliveredDatetime: json['debitDeliveredDatetime'],
    isDebitDelivered: json['isDebitDelivered'] as bool?,
    debitCardActivated: json['debitCardActivated'] == null
        ? null
        : DateTime.parse(json['debitCardActivated'] as String),
    cardStatus: json['cardStatus'] as String?,
    code: json['code'] as String?,
    primarySecondaryCard: json['primarySecondaryCard'] as String?,
    isPINSet: json['isPINSet'] as bool?,
    isPhysicalDebitCardRequested: json['isPhysicalDebitCardRequested'] as bool?,
  );
}

Map<String, dynamic> _$DashboardDebitCardEntityToJson(
        DashboardDebitCardEntity instance) =>
    <String, dynamic>{
      'accountTitle': instance.accountTitle,
      'cardStatus': instance.cardStatus,
      'code': instance.code,
      'cardNumber': instance.cardNumber,
      'linkedAccountNumber': instance.linkedAccountNumber,
      'expiryDate': instance.expiryDate,
      'cvv': instance.cvv,
      'isDebitDelivered': instance.isDebitDelivered,
      'debitDeliveredDatetime': instance.debitDeliveredDatetime,
      'debitCardActivated': instance.debitCardActivated?.toIso8601String(),
      'primarySecondaryCard': instance.primarySecondaryCard,
      'isPINSet': instance.isPINSet,
      'isPhysicalDebitCardRequested': instance.isPhysicalDebitCardRequested,
    };
