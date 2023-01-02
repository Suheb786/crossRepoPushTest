// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biller_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillerListEntity _$BillerListEntityFromJson(Map<String, dynamic> json) {
  return BillerListEntity(
    billerName: json['billerName'] as String?,
    billerNameAR: json['billerNameAR'] as String?,
    totalAmount: json['totalAmount'] as String?,
    refNo: json['refNo'] as String?,
    date: json['date'] as String?,
    isPaid: json['isPaid'] as bool?,
    statusDescription: json['statusDescription'] as String?,
  );
}

Map<String, dynamic> _$BillerListEntityToJson(BillerListEntity instance) =>
    <String, dynamic>{
      'billerName': instance.billerName,
      'billerNameAR': instance.billerNameAR,
      'totalAmount': instance.totalAmount,
      'refNo': instance.refNo,
      'date': instance.date,
      'isPaid': instance.isPaid,
      'statusDescription': instance.statusDescription,
    };
