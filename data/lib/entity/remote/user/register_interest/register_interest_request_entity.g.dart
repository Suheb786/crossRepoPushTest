// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_interest_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterInterestRequestEntity _$RegisterInterestRequestEntityFromJson(Map<String, dynamic> json) =>
    RegisterInterestRequestEntity(
      uniqueId: json['UniqueId'] as String?,
      email: json['Email'] as String?,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$RegisterInterestRequestEntityToJson(RegisterInterestRequestEntity instance) =>
    <String, dynamic>{
      'UniqueId': instance.uniqueId,
      'Email': instance.email,
      'baseClass': instance.baseData,
    };
