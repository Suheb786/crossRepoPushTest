// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_income.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalIncome _$AdditionalIncomeFromJson(Map<String, dynamic> json) {
  return AdditionalIncome(
    additionalIncomeSource: json['AdditionalIncomeSource'] as String?,
    totalIncome: json['TotalIncome'] as String?,
  );
}

Map<String, dynamic> _$AdditionalIncomeToJson(AdditionalIncome instance) =>
    <String, dynamic>{
      'AdditionalIncomeSource': instance.additionalIncomeSource,
      'TotalIncome': instance.totalIncome,
    };
