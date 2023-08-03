// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_history_list_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherHistoryListResponseEntity _$VoucherHistoryListResponseEntityFromJson(Map<String, dynamic> json) =>
    VoucherHistoryListResponseEntity(
      json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VoucherHistoryListResponseEntityToJson(VoucherHistoryListResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
