// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_status_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KYCStatusRequest _$KYCStatusRequestFromJson(Map<String, dynamic> json) =>
    KYCStatusRequest(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
    );

Map<String, dynamic> _$KYCStatusRequestToJson(KYCStatusRequest instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
