import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page_view.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page_view_model.dart';

class SendMoneyQrScanningPage extends BasePage<SendMoneyQrScanningPageViewModel> {
  final SendMoneyQRScanningArguments arguments;

  SendMoneyQrScanningPage(this.arguments);

  @override
  SendMoneyQrScanningPageState createState() => SendMoneyQrScanningPageState();
}

class SendMoneyQrScanningPageState extends BaseStatefulPage<SendMoneyQrScanningPageViewModel, SendMoneyQrScanningPage> {
  @override
  ProviderBase provideBase() {
    return sendMoneyQrScanningViewModelProvider.call(widget.arguments);
  }

  @override
  Future<void> onModelReady(SendMoneyQrScanningPageViewModel model) async {
    ///LOG EVENT TO FIREBASE
    await FirebaseAnalytics.instance.logEvent(
      name: "payment_summary_viewed",
      parameters: {"is_payment_summary_viewed": true, "source": getViewModel().arguments.source},
    );

    super.onModelReady(model);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, SendMoneyQrScanningPageViewModel model) {
    return SendMoneyQrScanningPageView(provideBase());
  }
}

class SendMoneyQRScanningArguments {
  final String amount;
  final String accountHolderName;
  final String accountNo;
  final String requestId;
  final String source;

  SendMoneyQRScanningArguments(
      {required this.amount,
      required this.accountHolderName,
      required this.accountNo,
      required this.requestId,
      required this.source});
}
