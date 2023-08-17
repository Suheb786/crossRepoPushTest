import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/credit_card_pay_back/credit_card_pay_back_page_view_model.dart';
import 'package:neo_bank/feature/credit_card_pay_back_success/credit_card_pay_back_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/numeric_keyboard.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CreditCardPayBackPageView extends BasePageViewWidget<CreditCardPayBackPageModel> {
  CreditCardPayBackPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CreditCardPayBackPageModel model) {
    return Scaffold(
      body: AppStreamBuilder<Resource<bool>>(
          stream: model.payBackCreditCardStream,
          initialData: Resource.none(),
          onData: (data) {
            if (data.status == Status.SUCCESS) {
              Navigator.pushNamed(context, RoutePaths.CreditCardPayBackSuccess,
                  arguments: CreditCardPayBackSuccessArguments(payBackAmount: model.currentPinValue, accountHolderName: model.payBackArguments.accountHolderName));
            }
          },
          dataBuilder: (context, snapshot) {
            return Container(
              margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.20)),
              child: Column(
                children: [
                  Text(
                    S.of(context).payBack,
                    style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w400, fontSize: 20.t),
                  ),
                  Text(
                    S.of(context).myCreditCard,
                    style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 20.t),
                  ),
                  Spacer(),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width / 4.5),
                            child: Directionality(
                              textDirection: StringUtils.isDirectionRTL(context) ? TextDirection.rtl : TextDirection.ltr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: AutoSizeText(model.currentPinValue,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.t, fontFamily: StringUtils.appFont, color: AppColor.black)),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(bottom: 10.0.h, start: 4.0.w),
                                    child: Text(S.of(context).JOD,
                                        textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.t, fontFamily: StringUtils.appFont, color: AppColor.verLightGray4)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 2),
                            child: GestureDetector(
                                onTap: () {
                                  model.clearValue();
                                },
                                child: Icon(
                                  Icons.backspace,
                                  color: Theme.of(context).textTheme.bodyLarge?.color ?? AppColor.brightBlue,
                                  size: 30,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => model.changeMidDueValue(),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.45,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          margin: EdgeInsetsDirectional.only(start: MediaQuery.of(context).size.width / 13.5, end: 10),
                          decoration: BoxDecoration(border: Border.all(color: Theme.of(context).textTheme.bodyLarge?.color ?? AppColor.brightBlue), borderRadius: BorderRadius.circular(15.w)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(S.of(context).minDue, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.t, fontFamily: StringUtils.appFont, color: AppColor.verLightGray4)),
                              Text(model.payBackArguments.minDuePayBackAmount, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.t, fontFamily: StringUtils.appFont, color: AppColor.black))
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => model.changeTotalDueValue(),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.45,
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          margin: EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width / 13.5),
                          decoration: BoxDecoration(border: Border.all(color: Theme.of(context).textTheme.bodyLarge?.color ?? AppColor.brightBlue), borderRadius: BorderRadius.circular(15.w)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(S.of(context).totalDue, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.t, fontFamily: StringUtils.appFont, color: AppColor.verLightGray4)),
                              Text(model.payBackArguments.totalMinDueAmount, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.t, fontFamily: StringUtils.appFont, color: AppColor.black))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Column(
                      children: [
                        Text(S.of(context).accountBalance, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10.t, fontFamily: StringUtils.appFont, color: AppColor.verLightGray4)),
                        SizedBox(height: 1.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(model.payBackArguments.accountBalance, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.t, fontFamily: StringUtils.appFont, color: AppColor.black)),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(S.of(context).JOD, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.t, fontFamily: StringUtils.appFont, color: AppColor.verLightGray4))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: NumericKeyboard(
                        onKeyboardTap: (value) {
                          model.changeValue(value);
                        },
                        textColor: AppColor.black,
                        rightButtonFn: () {
                          // if (model.payBackArguments.minDuePayBackAmount ==
                          //         '0.0' ||
                          //     model.payBackArguments.totalMinDueAmount ==
                          //         '0.0') {
                          //   model.showToastWithError(AppError(
                          //       cause: Exception(),
                          //       error: ErrorInfo(message: ''),
                          //       type: ErrorType.NO_DUE_AMOUNT));
                          // } else
                          // if (num.parse(model.currentPinValue) < 0) {
                          //   model.showToastWithError(AppError(
                          //       cause: Exception(),
                          //       error: ErrorInfo(message: ''),
                          //       type: ErrorType.ZERO_AMOUNT));
                          // }
                          // else {
                          //   model.payBackCreditCard();
                          // }
                          if (num.parse(model.currentPinValue) > num.parse(model.payBackArguments.accountBalance)) {
                            model.showToastWithError(AppError(cause: Exception(), error: ErrorInfo(message: ''), type: ErrorType.INVALID_ACCOUNT_BALANCE));
                          } else if (!(num.parse(model.currentPinValue) > 0)) {
                            model.showToastWithError(AppError(cause: Exception(), error: ErrorInfo(message: ''), type: ErrorType.AMOUNT_GREATER_THAN_ZERO));
                          } else {
                            model.payBackCreditCard();
                          }
                        },
                        leftIcon: Icon(
                          Icons.circle,
                          color: AppColor.black,
                          size: 5,
                        ),
                        rightWidget: CircleAvatar(
                          radius: 30.w,
                          backgroundColor: Color(0xFF3CB4E5),
                          child: Center(child: AppSvg.asset(AssetUtils.next)),
                        ),
                        leftButtonFn: () {
                          model.changeValue('.');
                        },
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly),
                  ),
                  Spacer(),
                ],
              ),
            );
          }),
    );
  }
}
