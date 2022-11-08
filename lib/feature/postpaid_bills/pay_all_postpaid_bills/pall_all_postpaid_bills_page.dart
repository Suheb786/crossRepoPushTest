import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/change_card_pin_success/card_ready_success_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin_success/change_card_pin_success_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/view_postpaid_bills/view_postpaid_bills_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/view_postpaid_bills/view_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

import 'package:neo_bank/utils/color_utils.dart';

class ViewPostPaidBillsPage extends BasePage<ViewPostPaidBillsPageViewModel> {
  @override
  ViewPostPaidBillsPageState createState() => ViewPostPaidBillsPageState();
}

class ViewPostPaidBillsPageState
    extends BaseStatefulPage<ViewPostPaidBillsPageViewModel, ViewPostPaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return viewPostPaidBillsPageViewModelProvider;
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
          padding: const EdgeInsets.only(top: 92.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              Text(
                S.of(context).saveBills,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.white),
              ),
              AppSvg.asset(AssetUtils.plusIcon)
            ],
          ),
        ));
  }

  @override
  Widget buildView(BuildContext context, ViewPostPaidBillsPageViewModel model) {
    return ViewPostPaidBillsPageView(provideBase());
  }

  @override
  void onModelReady(ViewPostPaidBillsPageViewModel model) {
    model.viewPostPaidBillsPageDataList = [
      ViewPostPaidBillsPageData(
          billType: 'Electric Home',
          billName: 'Jordan Electricity',
          icon: AssetUtils.electricityIcon,
          billAmtDue: 1.00),
      ViewPostPaidBillsPageData(
          billType: 'Electric Home',
          billName: 'Jordan Electricity',
          icon: AssetUtils.electricityIcon,
          billAmtDue: 2.00),
      ViewPostPaidBillsPageData(
          billType: 'Electric Home',
          billName: 'Jordan Electricity',
          icon: AssetUtils.electricityIcon,
          billAmtDue: 3.00),
      ViewPostPaidBillsPageData(
          billType: 'Electric Home',
          billName: 'Jordan Electricity',
          icon: AssetUtils.electricityIcon,
          billAmtDue: 4.00),
      ViewPostPaidBillsPageData(
          billType: 'Electric Home',
          billName: 'Jordan Electricity',
          icon: AssetUtils.electricityIcon,
          billAmtDue: 5.00),
      ViewPostPaidBillsPageData(
          billType: 'Electric Home',
          billName: 'Jordan Electricity',
          icon: AssetUtils.electricityIcon,
          billAmtDue: 6.00),
    ];
    super.onModelReady(model);
  }
}
