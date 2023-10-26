import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page_view.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page_view_model.dart';

class SendMoneyQRScanningPage extends BasePage<SendMoneyQRScanningPageViewModel> {
  final SendMoneyQRScanningArguments arguments;

  SendMoneyQRScanningPage(this.arguments);

  @override
  SendMoneyQRScanningPageState createState() => SendMoneyQRScanningPageState();
}

class SendMoneyQRScanningPageState
    extends BaseStatefulPage<SendMoneyQRScanningPageViewModel, SendMoneyQRScanningPage> {
  @override
  ProviderBase provideBase() {
    return sendMoneyQrScanningViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, SendMoneyQRScanningPageViewModel model) {
    return SendMoneyQRScanningPageView(provideBase());
  }

  @override
  Future<void> onModelReady(SendMoneyQRScanningPageViewModel model) async {
    model.arguments = widget.arguments;

    ///LOG EVENT TO FIREBASE
    await FirebaseAnalytics.instance.logEvent(
      name: "payment_summary_viewed",
      parameters: {
        "is_payment_summary_viewed": true.toString(),
        "source": getViewModel().arguments?.source ?? ''
      },
    );
    super.onModelReady(model);
  }

  @override
  Future<bool> onBackPressed(SendMoneyQRScanningPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(sendMoneyQrScanningViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
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
