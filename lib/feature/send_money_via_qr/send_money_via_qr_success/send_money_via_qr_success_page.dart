import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_via_qr_success/send_money_via_qr_success_page_view.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_via_qr_success/send_money_via_qr_success_page_view_model.dart';

import '../../../di/dashboard/dashboard_modules.dart';
import '../../../main/navigation/route_paths.dart';

class SendMoneyViaQrSuccessPage extends BasePage<SendMoneyViaQrSuccessPageViewModel> {
  final SendMoneyViaQRSuccessPageArguments arguments;

  SendMoneyViaQrSuccessPage(this.arguments);

  @override
  SendMoneyViaQrSuccessPageState createState() => SendMoneyViaQrSuccessPageState();
}

class SendMoneyViaQrSuccessPageState
    extends BaseStatefulPage<SendMoneyViaQrSuccessPageViewModel, SendMoneyViaQrSuccessPage> {
  @override
  ProviderBase provideBase() {
    return sendMoneyQrSuccessViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, SendMoneyViaQrSuccessPageViewModel model) {
    return SendMoneyViaQrSuccessPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(SendMoneyViaQrSuccessPageViewModel model, {param}) {
    Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
    ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
    return super.onBackPressed(model);
  }
}

class SendMoneyViaQRSuccessPageArguments {
  final String amount;
  final String user;
  final String referenceNo;

  SendMoneyViaQRSuccessPageArguments({required this.amount, required this.user, required this.referenceNo});
}
