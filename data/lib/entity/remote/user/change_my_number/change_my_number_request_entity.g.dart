// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_my_number_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeMyNumberRequestEntity _$ChangeMyNumberRequestEntityFromJson(
        Map<String, dynamic> json) =>
    ChangeMyNumberRequestEntity(
      baseData: json['BaseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
      mobileNo: json['MobileNumber'] as String?,
      mobileCode: json['MobileCode'] as String?,
    );

Map<String, dynamic> _$ChangeMyNumberRequestEntityToJson(
        ChangeMyNumberRequestEntity instance) =>
    <String, dynamic>{
      'MobileNumber': instance.mobileNo,
      'MobileCode': instance.mobileCode,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
