import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';

class GetDashboardDataContent {
  GetDashboardDataContent({
    this.account,
    this.creditCard,
    this.debitCard,
    this.isApplied,
    this.isCreditDelivered,
    this.isDebitDelivered,
    this.debitCardActivated,
    this.creditCardActivated,
    this.youJoinedBlink,
    this.blinkWasBorn,
  });

  final Account? account;
  final CreditCard? creditCard;
  final DebitCard? debitCard;
  final bool? isApplied;
  final dynamic? isCreditDelivered;
  final dynamic? isDebitDelivered;
  final String? debitCardActivated;
  final String? creditCardActivated;
  final DateTime? youJoinedBlink;
  final DateTime? blinkWasBorn;
}
