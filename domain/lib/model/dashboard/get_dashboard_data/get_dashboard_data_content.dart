import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';

class GetDashboardDataContent {
  GetDashboardDataContent({
    this.account,
    this.creditCard,
    this.isApplied,
    this.isDelivered,
    this.debitCardActivated,
    this.youJoinedBlink,
    this.blinkWasBorn,
  });

  Account? account;
  CreditCard? creditCard;
  bool? isApplied;
  dynamic isDelivered;
  dynamic debitCardActivated;
  DateTime? youJoinedBlink;
  DateTime? blinkWasBorn;
}
