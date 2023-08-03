// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_biller_lookup_List_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBillerLookupEntity _$GetBillerLookupEntityFromJson(Map<String, dynamic> json) => GetBillerLookupEntity(
      billerDetails:
          (json['billerDetails'] as List<dynamic>?)?.map((e) => e as Map<String, dynamic>).toList(),
    );

Map<String, dynamic> _$GetBillerLookupEntityToJson(GetBillerLookupEntity instance) => <String, dynamic>{
      'billerDetails': instance.billerDetails,
    };
