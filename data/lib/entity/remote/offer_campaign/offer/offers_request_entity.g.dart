// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersRequestEntity _$OffersRequestEntityFromJson(Map<String, dynamic> json) =>
    OffersRequestEntity(
      baseData: json['BaseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
      categoryId: json['CategoryId'] as num,
      searchText: json['SearchText'] as String,
      pageNo: json['PageNo'] as int,
      totalRecord: json['TotalRecord'] as int,
    );

Map<String, dynamic> _$OffersRequestEntityToJson(
        OffersRequestEntity instance) =>
    <String, dynamic>{
      'CategoryId': instance.categoryId,
      'SearchText': instance.searchText,
      'PageNo': instance.pageNo,
      'TotalRecord': instance.totalRecord,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
