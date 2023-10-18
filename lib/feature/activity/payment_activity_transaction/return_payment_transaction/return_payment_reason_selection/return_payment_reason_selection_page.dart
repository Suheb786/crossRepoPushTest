import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_reason_selection/return_payment_reason_selection_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_reason_selection/return_payment_reason_selection_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

import '../../../../../di/activity/activity_modules.dart';

class ReturnPaymentReasonSelectionPage extends BasePage<ReturnPaymentReasonSelectionPageViewModel> {
  @override
  ReturnPaymentReasonSelectionPageState createState() => ReturnPaymentReasonSelectionPageState();
}

class ReturnPaymentReasonSelectionPageState
    extends BaseStatefulPage<ReturnPaymentReasonSelectionPageViewModel, ReturnPaymentReasonSelectionPage> {
  @override
  Widget buildView(BuildContext context, ReturnPaymentReasonSelectionPageViewModel model) {
    return ReturnPaymentReasonSelectionPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return returnPaymentSelectionPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Future<bool> onBackPressed(ReturnPaymentReasonSelectionPageViewModel model, {param}) async{
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
