import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_all_postpaid_bills_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_selected_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class PayAllPostPaidBillsPage extends BasePage<PayAllPostPaidBillsPageViewModel> {
  @override
  PayAllPostPaidBillsPageState createState() => PayAllPostPaidBillsPageState();
}

class PayAllPostPaidBillsPageState
    extends BaseStatefulPage<PayAllPostPaidBillsPageViewModel, PayAllPostPaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return payAllPostPaidBillsPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 107),
        child: Padding(
          padding: const EdgeInsets.only(top: 92.0, bottom: 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: AppSvg.asset(AssetUtils.leftArrow, color: AppColor.white, width: 24.0, height: 24.0),
              ),
              Text(
                S.of(context).payAllBills,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.white),
              ),
              SizedBox.shrink(),
            ],
          ),
        ));
  }

  @override
  Widget buildView(BuildContext context, PayAllPostPaidBillsPageViewModel model) {
    return PayAllPostPaidBillsPageView(provideBase());
  }

  @override
  void onModelReady(PayAllPostPaidBillsPageViewModel model) {
    model.payAllPostPaidBillsDataList = [
      PallAllPostPaidBillsData(
          billType: 'Electric Home',
          billName: 'Jordan Electricity',
          icon: AssetUtils.electricityIcon,
          billAmtDue: 1.00,
          isSelected: true),
      PallAllPostPaidBillsData(
          billType: 'Electric Home',
          billName: 'Jordan Electricity',
          icon: AssetUtils.electricityIcon,
          billAmtDue: 2.00,
          isSelected: true),
      PallAllPostPaidBillsData(
          billType: 'Electric Home',
          billName: 'Jordan Electricity',
          icon: AssetUtils.electricityIcon,
          billAmtDue: 3.00,
          isSelected: true),
      PallAllPostPaidBillsData(
          billType: 'Electric Home',
          billName: 'Jordan Electricity',
          icon: AssetUtils.electricityIcon,
          billAmtDue: 4.00,
          isSelected: true),
      PallAllPostPaidBillsData(
          billType: 'Electric Home',
          billName: 'Jordan Electricity',
          icon: AssetUtils.electricityIcon,
          billAmtDue: 5.00,
          isSelected: true),
      PallAllPostPaidBillsData(
          billType: 'Electric Home',
          billName: 'Jordan Electricity',
          icon: AssetUtils.electricityIcon,
          billAmtDue: 6.00,
          isSelected: true),
    ];
    model.addAllBillAmt();
    super.onModelReady(model);
  }
}
