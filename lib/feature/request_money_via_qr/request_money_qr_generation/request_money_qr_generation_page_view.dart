import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/qr/qr_response.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/request_money_via_qr/qr_screen/qr_screen_page.dart';
import 'package:neo_bank/feature/request_money_via_qr/request_money_qr_generation/request_money_qr_generation_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/numeric_keyboard.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RequestMoneyQrGenerationPageView extends BasePageViewWidget<RequestMoneyQrGenerationPageViewModel> {
  RequestMoneyQrGenerationPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity!.isNegative) {
          } else {
            Navigator.pop(context);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 48.w),
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
                      ),
                      Positioned(
                          bottom: -8,
                          child: LottieBuilder.asset(
                            AssetUtils.swipeDownAnimation,
                            width: 28.0.w,
                            height: 28.0.h,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    S.of(context).backToPayments,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.t,
                        color: AppColor.dark_gray_1),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80.h),
                  child: Text(
                    S.of(context).requestViaQR,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.t,
                        color: AppColor.veryDarkGray2),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 16.h, start: 24.w, end: 24.w),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Directionality(
                      textDirection:
                          StringUtils.isDirectionRTL(context) ? TextDirection.rtl : TextDirection.ltr,
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              model.currentPinValue,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 32.t,
                                  color: AppColor.black),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(bottom: 2.h, start: 4.w),
                              child: Text(
                                S.of(context).JOD,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.verLightGray4,
                                    fontSize: 14.t,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          model.clearValue();
                        },
                        child: AppSvg.asset(AssetUtils.backspaceBlue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 24.h),
                  child: Text(
                    S.of(context).to,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.t,
                        color: AppColor.gray1),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    model.arguments.account.accountTitle ?? '',
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.t,
                        color: AppColor.brightBlue),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        model.arguments.account.availableBalance ?? '',
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.t,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 4.0.w, bottom: 2.h),
                        child: Text(
                          S.of(context).JOD,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.t,
                              color: AppColor.gray1),
                        ),
                      ),
                    ],
                  ),
                ),
                AppStreamBuilder<Resource<QrResponse>>(
                    stream: model.generateQRStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        Navigator.pushNamed(context, RoutePaths.QRScreen,
                            arguments: QrScreenPageArguments(model.arguments.account, model.currentPinValue,
                                data.data?.qrContent?.requestId ?? ''));
                      }
                    },
                    dataBuilder: (context, value) {
                      return Directionality(
                        textDirection: TextDirection.ltr,
                        child: NumericKeyboard(
                            onKeyboardTap: (value) {
                              model.changeValue(value);
                            },
                            textColor: Colors.black,
                            rightButtonFn: () async {
                              ///LOG EVENT TO FIREBASE
                              await FirebaseAnalytics.instance.logEvent(
                                name: "amount_entered",
                                parameters: {"amount": "${model.currentPinValue}"},
                              );
                              if (double.parse(model.currentPinValue) <= 0) {
                                model.showToastWithError(AppError(
                                    cause: Exception(),
                                    error: ErrorInfo(message: ""),
                                    type: ErrorType.AMOUNT_GREATER_THAN_ZERO));
                              } else {
                                model.generateQR();
                              }
                            },
                            leftIcon: Icon(
                              Icons.circle,
                              color: AppColor.black,
                              size: 5,
                            ),
                            rightWidget: CircleAvatar(
                              radius: 30,
                              backgroundColor: AppColor.brightBlue,
                              child: Center(
                                child: AppSvg.asset(AssetUtils.next),
                              ),
                            ),
                            leftButtonFn: () {
                              model.changeValue(".");
                            },
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly),
                      );
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
