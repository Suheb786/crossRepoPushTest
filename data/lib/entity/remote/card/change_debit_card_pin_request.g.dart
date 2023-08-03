// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_debit_card_pin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeDebitCardPinRequest _$ChangeDebitCardPinRequestFromJson(Map<String, dynamic> json) =>
    ChangeDebitCardPinRequest(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['getToken'] as bool? ?? true,
      pinCode: json['PinCode'] as String?,
      tokenizedPan: json['TokenizedPan'] as String?,
      otp: json['otp'] as String?,
    );

Map<String, dynamic> _$ChangeDebitCardPinRequestToJson(ChangeDebitCardPinRequest instance) =>
    <String, dynamic>{
      'PinCode': instance.pinCode,
      'otp': instance.otp,
      'TokenizedPan': instance.tokenizedPan,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
