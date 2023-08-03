// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_card_statement_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountCardStatementContentEntity _$AccountCardStatementContentEntityFromJson(Map<String, dynamic> json) =>
    AccountCardStatementContentEntity(
      pdfBase64String: json['pdfBase64String'] as String?,
      pdfFileName: json['pdfFileName'] as String?,
    );

Map<String, dynamic> _$AccountCardStatementContentEntityToJson(AccountCardStatementContentEntity instance) =>
    <String, dynamic>{
      'pdfFileName': instance.pdfFileName,
      'pdfBase64String': instance.pdfBase64String,
    };
