// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_qr_clip_payment_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendQrCliqPaymentRequestEntity _$SendQrCliqPaymentRequestEntityFromJson(
        Map<String, dynamic> json) =>
    SendQrCliqPaymentRequestEntity(
      referenceLabel: json['referenceLabel'] as String?,
      merchantCategoryCode: json['merchantCategoryCode'] as String?,
      countryCode: json['countryCode'] as String?,
      merchantID: json['merchantID'] as String?,
      merchantName: json['merchantName'] as String?,
      location: json['location'],
      transactionAmount: json['transactionAmount'] as String?,
      city: json['city'] as String?,
      transactionCurrency: json['transactionCurrency'] as String?,
      additionalLanguageTemplate: json['additionalLanguageTemplate'] as String?,
      verificationCode: json['verificationCode'],
      dateTime: json['dateTime'] as String?,
      billNumber: json['billNumber'],
      mobileNumber: json['mobileNumber'],
      storeLabel: json['storeLabel'],
      loyaltyNumber: json['loyaltyNumber'],
      customerLabel: json['customerLabel'],
      terminalLabel: json['terminalLabel'],
      qrCode: json['qrCode'] as String?,
      crdtrBic: json['crdtrBic'] as String?,
      fromAccount: json['fromAccount'] as String?,
      fromAccountHolderName: json['fromAccountHolderName'] as String?,
      ValueOfConvenienceFixed: json['ValueOfConvenienceFixed'] as String?,
      TipOrConvenienceIndicator: json['TipOrConvenienceIndicator'] as String?,
      valueOfPercentageConvenience: json['valueOfPercentageConvenience'],
      getToken: json['getToken'] as bool?,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$SendQrCliqPaymentRequestEntityToJson(
        SendQrCliqPaymentRequestEntity instance) =>
    <String, dynamic>{
      'referenceLabel': instance.referenceLabel,
      'merchantCategoryCode': instance.merchantCategoryCode,
      'countryCode': instance.countryCode,
      'merchantID': instance.merchantID,
      'merchantName': instance.merchantName,
      'location': instance.location,
      'transactionAmount': instance.transactionAmount,
      'city': instance.city,
      'transactionCurrency': instance.transactionCurrency,
      'additionalLanguageTemplate': instance.additionalLanguageTemplate,
      'verificationCode': instance.verificationCode,
      'dateTime': instance.dateTime,
      'billNumber': instance.billNumber,
      'mobileNumber': instance.mobileNumber,
      'storeLabel': instance.storeLabel,
      'loyaltyNumber': instance.loyaltyNumber,
      'customerLabel': instance.customerLabel,
      'terminalLabel': instance.terminalLabel,
      'qrCode': instance.qrCode,
      'crdtrBic': instance.crdtrBic,
      'fromAccount': instance.fromAccount,
      'fromAccountHolderName': instance.fromAccountHolderName,
      'ValueOfConvenienceFixed': instance.ValueOfConvenienceFixed,
      'TipOrConvenienceIndicator': instance.TipOrConvenienceIndicator,
      'valueOfPercentageConvenience': instance.valueOfPercentageConvenience,
      'getToken': instance.getToken,
      'baseClass': instance.baseData,
    };
