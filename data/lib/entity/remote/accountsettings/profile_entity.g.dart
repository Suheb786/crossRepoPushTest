// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileEntity _$ProfileEntityFromJson(Map<String, dynamic> json) {
  return ProfileEntity(
    email: json['email'] as String?,
    mobileNumber: json['mobileNumber'] as String?,
    biometric: json['biometric'] as bool?,
    fullName: json['fullName'] as String?,
    profileImage: json['profileImage'] as String?,
    mobileCode: json['mobileCode'] as String?,
  );
}

Map<String, dynamic> _$ProfileEntityToJson(ProfileEntity instance) => <String, dynamic>{
      'email': instance.email,
      'mobileNumber': instance.mobileNumber,
      'biometric': instance.biometric,
      'profileImage': instance.profileImage,
      'fullName': instance.fullName,
      'mobileCode': instance.mobileCode,
    };
