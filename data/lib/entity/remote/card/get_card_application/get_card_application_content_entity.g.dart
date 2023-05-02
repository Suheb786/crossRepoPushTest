// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_card_application_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCardApplicationContentEntity _$GetCardApplicationContentEntityFromJson(
        Map<String, dynamic> json) =>
    GetCardApplicationContentEntity(
      cardId: json['cardId'] as String? ?? "",
      loanValueId: json['loanValueId'] as num? ?? 0,
      processLoanStep: json['processLoanStep'] as bool? ?? false,
      processLoanDate: json['processLoanDate'] as String? ?? "",
      issueCardOnNI: json['issueCardOnNI'] as bool? ?? false,
      issueCardDate: json['issueCardDate'] as String? ?? "",
      finalStep: json['finalStep'] as bool? ?? false,
      contactLessError: json['contactLessError'] as int? ?? 0,
      linkCardError: json['linkCardError'] as int? ?? 0,
      crifError: json['crifError'] as int? ?? 0,
      manageSOError: json['manageSOError'] as int? ?? 0,
      aramexError: json['aramexError'] as int? ?? 0,
    );

Map<String, dynamic> _$GetCardApplicationContentEntityToJson(
        GetCardApplicationContentEntity instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'loanValueId': instance.loanValueId,
      'processLoanStep': instance.processLoanStep,
      'processLoanDate': instance.processLoanDate,
      'issueCardOnNI': instance.issueCardOnNI,
      'issueCardDate': instance.issueCardDate,
      'finalStep': instance.finalStep,
      'contactLessError': instance.contactLessError,
      'linkCardError': instance.linkCardError,
      'crifError': instance.crifError,
      'manageSOError': instance.manageSOError,
      'aramexError': instance.aramexError,
    };
