// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_prepaid_biller_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemovePrepaidBillerRequest _$RemovePrepaidBillerRequestFromJson(
    Map<String, dynamic> json) {
  return RemovePrepaidBillerRequest(
    registrationID: json['registrationID'] as String?,
    getToken: json['GetToken'] as bool?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$RemovePrepaidBillerRequestToJson(
        RemovePrepaidBillerRequest instance) =>
    <String, dynamic>{
      'registrationID': instance.registrationID,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
