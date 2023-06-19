// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_vouchers_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyVouchersRequest _$MyVouchersRequestFromJson(Map<String, dynamic> json) =>
    MyVouchersRequest(
      PageNo: json['PageNo'] as String?,
      FromDate: json['FromDate'] as String?,
      ToDate: json['ToDate'] as String?,
      getToken: json['GetToken'] as bool? ?? true,
      baseData: json['baseClass'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$MyVouchersRequestToJson(MyVouchersRequest instance) =>
    <String, dynamic>{
      'PageNo': instance.PageNo,
      'FromDate': instance.FromDate,
      'ToDate': instance.ToDate,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
