// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_transaction_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardTransactionEntity _$CardTransactionEntityFromJson(
        Map<String, dynamic> json) =>
    CardTransactionEntity(
      date: json['label'] as String?,
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => TransactionEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardTransactionEntityToJson(
        CardTransactionEntity instance) =>
    <String, dynamic>{
      'label': instance.date,
      'transactions': instance.transactions,
    };
