// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_details_content_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightDetailsContentEntity _$FlightDetailsContentEntityFromJson(
    Map<String, dynamic> json) {
  return FlightDetailsContentEntity(
    flightType: json['flightType'] as String?,
    paymentRequestId: json['paymentRequestId'] as String?,
    createdOn: json['createdOn'] as String?,
    paymentAmount: json['paymentAmount'] as num?,
    paymentCurrency: json['paymentCurrency'] as String?,
    requestReference: json['requestReference'] as String?,
    customerReference: json['customerReference'] as String?,
    flightDetails: (json['flightDetails'] as List<dynamic>?)
        ?.map((e) => FlightDetailsEntity.fromJson(e as Map<String, dynamic>))
        .toList(),
    confirmationUrl: json['confirmationUrl'] as String?,
    cancellationUrl: json['cancellationUrl'] as String?,
  );
}

Map<String, dynamic> _$FlightDetailsContentEntityToJson(
        FlightDetailsContentEntity instance) =>
    <String, dynamic>{
      'paymentAmount': instance.paymentAmount,
      'paymentCurrency': instance.paymentCurrency,
      'requestReference': instance.requestReference,
      'customerReference': instance.customerReference,
      'flightDetails': instance.flightDetails,
      'confirmationUrl': instance.confirmationUrl,
      'cancellationUrl': instance.cancellationUrl,
      'flightType': instance.flightType,
      'paymentRequestId': instance.paymentRequestId,
      'createdOn': instance.createdOn,
    };
