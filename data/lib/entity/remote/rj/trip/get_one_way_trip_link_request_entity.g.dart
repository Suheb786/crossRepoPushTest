// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_one_way_trip_link_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOneWayTripLinkRequestEntity _$GetOneWayTripLinkRequestEntityFromJson(
        Map<String, dynamic> json) =>
    GetOneWayTripLinkRequestEntity(
      baseData: json['baseClass'] as Map<String, dynamic>,
      getToken: json['GetToken'] as bool? ?? true,
      language: json['Language'] as String?,
      adults: json['Adults'] as String?,
      cabin: json['Cabin'] as String?,
      childs: json['Childs'] as String?,
      customerRef: json['CustomerRef'] as String?,
      date1: json['Date1'] as String?,
      des: json['Des'] as String?,
      infants: json['Infants'] as String?,
      org: json['Org'] as String?,
      promoCode: json['PromoCode'] as String?,
      youths: json['Youths'] as String?,
    );

Map<String, dynamic> _$GetOneWayTripLinkRequestEntityToJson(
        GetOneWayTripLinkRequestEntity instance) =>
    <String, dynamic>{
      'Language': instance.language,
      'Org': instance.org,
      'Des': instance.des,
      'Date1': instance.date1,
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
