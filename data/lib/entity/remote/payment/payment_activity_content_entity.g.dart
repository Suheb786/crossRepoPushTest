// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_activity_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentActivityContentEntity _$PaymentActivityContentEntityFromJson(Map<String, dynamic> json) {
  return PaymentActivityContentEntity(
    rtpDate: json['rtpDate'] == null ? null : DateTime.parse(json['rtpDate'] as String),
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => PaymentActivityDataEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$PaymentActivityContentEntityToJson(PaymentActivityContentEntity instance) =>
    <String, dynamic>{
      'rtpDate': instance.rtpDate?.toIso8601String(),
      'data': instance.data,
    };
