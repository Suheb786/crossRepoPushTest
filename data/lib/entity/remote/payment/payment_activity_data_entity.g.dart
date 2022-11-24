// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_activity_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentActivityDataEntity _$PaymentActivityDataEntityFromJson(Map<String, dynamic> json) {
  return PaymentActivityDataEntity(
    name: json['name'] as String?,
    amount: (json['amount'] as num?)?.toDouble(),
    status: json['status'] as String?,
    rtpDate: json['rtpDate'] == null ? null : DateTime.parse(json['rtpDate'] as String),
    profileImage: json['profileImage'] as String?,
  );
}

Map<String, dynamic> _$PaymentActivityDataEntityToJson(PaymentActivityDataEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'profileImage': instance.profileImage,
      'status': instance.status,
      'rtpDate': instance.rtpDate?.toIso8601String(),
    };
