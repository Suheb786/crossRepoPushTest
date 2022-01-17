// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allowed_services_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllowedServicesEntity _$AllowedServicesEntityFromJson(
    Map<String, dynamic> json) {
  return AllowedServicesEntity(
    billPayment: json['billPayment'] as bool?,
    dashBoard: json['dashBoard'] as bool?,
    dashBoardStop: json['dashBoardStop'] as bool?,
    eidUpdate: json['eidUpdate'] as bool?,
    inter: json['inter'] as bool?,
    international: json['international'],
    intra: json['intra'] as bool?,
    showGraph: json['showGraph'] as bool?,
  );
}

Map<String, dynamic> _$AllowedServicesEntityToJson(
        AllowedServicesEntity instance) =>
    <String, dynamic>{
      'dashBoard': instance.dashBoard,
      'intra': instance.intra,
      'inter': instance.inter,
      'billPayment': instance.billPayment,
      'showGraph': instance.showGraph,
      'dashBoardStop': instance.dashBoardStop,
      'eidUpdate': instance.eidUpdate,
      'international': instance.international,
    };
