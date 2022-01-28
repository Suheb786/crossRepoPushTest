// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_status_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerStatusEntity _$CustomerStatusEntityFromJson(Map<String, dynamic> json) {
  return CustomerStatusEntity(
    nextScreen: json['nextScreen'] as String?,
    secondNextScreen: json['secondNextScreen'] as String?,
    applicationId: json['applicationId'] as String?,
  );
}

Map<String, dynamic> _$CustomerStatusEntityToJson(
        CustomerStatusEntity instance) =>
    <String, dynamic>{
      'nextScreen': instance.nextScreen,
      'secondNextScreen': instance.secondNextScreen,
      'applicationId': instance.applicationId,
    };
