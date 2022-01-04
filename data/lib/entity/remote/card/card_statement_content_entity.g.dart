// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_statement_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardStatementContentEntity _$CardStatementContentEntityFromJson(
    Map<String, dynamic> json) {
  return CardStatementContentEntity(
    pdfBase64String: json['pdfBase64String'] as String?,
    pdfFileName: json['pdfFileName'] as String?,
  );
}

Map<String, dynamic> _$CardStatementContentEntityToJson(
        CardStatementContentEntity instance) =>
    <String, dynamic>{
      'pdfFileName': instance.pdfFileName,
      'pdfBase64String': instance.pdfBase64String,
    };
