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
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CreditCardPayBackPageView extends BasePageViewWidget<CreditCardPayBackPageModel> {
  CreditCardPayBackPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CreditCardPayBackPageModel model) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.primaryDelta!.isNegative) {
            Navigator.pop(context);
          }
        },
        child: AppStreamBuilder<Resource<bool>>(
            stream: model.payBackCreditCardStream,
            initialData: Resource.none(),
            onData: (data) {
              if (data.status == Status.SUCCESS) {
                Navigator.pushNamed(context, RoutePaths.CreditCardPayBackSuccess,
                    arguments: CreditCardPayBackSuccessArguments(
                        payBackAmount: model.currentPinValue,
                        accountHolderName: model.payBackArguments.accountHolderName));
              }
            },
            dataBuilder: (context, snapshot) {
              return Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 48),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))),
                      ),
                      Positioned(
                          bottom: -8,
                          child: LottieBuilder.asset(
                            AssetUtils.swipeDownAnimation,
                            width: 28.0,
                            height: 28.0,
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      S.of(context).backToDashboard,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: AppColor.dark_gray_1),
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          S.of(context).payBack,
                          style:
                              TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                        Text(
                          S.of(context).myCreditCard,
                          style:
                              TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        SizedBox(height: 32),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsetsDirectional.only(
                                      start: MediaQuery.of(context).size.width / 4.5),
                                  child: Directionality(
                                    textDirection: StringUtils.isDirectionRTL(context)
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: AutoSizeText(model.currentPinValue,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 40,
                                                  fontFamily: 'Montserrat',
                                                  color: AppColor.black)),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Text(S.of(context).JOD,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  fontFamily: 'Montserrat',
                                                  color: AppColor.verLightGray4)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                    onTap: () {
                                      model.updateValue();
                                    },
                                    child: Icon(
                                      Icons.backspace,
                                      color: Colors.blue,
                                      size: 30,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.45,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              margin: EdgeInsetsDirectional.only(
                                  start: MediaQuery.of(context).size.width / 13.5, end: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(S.of(context).minDue,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10,
                                          fontFamily: 'Montserrat',
                                          color: AppColor.verLightGray4)),
                                  Text(model.payBackArguments.minDuePayBackAmount,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color: AppColor.black))
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.45,
                              padding: EdgeInsets.symmetric(vertical: 15),
                              margin:
                                  EdgeInsetsDirectional.only(end: MediaQuery.of(context).size.width / 13.5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(S.of(context).totalDue,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10,
                                          fontFamily: 'Montserrat',
                                          color: AppColor.verLightGray4)),
                                  Text(model.payBackArguments.totalMinDueAmount,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          fontFamily: 'Montserrat',
                                          color: AppColor.black))
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                            child: Column(children: [
                          Text(S.of(context).accountBalance,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  fontFamily: 'Montserrat',
                                  color: AppColor.verLightGray4)),
                          Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(model.payBackArguments.accountBalance,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat',
                                      color: AppColor.black)),
                              SizedBox(
                                width: 5,
                              ),
                              Text(S.of(context).JOD,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      fontFamily: 'Montserrat',
                                      color: AppColor.verLightGray4))
                            ],
                          )),
                        ])),
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
                                if (num.parse(model.currentPinValue) >
                                    num.parse(model.payBackArguments.accountBalance)) {
                                  model.showToastWithError(AppError(
                                      cause: Exception(),
                                      error: ErrorInfo(message: ''),
                                      type: ErrorType.INVALID_ACCOUNT_BALANCE));
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
                                radius: 30,
                                backgroundColor: Color(0xFF3CB4E5),
                                child: Center(child: AppSvg.asset(AssetUtils.next)),
                              ),
                              leftButtonFn: () {
                                model.changeValue('.');
                              },
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
