import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/payment/request_money/request_money_view_model.dart';
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

class RequestMoneyPageView extends BasePageViewWidget<RequestMoneyViewModel> {
  RequestMoneyPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<Resource<bool>>(
          stream: model.getValueResponseStream,
          initialData: Resource.none(),
          onData: (data) {
            if (data.status == Status.SUCCESS) {
              Navigator.pushNamed(context, RoutePaths.RequestPaymentFromNewRecipient,
                  arguments: model.currentPinValue);
            } else if (data.status == Status.ERROR) {
              model.showToastWithError(data.appError!);
            }
          },
          dataBuilder: (context, data) {
            return GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity!.isNegative) {
                } else {
                  Navigator.pop(context);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 25.0.h),
                          child: Container(
                            height: 50.0.h,
                            width: 281.0.w,
                            decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: -2,
                            child: LottieBuilder.asset(
                              AssetUtils.swipeDownAnimation,
                              width: 28.0.w,
                              height: 28.0.h,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0.h),
                    child: Text(
                      S.of(context).backToPayments,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 12.0.t,
                          fontWeight: FontWeight.w600,
                          color: AppColor.dark_gray_2),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 80.0.h),
                    child: Text(
                      S.of(context).requestMoney,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont, fontWeight: FontWeight.w400, fontSize: 18.0.t),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 88.0.h, start: 24.0.w, end: 24.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText(
                                model.currentPinValue,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40.0.t,
                                    color: AppColor.black),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.only(top: 15.0.h, start: 4.0.w),
                                child: Text(
                                  S.of(context).JOD,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.verLightGray4,
                                      fontSize: 16.0.t,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              onTap: () {
                                model.clearValue();
                              },
                              child: AppSvg.asset(AssetUtils.backspaceBlue)),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 85.0.h),
                    child: Text(
                      S.of(context).accountBalance,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.0.t,
                          color: AppColor.dark_gray_1),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.0.h, bottom: 32.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ProviderScope.containerOf(context)
                              .read(appHomeViewModelProvider)
                              .dashboardDataContent
                              .account!
                              .availableBalance!,
                          style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0.t,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 4.0.w, top: 2.0.h),
                          child: Text(
                            S.of(context).JOD,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.0.t,
                                color: AppColor.dark_gray_1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: NumericKeyboard(
                          onKeyboardTap: (value) {
                            model.changeValue(value);
                          },
                          textColor: Colors.black,
                          rightButtonFn: () {
                            model.requestMoney();
                          },
                          leftIcon: Icon(
                            Icons.circle,
                            color: AppColor.black,
                            size: 5,
                          ),
                          rightWidget: CircleAvatar(
                            radius: 30.0.w,
                            backgroundColor: Color(0xFF3CB4E5),
                            child: Center(
                              child: AppSvg.asset(AssetUtils.next),
                            ),
                          ),
                          leftButtonFn: () {
                            model.changeValue(".");
                          },
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
