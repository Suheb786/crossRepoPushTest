// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_by_alias_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountByAliasContentEntity _$GetAccountByAliasContentEntityFromJson(Map<String, dynamic> json) =>
    GetAccountByAliasContentEntity(
      acciban: json['acciban'] as String?,
      bic: json['bic'] as String?,
      currency: json['currency'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      nickName: json['nickName'] as String?,
      addressCity: json['addressCity'] as String?,
      addressCountry: json['addressCountry'] as String?,
      addressSPR: json['addressSPR'] as String?,
      address: json['address'] as String?,
      detCustomerType: json['detCustomerType'] as String?,
    );

Map<String, dynamic> _$GetAccountByAliasContentEntityToJson(GetAccountByAliasContentEntity instance) =>
    <String, dynamic>{
      'acciban': instance.acciban,
      'bic': instance.bic,
      'currency': instance.currency,
      'type': instance.type,
      'name': instance.name,
      'surname': instance.surname,
      'nickName': instance.nickName,
      'addressCity': instance.addressCity,
      'addressCountry': instance.addressCountry,
      'addressSPR': instance.addressSPR,
      'address': instance.address,
      'detCustomerType': instance.detCustomerType,
    };
