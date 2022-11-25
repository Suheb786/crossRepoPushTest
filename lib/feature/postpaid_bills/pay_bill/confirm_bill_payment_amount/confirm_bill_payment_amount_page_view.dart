import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/paid_bills_success/paid_bills_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'confirm_bill_payment_amount_page_view_model.dart';

class ConfirmBillPaymentAmountPageView extends BasePageViewWidget<ConfirmBillPaymentAmountPageViewModel> {
  ConfirmBillPaymentAmountPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          initialData: false,
          stream: model.errorDetectorStream,
          dataBuilder: (context, isError) {
            return ShakeAnimatedWidget(
                enabled: isError ?? false,
                duration: Duration(milliseconds: 100),
                shakeAngle: Rotation.deg(z: 1),
                curve: Curves.easeInOutSine,
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (ProviderScope.containerOf(context)
                            .read(payBillPageViewModelProvider)
                            .appSwiperController
                            .page ==
                        1.0) {
                      FocusScope.of(context).unfocus();

                      if (StringUtils.isDirectionRTL(context)) {
                        if (details.primaryVelocity!.isNegative) {
                          ProviderScope.containerOf(context)
                              .read(payBillPageViewModelProvider)
                              .previousPage();
                        } else {
                          ProviderScope.containerOf(context).read(payBillPageViewModelProvider).nextPage();
                        }
                      } else {
                        if (details.primaryVelocity!.isNegative) {
                          ProviderScope.containerOf(context).read(payBillPageViewModelProvider).nextPage();
                        } else {
                          ProviderScope.containerOf(context)
                              .read(payBillPageViewModelProvider)
                              .previousPage();
                        }
                      }
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                  // padding: EdgeInsets.only(left: 24.0.w, right: 24.0.w, top: 24.0.h),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColor.white_gray),
                                      borderRadius: BorderRadius.circular(12.0)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w, top: 24.0.h),
                                        child: Text(
                                          S.of(context).amount,
                                          style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            color: AppColor.veryDarkGray2,
                                            fontSize: 10.0.t,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AutoSizeTextField(
                                            wrapWords: false,
                                            fullwidth: false,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                                            ],
                                            controller: model.amtController,
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              //  this.onChanged?.call(value);
                                            },
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: AppColor.black,
                                                fontWeight: FontWeight.w700,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 24.0.t),
                                          ),
                                          Text(
                                            S.of(context).JOD,
                                            style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: AppColor.verLightGray4,
                                              fontSize: 14.0.t,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        S.of(context).tapAmtToEdit,
                                        style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.gray1,
                                          fontSize: 10.0.t,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: 16.0.h,
                                          left: 16.0.w,
                                          right: 16.0.w,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              S.of(context).dueAmt,
                                              style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: AppColor.black,
                                                fontSize: 12.0.t,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              '${ProviderScope.containerOf(context).read(payBillDetailPageViewModelProvider).amountTextControl.text} JOD',
                                              style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: AppColor.black,
                                                fontSize: 12.0.t,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: EdgeInsets.only(
                                      //     top: 8.0.h,
                                      //     left: 16.0.w,
                                      //     right: 16.0.w,
                                      //   ),
                                      //   child: Row(
                                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //     children: [
                                      //       Text(
                                      //         S.of(context).fees,
                                      //         style: TextStyle(
                                      //           fontFamily: StringUtils.appFont,
                                      //           color: AppColor.black,
                                      //           fontSize: 12.0.t,
                                      //           fontWeight: FontWeight.w400,
                                      //         ),
                                      //       ),
                                      //       Text(
                                      //         '20.000 JOD',
                                      //         style: TextStyle(
                                      //           fontFamily: StringUtils.appFont,
                                      //           color: AppColor.black,
                                      //           fontSize: 12.0.t,
                                      //           fontWeight: FontWeight.w600,
                                      //         ),
                                      //       )
                                      //     ],
                                      //   ),
                                      // ),
                                      SizedBox(
                                        height: 24.0.h,
                                      ),
                                      Container(
                                        color: AppColor.white_gray,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 40.w,
                                                height: 40.w,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColor.vividYellow,
                                                ),
                                                child: AppSvg.asset(AssetUtils.electricityIcon),
                                              ),
                                              SizedBox(
                                                width: 16.w,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    ProviderScope.containerOf(context).read(payBillDetailPageViewModelProvider).nicknameTextControl.text,
                                                    style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      color: AppColor.veryDarkGray2,
                                                      fontSize: 12.0.t,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    ProviderScope.containerOf(context).read(payBillDetailPageViewModelProvider).billerNameTextController.text,
                                                    style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      color: AppColor.very_dark_gray_black,
                                                      fontSize: 12.0.t,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    ProviderScope.containerOf(context).read(payBillDetailPageViewModelProvider).serviceTypeTextControl.text,
                                                    style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      color: AppColor.veryDarkGray2,
                                                      fontSize: 12.0.t,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                    ProviderScope.containerOf(context).read(payBillDetailPageViewModelProvider).refNoController.text,
                                                    style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      color: AppColor.veryDarkGray2,
                                                      fontSize: 12.0.t,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(
                                height: 107.h,
                              ),
                              GestureDetector(
                                onHorizontalDragEnd: (details) {
                                  if (details.primaryVelocity!.isNegative) {
                                    if(AppConstantsUtils.POST_PAID_FLOW){
                                      ProviderScope.containerOf(context).read(payBillDetailPageViewModelProvider).addNewPostpaidBiller();
                                    }else if(AppConstantsUtils.PRE_PAID_FLOW){
                                      ProviderScope.containerOf(context).read(payBillDetailPageViewModelProvider).addNewPrepaidBiller();
                                    }
                                  }
                                },
                                child: AnimatedButton(
                                  buttonText: S.of(context).swipeToProceed,
                                ),
                              ),
                              SizedBox(
                                height: 23.h,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  S.of(context).cancel,
                                  style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.brightBlue,
                                    fontSize: 14.t,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ));
          }),
    );
  }
}
