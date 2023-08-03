// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_details_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherDetailsResponseEntity _$VoucherDetailsResponseEntityFromJson(
        Map<String, dynamic> json) =>
    VoucherDetailsResponseEntity(
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VoucherDetailsResponseEntityToJson(
        VoucherDetailsResponseEntity instance) =>
    <String, dynamic>{
      'response': instance.response,
    };
