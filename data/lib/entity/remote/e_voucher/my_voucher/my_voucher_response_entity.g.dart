// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_voucher_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyVoucherResponseEntity _$MyVoucherResponseEntityFromJson(
        Map<String, dynamic> json) =>
    MyVoucherResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyVoucherResponseEntityToJson(
        MyVoucherResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
