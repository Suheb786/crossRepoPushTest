import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_page_view_model.dart';

class RejectRequestPaymentPage extends BasePage<RejectRequestPaymentPageViewModel> {
  @override
  RejectRequestPaymentPageState createState() => RejectRequestPaymentPageState();
}

class RejectRequestPaymentPageState
    extends BaseStatefulPage<RejectRequestPaymentPageViewModel, RejectRequestPaymentPage> {
  @override
  ProviderBase provideBase() {
    return rejectRequestPaymentPageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, RejectRequestPaymentPageViewModel model) {
    return RejectRequestPaymentPageView(provideBase());
  }
}
