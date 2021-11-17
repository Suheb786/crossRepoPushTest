// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserRequest _$LoginUserRequestFromJson(Map<String, dynamic> json) {
  return LoginUserRequest(
    email: json['email'] as String?,
    password: json['password'] as String?,
    baseData:
        BaseClassEntity.fromJson(json['baseClass'] as Map<String, dynamic>),
    getToken: json['GetToken'] as bool?,
    platform: json['Platform'] as String?,
    uniqueId: json['UniqueId'] as String?,
    fireBaseToken: json['FireBaseToken'] as String?,
  );
}

Map<String, dynamic> _$LoginUserRequestToJson(LoginUserRequest instance) =>
    <String, dynamic>{
      'UniqueId': instance.uniqueId,
      'GetToken': instance.getToken,
      'Platform': instance.platform,
      'FireBaseToken': instance.fireBaseToken,
      'email': instance.email,
      'password': instance.password,
      'baseClass': instance.baseData,
    };
