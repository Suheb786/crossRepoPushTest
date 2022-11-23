// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_call_status_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCallStatusRequest _$GetCallStatusRequestFromJson(Map<String, dynamic> json) {
  return GetCallStatusRequest(
    session: json['session'] as String?,
    baseData: json['BaseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$GetCallStatusRequestToJson(GetCallStatusRequest instance) => <String, dynamic>{
      'session': instance.session,
      'BaseClass': instance.baseData,
    };
