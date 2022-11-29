import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'otp_for_edit_alias_mobile_no_page_view_model.dart';

class OtpForEditAliasAndMobileNoPageView extends BasePageViewWidget<OtpForEditAliasAndMobileNoPageViewModel> {
  OtpForEditAliasAndMobileNoPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 96.0.h, start: 24.w, end: 24.w, bottom: 36.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).createNewCliqId,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 10.t,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              S.of(context).enterOtpHeader + "+962 79 322 8080",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.t,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 32.h,
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
                        stream: model.enterOtpForCliqIdStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            if (data.data!) {
                              //    Navigator.pushReplacementNamed(context, RoutePaths.CliqIdCreationSuccess);
                            }
                          }
                        },
                        dataBuilder: (context, enterOtpForCliqResponse) {
                          return GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (details.primaryVelocity!.isNegative) {
                                //  Navigator.pushNamed(context, RoutePaths.OtpForEditAliasAndMobileNoPage);
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        AppOtpFields(
                                          length: 6,
                                          controller: model.otpController,
                                          onChanged: (val) {
                                            model.validate(val);
                                          },
                                        ),
                                      ],
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
                                                    onPressed: () {},
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
                                        AppStreamBuilder<bool>(
                                          stream: model.showButtonStream,
                                          initialData: false,
                                          dataBuilder: (BuildContext context, isValid) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                top: 26.0.h,
                                              ),
                                              child: Visibility(
                                                visible: isValid!,
                                                child:
                                                    AnimatedButton(buttonText: S.of(context).swipeToProceed),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
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
