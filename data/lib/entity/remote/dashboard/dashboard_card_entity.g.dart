// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_card_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardCardEntity _$DashboardCardEntityFromJson(Map<String, dynamic> json) =>
    DashboardCardEntity(
      name: json['name'] as String? ?? "",
      availableBalance: json['availableBalance'] as num? ?? 0.0,
      minDue: json['minDue'] as num? ?? 0.0,
      totalAmount: json['totalAmount'] as num? ?? 0.0,
      cardNumber: json['cardNumber'] as String? ?? "",
      expiryDate: json['expiryDate'] as String? ?? "",
      maxLimit: json['maxLimit'] as num? ?? 0.0,
      cvv: json['cvv'] as String? ?? "",
      usedBalance: json['usedbalance'] as String?,
      isSupCard: json['isSupCard'] as bool?,
      creditCardActivatedDate: json['creditCardActivated'] as String?,
      isApplied: json['isApplied'] as bool?,
      isCreditDelivered: json['isCreditDelivered'] as bool?,
      creditDeliveredDatetime: json['creditDeliveredDatetime'] as String?,
      creditLimit: json['creditlimit'] as String?,
      cardId: json['cardId'] as String?,
      primarySecondaryCard: json['primarysecondarycard'] as String?,
      cardCode: json['cardCode'] as String?,
      paymentDueAmount: json['paymentDueAmount'],
      isCompleted: json['isCompleted'] as bool? ?? false,
      nextPaymentDate: json['nextpaymentdate'] as String? ?? "",
      cardStatus: json['cardStatus'] as String? ?? "",
      minimumSettlement: json['minimumSettlement'] as num? ?? 0,
      callStatus: json['callStatus'] as String? ?? "",
      isCallPending: json['isCallPending'] as bool? ?? false,
      parentId: json['parentId'] as String? ?? "",
      issuedFromCms: json['issuedFromCms'] as bool? ?? false,
    );

Map<String, dynamic> _$DashboardCardEntityToJson(
        DashboardCardEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
      'availableBalance': instance.availableBalance,
      'minDue': instance.minDue,
      'totalAmount': instance.totalAmount,
      'cardNumber': instance.cardNumber,
      'expiryDate': instance.expiryDate,
      'cvv': instance.cvv,
      'maxLimit': instance.maxLimit,
      'creditlimit': instance.creditLimit,
      'usedbalance': instance.usedBalance,
      'isCreditDelivered': instance.isCreditDelivered,
      'creditCardActivated': instance.creditCardActivatedDate,
      'creditDeliveredDatetime': instance.creditDeliveredDatetime,
      'isApplied': instance.isApplied,
      'cardId': instance.cardId,
      'isSupCard': instance.isSupCard,
      'primarysecondarycard': instance.primarySecondaryCard,
      'cardCode': instance.cardCode,
      'paymentDueAmount': instance.paymentDueAmount,
      'isCompleted': instance.isCompleted,
      'nextpaymentdate': instance.nextPaymentDate,
      'cardStatus': instance.cardStatus,
      'minimumSettlement': instance.minimumSettlement,
      'callStatus': instance.callStatus,
      'isCallPending': instance.isCallPending,
      'parentId': instance.parentId,
      'issuedFromCms': instance.issuedFromCms,
    };
