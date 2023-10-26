import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';

import 'pay_bill_page_view.dart';
import 'pay_bill_page_view_model.dart';

class PayBillPage extends BasePage<PayBillPageViewModel> {
  @override
  PayBillPageState createState() => PayBillPageState();
}

class PayBillPageState extends BaseStatefulPage<PayBillPageViewModel, PayBillPage> {
  @override
  ProviderBase provideBase() {
    return payBillPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  void onModelReady(PayBillPageViewModel model) {
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, PayBillPageViewModel model) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, child: PayBillPageView(provideBase()));
  }

  @override
  Future<bool> onBackPressed(PayBillPageViewModel model, {param}) async {
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
