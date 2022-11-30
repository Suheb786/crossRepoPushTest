import 'package:animated_widgets/animated_widgets.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/prepaid_bill/prepaid_bills_success/prepaid_bills_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'confirm_prepaid_bill_payment_amount_page_view_model.dart';

class ConfirmPrePaidBillPaymentAmountPageView
    extends BasePageViewWidget<ConfirmPrePaidBillPaymentAmountPageViewModel> {
  ConfirmPrePaidBillPaymentAmountPageView(ProviderBase model) : super(model);

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
                            .read(payPrePaidBillPageViewModelProvider)
                            .appSwiperController
                            .page ==
                        1.0) {
                      FocusScope.of(context).unfocus();

                      if (StringUtils.isDirectionRTL(context)) {
                        if (details.primaryVelocity!.isNegative) {
                          ProviderScope.containerOf(context)
                              .read(payPrePaidBillPageViewModelProvider)
                              .previousPage();
                        } else {
                          ProviderScope.containerOf(context)
                              .read(payPrePaidBillPageViewModelProvider)
                              .nextPage();
                        }
                      } else {
                        if (details.primaryVelocity!.isNegative) {
                          print('1');
                          ProviderScope.containerOf(context)
                              .read(payPrePaidBillPageViewModelProvider)
                              .nextPage();
                        } else {
                          print('2');
                          ProviderScope.containerOf(context)
                              .read(payPrePaidBillPageViewModelProvider)
                              .previousPage();
                        }
                      }
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
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
                                        S.of(context).amount.toUpperCase(),
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
                                        Text(
                                          S.of(context).amt,
                                          style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            color: AppColor.black,
                                            fontSize: 24.0.t,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.0.w,
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
                                                  'New Home Internet',
                                                  style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    color: AppColor.veryDarkGray2,
                                                    fontSize: 12.0.t,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  'Orange Internet',
                                                  style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    color: AppColor.very_dark_gray_black,
                                                    fontSize: 12.0.t,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  'Internet Bill Payment',
                                                  style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    color: AppColor.veryDarkGray2,
                                                    fontSize: 12.0.t,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  'A121451200',
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
                            Spacer(),
                            GestureDetector(
                              onHorizontalDragEnd: (details) {
                                if (details.primaryVelocity!.isNegative) {
/*
                                  Navigator.pushNamed(context, RoutePaths.PrePaidBillsSuccessPage,
                                      arguments: PrePaidBillsSuccessPageArguments(
                                          '21000',
                                          'Orange Mobile and Net Every..',
                                          'New Home Internet',
                                          '123142141213'));
*/
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
                            /*SizedBox(
                              height: 220.h,
                            ),*/
                          ],
                        )),
                  ),
                ));
          }),
    );
  }
}
