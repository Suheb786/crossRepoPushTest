// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unblock_debit_card_pin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnblockDebitCardPinRequest _$UnblockDebitCardPinRequestFromJson(
    Map<String, dynamic> json) {
  return UnblockDebitCardPinRequest(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['getToken'] as bool?,
    tokenizedPan: json['TokenizedPan'] as String?,
  );
}

Map<String, dynamic> _$UnblockDebitCardPinRequestToJson(
        UnblockDebitCardPinRequest instance) =>
    <String, dynamic>{
      'TokenizedPan': instance.tokenizedPan,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
