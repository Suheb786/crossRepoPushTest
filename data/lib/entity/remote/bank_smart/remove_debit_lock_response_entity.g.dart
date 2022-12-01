// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_debit_lock_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveDebitLockResponseEntity _$RemoveDebitLockResponseEntityFromJson(
    Map<String, dynamic> json) {
  return RemoveDebitLockResponseEntity(
    response: json['response'] == null
        ? null
        : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RemoveDebitLockResponseEntityToJson(
        RemoveDebitLockResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
