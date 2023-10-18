import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/request_payment_from_new_recipient/request_payment_from_new_recipient_page_view.dart';
import 'package:neo_bank/feature/payment/request_payment_from_new_recipient/request_payment_from_new_recipient_view_model.dart';

class RequestPaymentFromNewRecipientPage extends BasePage<RequestPaymentFromNewRecipientViewModel> {
  final RequestPaymentFromNewRecipientArgument argument;
  String? requestValue;

  RequestPaymentFromNewRecipientPage({
    required this.argument,
  });

  @override
  RequestPaymentFromNewRecipientPageState createState() => RequestPaymentFromNewRecipientPageState();
}

class RequestPaymentFromNewRecipientPageState
    extends BaseStatefulPage<RequestPaymentFromNewRecipientViewModel, RequestPaymentFromNewRecipientPage> {
  @override
  ProviderBase provideBase() {
    return requestPaymentFromNewRecipientViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  void onModelReady(RequestPaymentFromNewRecipientViewModel model) {
    super.onModelReady(model);
    model.argument = widget.argument;
    model.editAmountController.text = double.parse(model.argument?.currentPin ?? "").toStringAsFixed(2);
  }

  @override
  Widget buildView(BuildContext context, RequestPaymentFromNewRecipientViewModel model) {
    return RequestPaymentFromNewRecipientPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(RequestPaymentFromNewRecipientViewModel model, {param}) async {
    var parentModel =
        ProviderScope.containerOf(context).read(requestPaymentFromNewRecipientViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}

class RequestPaymentFromNewRecipientArgument {
  Account account;
  String currentPin;

  RequestPaymentFromNewRecipientArgument({required this.account, required this.currentPin});
}
