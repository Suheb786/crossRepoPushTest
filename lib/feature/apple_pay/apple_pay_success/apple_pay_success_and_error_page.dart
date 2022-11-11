import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/selected_card_for_apple_pay/selected_card_for_apple_pay_modules.dart';

import 'apple_pay_success_and_error_page_view.dart';
import 'apple_pay_success_and_error_page_view_model.dart';

class ApplePaySuccessAndErrorPage extends BasePage<ApplePaySuccessAndErrorPageViewModel> {
  final ApplePaySuccessAndErrorPageArguments applePaySuccessAndErrorPageArguments;

  ApplePaySuccessAndErrorPage(this.applePaySuccessAndErrorPageArguments);

  @override
  ApplePaySuccessAndErrorPageState createState() => ApplePaySuccessAndErrorPageState();
}

class ApplePaySuccessAndErrorPageState
    extends BaseStatefulPage<ApplePaySuccessAndErrorPageViewModel, ApplePaySuccessAndErrorPage> {
  @override
  ProviderBase provideBase() {
    return applePaySuccessAndErrorPageViewModelProvider.call(widget.applePaySuccessAndErrorPageArguments);
  }

  @override
  Widget buildView(BuildContext context, ApplePaySuccessAndErrorPageViewModel model) {
    return ApplePaySuccessAndErrorPageView(provideBase());
  }
}

class ApplePaySuccessAndErrorPageArguments {
  final String? successOrErrorIcon;
  final String? title;
  final String? titleDescription;

  ApplePaySuccessAndErrorPageArguments(
      {required this.successOrErrorIcon, required this.title, required this.titleDescription});
}
