import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/prepaid_bill/prepaid_bills_success/prepaid_bills_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_secondary_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/share_bill_payments_info.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:share_plus/share_plus.dart';


class PrePaidBillsSuccessPageView extends BasePageViewWidget<PrePaidBillsSuccessPageViewModel> {
  PrePaidBillsSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PrePaidBillsSuccessPageViewModel model) {
    return AppStreamBuilder<Resource<bool>>(
      stream: model.addNewPrepaidBillerStream,
      initialData: Resource.none(),
      onData: (event) {
        if (event.status == Status.SUCCESS) {
          ///LOG EVENT TO FIREBASE
          FireBaseLogUtil.fireBaseLog("saved_new_pre_paid_biller", {"saved_new_pre_paid_biller": true});
          model.showSuccessToast(S.of(context).billerAddedSuccessfully);
        } else if (event.status == Status.ERROR) {
          model.showToastWithError(event.appError!);
        }
      },
      dataBuilder: (context, snapshot) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  top: 92.h,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      AssetUtils.line_gray,
                      color: AppColor.veryDarkGray1,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 111.37.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).canvasColor,
                        ),
                        child: model.arguments.paidBillContent.paidBill?[0].isPaid == true
                            ? Center(child: AppSvg.asset(AssetUtils.right))
                            : Center(child: AppSvg.asset(AssetUtils.fail, color: AppColor.black)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: double.parse(model.arguments.paidBillContent.paidBill?[0].totalAmount ?? "0")
                      .toStringAsFixed(3),
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: AppColor.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 32.0.t),
                ),
                TextSpan(
                  text: '  ${S.of(context).JOD}',
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: AppColor.gray5,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0.t),
                ),
              ])),
              Text(
                S.of(context).paidTo,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.0.t),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 40.0.h, end: 24.w, start: 24.0.w),
                child: Card(
                    child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 24.0.h, bottom: 24.0.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).billerName,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0.t),
                          ),
                          Text(
                            model.getBillerName(context, model.arguments.paidBillContent.paidBill![0]),
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0.t),
                          )
                        ],
                      ),
                      (model.arguments.paidBillContent.paidBill?[0].fee != null &&
                              double.parse(model.arguments.paidBillContent.paidBill?[0].fee ?? "0") > 0.0)
                          ? SizedBox(height: 16.h)
                          : Container(),
                      (model.arguments.paidBillContent.paidBill?[0].fee != null &&
                              double.parse(model.arguments.paidBillContent.paidBill?[0].fee ?? "0") > 0.0)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).fees,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0.t),
                                ),
                                Text(
                                  "${double.parse(model.arguments.paidBillContent.paidBill?[0].fee ?? "0").toStringAsFixed(3)} ${S.of(context).JOD}",
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0.t),
                                )
                              ],
                            )
                          : Container(),
                      AppConstantsUtils.NICK_NAME.toString().isNotEmpty
                          ? SizedBox(height: 16.h)
                          : Container(),
                      AppConstantsUtils.NICK_NAME.toString().isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).nickName,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0.t),
                                ),
                                Text(
                                  AppConstantsUtils.NICK_NAME,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0.t),
                                )
                              ],
                            )
                          : Container(),
                      model.arguments.paidBillContent.paidBill?[0].isPaid == true
                          ? SizedBox(height: 16.h)
                          : Container(),
                      model.arguments.paidBillContent.paidBill?[0].isPaid == true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).refNo,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0.t),
                                ),
                                Text(
                                  model.arguments.paidBillContent.paidBill?[0].refNo ?? "",
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.0.t),
                                )
                              ],
                            )
                          : Container(),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).status,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.0.t),
                          ),
                          Text(
                            model.arguments.paidBillContent.paidBill?[0].isPaid == true
                                ? S.of(context).successS
                                : S.of(context).failed,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: model.arguments.paidBillContent.paidBill?[0].isPaid == true
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0.t),
                          )
                        ],
                      )
                    ],
                  ),
                )),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 32.0.h),
                child: GestureDetector(
                  onTap: () {
                    _shareDetails(context, model);
                  },
                  child: model.arguments.paidBillContent.paidBill?[0].isPaid == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppSvg.asset(AssetUtils.share, color: AppColor.light_acccent_blue),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              S.of(context).shareMyReceipt,
                              style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w600,
                                color: AppColor.light_acccent_blue,
                                fontSize: 14.t,
                              ),
                            )
                          ],
                        )
                      : Container(),
                ),
              ),
              SizedBox(
                height: 166.h,
              ),
              AppSecondaryButton(
                text: S.of(context).next,
                width: 230.w,
                onPressed: () {
                  Navigator.of(context)
                    ..pop()
                    ..pop()
                    ..pop()
                    ..pop();
                },
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 56.h,
                ),
                child: Center(
                  child: Text(
                    S.of(context).toPayments,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.t,
                        color: AppColor.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _shareDetails(BuildContext context, PrePaidBillsSuccessPageViewModel model) {
    Share.share(
      ShareInfo.newPrePaidSuccess(
        context,
        refNo: model.arguments.paidBillContent.paidBill?[0].refNo ?? "",
        billerName: model.getBillerName(context, model.arguments.paidBillContent.paidBill![0]),
        amount:
            '${double.parse(model.arguments.paidBillContent.paidBill?[0].totalAmount ?? "0").toStringAsFixed(3)}',
        nickName: AppConstantsUtils.IS_NEW_PAYMENT == true ? AppConstantsUtils.NICK_NAME : "",
      ),
      subject: S.of(context).billDetails,
    );
  }
}
