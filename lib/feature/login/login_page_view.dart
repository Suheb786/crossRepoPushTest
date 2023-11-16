import 'dart:io';

import 'package:domain/constants/error_types.dart';
import 'package:domain/model/kyc/check_kyc_data.dart';
import 'package:domain/model/kyc/check_kyc_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/change_device_flow/otp_for_change_device/otp_for_change_device_confirmation_page.dart';
import 'package:neo_bank/feature/credit_card_application_failure/credit_card_application_failure_page.dart';
import 'package:neo_bank/feature/login/login_page_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../register/manage_idwise_status/manage_idwise_status_page.dart';
import '../register/register_page.dart';

class LoginPageView extends BasePageViewWidget<LoginViewModel> {
  LoginPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
        height: double.infinity,
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40.0.h),
                child: AppSvg.asset(
                  AssetUtils.blinkLogo,
                  width: 224.0.w,
                  height: 104.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 56.0.h, bottom: 24.h),
                child: Text(
                  S.of(context).enterLoginDetails,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.0.t,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w500),
                ),
              ),
              AppTextField(
                  textFieldBorderColor: AppColor.whiteGray,
                  textFieldFocusBorderColor: Theme.of(context).primaryColorDark,
                  labelText: S.of(context).emailAddress,
                  hintText: S.of(context).pleaseEnter,
                  key: model.emailKey,
                  controller: model.emailController,
                  inputType: TextInputType.emailAddress,
                  inputAction: TextInputAction.next,
                  onSaved: (value) {
                    model.validateEmail(context: context);
                  },
                  onChanged: (value) => model.validate()),
              Padding(
                padding: EdgeInsets.only(top: 16.0.h),
                child: AppTextField(
                  textFieldBorderColor: AppColor.whiteGray,
                  textFieldFocusBorderColor: Theme.of(context).primaryColorDark,
                  labelText: S.of(context).password,
                  hintText: S.of(context).pleaseEnter,
                  key: model.passwordKey,
                  controller: model.passwordController,
                  inputAction: TextInputAction.done,
                  onSaved: (value) {
                    model.validateEmail(context: context);
                  },
                  onChanged: (value) => model.validate(),
                  obscureText: true,
                  suffixIcon: (isChecked, value) {
                    return InkWell(
                      onTap: () {
                        model.passwordKey.currentState!.secureText =
                            !model.passwordKey.currentState!.secureText;
                      },
                      child: !model.passwordKey.currentState!.secureText
                          ? Container(
                              width: 16.0.w,
                              height: 16.0.h,
                              padding: EdgeInsets.all(4),
                              child: AppSvg.asset(AssetUtils.eye,
                                  color: Theme.of(context).inputDecorationTheme.labelStyle!.color),
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: Theme.of(context).inputDecorationTheme.labelStyle!.color,
                            ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24.0.h, bottom: 56.h),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, RoutePaths.ForgotPassword),
                  child: Text(
                    S.of(context).forgotPassword,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 14.0.t,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              ),
              AppStreamBuilder<bool>(
                  initialData: true,
                  stream: model.showButtonStream,
                  dataBuilder: (context, isButtonVisible) {
                    return AppPrimaryButton(
                      isDisabled: isButtonVisible ?? true,
                      onPressed: () {
                        model.validateEmail(context: context);
                      },
                      text: S.of(context).login,
                    );
                  }),
              SizedBox(
                height: 34,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  S.of(context).goBack,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.t,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              AppStreamBuilder<Resource<bool>>(
                  stream: model.sendOtpTokenMobileStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      model.emailController.clear();
                      model.passwordController.clear();
                      Navigator.pushNamedAndRemoveUntil(
                          context, RoutePaths.OTPForChangeDevice, (route) => false,
                          arguments: OtpForChangeDeviceConfirmationPageArguments(
                              rimNo: model.rimNo,
                              mobileCode: model.mobileCode,
                              mobileNumber: model.mobileNumber,
                              journeyId: model.user.journeyId!));
                    }
                  },
                  dataBuilder: (context, otpForChangeDevice) {
                    return AppStreamBuilder<Resource<User>>(
                      stream: model.loginStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          model.mobileNumber = data.data?.mobile ?? '';
                          model.mobileCode = data.data?.mobileCode ?? '';
                          model.applicationId = data.data?.applicationId ?? '';
                          model.rimNo = data.data?.cifNumber ?? '';
                          model.saveUserData();
                          model.user = data.data!;
                          AppConstantsUtils.isApplePayFeatureEnabled = data.data?.applePay ?? false;

                          ///new device flow check

                          if (data.data!.newDevice!) {
                            InformationDialog.show(context,
                                image: AssetUtils.mobile,
                                title: S.of(context).newDeviceDetected,
                                descriptionWidget: Text(
                                  S.of(context).newDeviceDetectedDesc,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context)
                                          .inputDecorationTheme
                                          .focusedBorder!
                                          .borderSide
                                          .color,
                                      fontSize: 14.0.t,
                                      fontWeight: FontWeight.w400),
                                ), onDismissed: () {
                              Navigator.pop(context);
                            }, onSelected: () {
                              model.sendOtpTokenMobile();
                            });
                          } else {
                            if (Platform.isIOS &&
                                AppConstantsUtils.isApplePayFeatureEnabled &&
                                (data.data?.cifNumber ?? '').isNotEmpty) {
                              model.antelopSdkInitialize();
                            }
                            model.checkKycStatus();
                          }

                          // Future.delayed(
                          //     Duration(
                          //         milliseconds:
                          //             500),
                          //     () {
                          //   // Navigator.pushReplacementNamed(
                          //   //     context, RoutePaths.AppHome);
                          //   Navigator.pushReplacementNamed(
                          //       context,
                          //       RoutePaths
                          //           .Registration,
                          //       arguments:
                          //           RegisterPageParams());
                          // });
                        } else if (data.status == Status.ERROR) {
                          if (data.appError?.type == ErrorType.FATCA_ELIGIBLE) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, RoutePaths.CreditCardApplicationFailure, (route) => false,
                                arguments: CreditCardApplicationFailureArguments(
                                    creditFailureState: CreditFailureState.FATCA));
                          } else {
                            model.emailKey.currentState!.isValid = false;
                            model.showToastWithError(data.appError!);
                          }
                        }
                      },
                      dataBuilder: (context, loginData) {
                        return AppStreamBuilder<Resource<CheckKycResponse>>(
                          stream: model.kycStatusStream,
                          initialData: Resource.none(),
                          onData: (data) {
                            if (data.status == Status.SUCCESS) {
                              CheckKYCData kycData = data.data?.content?.kycData?.firstWhere(
                                      (element) => element.status ?? false,
                                      orElse: () => CheckKYCData()) ??
                                  CheckKYCData();

                              if (kycData.type?.isNotEmpty ?? false) {
                                if (kycData.type == 'IDWISE') {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RoutePaths.IdWiseIntialPage,
                                    (route) => false,
                                  );
                                } else if (kycData.type == 'AhwalCheck' ||
                                    kycData.type == 'ProcessSelfieImage') {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, RoutePaths.ManageIDWiseStatus, (route) => false,
                                      arguments: ManageIDWiseStatusParams(
                                          isAhwalCheckPassed: kycData.type == 'AhwalCheck',
                                          isFaceMatchScorePassed: kycData.type == 'ProcessSelfieImage',
                                          journeyId: model.user.journeyId ?? ''));
                                } else {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, RoutePaths.Registration, (route) => false,
                                      arguments: RegisterPageParams(
                                        kycData: kycData,
                                        applicationId: model.applicationId,
                                      ));
                                }
                              } else {
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    RoutePaths.AppHome, (Route<dynamic> route) => false);
                              }
                            }
                          },
                          dataBuilder: (context, kycResponse) {
                            return Container();
                          },
                        );
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
