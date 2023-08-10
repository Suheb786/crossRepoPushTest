import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';
import 'package:neo_bank/feature/account_registration/validateotp/validate_otp_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/change_my_number_dialog/change_my_number_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../ui/molecules/button/app_primary_button.dart';
import '../../../utils/color_utils.dart';
import '../manage_idwise_status/manage_idwise_status_page.dart';

class ValidateOtpPageView extends BasePageViewWidget<ValidateOtpViewModel> {
  ValidateOtpPageView(ProviderBase model) : super(model);

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
                stream: model.changeMyNumberStream,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.SUCCESS) {
                    ProviderScope.containerOf(context)
                        .read(accountRegistrationViewModelProvider)
                        .updateMobileNumber(model.mobileNumberParams);
                  }
                },
                dataBuilder: (context, snapshot) {
                  return AppStreamBuilder<Resource<bool>>(
                    stream: model.verifyOtpStream,
                    initialData: Resource.none(),
                    onData: (data) async {
                      if (data.status == Status.SUCCESS) {
                        model.saveUserData();
                        // Navigator.pushReplacementNamed(context, RoutePaths.Dashboard);

                        /* IdWiseHelper idWiseHelper = IdWiseHelper();
                        idWiseHelper.initializeIdWise();
                        var status = await idWiseHelper.startVerification('en');
                        debugPrint("STATUS : ${status.keys.first}");
                        debugPrint("TEXT :  ${status.values.first}");*/

                        Navigator.pushReplacementNamed(context, RoutePaths.ManageIDWiseStatus,
                            arguments: ManageIDWiseStatusParams(journeyId: ''));
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
                                      Center(
                                          child: Padding(
                                        padding: EdgeInsets.only(top: 32.0.h),
                                        child: InkWell(
                                          onTap: () {
                                            ChangeMyNumberDialog.show(context,
                                                countryList: ProviderScope.containerOf(context)
                                                    .read(accountRegistrationViewModelProvider)
                                                    .countryDataList, onDismissed: () {
                                              Navigator.pop(context);
                                            }, onSelected: (country, mobileNo) {
                                              model.mobileNumberParams = MobileNumberParams(
                                                  mobileNumber: mobileNo, mobileCode: country.phoneCode!);
                                              Navigator.pop(context);
                                              model.changeMyNumber(mobileNo, country.phoneCode!);
                                            });
                                          },
                                          child: Text(
                                            S.of(context).changeMyNumber,
                                            style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: Theme.of(context).textTheme.bodyLarge!.color!,
                                              fontSize: 14.t,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      )),
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
                                                    model.updateTime();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    padding: EdgeInsets.all(8.0),
                                                  ),
                                                  child: Text(
                                                    S.of(context).resendCode,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 14.t,
                                                        color: Theme.of(context).textTheme.bodyLarge!.color!),
                                                  ))
                                              : Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Text(
                                                    S.of(context).resendIn(
                                                        '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 14.t,
                                                        color: Theme.of(context).textTheme.bodyLarge!.color!),
                                                  ),
                                                );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20.0.h),
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
                                    InkWell(
                                      onTap: () {
                                        ProviderScope.containerOf(context)
                                            .read(accountRegistrationViewModelProvider)
                                            .previousPage();
                                      },
                                      child: Text(
                                        S.of(context).back,
                                        style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.brightBlue,
                                          fontSize: 14.t,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      );
                    },
                  );
                }),
          );
        },
      ),
    );
  }
}
