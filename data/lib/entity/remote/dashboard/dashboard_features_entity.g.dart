// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_features_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardFeaturesEntity _$DashboardFeaturesEntityFromJson(
    Map<String, dynamic> json) {
  return DashboardFeaturesEntity(
    isCreditCardEnabled:
        json['blink-retail-app-creditCard-application'] as bool?,
    isGoRJEnabled: json['blink-retail-app-gorj'] as bool?,
    isLoginEnabled: json['blink-retail-app-login'] as bool?,
    isRegisterEnabled: json['blink-retail-app-register'] as bool?,
  );
}

Map<String, dynamic> _$DashboardFeaturesEntityToJson(
        DashboardFeaturesEntity instance) =>
    <String, dynamic>{
      'blink-retail-app-login': instance.isLoginEnabled,
      'blink-retail-app-creditCard-application': instance.isCreditCardEnabled,
      'blink-retail-app-register': instance.isRegisterEnabled,
      'blink-retail-app-gorj': instance.isGoRJEnabled,
    };
