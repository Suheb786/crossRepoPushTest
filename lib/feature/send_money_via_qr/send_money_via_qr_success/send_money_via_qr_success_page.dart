import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_via_qr_success/send_money_via_qr_success_page_view.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_via_qr_success/send_money_via_qr_success_page_view_model.dart';

class SendMoneyViaQrSuccessPage extends BasePage<SendMoneyViaQrSuccessPageViewModel> {
  @override
  SendMoneyViaQrSuccessPageState createState() => SendMoneyViaQrSuccessPageState();
}

class SendMoneyViaQrSuccessPageState
    extends BaseStatefulPage<SendMoneyViaQrSuccessPageViewModel, SendMoneyViaQrSuccessPage> {
  @override
  ProviderBase provideBase() {
    return sendMoneyQrSuccessViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, SendMoneyViaQrSuccessPageViewModel model) {
    return SendMoneyViaQrSuccessPageView(provideBase());
  }
}
