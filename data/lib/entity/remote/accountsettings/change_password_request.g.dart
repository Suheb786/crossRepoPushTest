// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordRequest _$ChangePasswordRequestFromJson(
    Map<String, dynamic> json) {
  return ChangePasswordRequest(
    currentPassword: json['Password'] as String,
    newPassword: json['NewPassword'] as String,
    confirmPassword: json['ConfirmPassword'] as String,
    getToken: json['GetToken'] as bool,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ChangePasswordRequestToJson(
        ChangePasswordRequest instance) =>
    <String, dynamic>{
      'Password': instance.currentPassword,
      'NewPassword': instance.newPassword,
      'ConfirmPassword': instance.confirmPassword,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
