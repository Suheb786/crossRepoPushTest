// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_loan_values_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLoanValuesContentEntity _$GetLoanValuesContentEntityFromJson(Map<String, dynamic> json) {
  return GetLoanValuesContentEntity(
    maxLimit: json['maxLimit'] as num?,
    loanValueId: json['loanValueId'] as num?,
    minimumLimit: json['minimumLimit'] as String?,
    step: json['step'] as String?,
  );
}

Map<String, dynamic> _$GetLoanValuesContentEntityToJson(GetLoanValuesContentEntity instance) =>
    <String, dynamic>{
      'loanValueId': instance.loanValueId,
      'minimumLimit': instance.minimumLimit,
      'step': instance.step,
      'maxLimit': instance.maxLimit,
    };
