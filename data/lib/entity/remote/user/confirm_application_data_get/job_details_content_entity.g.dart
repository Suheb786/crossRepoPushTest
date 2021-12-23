// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_details_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobDetailContentEntity _$JobDetailContentEntityFromJson(
    Map<String, dynamic> json) {
  return JobDetailContentEntity(
    id: json['id'] as int?,
    userId: json['userId'] as String?,
    profession: json['profession'] as String?,
    mainSource: json['mainSource'] as String?,
    annualIncome: json['annualIncome'] as String?,
    employeeName: json['employeeName'] as String?,
    employerCountry: json['employerCountry'] as String?,
    employerCity: json['employerCity'] as String?,
    employerContact: json['employerContact'] as String?,
    createdOn: json['createdOn'] == null
        ? null
        : DateTime.parse(json['createdOn'] as String),
    additionalIncome: json['additionalIncome'] as bool?,
    isActive: json['isActive'] as bool?,
  );
}

Map<String, dynamic> _$JobDetailContentEntityToJson(
        JobDetailContentEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'profession': instance.profession,
      'mainSource': instance.mainSource,
      'annualIncome': instance.annualIncome,
      'employeeName': instance.employeeName,
      'employerCountry': instance.employerCountry,
      'employerCity': instance.employerCity,
      'employerContact': instance.employerContact,
      'createdOn': instance.createdOn?.toIso8601String(),
      'additionalIncome': instance.additionalIncome,
      'isActive': instance.isActive,
    };
