// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_postpaid_biller_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPostpaidBillerListEntity _$GetPostpaidBillerListEntityFromJson(
        Map<String, dynamic> json) =>
    GetPostpaidBillerListEntity(
      billList: (json['billList'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$GetPostpaidBillerListEntityToJson(
        GetPostpaidBillerListEntity instance) =>
    <String, dynamic>{
      'billList': instance.billList,
    };
