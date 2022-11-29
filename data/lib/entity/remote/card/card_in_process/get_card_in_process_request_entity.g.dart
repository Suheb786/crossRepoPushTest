// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_card_in_process_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCardInProcessRequestEntity _$GetCardInProcessRequestEntityFromJson(Map<String, dynamic> json) {
  return GetCardInProcessRequestEntity(
    baseData: json['BaseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    minimumSettlement: json['MinimumSettlement'] as String?,
    loanValueId: json['LoanValueId'] as num?,
    nickName: json['NickName'] as String?,
    creditLimit: json['CreditLimit'] as num?,
  );
}

Map<String, dynamic> _$GetCardInProcessRequestEntityToJson(GetCardInProcessRequestEntity instance) =>
    <String, dynamic>{
      'MinimumSettlement': instance.minimumSettlement,
      'NickName': instance.nickName,
      'LoanValueId': instance.loanValueId,
      'CreditLimit': instance.creditLimit,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
