// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_card_application_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCardApplicationContentEntity _$GetCardApplicationContentEntityFromJson(
    Map<String, dynamic> json) {
  return GetCardApplicationContentEntity(
    cardId: json['cardId'] as String?,
    loanValueId: json['loanValueId'] as num?,
    processLoanStep: json['processLoanStep'] as bool?,
    processLoanDate: json['processLoanDate'] as String?,
    issueCardOnNI: json['issueCardOnNI'] as bool?,
    issueCardDate: json['issueCardDate'] as String?,
  );
}

Map<String, dynamic> _$GetCardApplicationContentEntityToJson(
        GetCardApplicationContentEntity instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'loanValueId': instance.loanValueId,
      'processLoanStep': instance.processLoanStep,
      'processLoanDate': instance.processLoanDate,
      'issueCardOnNI': instance.issueCardOnNI,
      'issueCardDate': instance.issueCardDate,
    };
