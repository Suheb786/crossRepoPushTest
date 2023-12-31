import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
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

import '../account_swiching/payment_account_switcher.dart';
import '../request_payment_from_new_recipient/request_payment_from_new_recipient_page.dart';

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
                  arguments: RequestPaymentFromNewRecipientArgument(
                      account: model.selectedAccount, currentPin: model.currentPinValue));
            } else if (data.status == Status.ERROR) {
              model.showToastWithError(data.appError!);
            }
          },
          dataBuilder: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: (MediaQuery.of(context).size.height * 0.14) +
                          (MediaQuery.of(context).size.height * 0.08)),
                  child: Text(
                    S.of(context).requestMoney,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont, fontWeight: FontWeight.w400, fontSize: 20.0.t),
                  ),
                ),
                Spacer(),
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
                              padding: EdgeInsetsDirectional.only(top: 6.0.h, start: 4.0.w),
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
                        alignment: AlignmentDirectional.centerEnd,
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
                  padding: EdgeInsets.only(top: 22.0.h, bottom: 32.0.h),
                  child: PaymentAccountSwitcher(
                    title: S.of(context).transferFrom,
                    onDefaultSelectedAccount: (Account account) {
                      model.selectedAccount = account;
                    },
                    onSelectAccount: (Account account) {
                      model.selectedAccount = account;
                    },
                    isSingleLineView: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.06),
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
            );
          }),
    );
  }
}
