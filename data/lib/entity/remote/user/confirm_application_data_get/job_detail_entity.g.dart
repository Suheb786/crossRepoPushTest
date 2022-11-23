// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobDetailEntity _$JobDetailEntityFromJson(Map<String, dynamic> json) {
  return JobDetailEntity(
    additionalIncomeList: (json['additionalInfos1'] as List<dynamic>?)
        ?.map((e) => AdditionalIncomeEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
    jobDetailContent: json['jobDetail1'] == null
        ? null
        : JobDetailContentEntity.fromJson(json['jobDetail1'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$JobDetailEntityToJson(JobDetailEntity instance) => <String, dynamic>{
      'additionalInfos1': instance.additionalIncomeList,
      'jobDetail1': instance.jobDetailContent,
    };
