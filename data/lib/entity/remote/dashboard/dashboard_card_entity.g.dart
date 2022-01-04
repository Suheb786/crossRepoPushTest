// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_card_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardCardEntity _$DashboardCardEntityFromJson(Map<String, dynamic> json) {
  return DashboardCardEntity(
    name: json['name'] as String?,
    availableBalance: json['availableBalance'] as num?,
    minDue: json['minDue'] as num?,
    totalAmount: json['totalAmount'] as num?,
    cardNumber: json['cardNumber'] as String?,
    expiryDate: json['expiryDate'] as String?,
    maxLimit: json['maxLimit'] as num?,
    cvv: json['cvv'] as String?,
  );
}

Map<String, dynamic> _$DashboardCardEntityToJson(
        DashboardCardEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'availableBalance': instance.availableBalance,
      'minDue': instance.minDue,
      'totalAmount': instance.totalAmount,
      'cardNumber': instance.cardNumber,
      'expiryDate': instance.expiryDate,
      'cvv': instance.cvv,
      'maxLimit': instance.maxLimit,
    };
