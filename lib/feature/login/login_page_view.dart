import 'dart:io';
import 'dart:ui';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/kyc/check_kyc_data.dart';
import 'package:domain/model/kyc/check_kyc_response.dart';
import 'package:domain/model/user/biometric_login/get_cipher_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/di/onboarding/onboarding_module.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page.dart';
import 'package:neo_bank/feature/login/login_page_model.dart';
import 'package:neo_bank/feature/register/register_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class LoginPageView extends BasePageViewWidget<LoginViewModel> {
  LoginPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity!.isNegative) {
                    model.validateEmail();
                  }
                },
                child: SingleChildScrollView(
                  controller: model.scrollController,
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 112.0),
                        child: AppSvg.asset(
                          AssetUtils.blinkLogo,
                          width: 195,
                          height: 91.14,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 100.0),
                        child: Text(
                          S.of(context).enterLoginDetails,
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      AppStreamBuilder<bool>(
                          initialData: false,
                          stream: model.errorDetectorStream,
                          dataBuilder: (context, isError) {
                            return ShakeAnimatedWidget(
                                enabled: isError ?? false,
                                duration: Duration(milliseconds: 100),
                                shakeAngle: Rotation.deg(z: 1),
                                curve: Curves.easeInOutSine,
                                child: AppStreamBuilder<Resource<bool>>(
                                    stream: model.sendOtpTokenMobileStream,
                                    initialData: Resource.none(),
                                    onData: (data) {
                                      if (data.status == Status.SUCCESS) {
                                        Navigator.pushReplacementNamed(context,
                                            RoutePaths.OTPForChangeDevice);
                                      }
                                    },
                                    dataBuilder: (context, otpForChangeDevice) {
                                      return AppStreamBuilder<Resource<User>>(
                                          stream: model.iphoneLoginStream,
                                          initialData: Resource.none(),
                                          onData: (data) {
                                            if (data.status == Status.SUCCESS) {
                                              model.checkKycStatus();
                                            }
                                          },
                                          dataBuilder: (context, snapshot) {
                                            return AppStreamBuilder<
                                                    Resource<bool>>(
                                                stream:
                                                    model.androidLoginStream,
                                                initialData: Resource.none(),
                                                onData: (data) {
                                                  if (data.status ==
                                                      Status.SUCCESS) {
                                                    ProviderScope.containerOf(
                                                            context)
                                                        .read(appViewModel)
                                                        .getToken();
                                                    model.checkKycStatus();
                                                  }
                                                },
                                                dataBuilder:
                                                    (context, snapshot) {
                                                  return AppStreamBuilder<
                                                          Resource<
                                                              GetCipherResponse>>(
                                                      stream:
                                                          model.getCipherStream,
                                                      initialData:
                                                          Resource.none(),
                                                      onData: (cipherResponse) {
                                                        if (cipherResponse
                                                                .status ==
                                                            Status.SUCCESS) {
                                                          if (cipherResponse
                                                                      .data!
                                                                      .getCipherContent!
                                                                      .cipher !=
                                                                  null &&
                                                              cipherResponse
                                                                  .data!
                                                                  .getCipherContent!
                                                                  .cipher!
                                                                  .isNotEmpty) {
                                                            model
                                                                .fingerPrintShow(
                                                                    true);
                                                          }
                                                        }
                                                      },
                                                      dataBuilder:
                                                          (context, cipher) {
                                                        return AppStreamBuilder<
                                                            Resource<User>>(
                                                          stream:
                                                              model.loginStream,
                                                          initialData:
                                                              Resource.none(),
                                                          onData: (data) {
                                                            if (data.status ==
                                                                Status
                                                                    .SUCCESS) {
                                                              model.mobileCode =
                                                                  data.data!
                                                                      .mobile!;
                                                              model.mobileCode =
                                                                  data.data!
                                                                      .mobileCode!;
                                                              ProviderScope
                                                                      .containerOf(
                                                                          context)
                                                                  .read(
                                                                      appViewModel)
                                                                  .getToken();
                                                              model
                                                                  .checkKycStatus();

                                                              ///new device flow check
                                                              /*
                                                              if (data.data!
                                                                  .newDevice!) {
                                                                InformationDialog.show(
                                                                    context,
                                                                    image: AssetUtils
                                                                        .mobile,
                                                                    title: S
                                                                        .of(
                                                                            context)
                                                                        .newDeviceDetected,
                                                                    descriptionWidget:
                                                                        Text(
                                                                      S
                                                                          .of(context)
                                                                          .newDeviceDetectedDesc,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                    ),
                                                                    onDismissed:
                                                                        () {
                                                                  Navigator.pop(
                                                                      context);
                                                                }, onSelected:
                                                                        () {
                                                                  model
                                                                      .sendOtpTokenEmail();
                                                                });
                                                              } else {
                                                                ProviderScope
                                                                        .containerOf(
                                                                            context)
                                                                    .read(
                                                                        appViewModel)
                                                                    .getToken();
                                                                model
                                                                    .checkKycStatus();
                                                              }

                                                               */

                                                              // Future.delayed(Duration(milliseconds: 500),
                                                              //     () {
                                                              //   // Navigator.pushReplacementNamed(
                                                              //   //     context, RoutePaths.AppHome);
                                                              //   Navigator.pushReplacementNamed(
                                                              //       context, RoutePaths.Registration);
                                                              // });
                                                            } else if (data
                                                                    .status ==
                                                                Status.ERROR) {
                                                              model
                                                                  .emailKey
                                                                  .currentState!
                                                                  .isValid = false;
                                                              model.showToastWithError(
                                                                  data.appError!);
                                                            }
                                                          },
                                                          dataBuilder: (context,
                                                              loginData) {
                                                            return AppStreamBuilder<
                                                                Resource<
                                                                    CheckKycResponse>>(
                                                              stream: model
                                                                  .kycStatusStream,
                                                              initialData:
                                                                  Resource
                                                                      .none(),
                                                              onData: (data) {
                                                                if (data.status ==
                                                                    Status
                                                                        .SUCCESS) {
                                                                  CheckKYCData kycData = data
                                                                          .data
                                                                          ?.content
                                                                          ?.kycData
                                                                          ?.firstWhere(
                                                                              (element) => element.status ?? false,
                                                                              orElse: () => CheckKYCData()) ??
                                                                      CheckKYCData();

                                                                  if (kycData
                                                                          .type
                                                                          ?.isNotEmpty ??
                                                                      false) {
                                                                    if (kycData
                                                                            .type ==
                                                                        'MobileOTP') {
                                                                      Navigator.pushReplacementNamed(
                                                                          context,
                                                                          RoutePaths
                                                                              .AccountRegistration,
                                                                          arguments: AccountRegistrationParams(
                                                                              kycData: kycData,
                                                                              mobileCode: loginData!.data!.mobileCode!,
                                                                              mobileNumber: loginData.data!.mobile!));
                                                                    } else {
                                                                      Navigator.pushReplacementNamed(
                                                                          context,
                                                                          RoutePaths
                                                                              .Registration,
                                                                          arguments:
                                                                              RegisterPageParams(
                                                                            kycData:
                                                                                kycData,
                                                                          ));
                                                                    }
                                                                  } else {
                                                                    Navigator.pushReplacementNamed(
                                                                        context,
                                                                        RoutePaths
                                                                            .AppHome);
                                                                  }
                                                                }
                                                              },
                                                              dataBuilder: (context,
                                                                  kycResponse) {
                                                                return Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              40,
                                                                          right:
                                                                              40,
                                                                          top:
                                                                              25),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .stretch,
                                                                    children: [
                                                                      AppTextField(
                                                                          textFieldBorderColor: AppColor
                                                                              .whiteGray,
                                                                          textFieldFocusBorderColor: Theme.of(context)
                                                                              .primaryColorDark,
                                                                          labelText: S
                                                                              .of(
                                                                                  context)
                                                                              .emailAddress,
                                                                          hintText: S
                                                                              .of(
                                                                                  context)
                                                                              .pleaseEnter,
                                                                          key: model
                                                                              .emailKey,
                                                                          controller: model
                                                                              .emailController,
                                                                          inputType: TextInputType
                                                                              .emailAddress,
                                                                          inputAction: TextInputAction
                                                                              .next,
                                                                          onSaved:
                                                                              (value) {
                                                                            model.validateEmail();
                                                                          },
                                                                          suffixIcon:
                                                                              (_,
                                                                                  __) {
                                                                            return AppStreamBuilder<Resource<bool>>(
                                                                                stream: model.checkBioMetricStream,
                                                                                initialData: Resource.none(),
                                                                                onData: (data) {
                                                                                  if (data.status == Status.SUCCESS) {
                                                                                    model.authenticateBioMetric(title: S.of(context).biometricLogin, localisedReason: Platform.isAndroid ? S.of(context).enableBiometricLoginDescriptionAndroid : S.of(context).enableBiometricLoginDescriptionIos);
                                                                                  }
                                                                                },
                                                                                dataBuilder: (context, checkBioMetric) {
                                                                                  return AppStreamBuilder<Resource<bool>>(
                                                                                      stream: model.authenticateBioMetricStream,
                                                                                      initialData: Resource.none(),
                                                                                      onData: (data) {
                                                                                        if (data.status == Status.SUCCESS) {
                                                                                          model.androidLogin(cipher: cipher!.data!.getCipherContent!.cipher!);
                                                                                          //Platform.isAndroid ? model.androidLogin(cipher: cipher!.data!.getCipherContent!.cipher!) : model.iphoneLogin(cipher: cipher!.data!.getCipherContent!.cipher!);
                                                                                        }
                                                                                      },
                                                                                      dataBuilder: (context, authenticBiometric) {
                                                                                        return AppStreamBuilder<bool>(
                                                                                            stream: model.fingerPrintShowStream,
                                                                                            initialData: false,
                                                                                            dataBuilder: (context, fingerPrintValue) {
                                                                                              return Visibility(
                                                                                                visible: fingerPrintValue!,
                                                                                                child: InkWell(
                                                                                                  onTap: () {
                                                                                                    model.checkBiometric();
                                                                                                  },
                                                                                                  child: AppSvg.asset(AssetUtils.fingerPrint, color: Theme.of(context).accentTextTheme.bodyText1!.color),
                                                                                                ),
                                                                                              );
                                                                                            });
                                                                                      });
                                                                                });
                                                                          },
                                                                          suffixIconSize:
                                                                              24,
                                                                          onChanged: (value) =>
                                                                              model.validate()),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 16),
                                                                        child:
                                                                            AppTextField(
                                                                          textFieldBorderColor:
                                                                              AppColor.whiteGray,
                                                                          textFieldFocusBorderColor:
                                                                              Theme.of(context).primaryColorDark,
                                                                          labelText: S
                                                                              .of(context)
                                                                              .password,
                                                                          hintText: S
                                                                              .of(context)
                                                                              .pleaseEnter,
                                                                          key: model
                                                                              .passwordKey,
                                                                          controller:
                                                                              model.passwordController,
                                                                          inputAction:
                                                                              TextInputAction.done,
                                                                          onSaved:
                                                                              (value) {
                                                                            model.validateEmail();
                                                                          },
                                                                          onChanged: (value) =>
                                                                              model.validate(),
                                                                          obscureText:
                                                                              true,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 24),
                                                                        child:
                                                                            InkWell(
                                                                          onTap: () => Navigator.pushNamed(
                                                                              context,
                                                                              RoutePaths.ForgotPassword),
                                                                          child:
                                                                              Text(
                                                                            S.of(context).forgotPassword,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Theme.of(context).accentColor),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Center(
                                                                        child: AppStreamBuilder<
                                                                                bool>(
                                                                            stream: model
                                                                                .showButtonStream,
                                                                            initialData:
                                                                                false,
                                                                            dataBuilder:
                                                                                (context, isValid) {
                                                                              return Visibility(
                                                                                visible: isValid!,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.only(top: 24),
                                                                                  child: AnimatedButton(
                                                                                    buttonText: S.of(context).swipeToProceed,
                                                                                    borderColor: Theme.of(context).accentColor,
                                                                                    textColor: Theme.of(context).accentColor,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            }),
                                                                      )
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                        );
                                                      });
                                                });
                                          });
                                    }));
                          }),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta!.isNegative
                    // &&
                    // model.scrollController.offset >=
                    //     model.scrollController.position.maxScrollExtent - 100 &&
                    // !model.scrollController.position.outOfRange &&
                    // details.primaryDelta != 0
                    ) {
                  ProviderScope.containerOf(context)
                      .read(onBoardingViewModelProvider)
                      .onBoardingPageController
                      .nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                } else {
                  // model.scrollController.animateTo(details.localPosition.dx,
                  //     duration: Duration(milliseconds: 350), curve: Curves.ease);
                }
              },
              child: Column(
                children: [
                  Container(
                    height: 4,
                    width: 128,
                    margin: EdgeInsets.only(bottom: 8, top: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: AppColor.whiteGray),
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 25, top: 19),
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16))),
                      child: Text(
                        S.of(context).swipeUpToJoinOurCommunity,
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context)
                                .accentTextTheme
                                .bodyText1
                                ?.color,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
