// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id_card_details_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdCardDetailsEntity _$IdCardDetailsEntityFromJson(Map<String, dynamic> json) =>
    IdCardDetailsEntity(
      fullNameEn: json['fullNameEn'] as String?,
      fullNameAr: json['fullNameAr'] as String?,
      nationalID: json['nationalID'] as String?,
      placeOfBirthEn: json['placeOfBirthEn'] as String?,
      placeOfBirthAr: json['placeOfBirthAr'] as String?,
      gender: json['gender'] as String?,
      motherNameEn: json['motherNameEn'] as String?,
      motherNameAr: json['motherNameAr'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      documentNo: json['documentNo'] as String?,
      issuingDate: json['issuingDate'] as String?,
      expiryDate: json['expiryDate'] as String?,
      issuingPlace: json['issuingPlace'] as String?,
    );

Map<String, dynamic> _$IdCardDetailsEntityToJson(
        IdCardDetailsEntity instance) =>
    <String, dynamic>{
      'fullNameEn': instance.fullNameEn,
      'fullNameAr': instance.fullNameAr,
      'nationalID': instance.nationalID,
      'placeOfBirthEn': instance.placeOfBirthEn,
      'placeOfBirthAr': instance.placeOfBirthAr,
      'gender': instance.gender,
      'motherNameEn': instance.motherNameEn,
      'motherNameAr': instance.motherNameAr,
      'dateOfBirth': instance.dateOfBirth,
      'documentNo': instance.documentNo,
      'issuingDate': instance.issuingDate,
      'expiryDate': instance.expiryDate,
      'issuingPlace': instance.issuingPlace,
    };
