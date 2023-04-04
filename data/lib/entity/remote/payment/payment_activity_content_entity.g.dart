// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_activity_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentActivityContentEntity _$PaymentActivityContentEntityFromJson(Map<String, dynamic> json) {
  return PaymentActivityContentEntity(
    activityDate: json['activityDate'] == null ? null : DateTime.parse(json['activityDate'] as String),
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => RequestMoneyActivityListEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PaymentActivityContentEntityToJson(PaymentActivityContentEntity instance) =>
    <String, dynamic>{
      'activityDate': instance.activityDate?.toIso8601String(),
      'data': instance.data,
    };
