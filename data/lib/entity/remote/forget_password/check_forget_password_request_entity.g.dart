// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_forget_password_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckForgetPasswordRequestEntity _$CheckForgetPasswordRequestEntityFromJson(Map<String, dynamic> json) {
  return CheckForgetPasswordRequestEntity(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    getToken: json['getToken'] as bool?,
    email: json['Email'] as String?,
    idExpiry: json['IdExpiry'] as String?,
    idNo: json['Idno'] as String?,
    uniqueId: json['UniqueId'] as String?,
  );
}

Map<String, dynamic> _$CheckForgetPasswordRequestEntityToJson(CheckForgetPasswordRequestEntity instance) =>
    <String, dynamic>{
      'UniqueId': instance.uniqueId,
      'getToken': instance.getToken,
      'Email': instance.email,
      'Idno': instance.idNo,
      'IdExpiry': instance.idExpiry,
      'BaseClass': instance.baseData,
    };
