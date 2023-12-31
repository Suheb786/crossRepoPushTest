import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/profile_settings/profile_changed_success_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/enter_code_for_change_mobile_number/enter_code_for_change_mobile_number_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../ui/molecules/button/app_primary_button.dart';
import '../../../../utils/color_utils.dart';

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
                  model.saveUserData();
                  model.showSuccessToast(S.of(context).mobileNumberUpdated);
                  Navigator.pop(context, true);
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, isOtpVerified) {
                return Card(
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
                                    color: Theme.of(context).textTheme.bodyMedium!.color!),
                                widgetBuilder: (context, currentTimeRemaining) {
                                  return currentTimeRemaining == null
                                      ? TextButton(
                                          onPressed: () {
                                            model.changeOtp(
                                                mobileNo: ProviderScope.containerOf(context)
                                                    .read(addNewMobileNumberViewModelProvider)
                                                    .mobileNumber,
                                                mobileCode: ProviderScope.containerOf(context)
                                                    .read(addNewMobileNumberViewModelProvider)
                                                    .countryData
                                                    .phoneCode!);
                                          },
                                          child: Text(
                                            S.of(context).resendCode,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 14.t,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context).textTheme.bodyLarge!.color!),
                                          ))
                                      : Text(
                                          S.of(context).resendIn(
                                              '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 14.t,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).textTheme.bodyLarge!.color!),
                                        );
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16.0.h, bottom: 16.h),
                                child: AppStreamBuilder<bool>(
                                    stream: model.showButtonStream,
                                    initialData: false,
                                    dataBuilder: (context, isValid) {
                                      return AppPrimaryButton(
                                        text: S.of(context).next,
                                        isDisabled: !isValid!,
                                        onPressed: () {
                                          model.validateOtp(
                                              mobile: ProviderScope.containerOf(context)
                                                  .read(addNewMobileNumberViewModelProvider)
                                                  .mobileNumber,
                                              mobileCode: ProviderScope.containerOf(context)
                                                  .read(addNewMobileNumberViewModelProvider)
                                                  .countryData
                                                  .phoneCode!);
                                        },
                                      );
                                    }),
                              ),
                              InkWell(
                                onTap: () {
                                  ProviderScope.containerOf(context)
                                      .read(changeMobileNumberViewModelProvider)
                                      .previousPage();
                                },
                                child: Text(
                                  S.current.back,
                                  style: TextStyle(
                                    color: AppColor.brightBlue,
                                    fontSize: 14.t,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
