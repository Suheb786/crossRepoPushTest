import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/paid_bills_success/paid_bills_success_page_view_model.dart';
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

class PaidBillsSuccessPageView extends BasePageViewWidget<PaidBillsSuccessPageViewModel> {
  PaidBillsSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PaidBillsSuccessPageViewModel model) {
    return AppStreamBuilder<Resource<bool>>(
        stream: model.addNewPostpaidStream,
        initialData: Resource.none(),
        onData: (event) {
          if (event.status == Status.SUCCESS) {
            ///LOG EVENT TO FIREBASE
            FireBaseLogUtil.fireBaseLog("saved_new_post_paid_biller", {"saved_new_post_paid_biller": true});
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
                          child: model.arguments?.isPaid == true
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
                    text: '${double.parse(model.arguments?.amt ?? "0").toStringAsFixed(3)}',
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
                    padding:
                        EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 24.0.h, bottom: 24.0.h),
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
                              StringUtils.isDirectionRTL(context)
                                  ? model.arguments?.billNameAr ?? ""
                                  : model.arguments?.billName ?? "",
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0.t),
                            )
                          ],
                        ),
                        (double.parse(model.arguments?.fee ?? "0") > 0.0)
                            ? SizedBox(height: 16.h)
                            : Container(),
                        (double.parse(model.arguments?.fee ?? "0") > 0.0)
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
                                    '${double.parse(model.arguments?.fee ?? "0").toStringAsFixed(3)} ${S.of(context).JOD}',
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0.t),
                                  )
                                ],
                              )
                            : Container(),
                        model.arguments!.nickName.isNotEmpty ? SizedBox(height: 16.h) : Container(),
                        model.arguments!.nickName.isNotEmpty
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
                                  Spacer(),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      model.arguments?.nickName ?? "",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0.t),
                                    ),
                                  )
                                ],
                              )
                            : Container(),
                        model.arguments?.isPaid == true ? SizedBox(height: 16.h) : Container(),
                        model.arguments?.isPaid == true
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
                                    model.arguments?.refNo ?? "",
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
                              model.arguments?.isPaid == true
                                  ? S.of(context).successS
                                  : S.of(context).failed,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: model.arguments?.isPaid == true ? Colors.green : Colors.red,
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
                    child: model.arguments?.isPaid == true
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: AppSecondaryButton(
                    text: S.of(context).next,
                    onPressed: () {
                      Navigator.of(context)
                        ..pop()
                        ..pop(true);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _shareDetails(BuildContext context, PaidBillsSuccessPageViewModel model) {
    Share.share(
      ShareInfo.newPrePaidSuccess(
        context,
        refNo: model.arguments?.refNo ?? "",
        billerName: StringUtils.isDirectionRTL(context)
            ? model.arguments?.billNameAr ?? ""
            : model.arguments?.billName ?? "",
        amount: '${double.parse(model.arguments?.amt ?? "0").toStringAsFixed(3)}',
        nickName: AppConstantsUtils.NICK_NAME,
      ),
      subject: S.of(context).billDetails,
    );
  }
}
