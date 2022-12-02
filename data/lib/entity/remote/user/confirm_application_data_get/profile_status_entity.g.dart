// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_status_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileStatusEntity _$ProfileStatusEntityFromJson(Map<String, dynamic> json) {
  return ProfileStatusEntity(
    id: json['id'] as int?,
    userId: json['userId'] as String?,
    employmentStatus: json['employmentStatus'] as String?,
    married: json['married'] as bool?,
    specialPerson: json['specialPerson'] as bool?,
    spouseName: json['spauseName'] as String?,
    natureSp: json['natureSP'] as String?,
    createdOn: json['createdOn'] == null
        ? null
        : DateTime.parse(json['createdOn'] as String),
    isActive: json['isActive'] as bool?,
    employmentStatusAr: json['employmentStatusAr'] as String?,
  );
}

Map<String, dynamic> _$ProfileStatusEntityToJson(
        ProfileStatusEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'employmentStatus': instance.employmentStatus,
      'employmentStatusAr': instance.employmentStatusAr,
      'married': instance.married,
      'specialPerson': instance.specialPerson,
      'spauseName': instance.spouseName,
      'natureSP': instance.natureSp,
      'createdOn': instance.createdOn?.toIso8601String(),
      'isActive': instance.isActive,
    };
