// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_data_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardDataEntity _$DashboardDataEntityFromJson(Map<String, dynamic> json) =>
    DashboardDataEntity(
      account: json['account'] == null
          ? null
          : DashboardAccountEntity.fromJson(
              json['account'] as Map<String, dynamic>),
      creditCard: (json['creditCard'] as List<dynamic>?)
          ?.map((e) => DashboardCardEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      mobileNumber: json['mobileNumber'] as String? ?? "",
      blinkBornDate: json['blinkWasBorn'] == null
          ? null
          : DateTime.parse(json['blinkWasBorn'] as String),
      blinkJoinedDate: json['youJoinedBlink'] == null
          ? null
          : DateTime.parse(json['youJoinedBlink'] as String),
      mobileCode: json['mobileCode'] as String? ?? "",
      somethingWrong: json['somethingWrong'] as bool? ?? false,
      debitCardSomethingWrong:
          json['debitCardSomethingWrong'] as bool? ?? false,
      isCreditCard: json['isCreditCard'] as bool? ?? true,
      dashboardFeatures: json['features'] == null
          ? null
          : DashboardFeaturesEntity.fromJson(
              json['features'] as Map<String, dynamic>),
      debitCard: (json['debitCard'] as List<dynamic>?)
          ?.map((e) => DashboardDebitCardEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      email: json['email'] as String?,
      allowSubAccount: json['allowSubAccount'] as bool?,
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => DashboardAccountEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      availableBalance: json['availableBalance'] as num?,
      userPromoCode: json['userPromoCode'] as String?,
    );

Map<String, dynamic> _$DashboardDataEntityToJson(
        DashboardDataEntity instance) =>
    <String, dynamic>{
      'account': instance.account,
      'accounts': instance.accounts,
      'creditCard': instance.creditCard,
      'debitCard': instance.debitCard,
      'mobileNumber': instance.mobileNumber,
      'mobileCode': instance.mobileCode,
      'features': instance.dashboardFeatures,
      'youJoinedBlink': instance.blinkJoinedDate?.toIso8601String(),
      'blinkWasBorn': instance.blinkBornDate?.toIso8601String(),
      'somethingWrong': instance.somethingWrong,
      'debitCardSomethingWrong': instance.debitCardSomethingWrong,
      'isCreditCard': instance.isCreditCard,
      'email': instance.email,
      'allowSubAccount': instance.allowSubAccount,
      'availableBalance': instance.availableBalance,
      'userPromoCode': instance.userPromoCode,
    };
