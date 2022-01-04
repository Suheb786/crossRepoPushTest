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
  );
}

Map<String, dynamic> _$DashboardDebitCardEntityToJson(
        DashboardDebitCardEntity instance) =>
    <String, dynamic>{
      'accountTitle': instance.accountTitle,
      'cardNumber': instance.cardNumber,
      'linkedAccountNumber': instance.linkedAccountNumber,
      'expiryDate': instance.expiryDate,
      'cvv': instance.cvv,
    };
