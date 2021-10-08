import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/stepone/validateotp/validate_otp_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/utils/color_utils.dart';

import '../../../../generated/l10n.dart';

class ValidateOtpPageView extends BasePageViewWidget<ValidateOtpViewModel> {
  ValidateOtpPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      children: [
        Text(
          S.of(context).accountRegistration,
          style: TextStyle(
              color: AppColor.dark_gray,
              fontSize: 10,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.only(top: 36.0, bottom: 32),
          child: Column(
            children: [
              Text(
                S.of(context).enterOtpHeader,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.very_dark_gray,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "+962 79 322 8080",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.vivid_orange,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Expanded(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 2,
            shadowColor: AppColor.black.withOpacity(0.32),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                decoration: BoxDecoration(
                    color: AppColor.very_soft_violet,
                    gradient: LinearGradient(
                        colors: [
                          AppColor.dark_violet,
                          AppColor.dark_moderate_blue
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          AppOtpFields(
                            length: 6,
                            controller: model.otpController,
                          ),
                          Center(
                              child: Padding(
                            padding: const EdgeInsets.only(top: 32.0),
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                S.of(context).changeMyNumber,
                                style: TextStyle(
                                  color: AppColor.vivid_orange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    CountdownTimer(
                      controller: model.countDownController,
                      onEnd: () {},
                      endTime: model.endTime,
                      textStyle: TextStyle(fontSize: 16, color: AppColor.white),
                      widgetBuilder: (context, currentTimeRemaining) {
                        return currentTimeRemaining == null
                            ? TextButton(
                                onPressed: () {
                                  model.updateTime();
                                },
                                child: Text(
                                  'Resend Code',
                                  style: TextStyle(
                                      fontSize: 14, color: AppColor.white),
                                ))
                            : Text(
                                S.of(context).resendIn(
                                    '${currentTimeRemaining.min ?? 00}:${currentTimeRemaining.sec ?? 00}'),
                                style: TextStyle(
                                    fontSize: 14, color: AppColor.soft_violet),
                              );
                      },
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
