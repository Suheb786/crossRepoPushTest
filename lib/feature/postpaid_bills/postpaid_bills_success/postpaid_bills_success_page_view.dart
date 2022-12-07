import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_postpaid_biller_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/postpaid_bills/postpaid_bills_success/postpaid_bills_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PostPaidBillsSuccessPageView extends BasePageViewWidget<PostPaidBillsSuccessPageViewModel> {
  PostPaidBillsSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PostPaidBillsSuccessPageViewModel model) {
    return AppStreamBuilder<Resource<bool>>(
      stream: model.addNewPostpaidStream,
      initialData: Resource.none(),
      onData: (event) {
        if (event.status == Status.SUCCESS) {
          model.showSuccessToast('Biller Added Successfully.');
        } else if (event.status == Status.ERROR) {
          model.showToastWithError(event.appError!);
        }
      },
      dataBuilder: (context, snapshot) {
        return GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity!.isNegative) {
              Navigator.of(context)
                ..pop()
                ..pop()
                ..pop();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 92.h,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        AssetUtils.line,
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
                          child: Center(
                              child: AppSvg.asset(
                            AssetUtils.right,
                          )),
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
                    text: S.of(context).JOD,
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
                  padding:
                      EdgeInsets.only(top: 40.0.h, right: 24.w, left: 24.0.w),
                  child: Card(
                    child: ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 15.w,
                                end: 19.w,
                                top: 16.0.h,
                                bottom: 16.0.h),
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
                                            start: 16.0.w,
                                            end: 16.0.w,
                                            top: 16.0.h,
                                            bottom: 16.h),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          model.arguments.billerList?[index]
                                                  .billerName ??
                                              "",
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: AppColor.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0.t),
                                        ),
                                        Text(
                                          S.of(context).refTitle,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: AppColor.veryDarkGray2,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.0.t),
                                        )
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
                                        '${double.parse(model.arguments.billerList?[index].totalAmount ?? "0").toStringAsFixed(3)} ${S.of(context).JOD} ',
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            color: AppColor.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.0.t),
                                      ),
                                      Text(
                                        model.arguments.billerList?[index]
                                                .refNo ??
                                            "",
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            color: AppColor.gray5,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.0.t),
                                      ),
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
                        itemCount: model.arguments.billerList!.length),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppSvg.asset(AssetUtils.share,
                          color: AppColor.light_acccent_blue),
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
                  ),
                ),
                SizedBox(
                  height: 85.h,
                ),
                AnimatedButton(
                  buttonText: S.of(context).swipeToProceed,
                  textColor: Theme.of(context).accentColor,
                  borderColor: Theme.of(context).accentColor,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
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
          ),
        );
      },
    );
  }
}
