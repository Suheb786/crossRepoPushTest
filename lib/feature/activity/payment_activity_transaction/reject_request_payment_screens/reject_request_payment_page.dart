import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_page_view_model.dart';

class RejectRequestPaymentPage extends BasePage<RejectRequestPaymentPageViewModel> {
  final RejectRequestPaymentPageArgument argument;

  RejectRequestPaymentPage(this.argument);

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
  void onModelReady(RejectRequestPaymentPageViewModel model) {
    model.argument = widget.argument;
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, RejectRequestPaymentPageViewModel model) {
    return RejectRequestPaymentPageView(provideBase());
  }
}

class RejectRequestPaymentPageArgument {
  final String amount;
  final String name;
  final String iban;
  final String statusInfo;
  final String custID;
  final String OrgnlMsgId;
  final String rtpStatus;

  RejectRequestPaymentPageArgument({
    required this.amount,
    required this.name,
    required this.iban,
    required this.statusInfo,
    required this.custID,
    required this.OrgnlMsgId,
    required this.rtpStatus,
  });
}
