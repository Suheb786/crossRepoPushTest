// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_forget_password_otp_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyForgetPasswordOtpRequestEntity
    _$VerifyForgetPasswordOtpRequestEntityFromJson(Map<String, dynamic> json) {
  return VerifyForgetPasswordOtpRequestEntity(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    getToken: json['getToken'] as bool?,
    email: json['Email'] as String?,
    idExpiry: json['IdExpiry'] as String?,
    idNo: json['Idno'] as String?,
    reEnterPassword: json['ReEnterPassword'] as String?,
    password: json['Password'] as String?,
    otp: json['Otp'] as String?,
    uniqueId: json['UniqueId'] as String?,
  );
}

Map<String, dynamic> _$VerifyForgetPasswordOtpRequestEntityToJson(
        VerifyForgetPasswordOtpRequestEntity instance) =>
    <String, dynamic>{
      'UniqueId': instance.uniqueId,
      'getToken': instance.getToken,
      'Email': instance.email,
      'Idno': instance.idNo,
      'IdExpiry': instance.idExpiry,
      'Password': instance.password,
      'ReEnterPassword': instance.reEnterPassword,
      'Otp': instance.otp,
      'BaseClass': instance.baseData,
    };
