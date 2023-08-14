import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/payment/send_money/send_money_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/numeric_keyboard.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SendMoneyPageView extends BasePageViewWidget<SendMoneyViewModel> {
  SendMoneyPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(top: (MediaQuery.of(context).size.height * 0.18) + 10.h),
            child: Text(
              S.of(context).sendMoney,
              style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w400, fontSize: 18.0.t),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 95.0.h, left: 24.0.w, right: 24.0.w),
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
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0.t, fontFamily: StringUtils.appFont, color: AppColor.black),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.0.h, left: 4.0.w),
                        child: Text(
                          S.of(context).JOD,
                          style: TextStyle(fontFamily: StringUtils.appFont, color: AppColor.verLightGray4, fontSize: 16.0.t, fontWeight: FontWeight.w700),
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
                    child: AppSvg.asset(AssetUtils.backspaceBlue),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 49.0.h),
            child: Text(
              S.of(context).accountBalance,
              style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 10.0.t, color: AppColor.dark_gray_1),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.0.h, bottom: 32.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.account!.availableBalance!,
                  style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0.t,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.0.w, top: 2.0.h),
                  child: Text(
                    S.of(context).JOD,
                    style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w700, fontSize: 12.0.t, color: AppColor.dark_gray_1),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: NumericKeyboard(
                  onKeyboardTap: (value) {
                    model.changeValue(value);
                  },
                  textColor: Colors.black,
                  rightButtonFn: () {
                    if (double.parse(model.currentPinValue) <= 0) {
                      model.showToastWithError(AppError(cause: Exception(), error: ErrorInfo(message: ""), type: ErrorType.ZERO_AMOUNT));
                    } else if (double.parse(model.currentPinValue) > double.parse(ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.account!.availableBalance!)) {
                      model.showToastWithError(AppError(cause: Exception(), error: ErrorInfo(message: ''), type: ErrorType.INSUFFICIENT_BALANCE_TRANSFER));
                    } else {
                      Navigator.pushNamed(context, RoutePaths.PaymentToNewRecipient, arguments: model.currentPinValue);
                    }
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
  }
}
