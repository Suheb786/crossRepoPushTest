// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_card_in_process_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCardInProcessRequestEntity _$GetCardInProcessRequestEntityFromJson(Map<String, dynamic> json) =>
    GetCardInProcessRequestEntity(
      baseData: json['BaseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
      minimumSettlement: json['MinimumSettlement'] as String? ?? "",
      loanValueId: json['LoanValueId'] as num? ?? 0,
      nickName: json['NickName'] as String? ?? "",
      creditLimit: json['CreditLimit'] as num? ?? 0,
    );

Map<String, dynamic> _$GetCardInProcessRequestEntityToJson(GetCardInProcessRequestEntity instance) =>
    <String, dynamic>{
      'MinimumSettlement': instance.minimumSettlement,
      'NickName': instance.nickName,
      'LoanValueId': instance.loanValueId,
      'CreditLimit': instance.creditLimit,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
