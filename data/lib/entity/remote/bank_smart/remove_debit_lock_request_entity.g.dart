// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_debit_lock_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveDebitLockRequestEntity _$RemoveDebitLockRequestEntityFromJson(
    Map<String, dynamic> json) {
  return RemoveDebitLockRequestEntity(
    getToken: json['GetToken'] as bool?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$RemoveDebitLockRequestEntityToJson(
    RemoveDebitLockRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
