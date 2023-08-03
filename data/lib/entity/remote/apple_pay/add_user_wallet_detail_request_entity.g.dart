// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_user_wallet_detail_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddUserWalletDetailRequestEntity _$AddUserWalletDetailRequestEntityFromJson(Map<String, dynamic> json) =>
    AddUserWalletDetailRequestEntity(
      getToken: json['GetToken'] as bool? ?? true,
      walletId: json['WalletId'] as String? ?? "",
      entrustWalletId: json['EntrustWalletId'] as String? ?? "",
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$AddUserWalletDetailRequestEntityToJson(AddUserWalletDetailRequestEntity instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'WalletId': instance.walletId,
      'EntrustWalletId': instance.entrustWalletId,
      'baseClass': instance.baseData,
    };
