// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_two_way_trip_link_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTwoWayTripLinkRequestEntity _$GetTwoWayTripLinkRequestEntityFromJson(
    Map<String, dynamic> json) {
  return GetTwoWayTripLinkRequestEntity(
    baseData: json['baseClass'] as Map<String, dynamic>,
    getToken: json['GetToken'] as bool?,
    language: json['Language'] as String?,
    adults: json['Adults'] as String?,
    cabin: json['Cabin'] as String?,
    childs: json['Childs'] as String?,
    customerRef: json['CustomerRef'] as String?,
    fromDate: json['Date1'] as String?,
    toDate: json['Date2'] as String?,
    des: json['Des'] as String?,
    infants: json['Infants'] as String?,
    org: json['Org'] as String?,
    promoCode: json['PromoCode'] as String?,
    youths: json['Youths'] as String?,
  );
}

Map<String, dynamic> _$GetTwoWayTripLinkRequestEntityToJson(
        GetTwoWayTripLinkRequestEntity instance) =>
    <String, dynamic>{
      'Language': instance.language,
      'Org': instance.org,
      'Des': instance.des,
      'Date1': instance.fromDate,
      'Date2': instance.toDate,
      'Adults': instance.adults,
      'Childs': instance.childs,
      'Infants': instance.infants,
      'Youths': instance.youths,
      'Cabin': instance.cabin,
      'PromoCode': instance.promoCode,
      'CustomerRef': instance.customerRef,
      'GetToken': instance.getToken,
      'baseClass': instance.baseData,
    };
