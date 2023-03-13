// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_money_activity_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMoneyActivityRequestEntity _$RequestMoneyActivityRequestEntityFromJson(
    Map<String, dynamic> json) {
  return RequestMoneyActivityRequestEntity(
    FilterDays: json['FilterDays'] as int,
    TransactionType: json['TransactionType'] as String,
    getToken: json['GetToken'] as bool,
    baseClass: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$RequestMoneyActivityRequestEntityToJson(
        RequestMoneyActivityRequestEntity instance) =>
    <String, dynamic>{
      'FilterDays': instance.FilterDays,
      'TransactionType': instance.TransactionType,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseClass,
    };
