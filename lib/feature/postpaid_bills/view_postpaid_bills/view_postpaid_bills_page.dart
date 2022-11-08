import 'package:domain/constants/enum/postpaid_bills_pay_type_option_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/view_postpaid_bills/view_postpaid_bills_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/view_postpaid_bills/view_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class ViewPostPaidBillsPage extends BasePage<ViewPostPaidBillsPageViewModel> {
  final ViewPostPaidBillsPageArguments arguments;

  ViewPostPaidBillsPage(this.arguments);

  @override
  ViewPostPaidBillsPageState createState() => ViewPostPaidBillsPageState();
}

class ViewPostPaidBillsPageState
    extends BaseStatefulPage<ViewPostPaidBillsPageViewModel, ViewPostPaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return viewPostPaidBillsPageViewModelProvider.call(widget.arguments);
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
          padding: EdgeInsets.only(top: 52.0.h, bottom: 35.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox.shrink(),
              Text(
                S.of(context).saveBills,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.white),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppSvg.asset(AssetUtils.plusIcon),
              )
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

class ViewPostPaidBillsPageArguments {
  final PostPaidBillsPayTypeOptionEnum paidBillsPayTypeOptionEnum;

  ViewPostPaidBillsPageArguments(this.paidBillsPayTypeOptionEnum);
}
