// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_purpose_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountPurposeEntity _$AccountPurposeEntityFromJson(Map<String, dynamic> json) {
  return AccountPurposeEntity(
    id: json['id'] as int?,
    userId: json['userId'] as String?,
    purpose: json['purpose'] as String?,
    isCashDeposit: json['isCashDeposit'] as bool?,
    isTransfer: json['isTransfer'] as bool?,
    isBillPayment: json['isBillPayment'] as bool?,
    isOther: json['isOther'] as bool?,
    monthlyTransaction: (json['monthlyTransaction'] as num?)?.toDouble(),
    anualTransaction: (json['anualTransaction'] as num?)?.toDouble(),
    createdOn: json['createdOn'] == null ? null : DateTime.parse(json['createdOn'] as String),
    isActive: json['isActive'] as bool?,
    purposeAr: json['purposeAr'] as String?,
  );
}

Map<String, dynamic> _$AccountPurposeEntityToJson(AccountPurposeEntity instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'purpose': instance.purpose,
      'purposeAr': instance.purposeAr,
      'isCashDeposit': instance.isCashDeposit,
      'isTransfer': instance.isTransfer,
      'isBillPayment': instance.isBillPayment,
      'isOther': instance.isOther,
      'monthlyTransaction': instance.monthlyTransaction,
      'anualTransaction': instance.anualTransaction,
      'createdOn': instance.createdOn?.toIso8601String(),
      'isActive': instance.isActive,
    };
