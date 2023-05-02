// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordRequest _$ChangePasswordRequestFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordRequest(
      currentPassword: json['Password'] as String? ?? "",
      newPassword: json['NewPassword'] as String? ?? "",
      confirmPassword: json['ConfirmPassword'] as String? ?? "",
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ChangePasswordRequestToJson(
        ChangePasswordRequest instance) =>
    <String, dynamic>{
      'Password': instance.currentPassword,
      'NewPassword': instance.newPassword,
      'ConfirmPassword': instance.confirmPassword,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
