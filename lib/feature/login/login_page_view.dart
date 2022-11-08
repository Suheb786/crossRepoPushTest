import 'dart:io';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/language_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/kyc/check_kyc_data.dart';
import 'package:domain/model/kyc/check_kyc_response.dart';
import 'package:domain/model/user/biometric_login/get_cipher_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/onboarding/onboarding_module.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page.dart';
import 'package:neo_bank/feature/login/login_page_model.dart';
import 'package:neo_bank/feature/register/register_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/version_update/version_update_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/launch_urls_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

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
                  // FirebaseCrashlytics.instance.crash();

                  FocusScope.of(context).unfocus();
                  if (details.primaryVelocity!.isNegative) {
                    model.validateEmail();
                    //FirebaseCrashlytics.instance.crash();
                  }
                },
                child: SingleChildScrollView(
                  controller: model.scrollController,
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: AppStreamBuilder<LanguageEnum>(
                            stream: model.selectedLanguageStream,
                            initialData: LanguageEnum.ENGLISH,
                            dataBuilder: (context, selectedLanguage) {
                              return Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(top: 64.0.h, end: 40.0.w),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0.w, /*vertical: 8.5*/
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(200),
                                        border: Border.all(color: Theme.of(context).accentColor, width: 1)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<LanguageEnum>(
                                        value: selectedLanguage,
                                        items: model.language
                                            .map((LanguageEnum e) => DropdownMenuItem(
                                                value: e,
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional.only(end: 12.0.w),
                                                  child: Text(
                                                    e.fromLanguage(),
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        color: Theme.of(context).accentColor,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 14.0.t),
                                                  ),
                                                )))
                                            .toList(),
                                        onChanged: (value) {
                                          model.setLanguage(value!, context);
                                        },
                                        dropdownColor: Theme.of(context).primaryColor,
                                        icon: AppSvg.asset(AssetUtils.dropDown),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40.0.h),
                        child: AppSvg.asset(
                          AssetUtils.blinkLogo,
                          width: 195.0.w,
                          height: 91.14.h,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 100.0.h),
                        child: Text(
                          S.of(context).enterLoginDetails,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 14.0.t,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      AppStreamBuilder<Resource<bool>>(
                          initialData: Resource.none(),
                          stream: model.checkVersionUpdateStream,
                          onData: (data) {
                            if (data.status == Status.ERROR) {
                              if (data.appError!.type == ErrorType.PLATFORM_NOT_FOUND) {
                                VersionUpdateDialog.show(context,
                                    image: AssetUtils.alert,
                                    title: S.of(context).updateRequired,
                                    descriptionWidget: Text(
                                      S.of(context).updateRequiredDesc,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 14.0.t,
                                          height: 1.7,
                                          color: Theme.of(context)
                                              .inputDecorationTheme
                                              .focusedBorder!
                                              .borderSide
                                              .color),
                                    ), onSelected: () {
                                  Navigator.pop(context);
                                  Platform.isAndroid
                                      ? LaunchUrlUtils.launchDigitalService(AppConstantsUtils.PLAY_STORE_URL)
                                      : Platform.isIOS
                                          ? LaunchUrlUtils.launchDigitalService(
                                              AppConstantsUtils.APP_STORE_URL)
                                          : "";
                                });
                              } else if (data.appError?.type == ErrorType.LOCATION_RESTRICTED) {
                                InformationDialog.show(context,
                                    image: AssetUtils.mobile,
                                    title: S.of(context).attention,
                                    descriptionWidget: Text(
                                      S.of(context).applicationNotAvailableInRegion,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont, fontSize: 14.0.t, height: 1.7),
                                    ), onDismissed: () {
                                  exit(0);
                                }, onSelected: () {
                                  exit(0);
                                });
                              }
                            } else if (data.status == Status.SUCCESS) {
                              model.initInfobipMessagePlugin();
                              model.getCipher();
                            }
                          },
                          dataBuilder: (context, data) {
                            return AppStreamBuilder<bool>(
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
                                              model.emailController.clear();
                                              model.passwordController.clear();
                                              model.fingerPrintShow(false);
                                              Navigator.popAndPushNamed(
                                                  context, RoutePaths.OTPForChangeDevice);
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
                                                  return AppStreamBuilder<Resource<bool>>(
                                                      stream: model.androidLoginStream,
                                                      initialData: Resource.none(),
                                                      onData: (data) {
                                                        if (data.status == Status.SUCCESS) {
                                                          ///apple pay initialize
                                                          model.antelopSdkInitialize();

                                                          ///refresh token api
                                                          // ProviderScope
                                                          //         .containerOf(
                                                          //             context)
                                                          //     .read(
                                                          //         appViewModel)
                                                          //     .getToken();
                                                          model.checkKycStatus();
                                                        }
                                                      },
                                                      dataBuilder: (context, snapshot) {
                                                        return AppStreamBuilder<Resource<GetCipherResponse>>(
                                                            stream: model.getCipherStream,
                                                            initialData: Resource.none(),
                                                            onData: (cipherResponse) {
                                                              if (cipherResponse.status == Status.SUCCESS) {
                                                                if (cipherResponse
                                                                            .data!.getCipherContent!.cipher !=
                                                                        null &&
                                                                    cipherResponse.data!.getCipherContent!
                                                                        .cipher!.isNotEmpty) {
                                                                  model.fingerPrintShow(true);
                                                                }
                                                              }
                                                            },
                                                            dataBuilder: (context, cipher) {
                                                              return AppStreamBuilder<Resource<User>>(
                                                                stream: model.loginStream,
                                                                initialData: Resource.none(),
                                                                onData: (data) {
                                                                  if (data.status == Status.SUCCESS) {
                                                                    model.mobileNumber = data.data!.mobile!;
                                                                    model.mobileCode = data.data!.mobileCode!;
                                                                    model.applicationId =
                                                                        data.data!.applicationId!;
                                                                    model.saveUserData();

                                                                    ///refresh token api
                                                                    // ProviderScope.containerOf(
                                                                    //         context)
                                                                    //     .read(
                                                                    //         appViewModel)
                                                                    //     .getToken();
                                                                    // model
                                                                    //     .checkKycStatus();

                                                                    ///apple pay initialize
                                                                    model.antelopSdkInitialize();

                                                                    ///new device flow check

                                                                    if (data.data!.newDevice!) {
                                                                      InformationDialog.show(context,
                                                                          image: AssetUtils.mobile,
                                                                          title:
                                                                              S.of(context).newDeviceDetected,
                                                                          descriptionWidget: Text(
                                                                            S
                                                                                .of(context)
                                                                                .newDeviceDetectedDesc,
                                                                            style: TextStyle(
                                                                                fontFamily:
                                                                                    StringUtils.appFont,
                                                                                fontSize: 14.0.t,
                                                                                fontWeight: FontWeight.w400),
                                                                          ), onDismissed: () {
                                                                        Navigator.pop(context);
                                                                      }, onSelected: () {
                                                                        model.sendOtpTokenMobile();
                                                                      });
                                                                    } else {
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
                                                                    model.emailKey.currentState!.isValid =
                                                                        false;
                                                                    model.showToastWithError(data.appError!);
                                                                  }
                                                                },
                                                                dataBuilder: (context, loginData) {
                                                                  return AppStreamBuilder<
                                                                      Resource<CheckKycResponse>>(
                                                                    stream: model.kycStatusStream,
                                                                    initialData: Resource.none(),
                                                                    onData: (data) {
                                                                      if (data.status == Status.SUCCESS) {
                                                                        CheckKYCData kycData = data
                                                                                .data?.content?.kycData
                                                                                ?.firstWhere(
                                                                                    (element) =>
                                                                                        element.status ??
                                                                                        false,
                                                                                    orElse: () =>
                                                                                        CheckKYCData()) ??
                                                                            CheckKYCData();

                                                                        if (kycData.type?.isNotEmpty ??
                                                                            false) {
                                                                          if (kycData.type == 'MobileOTP') {
                                                                            Navigator.popAndPushNamed(
                                                                                context,
                                                                                RoutePaths
                                                                                    .AccountRegistration,
                                                                                arguments:
                                                                                    AccountRegistrationParams(
                                                                                        kycData: kycData,
                                                                                        mobileCode: loginData!
                                                                                            .data!
                                                                                            .mobileCode!,
                                                                                        mobileNumber:
                                                                                            loginData.data!
                                                                                                .mobile!));
                                                                          } else {
                                                                            Navigator.popAndPushNamed(context,
                                                                                RoutePaths.Registration,
                                                                                arguments: RegisterPageParams(
                                                                                  applicationId:
                                                                                      model.applicationId,
                                                                                  kycData: kycData,
                                                                                ));
                                                                          }
                                                                        } else {
                                                                          Navigator.popAndPushNamed(
                                                                              context, RoutePaths.AppHome);
                                                                        }
                                                                      }
                                                                    },
                                                                    dataBuilder: (context, kycResponse) {
                                                                      return Padding(
                                                                        padding: EdgeInsets.only(
                                                                            left: 40.0.w,
                                                                            right: 40.0.w,
                                                                            top: 25.0.h),
                                                                        child: Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.stretch,
                                                                          children: [
                                                                            AppTextField(
                                                                                textFieldBorderColor:
                                                                                    AppColor.whiteGray,
                                                                                textFieldFocusBorderColor:
                                                                                    Theme.of(context)
                                                                                        .primaryColorDark,
                                                                                labelText: S
                                                                                    .of(context)
                                                                                    .emailAddress,
                                                                                hintText:
                                                                                    S.of(context).pleaseEnter,
                                                                                key: model.emailKey,
                                                                                controller:
                                                                                    model.emailController,
                                                                                inputType: TextInputType
                                                                                    .emailAddress,
                                                                                inputAction:
                                                                                    TextInputAction.next,
                                                                                onSaved: (value) {
                                                                                  model.validateEmail();
                                                                                },
                                                                                suffixIcon: (_, __) {
                                                                                  return AppStreamBuilder<
                                                                                          Resource<bool>>(
                                                                                      stream: model
                                                                                          .checkBioMetricStream,
                                                                                      initialData:
                                                                                          Resource.none(),
                                                                                      onData: (data) {
                                                                                        if (data.status ==
                                                                                            Status.SUCCESS) {
                                                                                          model.authenticateBioMetric(
                                                                                              title: S
                                                                                                  .of(context)
                                                                                                  .biometricLogin,
                                                                                              localisedReason: Platform
                                                                                                      .isAndroid
                                                                                                  ? S
                                                                                                      .of(
                                                                                                          context)
                                                                                                      .enableBiometricLoginDescriptionAndroid
                                                                                                  : S
                                                                                                      .of(context)
                                                                                                      .enableBiometricLoginDescriptionIos);
                                                                                        }
                                                                                      },
                                                                                      dataBuilder: (context,
                                                                                          checkBioMetric) {
                                                                                        return AppStreamBuilder<
                                                                                                Resource<
                                                                                                    bool>>(
                                                                                            stream: model
                                                                                                .authenticateBioMetricStream,
                                                                                            initialData:
                                                                                                Resource
                                                                                                    .none(),
                                                                                            onData: (data) {
                                                                                              if (data.status ==
                                                                                                  Status
                                                                                                      .SUCCESS) {
                                                                                                if (data
                                                                                                    .data!) {
                                                                                                  model.androidLogin(
                                                                                                      cipher: cipher!
                                                                                                          .data!
                                                                                                          .getCipherContent!
                                                                                                          .cipher!);
                                                                                                }
                                                                                                // model.getCurrentUser();
                                                                                                //Platform.isAndroid ? model.androidLogin(cipher: cipher!.data!.getCipherContent!.cipher!) : model.iphoneLogin(cipher: cipher!.data!.getCipherContent!.cipher!);
                                                                                              }
                                                                                            },
                                                                                            dataBuilder: (context,
                                                                                                authenticBiometric) {
                                                                                              return AppStreamBuilder<
                                                                                                      Resource<
                                                                                                          User>>(
                                                                                                  stream: model
                                                                                                      .currentUser,
                                                                                                  initialData:
                                                                                                      Resource
                                                                                                          .none(),
                                                                                                  onData:
                                                                                                      (data) {
                                                                                                    if (data.status ==
                                                                                                        Status
                                                                                                            .SUCCESS) {
                                                                                                      model.checkVersionUpdate(
                                                                                                          clear:
                                                                                                              "false");
                                                                                                    } else if (data
                                                                                                            .status ==
                                                                                                        Status
                                                                                                            .ERROR) {
                                                                                                      if (data.appError!.type ==
                                                                                                          ErrorType.DB_USER_NOT_FOUND) {
                                                                                                        model.checkVersionUpdate(
                                                                                                            clear: "true");
                                                                                                      }
                                                                                                    }
                                                                                                  },
                                                                                                  dataBuilder:
                                                                                                      (context,
                                                                                                          progress) {
                                                                                                    return AppStreamBuilder<
                                                                                                            bool>(
                                                                                                        stream: model
                                                                                                            .fingerPrintShowStream,
                                                                                                        initialData:
                                                                                                            false,
                                                                                                        dataBuilder:
                                                                                                            (context, fingerPrintValue) {
                                                                                                          return Visibility(
                                                                                                            visible: fingerPrintValue!,
                                                                                                            child: InkWell(
                                                                                                              onTap: () {
                                                                                                                FocusScope.of(context).unfocus();
                                                                                                                model.checkBiometric();
                                                                                                              },
                                                                                                              child: AppSvg.asset(AssetUtils.fingerPrint, color: Theme.of(context).accentTextTheme.bodyText1!.color),
                                                                                                            ),
                                                                                                          );
                                                                                                        });
                                                                                                  });
                                                                                            });
                                                                                      });
                                                                                },
                                                                                suffixIconSize: 24,
                                                                                onChanged: (value) =>
                                                                                    model.validate()),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(
                                                                                  top: 16.0.h),
                                                                              child: AppTextField(
                                                                                textFieldBorderColor:
                                                                                    AppColor.whiteGray,
                                                                                textFieldFocusBorderColor:
                                                                                    Theme.of(context)
                                                                                        .primaryColorDark,
                                                                                labelText:
                                                                                    S.of(context).password,
                                                                                hintText:
                                                                                    S.of(context).pleaseEnter,
                                                                                key: model.passwordKey,
                                                                                controller:
                                                                                    model.passwordController,
                                                                                inputAction:
                                                                                    TextInputAction.done,
                                                                                onSaved: (value) {
                                                                                  model.validateEmail();
                                                                                },
                                                                                onChanged: (value) =>
                                                                                    model.validate(),
                                                                                obscureText: true,
                                                                                suffixIcon:
                                                                                    (isChecked, value) {
                                                                                  return InkWell(
                                                                                    onTap: () {
                                                                                      model
                                                                                              .passwordKey
                                                                                              .currentState!
                                                                                              .secureText =
                                                                                          !model
                                                                                              .passwordKey
                                                                                              .currentState!
                                                                                              .secureText;
                                                                                    },
                                                                                    child: model
                                                                                            .passwordKey
                                                                                            .currentState!
                                                                                            .secureText
                                                                                        ? Container(
                                                                                            width: 16.0.w,
                                                                                            height: 16.0.h,
                                                                                            padding:
                                                                                                EdgeInsets
                                                                                                    .all(4),
                                                                                            child: AppSvg.asset(
                                                                                                AssetUtils
                                                                                                    .eye,
                                                                                                color: Theme.of(
                                                                                                        context)
                                                                                                    .inputDecorationTheme
                                                                                                    .labelStyle!
                                                                                                    .color),
                                                                                          )
                                                                                        : Icon(
                                                                                            Icons
                                                                                                .visibility_off,
                                                                                            color: Theme.of(
                                                                                                    context)
                                                                                                .inputDecorationTheme
                                                                                                .labelStyle!
                                                                                                .color,
                                                                                          ),
                                                                                  );
                                                                                },
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(
                                                                                  top: 24.0.h),
                                                                              child: InkWell(
                                                                                onTap: () =>
                                                                                    Navigator.pushNamed(
                                                                                        context,
                                                                                        RoutePaths
                                                                                            .ForgotPassword),
                                                                                child: Text(
                                                                                  S
                                                                                      .of(context)
                                                                                      .forgotPassword,
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(
                                                                                      fontFamily:
                                                                                          StringUtils.appFont,
                                                                                      fontSize: 14.0.t,
                                                                                      fontWeight:
                                                                                          FontWeight.w500,
                                                                                      color: Theme.of(context)
                                                                                          .accentColor),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Center(
                                                                              child: AppStreamBuilder<bool>(
                                                                                  stream:
                                                                                      model.showButtonStream,
                                                                                  initialData: false,
                                                                                  dataBuilder:
                                                                                      (context, isValid) {
                                                                                    return Visibility(
                                                                                      visible: isValid!,
                                                                                      child: Padding(
                                                                                        padding:
                                                                                            EdgeInsets.only(
                                                                                                top: 24.0.h),
                                                                                        child: AnimatedButton(
                                                                                          buttonText: S
                                                                                              .of(context)
                                                                                              .swipeToProceed,
                                                                                          borderColor: Theme
                                                                                                  .of(context)
                                                                                              .accentColor,
                                                                                          textColor: Theme.of(
                                                                                                  context)
                                                                                              .accentColor,
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
                                });
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
                      .nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
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
                    margin: EdgeInsets.only(bottom: 8.0.h, top: 8.0.h),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColor.whiteGray),
                  ),
                  Container(
                      padding: Platform.isAndroid
                          ? EdgeInsets.only(bottom: 28.0.h, top: 16.0.h)
                          : EdgeInsets.only(bottom: 68.0.h, top: 16.0.h),
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                      child: Text(
                        S.of(context).swipeUpToJoinOurCommunity,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 14.0.t,
                            color: Theme.of(context).accentTextTheme.bodyText1?.color,
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
