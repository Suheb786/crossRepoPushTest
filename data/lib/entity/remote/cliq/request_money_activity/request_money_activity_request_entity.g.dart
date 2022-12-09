// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_money_activity_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMoneyActivityRequestEntity _$RequestMoneyActivityRequestEntityFromJson(
    Map<String, dynamic> json) {
  return RequestMoneyActivityRequestEntity(
    getToken: json['getToken'] as bool,
    baseClass: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$RequestMoneyActivityRequestEntityToJson(
        RequestMoneyActivityRequestEntity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'baseClass': instance.baseClass,
    };
