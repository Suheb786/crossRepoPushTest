import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/request_money_via_qr/request_money_qr_generation/request_money_qr_generation_page_view.dart';
import 'package:neo_bank/feature/request_money_via_qr/request_money_qr_generation/request_money_qr_generation_page_view_model.dart';

class RequestMoneyQrGenerationPage
    extends BasePage<RequestMoneyQrGenerationPageViewModel> {
  @override
  RequestMoneyQrGenerationPageState createState() =>
      RequestMoneyQrGenerationPageState();
}

class RequestMoneyQrGenerationPageState extends BaseStatefulPage<
    RequestMoneyQrGenerationPageViewModel, RequestMoneyQrGenerationPage> {
  @override
  ProviderBase provideBase() {
    return requestMoneyQrGenerationViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(
      BuildContext context, RequestMoneyQrGenerationPageViewModel model) {
    return RequestMoneyQrGenerationPageView(provideBase());
  }
}
