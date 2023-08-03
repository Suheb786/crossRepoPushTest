// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserRequest _$LoginUserRequestFromJson(Map<String, dynamic> json) =>
    LoginUserRequest(
      userName: json['userName'] as String? ?? "",
      password: json['password'] as String? ?? "",
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['getToken'] as bool? ?? true,
      platform: json['platform'] as String? ?? "",
      uniqueId: json['uniqueId'] as String? ?? "",
      fireBaseToken: json['fireBaseToken'] as String? ?? "",
    );

Map<String, dynamic> _$LoginUserRequestToJson(LoginUserRequest instance) =>
    <String, dynamic>{
      'uniqueId': instance.uniqueId,
      'getToken': instance.getToken,
      'platform': instance.platform,
      'fireBaseToken': instance.fireBaseToken,
      'userName': instance.userName,
      'password': instance.password,
      'baseClass': instance.baseData,
    };
