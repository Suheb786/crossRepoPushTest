import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_change_linked_mobile_number/dc_change_linked_mobile_number_module.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_linked_mobile_number_page.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_enter_otp/dc_enter_otp_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class DcEnterOtpPageView extends BasePageViewWidget<DcEnterOtpViewModel> {
  DcEnterOtpPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
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
              stream: model.dcEnterOtpStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  Navigator.pushNamed(context, RoutePaths.DcChangeMobileNumberSuccess,
                      arguments: DCChangeLinkedMobileNumberArguments(
                          cardType: ProviderScope.containerOf(context)
                              .read(dcChangeLinkedMobileNumberViewModelProvider)
                              .arguments!
                              .cardType));
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, isOtpVerified) {
                return GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (ProviderScope.containerOf(context)
                            .read(dcChangeLinkedMobileNumberViewModelProvider)
                            .appSwiperController
                            .page ==
                        1.0) {
                      FocusScope.of(context).unfocus();
                      if (StringUtils.isDirectionRTL(context)) {
                        if (!details.primaryVelocity!.isNegative) {
                          model.enterOtp(
                              ProviderScope.containerOf(context)
                                  .read(dcChangeLinkedMobileNumberViewModelProvider)
                                  .arguments!
                                  .tokenizedPan,
                              ProviderScope.containerOf(context)
                                  .read(dcEnterNewMobileNumberViewModelProvider)
                                  .mobileNumberController
                                  .text,
                              ProviderScope.containerOf(context)
                                  .read(dcEnterNewMobileNumberViewModelProvider)
                                  .countryData
                                  .phoneCode,
                              ProviderScope.containerOf(context)
                                  .read(dcChangeLinkedMobileNumberViewModelProvider)
                                  .arguments!
                                  .cardType);
                        } else {
                          ProviderScope.containerOf(context)
                              .read(dcChangeLinkedMobileNumberViewModelProvider)
                              .previousPage();
                        }
                      } else {
                        if (details.primaryVelocity!.isNegative) {
                          model.enterOtp(
                              ProviderScope.containerOf(context)
                                  .read(dcChangeLinkedMobileNumberViewModelProvider)
                                  .arguments!
                                  .tokenizedPan,
                              ProviderScope.containerOf(context)
                                  .read(dcEnterNewMobileNumberViewModelProvider)
                                  .mobileNumberController
                                  .text,
                              ProviderScope.containerOf(context)
                                  .read(dcEnterNewMobileNumberViewModelProvider)
                                  .countryData
                                  .phoneCode,
                              ProviderScope.containerOf(context)
                                  .read(dcChangeLinkedMobileNumberViewModelProvider)
                                  .arguments!
                                  .cardType);
                        } else {
                          ProviderScope.containerOf(context)
                              .read(dcChangeLinkedMobileNumberViewModelProvider)
                              .previousPage();
                        }
                      }
                    }
                  },
                  child: Card(
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
                                    length: 6,
                                    controller: model.otpController,
                                    onChanged: (val) {
                                      model.validate(val);
                                    },
                                  ),
                                  Container()
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
                                              model.updateTime(context);
                                            },
                                            child: Text(
                                              S.of(context).resendCode,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 14,
                                                  color: Theme.of(context).textTheme.bodyMedium!.color!),
                                            ))
                                        : Text(
                                            S.of(context).resendIn(
                                                '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 14,
                                                color: Theme.of(context).textTheme.bodyMedium!.color!),
                                          );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 16.0),
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
                                )
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
    );
  }
}
