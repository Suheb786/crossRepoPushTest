// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ahwal_info_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AhwalInfoEntity _$AhwalInfoEntityFromJson(Map<String, dynamic> json) {
  return AhwalInfoEntity(
    firstNameAr: json['firstNameAr'] as String?,
    secNameAr: json['secNameAr'] as String?,
    thirdNameAr: json['thirdNameAr'] as String?,
    familyNameAr: json['familyNameAr'] as String?,
    motherFirstName: json['motherFirstName'] as String?,
    placeOfBirth: json['placeOfBirth'] as String?,
    familyNameEn: json['familyNameEn'] as String?,
    firstNameEn: json['firstNameEn'] as String?,
    secondNameEn: json['secondNameEn'] as String?,
    thirdNameEn: json['thirdNameEn'] as String?,
  );
}

Map<String, dynamic> _$AhwalInfoEntityToJson(AhwalInfoEntity instance) =>
    <String, dynamic>{
      'firstNameAr': instance.firstNameAr,
      'secNameAr': instance.secNameAr,
      'thirdNameAr': instance.thirdNameAr,
      'familyNameAr': instance.familyNameAr,
      'firstNameEn': instance.firstNameEn,
      'secondNameEn': instance.secondNameEn,
      'thirdNameEn': instance.thirdNameEn,
      'familyNameEn': instance.familyNameEn,
      'motherFirstName': instance.motherFirstName,
      'placeOfBirth': instance.placeOfBirth,
    };
