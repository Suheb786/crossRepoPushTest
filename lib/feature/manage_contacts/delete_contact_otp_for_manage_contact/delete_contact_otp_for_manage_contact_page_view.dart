import 'dart:developer';

import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/login/login_module.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

import 'delete_contact_otp_for_manage_contact_page_view_model.dart';

class DeleteContactOTPPageView extends BasePageViewWidget<DeleteContactOTPPageViewModel> {
  DeleteContactOTPPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 24.w, top: 96.h, end: 24.w, bottom: 30.h),
      child: AppKeyBoardHide(
        child: Column(
          children: [
            Text(
              S.of(context).editContact.toUpperCase(),
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 10.t,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0.h, bottom: 0),
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
                      fontSize: 20.t,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 32.h),
              child: ShowUpAnimation(
                delayStart: Duration(milliseconds: 500),
                animationDuration: Duration(milliseconds: 750),
                curve: Curves.bounceIn,
                direction: Direction.vertical,
                offset: 0.5,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    '${ProviderScope.containerOf(context).read(loginViewModelProvider).mobileCode.isNotEmpty ? ProviderScope.containerOf(context).read(loginViewModelProvider).mobileCode.replaceAll('00', '+') : '-'} ${ProviderScope.containerOf(context).read(loginViewModelProvider).mobileNumber}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20.t,
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
                      stream: model.validatedOtpStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          // Navigator.pushReplacementNamed(context, RoutePaths.UserContactDetailsPage);
                          log("message");
                        }
                      },
                      dataBuilder: (context, isOtpVerified) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (details.primaryVelocity!.isNegative) {
                              model.validateOtp();
                            }
                          },
                          child: Expanded(
                            child: Card(
                              margin: EdgeInsets.zero,
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
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
                                                fontSize: 16.t,
                                                color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                                            widgetBuilder: (context, currentTimeRemaining) {
                                              return currentTimeRemaining == null
                                                  ? TextButton(
                                                      onPressed: () {
                                                        model.updateTime();
                                                      },
                                                      child: Text(
                                                        S.of(context).resendCode,
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            fontSize: 14.t,
                                                            fontWeight: FontWeight.w600,
                                                            color: Theme.of(context)
                                                                .accentTextTheme
                                                                .bodyText1!
                                                                .color!),
                                                      ))
                                                  : Text(
                                                      S.of(context).resendIn(
                                                          '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          fontSize: 14.t,
                                                          fontWeight: FontWeight.w600,
                                                          color: Theme.of(context)
                                                              .accentTextTheme
                                                              .bodyText1!
                                                              .color!),
                                                    );
                                            },
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 16.0.h),
                                            child: AppStreamBuilder<bool>(
                                                stream: model.showButtonStream,
                                                initialData: false,
                                                dataBuilder: (context, isValid) {
                                                  return Visibility(
                                                    visible: isValid!,
                                                    child: AnimatedButton(
                                                      buttonHeight: 50,
                                                      buttonText: S.of(context).swipeToProceed,
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
