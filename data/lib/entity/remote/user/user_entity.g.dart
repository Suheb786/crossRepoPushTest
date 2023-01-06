// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) {
  return UserEntity(
    applicationId: json['applicationId'] as String?,
    languageCode: json['languageCode'] as String?,
    fullName: json['fullName'] as String?,
    emailId: json['emailId'] as String?,
    mobileStatus: json['mobileStatus'] as bool?,
    mobileNumber: json['mobileNumber'] as String?,
    emailStatus: json['emailStatus'] as bool?,
    nationality: json['nationality'] as String?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
    gender: json['gender'] as String?,
    dob: json['dob'] as String?,
    userName: json['userName'] as String?,
    image: json['image'] as String?,
    userId: json['userId'] as String?,
    existing: json['existing'] as bool?,
    nameOnCard: json['nameOnCard'] as String?,
    mobileCode: json['mobileCode'] as String?,
    cif: json['cif'] as String?,
    accountNumber: json['accountNumber'] as String?,
    newDevice: json['newDevice'] as bool?,
    applePay: json['applepay'] as bool?,
  );
}

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'applicationId': instance.applicationId,
      'languageCode': instance.languageCode,
      'fullName': instance.fullName,
      'emailId': instance.emailId,
      'mobileStatus': instance.mobileStatus,
      'mobileNumber': instance.mobileNumber,
      'mobileCode': instance.mobileCode,
      'emailStatus': instance.emailStatus,
      'nationality': instance.nationality,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'dob': instance.dob,
      'userName': instance.userName,
      'image': instance.image,
      'nameOnCard': instance.nameOnCard,
      'userId': instance.userId,
      'existing': instance.existing,
      'newDevice': instance.newDevice,
      'cif': instance.cif,
      'accountNumber': instance.accountNumber,
      'applepay': instance.applePay,
    };
