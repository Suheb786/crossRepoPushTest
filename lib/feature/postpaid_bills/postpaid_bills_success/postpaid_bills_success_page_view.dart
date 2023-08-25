import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/postpaid_bills/postpaid_bills_success/postpaid_bills_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_secondary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PostPaidBillsSuccessPageView extends BasePageViewWidget<PostPaidBillsSuccessPageViewModel> {
  PostPaidBillsSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PostPaidBillsSuccessPageViewModel model) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
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
                      child: model.addAllBillAmt() > 0.0
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
                text: model.addAllBillAmt().toStringAsFixed(3),
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
            Padding(
              padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.0.w),
              child: Text(
                S.of(context).submittedFor,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.0.t),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 40.0.h, start: 24.w, end: 24.0.w),
              child: Card(
                child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 15.w, end: 19.w, top: 16.0.h, bottom: 16.0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.black,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 16.0.w, end: 16.0.w, top: 16.0.h, bottom: 16.h),
                                    child: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.0.t),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.getBillerName(
                                          context, model.arguments.billerSuccessDetailsList![index]),
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0.t),
                                    ),
                                    (model.arguments.billerSuccessDetailsList?[index].fee != null &&
                                            double.parse(
                                                    model.arguments.billerSuccessDetailsList?[index].fee ??
                                                        "0") >
                                                0.0)
                                        ? Text(S.of(context).fees,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: AppColor.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.0.t))
                                        : Container(),
                                    /* model.arguments.billerSuccessDetailsList?[index].isPaid == true
                                        ? Text(
                                            S.of(context).refTitle,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: AppColor.veryDarkGray2,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.0.t),
                                          )
                                        : Container(),*/
                                    // Text(
                                    //   S.of(context).status,
                                    //   style: TextStyle(
                                    //       fontFamily: StringUtils.appFont,
                                    //       color: AppColor.veryDarkGray2,
                                    //       fontWeight: FontWeight.w400,
                                    //       fontSize: 12.0.t),
                                    // )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.0.w,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${double.parse(model.arguments.billerSuccessDetailsList?[index].dueAmount ?? "0").toStringAsFixed(3)} ${S.of(context).JOD} ',
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: AppColor.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.0.t),
                                  ),
                                  (model.arguments.billerSuccessDetailsList?[index].fee != null &&
                                          double.parse(model.arguments.billerSuccessDetailsList?[index].fee ??
                                                  "0") >
                                              0.0)
                                      ? Text(
                                          '${double.parse(model.arguments.billerSuccessDetailsList?[index].fee ?? "0").toStringAsFixed(3)} ${S.of(context).JOD} ',
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: AppColor.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.0.t),
                                        )
                                      : Container(),
                                  /* model.arguments.billerSuccessDetailsList?[index].isPaid == true
                                      ? Text(
                                          model.arguments.billerSuccessDetailsList?[index].refNo ?? "",
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: AppColor.gray5,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.0.t),
                                        )
                                      : Container(),*/
                                  /* Text(
                                    model.arguments.billerSuccessDetailsList?[index].isPaid == true
                                        ? S.of(context).successS
                                        : S.of(context).failed,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: model.arguments.billerSuccessDetailsList?[index].isPaid == true
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.0.t),
                                  ),*/
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return AppDivider();
                    },
                    itemCount: model.arguments.billerSuccessDetailsList!.length),
              ),
            ),
            // Padding(
            //   padding: EdgeInsetsDirectional.only(top: 25.0.h),
            //   child: GestureDetector(
            //     onTap: () {
            //       _shareDetails(context, model);
            //     },
            //     child: model.addAllBillAmt() > 0.0
            //         ? Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               AppSvg.asset(AssetUtils.share, color: AppColor.light_acccent_blue),
            //               SizedBox(
            //                 width: 8.w,
            //               ),
            //               Text(
            //                 S.of(context).shareMyReceipt,
            //                 style: TextStyle(
            //                   fontFamily: StringUtils.appFont,
            //                   fontWeight: FontWeight.w600,
            //                   color: AppColor.light_acccent_blue,
            //                   fontSize: 14.t,
            //                 ),
            //               )
            //             ],
            //           )
            //         : Container(),
            //   ),
            // ),
            /*SizedBox(
              height: 85.h,
            ),*/
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: AppSecondaryButton(
                text: S.of(context).done,
                onPressed: () {
                  Navigator.of(context)
                    ..pop()
                    ..pop()
                    ..pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

// void _shareDetails(BuildContext context, PostPaidBillsSuccessPageViewModel model) {
//   Share.share(
//     ShareInfo.savedMultipleBillsPostPaidSuccess(
//       context,
//       paidBillsList: model.arguments.billerSuccessDetailsList ?? [],
//     ),
//     subject: S.of(context).billDetails,
//   );
// }
}
