// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_transaction_history_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryTransactionHistoryContentEntity
    _$BeneficiaryTransactionHistoryContentEntityFromJson(
            Map<String, dynamic> json) =>
        BeneficiaryTransactionHistoryContentEntity(
          date: json['date'] as String? ?? '',
          data: (json['data'] as List<dynamic>?)
                  ?.map((e) => BeneficiaryTransactionHistoryEntity.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$BeneficiaryTransactionHistoryContentEntityToJson(
        BeneficiaryTransactionHistoryContentEntity instance) =>
    <String, dynamic>{
      'date': instance.date,
      'data': instance.data,
    };
