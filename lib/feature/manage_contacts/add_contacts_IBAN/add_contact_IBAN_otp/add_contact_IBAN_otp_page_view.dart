import 'dart:developer';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/manage_contacts/manage_contacts_modules.dart';
import 'package:neo_bank/feature/manage_contacts/add_contacts_IBAN/add_contact_IBAN_otp/add_contact_IBAN_otp_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:riverpod/src/framework.dart';

class AddContactIBANotpPageView extends BasePageViewWidget<AddContactIBANotpPageViewModel> {
  AddContactIBANotpPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, AddContactIBANotpPageViewModel model) {
    return AppStreamBuilder<bool>(
        stream: model.errorDetectorStream,
        initialData: false,
        dataBuilder: (context, isValid) {
          return ShakeAnimatedWidget(
              enabled: isValid ?? false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: AppStreamBuilder<Resource<bool>>(
                  stream: model.addcontactIbanOTPValidationStream,
                  initialData: Resource.none(),
                  onData: (value) {
                    if (value.status == Status.SUCCESS) {
                      Navigator.pushReplacementNamed(context, RoutePaths.UserContactDetailsPage);
                      model.showSuccessTitleandDescriptionToast(ToastwithTitleandDescription(
                          title: S.current.success, description: S.current.newContacthasBeenAdded));
                    }
                  },
                  dataBuilder: (context, enterOTP) {
                    return GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (ProviderScope.containerOf(context)
                                .read(addContactIBANViewModelProvider)
                                .appSwiperController
                                .page ==
                            1.0) {
                          FocusScope.of(context).unfocus();
                          if (StringUtils.isDirectionRTL(context)) {
                            if (!details.primaryVelocity!.isNegative) {
                              model.validateOTP();
                            } else {
                              ProviderScope.containerOf(context)
                                  .read(addContactIBANViewModelProvider)
                                  .previousPage();
                            }
                          } else {
                            if (details.primaryVelocity!.isNegative) {
                              model.validateOTP();
                            } else {
                              ProviderScope.containerOf(context)
                                  .read(addContactIBANViewModelProvider)
                                  .previousPage();
                            }
                          }
                        }
                      },
                      child: Card(
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
                                        key: model.otpKey,
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
                                        color: AppColor.sky_blue_mid,
                                      ),
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
                                                      color: AppColor.sky_blue_mid),
                                                ))
                                            : Text(
                                                S.of(context).resendIn(
                                                    '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontSize: 14.t,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.sky_blue_mid),
                                              );
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 16.0.h),
                                      child: AppStreamBuilder<bool>(
                                          stream: model.showButtonSubjectStream,
                                          initialData: false,
                                          dataBuilder: (context, isValid) {
                                            return Visibility(
                                              visible: isValid!,
                                              child: AnimatedButton(
                                                borderColor: AppColor.sky_blue_mid,
                                                textColor: AppColor.sky_blue_mid,
                                                buttonHeight: 50.h,
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
                  }));
        });
  }
}
