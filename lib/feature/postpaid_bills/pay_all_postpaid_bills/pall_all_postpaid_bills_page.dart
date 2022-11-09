import 'package:domain/constants/enum/postpaid_bills_pay_type_option_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_all_postpaid_bills_page_view.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_selected_postpaid_bills_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class PayAllPostPaidBillsPage extends BasePage<PayAllPostPaidBillsPageViewModel> {
  final PayAllPostPaidBillsPageArguments arguments;

  PayAllPostPaidBillsPage(this.arguments);

  @override
  PayAllPostPaidBillsPageState createState() => PayAllPostPaidBillsPageState();
}

class PayAllPostPaidBillsPageState
    extends BaseStatefulPage<PayAllPostPaidBillsPageViewModel, PayAllPostPaidBillsPage> {
  @override
  ProviderBase provideBase() {
    return payAllPostPaidBillsPageViewModelProvider.call(widget.arguments);
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
                child: Visibility(
                  visible: widget.arguments.paidBillsPayTypeOptionEnum ==
                          PostPaidBillsPayTypeOptionEnum.PAYALLBILLS
                      ? true
                      : false,
                  child: Padding(
                    padding: EdgeInsets.only(left: 24.0.w),
                    child: AppSvg.asset(
                      AssetUtils.leftArrow,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
              Text(
                widget.arguments.paidBillsPayTypeOptionEnum == PostPaidBillsPayTypeOptionEnum.PAYALLBILLS
                    ? S.of(context).payAllBills
                    : S.of(context).myBills,
                style: TextStyle(fontSize: 14.t, fontWeight: FontWeight.w600, color: AppColor.white),
              ),
              Visibility(
                visible:
                    widget.arguments.paidBillsPayTypeOptionEnum == PostPaidBillsPayTypeOptionEnum.PAYALLBILLS
                        ? false
                        : true,
                child: Padding(
                  padding: EdgeInsets.only(right: 24.0.w),
                  child: AppSvg.asset(
                    AssetUtils.plusIcon,
                    color: AppColor.white,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget buildView(BuildContext context, PayAllPostPaidBillsPageViewModel model) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light, child: PayAllPostPaidBillsPageView(provideBase()));
  }

  @override
  void onModelReady(PayAllPostPaidBillsPageViewModel model) {
    // model.totalBillAmt = 0.0;
    if (model.arguments.paidBillsPayTypeOptionEnum == PostPaidBillsPayTypeOptionEnum.PAYALLBILLS) {
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
    } else if (model.arguments.paidBillsPayTypeOptionEnum == PostPaidBillsPayTypeOptionEnum.VIEWMYBILLS) {
      model.payAllPostPaidBillsDataList = [
        PallAllPostPaidBillsData(
            billType: 'Electric Home',
            billName: 'Jordan Electricity',
            icon: AssetUtils.electricityIcon,
            billAmtDue: 1.00),
        PallAllPostPaidBillsData(
            billType: 'Electric Home',
            billName: 'Jordan Electricity',
            icon: AssetUtils.electricityIcon,
            billAmtDue: 2.00),
        PallAllPostPaidBillsData(
            billType: 'Electric Home',
            billName: 'Jordan Electricity',
            icon: AssetUtils.electricityIcon,
            billAmtDue: 3.00),
        PallAllPostPaidBillsData(
            billType: 'Electric Home',
            billName: 'Jordan Electricity',
            icon: AssetUtils.electricityIcon,
            billAmtDue: 4.00),
        PallAllPostPaidBillsData(
            billType: 'Electric Home',
            billName: 'Jordan Electricity',
            icon: AssetUtils.electricityIcon,
            billAmtDue: 5.00),
        PallAllPostPaidBillsData(
            billType: 'Electric Home',
            billName: 'Jordan Electricity',
            icon: AssetUtils.electricityIcon,
            billAmtDue: 6.00),
      ];
    }

    // model.addAllBillAmt();
    super.onModelReady(model);
  }
}

class PayAllPostPaidBillsPageArguments {
  final PostPaidBillsPayTypeOptionEnum paidBillsPayTypeOptionEnum;

  PayAllPostPaidBillsPageArguments(this.paidBillsPayTypeOptionEnum);
}
