// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_post_paid_bill_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayPostPaidBillRequestEntity _$PayPostPaidBillRequestEntityFromJson(
        Map<String, dynamic> json) =>
    PayPostPaidBillRequestEntity(
      billerList: json['billList'],
      accountNo: json['accountNo'] as String?,
      totalAmount: json['totalAmount'] as String?,
      fee: json['fee'] as String?,
      currencyCode: json['currencyCode'] as String?,
      otpCode: json['otpCode'] as String?,
      isCreditCardPayment: json['isCreditCardPayment'] as bool?,
      isNewBiller: json['isNewBiller'] as bool?,
      CardId: json['CardId'] as String?,
      nickName: json['NickName'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      fromAccount: json['FromAccount'] as String?,
      baseData: json['BaseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$PayPostPaidBillRequestEntityToJson(
        PayPostPaidBillRequestEntity instance) =>
    <String, dynamic>{
      'billList': instance.billerList,
      'accountNo': instance.accountNo,
      'totalAmount': instance.totalAmount,
      'fee': instance.fee,
      'currencyCode': instance.currencyCode,
      'isNewBiller': instance.isNewBiller,
      'isCreditCardPayment': instance.isCreditCardPayment,
      'otpCode': instance.otpCode,
      'NickName': instance.nickName,
      'CardId': instance.CardId,
      'FromAccount': instance.fromAccount,
      'GetToken': instance.getToken,
      'BaseClass': instance.baseData,
    };
