import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/request_from_new_recipient/request_from_new_recipient_page_view.dart';
import 'package:neo_bank/feature/payment/request_from_new_recipient/request_from_new_recipient_view_model.dart';

class RequestFromNewRecipientPage extends BasePage<RequestFromNewRecipientViewModel> {
  @override
  RequestFromNewRecipientPageState createState() => RequestFromNewRecipientPageState();
}

class RequestFromNewRecipientPageState
    extends BaseStatefulPage<RequestFromNewRecipientViewModel, RequestFromNewRecipientPage> {
  @override
  ProviderBase provideBase() {
    return requestFromNewRecipientViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, RequestFromNewRecipientViewModel model) {
    return RequestFromNewRecipientPageView(provideBase());
  }

  @override
  void onModelReady(RequestFromNewRecipientViewModel model) {
    super.onModelReady(model);
    model.selectedAccount = ProviderScope.containerOf(context)
            .read(requestPaymentFromNewRecipientViewModelProvider)
            .argument
            ?.account ??
        Account();
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }
}
