// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionEntity _$TransactionEntityFromJson(Map<String, dynamic> json) {
  return TransactionEntity(
    id: json['id'] as int?,
    description: json['description'] as String?,
    transactionTime:
        json['time'] == null ? null : DateTime.parse(json['time'] as String),
    amount: json['amount'] as num?,
  );
}

Map<String, dynamic> _$TransactionEntityToJson(TransactionEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'time': instance.transactionTime?.toIso8601String(),
      'amount': instance.amount,
    };
