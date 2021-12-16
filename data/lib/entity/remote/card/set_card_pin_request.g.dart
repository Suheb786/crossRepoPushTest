// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_card_pin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetCardPinRequest _$SetCardPinRequestFromJson(Map<String, dynamic> json) {
  return SetCardPinRequest(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    pinCode: json['PinCode'] as String?,
  );
}

Map<String, dynamic> _$SetCardPinRequestToJson(SetCardPinRequest instance) =>
    <String, dynamic>{
      'GetToken': instance.getToken,
      'PinCode': instance.pinCode,
      'baseClass': instance.baseData,
    };
