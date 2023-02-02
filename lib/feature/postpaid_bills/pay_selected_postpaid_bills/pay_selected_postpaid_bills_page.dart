import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model_data.dart';
import 'package:domain/model/bill_payments/post_paid_bill_inquiry/post_paid_bill_inquiry_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page_view_model.dart';

class PaySelectedBillsPostPaidBillsPage extends BasePage<PaySelectedBillsPostPaidBillsPageViewModel> {
  final PaySelectedBillsPostPaidBillsPageArguments arguments;

  PaySelectedBillsPostPaidBillsPage(this.arguments);

  @override
  PaySelectedBillsPostPaidBillsPageState createState() => PaySelectedBillsPostPaidBillsPageState();
}

class PaySelectedBillsPostPaidBillsPageState
    extends BaseStatefulPage<PaySelectedBillsPostPaidBillsPageViewModel, PaySelectedBillsPostPaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return paySelectedBillsPostPaidBillsPageViewModelProvider.call(widget.arguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, PaySelectedBillsPostPaidBillsPageViewModel model) {
    return PaySelectedBillsPostPaidBillsPageView(provideBase());
  }

  @override
  void onModelReady(PaySelectedBillsPostPaidBillsPageViewModel model) {
    Future.delayed(Duration(milliseconds: 10))
        .then((value) => model.postpaidInquiryDataListener(list: model.arguments.postPaidBillInquiryData!));

    model.savingAccountController.text = ProviderScope.containerOf(context)
            .read(appHomeViewModelProvider)
            .dashboardDataContent
            .account
            ?.accountNo ??
        '';
    super.onModelReady(model);
  }
}

class PaySelectedBillsPostPaidBillsPageArguments {
  final String nosOfBills;
  final double amt;
  final List<GetPostpaidBillerListModelData> noOfSelectedBills;
  List<PostPaidBillInquiryData>? postPaidBillInquiryData;

  PaySelectedBillsPostPaidBillsPageArguments(
      this.nosOfBills, this.amt, this.noOfSelectedBills, this.postPaidBillInquiryData);
}
