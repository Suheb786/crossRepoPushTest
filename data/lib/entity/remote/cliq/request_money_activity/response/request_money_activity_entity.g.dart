// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_money_activity_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestMoneyActivityEntity _$RequestMoneyActivityEntityFromJson(Map<String, dynamic> json) =>
    RequestMoneyActivityEntity(
      requestMoneyActivities: (json['requestMoneyActivities'] as List<dynamic>?)
          ?.map((e) => RequestMoneyActivityListEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RequestMoneyActivityEntityToJson(RequestMoneyActivityEntity instance) =>
    <String, dynamic>{
      'requestMoneyActivities': instance.requestMoneyActivities,
    };
