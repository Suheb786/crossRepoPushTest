// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_transaction_slider_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_transaction_slider_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

class ReturnPaymentTransactionSliderPage
    extends BasePage<ReturnPaymentTransactionSliderPageViewModel> {
  final ReturnPaymentTransactionSliderPageArgument returnPaymentArgument;

  ReturnPaymentTransactionSliderPage(this.returnPaymentArgument);

  @override
  State<StatefulWidget> createState() {
    return ReturnPaymentTransactionSliderState();
  }
}

class ReturnPaymentTransactionSliderState extends BaseStatefulPage<
    ReturnPaymentTransactionSliderPageViewModel,
    ReturnPaymentTransactionSliderPage> {
  @override
  Widget buildView(
      BuildContext context, ReturnPaymentTransactionSliderPageViewModel model) {
    return ReturnPaymentTransactionSliderPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return returnPaymentTransactionSliderPageViewModelProvider;
  }

  @override
  void onModelReady(ReturnPaymentTransactionSliderPageViewModel model) {
    model.returnArgument = widget.returnPaymentArgument;
    super.onModelReady(model);
  }

  @override
  Future<bool> onBackPressed(ReturnPaymentTransactionSliderPageViewModel model,
      {param}) async {
    var parentModel = ProviderScope.containerOf(context)
        .read(returnPaymentTransactionSliderPageViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}

class ReturnPaymentTransactionSliderPageArgument {
  final double? amount;
  final String? name;
  final String? iban;
  final String? statusInfo;
  final String? custID;
  final String? OrgnlMsgId;
  final String? rtpStatus;
  final String? messageID;
  final String? dbtrAcct;
  final String? dbtrName;
  final String? cdtrAcct;
  final String? cdtrName;
  final String? currency;
  final String? rtrnReason;
  final String? rtrnAddInfo;
  final bool? isDispute;
  final String? disputeRefNo;
  final String? otpCode;
  final bool getToken;

  ReturnPaymentTransactionSliderPageArgument({
    this.amount = 0,
    required this.name,
    required this.iban,
    required this.statusInfo,
    required this.custID,
    required this.OrgnlMsgId,
    required this.rtpStatus,
    required this.messageID,
    required this.dbtrAcct,
    required this.dbtrName,
    required this.cdtrAcct,
    required this.cdtrName,
    required this.currency,
    required this.rtrnReason,
    required this.rtrnAddInfo,
    required this.isDispute,
    required this.disputeRefNo,
    required this.otpCode,
    required this.getToken,
  });
}
