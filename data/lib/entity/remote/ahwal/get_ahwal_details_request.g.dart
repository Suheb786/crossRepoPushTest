// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ahwal_details_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAhwalDetailsRequest _$GetAhwalDetailsRequestFromJson(Map<String, dynamic> json) {
  return GetAhwalDetailsRequest(
    idNo: json['IdNo'] as String?,
    baseData: json['baseClass'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$GetAhwalDetailsRequestToJson(GetAhwalDetailsRequest instance) => <String, dynamic>{
      'IdNo': instance.idNo,
      'baseClass': instance.baseData,
    };
