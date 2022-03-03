import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';

class GetDashboardDataContent {
  GetDashboardDataContent(
      {this.account,
      this.creditCard,
      this.debitCard,
      this.youJoinedBlink,
      this.somethingWrong: false,
      this.mobileNumber: "",
      this.mobileCode: "",
      this.blinkWasBorn});

  final Account? account;
  final bool? somethingWrong;
  final List<CreditCard>? creditCard;
  final List<DebitCard>? debitCard;
  final DateTime? youJoinedBlink;
  final DateTime? blinkWasBorn;
  final String? mobileNumber;
  final String? mobileCode;
}
