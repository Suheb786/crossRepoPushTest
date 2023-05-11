import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/request_money_via_qr/request_money_qr_generation/request_money_qr_generation_page_view.dart';
import 'package:neo_bank/feature/request_money_via_qr/request_money_qr_generation/request_money_qr_generation_page_view_model.dart';

class RequestMoneyQrGenerationPage extends BasePage<RequestMoneyQrGenerationPageViewModel> {
  final RequestMoneyQrGenerationPageArguments arguments;

  RequestMoneyQrGenerationPage(this.arguments);

  @override
  RequestMoneyQrGenerationPageState createState() => RequestMoneyQrGenerationPageState();
}

class RequestMoneyQrGenerationPageState
    extends BaseStatefulPage<RequestMoneyQrGenerationPageViewModel, RequestMoneyQrGenerationPage> {
  @override
  ProviderBase provideBase() {
    return requestMoneyQrGenerationViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget buildView(BuildContext context, RequestMoneyQrGenerationPageViewModel model) {
    return RequestMoneyQrGenerationPageView(provideBase());
  }
}

class RequestMoneyQrGenerationPageArguments {
  final Account account;

  RequestMoneyQrGenerationPageArguments(this.account);
}
