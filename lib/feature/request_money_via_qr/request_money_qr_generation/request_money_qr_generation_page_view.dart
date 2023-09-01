import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/qr/qr_response.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infobip_mobilemessaging/infobip_mobilemessaging.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/account_swiching/payment_account_switcher.dart';
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

import '../../../di/dashboard/dashboard_modules.dart';

class RequestMoneyQrGenerationPageView extends BasePageViewWidget<RequestMoneyQrGenerationPageViewModel> {
  RequestMoneyQrGenerationPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
                top: (MediaQuery.of(context).size.height * 0.14) +
                    (MediaQuery.of(context).size.height * 0.08)),
            child: Text(
              S.of(context).requestViaQR,
              style:
                  TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w400, fontSize: 20.0.t),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 95.0.h, left: 24.0.w, right: 24.0.w),
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
            padding: EdgeInsets.only(top: 8.0.h, bottom: 32.0.h),
            child: PaymentAccountSwitcher(
              title: S.of(context).to.toUpperCase(),
              onDefaultSelectedAccount: (Account account) {
                model.selectedAccount = account;
              },
              onSelectAccount: (Account account) {
                model.selectedAccount = account;
              },
              isSingleLineView: true,
            ),
          ),
          AppStreamBuilder<Resource<QrResponse>>(
              stream: model.generateQRStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  ///Log event to infobip
                  var event = {
                    "definitionId": "LinkQRGenerated",
                    "properties": {"completed": true}
                  };
                  InfobipMobilemessaging.submitEventImmediately(event);

                  Navigator.pushNamed(context, RoutePaths.QRScreen,
                      arguments: QrScreenPageArguments(model.arguments.account, model.currentPinValue,
                          data.data?.qrContent?.requestId ?? ''));
                }
              },
              dataBuilder: (context, value) {
                return Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.06),
                  child: Directionality(
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
                  ),
                );
              }),
        ],
      ),
    );
  }
}
