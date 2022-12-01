// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_income_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalIncomeEntity _$AdditionalIncomeEntityFromJson(
    Map<String, dynamic> json) {
  return AdditionalIncomeEntity(
    id: json['id'] as int?,
    userId: json['userId'] as String?,
    additionalIncomeSource: json['additionalIncomeSource'] as String?,
    totalIncome: json['totalIncome'] as String?,
    createdOn: json['createdOn'] == null
        ? null
        : DateTime.parse(json['createdOn'] as String),
    additionalIncomeSourceAr: json['additionalIncomeSourceAr'] as String?,
  );
}

Map<String, dynamic> _$AdditionalIncomeEntityToJson(
        AdditionalIncomeEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'additionalIncomeSource': instance.additionalIncomeSource,
      'additionalIncomeSourceAr': instance.additionalIncomeSourceAr,
      'totalIncome': instance.totalIncome,
      'createdOn': instance.createdOn?.toIso8601String(),
    };
