import 'package:domain/model/bill_payments/pay_prepaid_bill/paid_bill_conent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/prepaid_bill/prepaid_bills_success/prepaid_bills_success_page_view.dart';
import 'package:neo_bank/feature/prepaid_bill/prepaid_bills_success/prepaid_bills_success_page_view_model.dart';
import 'package:neo_bank/utils/app_constants.dart';

class PrePaidBillsSuccessPage extends BasePage<PrePaidBillsSuccessPageViewModel> {
  final PrePaidBillsSuccessPageArguments arguments;

  PrePaidBillsSuccessPage(this.arguments);

  @override
  PrePaidBillsSuccessPageState createState() => PrePaidBillsSuccessPageState();
}

class PrePaidBillsSuccessPageState
    extends BaseStatefulPage<PrePaidBillsSuccessPageViewModel, PrePaidBillsSuccessPage> {
  @override
  ProviderBase provideBase() {
    return prePaidBillsSuccessPageViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, PrePaidBillsSuccessPageViewModel model) {
    return PrePaidBillsSuccessPageView(provideBase());
  }

  @override
  void didChangeDependencies() {
    final model = ProviderScope.containerOf(context)
        .read(prePaidBillsSuccessPageViewModelProvider.call(widget.arguments));
    if (AppConstantsUtils.IS_NEW_PAYMENT == true && AppConstantsUtils.NICK_NAME.toString().isNotEmpty) {
      if (AppConstantsUtils.IS_NEW_BILL_ADD_API_CALL == true) {
        AppConstantsUtils.IS_NEW_BILL_ADD_API_CALL = false;
        Future.delayed(Duration(milliseconds: 10)).then((value) => model.addNewPrepaidBiller(context));
      }
    }
    super.didChangeDependencies();
  }

  @override
  Future<bool> onBackPressed(PrePaidBillsSuccessPageViewModel model, {param}) {
    Navigator.of(context)
      ..pop()
      ..pop()
      ..pop(true);
    ProviderScope.containerOf(context)
        .read(appHomeViewModelProvider).getDashboardData();
    return super.onBackPressed(model);
  }
}

class PrePaidBillsSuccessPageArguments {
  PaidBillContent paidBillContent;
  PrePaidRoute paidRoute;

  PrePaidBillsSuccessPageArguments(this.paidBillContent, this.paidRoute);
}

enum PrePaidRoute { MANAGE_PAY_BILL, PAY_NEW_BILL }
