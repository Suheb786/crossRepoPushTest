// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateDataEntity _$StateDataEntityFromJson(Map<String, dynamic> json) {
  return StateDataEntity(
    createTime: json['createTime'] == null
        ? null
        : DateTime.parse(json['createTime'] as String),
    countryID: json['countryID'] as String?,
    stateID: json['stateID'] as String?,
    stateName: json['stateName'] as String?,
  );
}

Map<String, dynamic> _$StateDataEntityToJson(StateDataEntity instance) =>
    <String, dynamic>{
      'createTime': instance.createTime?.toIso8601String(),
      'countryID': instance.countryID,
      'stateID': instance.stateID,
      'stateName': instance.stateName,
    };
