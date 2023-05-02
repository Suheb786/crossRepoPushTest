// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_prepaid_biller_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPrepaidBillerListEntity _$GetPrepaidBillerListEntityFromJson(
        Map<String, dynamic> json) =>
    GetPrepaidBillerListEntity(
      billList: (json['result'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$GetPrepaidBillerListEntityToJson(
        GetPrepaidBillerListEntity instance) =>
    <String, dynamic>{
      'result': instance.billList,
    };
