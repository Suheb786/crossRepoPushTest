// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_my_number_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeMyNumberRequestEntity _$ChangeMyNumberRequestEntityFromJson(
    Map<String, dynamic> json) {
  return ChangeMyNumberRequestEntity(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    mobileNo: json['MobileNo'] as String?,
  );
}

Map<String, dynamic> _$ChangeMyNumberRequestEntityToJson(
        ChangeMyNumberRequestEntity instance) =>
    <String, dynamic>{
      'MobileNo': instance.mobileNo,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
