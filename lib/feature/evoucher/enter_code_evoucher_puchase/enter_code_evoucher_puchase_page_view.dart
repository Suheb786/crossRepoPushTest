import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/enter_code_evoucher_puchase/enter_code_evoucher_puchase_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../../ui/molecules/button/app_primary_button.dart';

class EnterCodeEVoucherPurchasePageView extends BasePageViewWidget<EnterCodeEVoucherPurchasePageViewModel> {
  EnterCodeEVoucherPurchasePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 24, end: 24, top: 60, bottom: 36),
      child: AppKeyBoardHide(
        child: Column(
          children: [
            Text(
              S.of(context).eVouchers.toUpperCase(),
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 0),
              child: ShowUpAnimation(
                key: ValueKey(0),
                delayStart: Duration(milliseconds: 50),
                animationDuration: Duration(milliseconds: 750),
                curve: Curves.easeInOut,
                direction: Direction.vertical,
                offset: 0.5,
                child: Text(
                  S.of(context).enterOtpHeader,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: ShowUpAnimation(
                delayStart: Duration(milliseconds: 500),
                animationDuration: Duration(milliseconds: 750),
                curve: Curves.bounceIn,
                direction: Direction.vertical,
                offset: 0.5,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    '+962 79 322 8080',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            Expanded(
              child: AppStreamBuilder<bool>(
                stream: model.errorDetectorStream,
                initialData: false,
                dataBuilder: (context, isValid) {
                  return ShakeAnimatedWidget(
                      enabled: isValid ?? false,
                      duration: Duration(milliseconds: 100),
                      shakeAngle: Rotation.deg(z: 1),
                      curve: Curves.easeInOutSine,
                      child: AppStreamBuilder<Resource<bool>>(
                          stream: model.enterCodeEVoucherPurchaseStream,
                          initialData: Resource.none(),
                          onData: (data) {
                            if (data.status == Status.SUCCESS) {
                              Navigator.pushNamed(context, RoutePaths.EVouchersPurchaseSuccess);
                            } else if (data.status == Status.ERROR) {
                              model.showToastWithError(data.appError!);
                            }
                          },
                          dataBuilder: (context, snapshot) {
                            return Card(
                              margin: EdgeInsets.zero,
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SingleChildScrollView(
                                        physics: ClampingScrollPhysics(),
                                        child: Column(
                                          children: [
                                            AppOtpFields(
                                              autoFocus: true,
                                              length: 6,
                                              controller: model.otpController,
                                              onChanged: (val) {
                                                model.validate(val);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          CountdownTimer(
                                            controller: model.countDownController,
                                            onEnd: () {},
                                            endTime: model.endTime,
                                            textStyle: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 16,
                                                color: Theme.of(context).textTheme.bodyMedium!.color!),
                                            widgetBuilder: (context, currentTimeRemaining) {
                                              return currentTimeRemaining == null
                                                  ? TextButton(
                                                      onPressed: () {
                                                        ///TODO:resend otp
                                                      },
                                                      child: Text(
                                                        S.of(context).resendCode,
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w600,
                                                            color: Theme.of(context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .color!),
                                                      ))
                                                  : Text(
                                                      S.of(context).resendIn(
                                                          '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                          color: Theme.of(context)
                                                              .textTheme
                                                              .bodyLarge!
                                                              .color!),
                                                    );
                                            },
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 16.0.h,bottom: 16.0.h),
                                            child: AppStreamBuilder<bool>(
                                                stream: model.showButtonStream,
                                                initialData: false,
                                                dataBuilder: (context, isValid) {
                                                  return AppPrimaryButton(
                                                    text: S.of(context).next,
                                                    isDisabled: !isValid!,
                                                    onPressed: () {
                                                      model.validateOtp();
                                                    },
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
