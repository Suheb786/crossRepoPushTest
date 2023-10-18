import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/pay_bill_detail/pay_bill_detail_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/pay_bill_detail/pay_bill_detail_page_view_model.dart';

class PayBillDetailPage extends BasePage<PayBillDetailPageViewModel> {
  @override
  PayBillDetailPageState createState() => PayBillDetailPageState();
}

class PayBillDetailPageState extends BaseStatefulPage<PayBillDetailPageViewModel, PayBillDetailPage>
    with AutomaticKeepAliveClientMixin {
  PayBillDetailPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return payBillDetailPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Widget buildView(BuildContext context, PayBillDetailPageViewModel model) {
    return PayBillDetailPageView(provideBase());
  }

  @override
  void onModelReady(PayBillDetailPageViewModel model) {
    model.payFromController.text = ProviderScope.containerOf(context)
            .read(appHomeViewModelProvider)
            .dashboardDataContent
            .account
            ?.accountNo ??
        "";
    super.onModelReady(model);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<bool> onBackPressed(PayBillDetailPageViewModel model, {param}) async {
    var parentModel =
    ProviderScope.containerOf(context).read(payBillPageViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
