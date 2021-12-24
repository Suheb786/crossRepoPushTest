// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_debit_card_pin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeDebitCardPinRequest _$ChangeDebitCardPinRequestFromJson(
    Map<String, dynamic> json) {
  return ChangeDebitCardPinRequest(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['getToken'] as bool?,
    status: json['Status'] as String?,
    pinCode: json['PinCode'] as String?,
  );
}

Map<String, dynamic> _$ChangeDebitCardPinRequestToJson(
        ChangeDebitCardPinRequest instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'PinCode': instance.pinCode,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
