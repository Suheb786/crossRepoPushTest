import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/prepaid_bill/pay_my_prepaid_bills/pay_my_prepaid_bills_page_view.dart';
import 'package:neo_bank/feature/prepaid_bill/pay_my_prepaid_bills/pay_my_prepaid_bills_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class PayMyPrePaidBillsPage extends BasePage<PayMyPrePaidBillsPageViewModel> {
  @override
  PayMyPrePaidBillsPageState createState() => PayMyPrePaidBillsPageState();
}

class PayMyPrePaidBillsPageState
    extends BaseStatefulPage<PayMyPrePaidBillsPageViewModel, PayMyPrePaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return payMyPrePaidBillsPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 107.h),
        child: Padding(
          padding: EdgeInsets.only(top: 52.0.h, bottom: 35.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 24.0.w),
                  child: AppSvg.asset(
                    AssetUtils.leftArrow,
                    color: AppColor.white,
                  ),
                ),
              ),
              Text(
                // S.of(context).payAllBills,
                "Pay My Bills",
                style: TextStyle(
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white),
              ),
              SizedBox.shrink()
            ],
          ),
        ));
  }

  @override
  void onModelReady(PayMyPrePaidBillsPageViewModel model) {
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, PayMyPrePaidBillsPageViewModel model) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, child: PayMyPrePaidBillsPageView(provideBase()));
  }
}
