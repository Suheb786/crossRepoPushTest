// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_statement_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardStatementContentEntity _$CardStatementContentEntityFromJson(
    Map<String, dynamic> json) {
  return CardStatementContentEntity(
    pdfBase64String: json['PDFBase64'] as String?,
    pdfFileName: json['fileName'] as String?,
  );
}

Map<String, dynamic> _$CardStatementContentEntityToJson(
        CardStatementContentEntity instance) =>
    <String, dynamic>{
      'fileName': instance.pdfFileName,
      'PDFBase64': instance.pdfBase64String,
    };
