import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/credit_confirmation/credit_confirmation_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/credit_confirmation/credit_confirmation_page_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class CreditConfirmationPaymentActivityPageView
    extends BasePageViewWidget<CreditConfirmationPaymentActivityViewModel> {
  CreditConfirmationPaymentActivityPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 8.h, bottom: 24.h),
            height: 4.h,
            width: 64.w,
            decoration: BoxDecoration(color: AppColor.white_gray, borderRadius: BorderRadius.circular(4)),
          )
        ],
      ),
    );
  }
}
