import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/prepaid_bill/pay_prepaid_bill/pay_prepaid_bill_detail/pay_prepaid_bill_detail_page_view.dart';
import 'package:neo_bank/feature/prepaid_bill/pay_prepaid_bill/pay_prepaid_bill_detail/pay_prepaid_bill_detail_page_view_model.dart';

class PayPrePaidBillDetailPage extends BasePage<PayPrePaidBillDetailPageViewModel> {
  @override
  PayPrePaidBillDetailPageState createState() => PayPrePaidBillDetailPageState();
}

class PayPrePaidBillDetailPageState
    extends BaseStatefulPage<PayPrePaidBillDetailPageViewModel, PayPrePaidBillDetailPage>
    with AutomaticKeepAliveClientMixin {
  PayPrePaidBillDetailPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return payPrePaidBillDetailPageViewModelProvider;
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
  Widget buildView(BuildContext context, PayPrePaidBillDetailPageViewModel model) {
    return PayPrePaidBillDetailPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
