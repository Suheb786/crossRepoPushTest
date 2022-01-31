import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';

class GetDashboardDataContent {
  GetDashboardDataContent(
      {this.account,
      this.creditCard,
      this.debitCard,
      this.youJoinedBlink,
      this.mobileNumber,
      this.blinkWasBorn});

  final Account? account;
  final List<CreditCard>? creditCard;
  final List<DebitCard>? debitCard;
  final DateTime? youJoinedBlink;
  final DateTime? blinkWasBorn;
  final String? mobileNumber;
}
