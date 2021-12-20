// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BeneficiaryEntity _$BeneficiaryEntityFromJson(Map<String, dynamic> json) {
  return BeneficiaryEntity(
    nickName: json['nickName'] as String?,
    fullName: json['fullName'] as String?,
    profileImage: json['profileImage'] as String?,
  );
}

Map<String, dynamic> _$BeneficiaryEntityToJson(BeneficiaryEntity instance) =>
    <String, dynamic>{
      'nickName': instance.nickName,
      'fullName': instance.fullName,
      'profileImage': instance.profileImage,
    };
