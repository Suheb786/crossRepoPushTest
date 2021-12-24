// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_status_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocStatusContentEntity _$DocStatusContentEntityFromJson(
    Map<String, dynamic> json) {
  return DocStatusContentEntity(
    showDoc: json['showDoc'] as bool?,
    docs: (json['docs'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$DocStatusContentEntityToJson(
        DocStatusContentEntity instance) =>
    <String, dynamic>{
      'showDoc': instance.showDoc,
      'docs': instance.docs,
    };
