// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordRequestEntity _$ForgetPasswordRequestEntityFromJson(Map<String, dynamic> json) =>
    ForgetPasswordRequestEntity(
      baseData: json['BaseClass'] as Map<String, dynamic>,
      getToken: json['getToken'] as bool? ?? true,
      email: json['Email'] as String?,
      idExpiry: json['IdExpiry'] as String?,
      idNo: json['Idno'] as String?,
      password: json['Password'] as String?,
      reEnterPassword: json['ReEnterPassword'] as String?,
      uniqueId: json['UniqueId'] as String? ?? "",
    );

Map<String, dynamic> _$ForgetPasswordRequestEntityToJson(ForgetPasswordRequestEntity instance) =>
    <String, dynamic>{
      'UniqueId': instance.uniqueId,
      'getToken': instance.getToken,
      'Email': instance.email,
      'Idno': instance.idNo,
      'IdExpiry': instance.idExpiry,
      'Password': instance.password,
      'ReEnterPassword': instance.reEnterPassword,
      'BaseClass': instance.baseData,
    };
