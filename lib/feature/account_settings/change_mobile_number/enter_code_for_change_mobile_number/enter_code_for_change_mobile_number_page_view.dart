import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/profile_settings/profile_changed_success_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/enter_code_for_change_mobile_number/enter_code_for_change_mobile_number_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class EnterCodeForChangeMobileNumberPageView
    extends BasePageViewWidget<EnterCodeForChangeMobileNumberPageViewModel> {
  EnterCodeForChangeMobileNumberPageView(ProviderBase model) : super(model);

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
            child: AppStreamBuilder<Resource<ProfileChangedSuccessResponse>>(
              stream: model.verifyOtpStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  Navigator.pop(context);
                  model.showSuccessToast(data.data!.data!.data!);
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, isOtpVerified) {
                return GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity!.isNegative) {
                      model.validateOtp(
                          mobile: ProviderScope.containerOf(context)
                              .read(addNewMobileNumberViewModelProvider)
                              .mobileNumber,
                          mobileCode: ProviderScope.containerOf(context)
                              .read(addNewMobileNumberViewModelProvider)
                              .countryData
                              .phoneCode!);
                    } else {
                      ProviderScope.containerOf(context)
                          .read(changeMobileNumberViewModelProvider)
                          .swiperController
                          .previous(animation: true);
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Column(
                                children: [
                                  AppOtpFields(
                                    length: 6,
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
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .accentTextTheme
                                          .bodyText1!
                                          .color!),
                                  widgetBuilder:
                                      (context, currentTimeRemaining) {
                                    return currentTimeRemaining == null
                                        ? TextButton(
                                            onPressed: () {
                                              model.updateTime();
                                            },
                                            child: Text(
                                              'Resend Code',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context)
                                                      .accentTextTheme
                                                      .bodyText1!
                                                      .color!),
                                            ))
                                        : Text(
                                            S.of(context).resendIn(
                                                '${currentTimeRemaining.min ?? 00}:${currentTimeRemaining.sec ?? 00}'),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .accentTextTheme
                                                    .bodyText1!
                                                    .color!),
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
                                            buttonText:
                                                S.of(context).swipeToProceed,
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).viewInsets.bottom,
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
