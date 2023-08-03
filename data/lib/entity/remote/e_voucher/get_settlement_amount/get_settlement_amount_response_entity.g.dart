// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_settlement_amount_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSettlementAmountResponseEntity _$GetSettlementAmountResponseEntityFromJson(Map<String, dynamic> json) =>
    GetSettlementAmountResponseEntity(
      response:
          json['response'] == null ? null : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetSettlementAmountResponseEntityToJson(GetSettlementAmountResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
