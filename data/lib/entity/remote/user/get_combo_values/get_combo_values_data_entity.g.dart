// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_combo_values_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetComboValuesDataEntity _$GetComboValuesDataEntityFromJson(Map<String, dynamic> json) =>
    GetComboValuesDataEntity(
      id: json['id'] as int?,
      type: json['type'] as String?,
      intCode: json['intCode'] as int?,
      strCode: json['strCode'] as String?,
      labelEn: json['labelEn'] as String?,
      labelAr: json['labelAr'] as String?,
      ageGroup: json['ageGroup'] as String?,
      orderNo: json['orderNo'] as int?,
    );

Map<String, dynamic> _$GetComboValuesDataEntityToJson(GetComboValuesDataEntity instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'intCode': instance.intCode,
      'strCode': instance.strCode,
      'labelEn': instance.labelEn,
      'labelAr': instance.labelAr,
      'ageGroup': instance.ageGroup,
      'orderNo': instance.orderNo,
    };
