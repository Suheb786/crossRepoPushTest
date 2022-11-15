import 'package:domain/constants/enum/postpaid_bills_pay_type_option_enum.dart';
import 'package:domain/model/bill_payments/get_postpaid_biller_list/get_postpaid_biller_list_model_data.dart';
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

class PayAllPostPaidBillsPage
    extends BasePage<PayAllPostPaidBillsPageViewModel> {
  final PayAllPostPaidBillsPageArguments arguments;

  PayAllPostPaidBillsPage(this.arguments);

  @override
  PayAllPostPaidBillsPageState createState() => PayAllPostPaidBillsPageState();
}

class PayAllPostPaidBillsPageState extends BaseStatefulPage<
    PayAllPostPaidBillsPageViewModel, PayAllPostPaidBillsPage> {
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
                widget.arguments.paidBillsPayTypeOptionEnum ==
                        PostPaidBillsPayTypeOptionEnum.PAYALLBILLS
                    ? S.of(context).payAllBills
                    : S.of(context).myBills,
                style: TextStyle(
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white),
              ),
              Visibility(
                visible: widget.arguments.paidBillsPayTypeOptionEnum ==
                        PostPaidBillsPayTypeOptionEnum.PAYALLBILLS
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
  Widget buildView(
      BuildContext context, PayAllPostPaidBillsPageViewModel model) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: PayAllPostPaidBillsPageView(provideBase()));
  }

  @override
  void onModelReady(PayAllPostPaidBillsPageViewModel model) {
    // model.totalBillAmt = 0.0;
    if (model.arguments.paidBillsPayTypeOptionEnum ==
        PostPaidBillsPayTypeOptionEnum.PAYALLBILLS) {
      model.payPostPaidBillsDataList = [
        GetPostpaidBillerListModelData(
            joebppsNo: "1747834",
            customerId: "9611015751",
            billerCode: "39",
            billingNo: "55",
            serviceType: "Electricity",
            billingStatus: "Active",
            nickName: "heba h",
            billerNameEN: "Madfooat2",
            billerNameAR: "مدفوعات2",
            billerCatogaryEN: "Government Service",
            billerCatogaryAR: "حكومي",
            serviceTypeDescEN: "Electricity",
            serviceTypeAR: "كهرباء",
            dueAmount: "1.00",
            dueDate: "0001-01-01T00:00:00",
            fees: "0.0",
            status: null,
            isChecked: true,
            iconCode: AssetUtils.electricityIcon),
        GetPostpaidBillerListModelData(
            joebppsNo: "1747834",
            customerId: "9611015751",
            billerCode: "39",
            billingNo: "55",
            serviceType: "Electricity",
            billingStatus: "Active",
            nickName: "heba h",
            billerNameEN: "Madfooat2",
            billerNameAR: "مدفوعات2",
            billerCatogaryEN: "Government Service",
            billerCatogaryAR: "حكومي",
            serviceTypeDescEN: "Electricity",
            serviceTypeAR: "كهرباء",
            dueAmount: "2.00",
            dueDate: "0001-01-01T00:00:00",
            fees: "0.0",
            status: null,
            isChecked: true,
            iconCode: AssetUtils.electricityIcon),
        GetPostpaidBillerListModelData(
            joebppsNo: "1747834",
            customerId: "9611015751",
            billerCode: "39",
            billingNo: "55",
            serviceType: "Electricity",
            billingStatus: "Active",
            nickName: "heba h",
            billerNameEN: "Madfooat2",
            billerNameAR: "مدفوعات2",
            billerCatogaryEN: "Government Service",
            billerCatogaryAR: "حكومي",
            serviceTypeDescEN: "Electricity",
            serviceTypeAR: "كهرباء",
            dueAmount: "3.00",
            dueDate: "0001-01-01T00:00:00",
            fees: "0.0",
            status: null,
            isChecked: true,
            iconCode: AssetUtils.electricityIcon),
        GetPostpaidBillerListModelData(
            joebppsNo: "1747834",
            customerId: "9611015751",
            billerCode: "39",
            billingNo: "55",
            serviceType: "Electricity",
            billingStatus: "Active",
            nickName: "heba h",
            billerNameEN: "Madfooat2",
            billerNameAR: "مدفوعات2",
            billerCatogaryEN: "Government Service",
            billerCatogaryAR: "حكومي",
            serviceTypeDescEN: "Electricity",
            serviceTypeAR: "كهرباء",
            dueAmount: "4.00",
            dueDate: "0001-01-01T00:00:00",
            fees: "0.0",
            status: null,
            isChecked: true,
            iconCode: AssetUtils.electricityIcon),
        GetPostpaidBillerListModelData(
            joebppsNo: "1747834",
            customerId: "9611015751",
            billerCode: "39",
            billingNo: "55",
            serviceType: "Electricity",
            billingStatus: "Active",
            nickName: "heba h",
            billerNameEN: "Madfooat2",
            billerNameAR: "مدفوعات2",
            billerCatogaryEN: "Government Service",
            billerCatogaryAR: "حكومي",
            serviceTypeDescEN: "Electricity",
            serviceTypeAR: "كهرباء",
            dueAmount: "5.00",
            dueDate: "0001-01-01T00:00:00",
            fees: "0.0",
            status: null,
            isChecked: true,
            iconCode: AssetUtils.electricityIcon),
        GetPostpaidBillerListModelData(
            joebppsNo: "1747834",
            customerId: "9611015751",
            billerCode: "39",
            billingNo: "55",
            serviceType: "Electricity",
            billingStatus: "Active",
            nickName: "heba h",
            billerNameEN: "Madfooat2",
            billerNameAR: "مدفوعات2",
            billerCatogaryEN: "Government Service",
            billerCatogaryAR: "حكومي",
            serviceTypeDescEN: "Electricity",
            serviceTypeAR: "كهرباء",
            dueAmount: "6.00",
            dueDate: "0001-01-01T00:00:00",
            fees: "0.0",
            status: null,
            isChecked: true,
            iconCode: AssetUtils.electricityIcon),
      ];
      model.addAllBillAmt();
    } else if (model.arguments.paidBillsPayTypeOptionEnum ==
        PostPaidBillsPayTypeOptionEnum.VIEWMYBILLS) {
      model.payPostPaidBillsDataList = [
        GetPostpaidBillerListModelData(
            joebppsNo: "1747834",
            customerId: "9611015751",
            billerCode: "39",
            billingNo: "55",
            serviceType: "Electricity",
            billingStatus: "Active",
            nickName: "heba h",
            billerNameEN: "Madfooat2",
            billerNameAR: "مدفوعات2",
            billerCatogaryEN: "Government Service",
            billerCatogaryAR: "حكومي",
            serviceTypeDescEN: "Electricity",
            serviceTypeAR: "كهرباء",
            dueAmount: "1.00",
            dueDate: "0001-01-01T00:00:00",
            fees: "0.0",
            status: null,
            isChecked: false,
            iconCode: AssetUtils.electricityIcon),
        GetPostpaidBillerListModelData(
            joebppsNo: "1747834",
            customerId: "9611015751",
            billerCode: "39",
            billingNo: "55",
            serviceType: "Electricity",
            billingStatus: "Active",
            nickName: "heba h",
            billerNameEN: "Madfooat2",
            billerNameAR: "مدفوعات2",
            billerCatogaryEN: "Government Service",
            billerCatogaryAR: "حكومي",
            serviceTypeDescEN: "Electricity",
            serviceTypeAR: "كهرباء",
            dueAmount: "2.00",
            dueDate: "0001-01-01T00:00:00",
            fees: "0.0",
            status: null,
            isChecked: false,
            iconCode: AssetUtils.electricityIcon),
        GetPostpaidBillerListModelData(
            joebppsNo: "1747834",
            customerId: "9611015751",
            billerCode: "39",
            billingNo: "55",
            serviceType: "Electricity",
            billingStatus: "Active",
            nickName: "heba h",
            billerNameEN: "Madfooat2",
            billerNameAR: "مدفوعات2",
            billerCatogaryEN: "Government Service",
            billerCatogaryAR: "حكومي",
            serviceTypeDescEN: "Electricity",
            serviceTypeAR: "كهرباء",
            dueAmount: "3.00",
            dueDate: "0001-01-01T00:00:00",
            fees: "0.0",
            status: null,
            isChecked: false,
            iconCode: AssetUtils.electricityIcon),
        GetPostpaidBillerListModelData(
            joebppsNo: "1747834",
            customerId: "9611015751",
            billerCode: "39",
            billingNo: "55",
            serviceType: "Electricity",
            billingStatus: "Active",
            nickName: "heba h",
            billerNameEN: "Madfooat2",
            billerNameAR: "مدفوعات2",
            billerCatogaryEN: "Government Service",
            billerCatogaryAR: "حكومي",
            serviceTypeDescEN: "Electricity",
            serviceTypeAR: "كهرباء",
            dueAmount: "4.00",
            dueDate: "0001-01-01T00:00:00",
            fees: "0.0",
            status: null,
            isChecked: false,
            iconCode: AssetUtils.electricityIcon),
        GetPostpaidBillerListModelData(
            joebppsNo: "1747834",
            customerId: "9611015751",
            billerCode: "39",
            billingNo: "55",
            serviceType: "Electricity",
            billingStatus: "Active",
            nickName: "heba h",
            billerNameEN: "Madfooat2",
            billerNameAR: "مدفوعات2",
            billerCatogaryEN: "Government Service",
            billerCatogaryAR: "حكومي",
            serviceTypeDescEN: "Electricity",
            serviceTypeAR: "كهرباء",
            dueAmount: "5.00",
            dueDate: "0001-01-01T00:00:00",
            fees: "0.0",
            status: null,
            isChecked: false,
            iconCode: AssetUtils.electricityIcon),
        GetPostpaidBillerListModelData(
            joebppsNo: "1747834",
            customerId: "9611015751",
            billerCode: "39",
            billingNo: "55",
            serviceType: "Electricity",
            billingStatus: "Active",
            nickName: "heba h",
            billerNameEN: "Madfooat2",
            billerNameAR: "مدفوعات2",
            billerCatogaryEN: "Government Service",
            billerCatogaryAR: "حكومي",
            serviceTypeDescEN: "Electricity",
            serviceTypeAR: "كهرباء",
            dueAmount: "6.00",
            dueDate: "0001-01-01T00:00:00",
            fees: "0.0",
            status: null,
            isChecked: false,
            iconCode: AssetUtils.electricityIcon),
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
