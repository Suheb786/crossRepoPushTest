import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';

import 'otp_for_manage_contact_page_view_model.dart';

class OtpForManageContactPageView extends BasePageViewWidget<OtpForManageContactPageViewModel> {
  OtpForManageContactPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container();
    /*return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 56.h),
      child: AppKeyBoardHide(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 36.h),
                child: Container(
                  height: 4.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).primaryColorLight.withOpacity(0.3)),
                )),
            Text(
              S.of(context).switchDevice,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: Theme.of(context).accentColor,
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
                      color: Theme.of(context).accentColor,
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
                        color: Theme.of(context).accentColor,
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
                      stream: model.verifyOtpStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          model.depersonalizeUserData();
                          model.saveUserData();
                          Navigator.pushReplacementNamed(context, RoutePaths.ChangeDeviceSuccess);
                        } else if (data.status == Status.ERROR) {
                          model.showToastWithError(data.appError!);
                        }
                      },
                      dataBuilder: (context, isOtpVerified) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (details.primaryVelocity!.isNegative) {
                              model.validateOtp();
                            }
                          },
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
                                                      model.resendOtp();
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
    );*/
  }
}
