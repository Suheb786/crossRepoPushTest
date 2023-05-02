// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_job_info_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveJobInfoRequest _$SaveJobInfoRequestFromJson(Map<String, dynamic> json) =>
    SaveJobInfoRequest(
      employeeName: json['EmployeeName'] as String?,
      occupation: json['Occupation'] as String?,
      annualIncome: json['AnnualIncome'] as String?,
      employerCountries: json['EmployerCountries'] as String?,
      employerCity: json['EmployerCity'] as String?,
      employerContact: json['EmployerContact'] as String?,
      additionalIncomes: json['AdditionalIncomes'] as bool?,
      mainSource: json['MainSource'] as String?,
      businessType: json['BusinessType'] as String?,
      additionalIncome: (json['AdditionalIncome'] as List<dynamic>?)
          ?.map((e) => AdditionalIncome.fromJson(e as Map<String, dynamic>))
          .toList(),
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$SaveJobInfoRequestToJson(SaveJobInfoRequest instance) =>
    <String, dynamic>{
      'EmployeeName': instance.employeeName,
      'Occupation': instance.occupation,
      'BusinessType': instance.businessType,
      'AnnualIncome': instance.annualIncome,
      'EmployerCountries': instance.employerCountries,
      'EmployerCity': instance.employerCity,
      'EmployerContact': instance.employerContact,
      'AdditionalIncomes': instance.additionalIncomes,
      'MainSource': instance.mainSource,
      'AdditionalIncome': instance.additionalIncome,
      'baseClass': instance.baseData,
    };
