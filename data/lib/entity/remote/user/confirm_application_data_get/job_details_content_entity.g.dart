// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_details_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobDetailContentEntity _$JobDetailContentEntityFromJson(
        Map<String, dynamic> json) =>
    JobDetailContentEntity(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      profession: json['profession'] as String?,
      mainSource: json['mainSource'] as String?,
      annualIncome: json['annualIncome'] as String?,
      employeeName: json['employeeName'] as String?,
      employerCountry: json['employerCountry'] as String?,
      employerCity: json['employerCity'] as String?,
      employerCityAr: json['employerCityAr'] as String?,
      employerContact: json['employerContact'] as String?,
      createdOn: json['createdOn'] == null
          ? null
          : DateTime.parse(json['createdOn'] as String),
      additionalIncome: json['additionalIncome'] as bool?,
      isActive: json['isActive'] as bool?,
      occupation: json['occupation'] as String?,
      businessType: json['businessType'] as String?,
      businessSpecificType: json['businessSpecificType'] as String?,
      employerCountryAr: json['employerCountryAr'] as String?,
      businessTypeAr: json['businessTypeAr'] as String?,
      employeeCityId: json['employeeCityId'] as String?,
    );

Map<String, dynamic> _$JobDetailContentEntityToJson(
        JobDetailContentEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'profession': instance.profession,
      'occupation': instance.occupation,
      'businessType': instance.businessType,
      'businessTypeAr': instance.businessTypeAr,
      'businessSpecificType': instance.businessSpecificType,
      'mainSource': instance.mainSource,
      'annualIncome': instance.annualIncome,
      'employeeCityId': instance.employeeCityId,
      'employeeName': instance.employeeName,
      'employerCountry': instance.employerCountry,
      'employerCountryAr': instance.employerCountryAr,
      'employerCity': instance.employerCity,
      'employerCityAr': instance.employerCityAr,
      'employerContact': instance.employerContact,
      'createdOn': instance.createdOn?.toIso8601String(),
      'additionalIncome': instance.additionalIncome,
      'isActive': instance.isActive,
    };
