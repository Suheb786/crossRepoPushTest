// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardDataRequest _$DashboardDataRequestFromJson(Map<String, dynamic> json) {
  return DashboardDataRequest(
    baseData: json['baseClass'] as Map<String, dynamic>,
    accountId: json['AccountId'] as int,
    getToken: json['GetToken'] as bool,
  );
}

Map<String, dynamic> _$DashboardDataRequestToJson(DashboardDataRequest instance) => <String, dynamic>{
      'AccountId': instance.accountId,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
