// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remove_or_reapply_supplementary_debit_card_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoveOrReApplySupplementaryDebitCardRequestEnity
    _$RemoveOrReApplySupplementaryDebitCardRequestEnityFromJson(
            Map<String, dynamic> json) =>
        RemoveOrReApplySupplementaryDebitCardRequestEnity(
          getToken: json['getToken'] as bool?,
          status: json['Status'] as String?,
          tokenizedPan: json['TokenizedPan'] as String?,
          reApply: json['ReApply'] as bool?,
          baseData: json['BaseClass'] as Map<String, dynamic>,
        );

Map<String, dynamic> _$RemoveOrReApplySupplementaryDebitCardRequestEnityToJson(
        RemoveOrReApplySupplementaryDebitCardRequestEnity instance) =>
    <String, dynamic>{
      'getToken': instance.getToken,
      'Status': instance.status,
      'TokenizedPan': instance.tokenizedPan,
      'ReApply': instance.reApply,
      'BaseClass': instance.baseData,
    };
