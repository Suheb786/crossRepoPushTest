import 'dart:io';

import 'package:data/helper/shared_preference_helper.dart';
import 'package:domain/constants/enum/language_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/kyc/check_kyc_data.dart';
import 'package:domain/model/kyc/check_kyc_response.dart';
import 'package:domain/model/user/biometric_login/android_login_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/onboarding/onboarding_module.dart';
import 'package:neo_bank/feature/onboarding/login_landing_page/login_landing_page_view_model.dart';
import 'package:neo_bank/feature/register/register_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/button/app_secondary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/version_update/version_update_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/launch_urls_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class LoginLandingPageView extends BasePageViewWidget<LoginLandingPageViewModel> {
  LoginLandingPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(vertical: 64.h, horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///language selection
          Directionality(
            textDirection: TextDirection.ltr,
            child: AppStreamBuilder<bool>(
                stream: model.switchStream,
                initialData: true,
                onData: (data) {},
                dataBuilder: (context, streamValue) {
                  return Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                      width: 115.w,
                      height: 56.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.w),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5), width: 1)),
                      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.t),
                      child: Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              model.updateSwitchValue(!(streamValue ?? true));
                              streamValue = !(streamValue ?? true);
                              model.setLanguage(
                                  (streamValue ?? true) ? LanguageEnum.ENGLISH : LanguageEnum.ARABIC,
                                  context);
                            },
                            child: Container(
                              width: 104.w,
                              height: 56.h,
                              decoration: ShapeDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.w),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  model.languageValue.length,
                                  (index) => Container(
                                    alignment: Alignment.center,
                                    height: 48.w,
                                    width: 48.w,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 4.w : 0, right: index == 1.w ? 4.w : 0),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: index == 0 ? 5.t : 0),
                                      child: Text(model.languageValue[index],
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 15.t,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).colorScheme.secondary)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AnimatedAlign(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.decelerate,
                            alignment: (streamValue ?? true) ? Alignment.centerLeft : Alignment.centerRight,
                            child: Container(
                              width: 48.w,
                              height: 48.w,
                              decoration: ShapeDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.w),
                                ),
                              ),
                              padding: EdgeInsets.only(top: (streamValue ?? true) ? 4.t : 0),
                              alignment: Alignment.center,
                              child: Text(
                                  (streamValue ?? true) ? model.languageValue[0] : model.languageValue[1],
                                  style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 15.t,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).textTheme.bodyLarge?.color ?? AppColor.brightBlue,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),

          ///blink logo
          Padding(
            padding: EdgeInsets.only(top: 10.0.h),
            child: AppSvg.asset(
              AssetUtils.blinkLogo,
              width: 224.w,
              height: 104.h,
            ),
          ),

          AppStreamBuilder<Resource<User>>(
              stream: model.currentUser,
              initialData: Resource.none(),
              onData: (data) async {
                if (data.status == Status.SUCCESS) {
                  await SharedPreferenceHelper.saveValue(false);
                  model.checkVersionUpdate(clear: "false");
                } else if (data.status == Status.ERROR) {
                  print(data.appError?.type);
                  if (data.appError!.type == ErrorType.DB_USER_NOT_FOUND) {
                    await SharedPreferenceHelper.saveValue(false);
                    model.checkVersionUpdate(clear: "true");
                  }
                }
              },
              dataBuilder: (context, userData) {
                return Column(
                  children: [
                    ///biometric icon
                    AppStreamBuilder<Resource<bool>>(
                        stream: model.authenticateBioMetricStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            if (data.data!) {
                              model.androidLogin(cipher: '');
                            }
                          }
                        },
                        dataBuilder: (context, authenticBiometric) {
                          return AppStreamBuilder<Resource<bool>>(
                              stream: model.checkBioMetricStream,
                              initialData: Resource.none(),
                              onData: (data) {
                                if (data.status == Status.SUCCESS) {
                                  model.authenticateBioMetric(
                                      title: S.of(context).biometricLogin,
                                      localisedReason: Platform.isAndroid
                                          ? S.of(context).enableBiometricLoginDescriptionAndroid
                                          : S.of(context).enableBiometricLoginDescriptionIos);
                                }
                              },
                              dataBuilder: (context, checkBioMetric) {
                                return GestureDetector(
                                  onTap: () {
                                    if (userData?.status == Status.SUCCESS) {
                                      if (userData?.data?.isBiometricEnabled ?? false) {
                                        model.isBiometricDialogShown = true;
                                        model.checkBiometric();
                                      } else {
                                        InformationDialog.show(context,
                                            image: AssetUtils.disclaimer,
                                            title: S.of(context).biometricLoginIsDisabled,
                                            descriptionWidget: Text(
                                              S.of(context).biometricLoginIsDisabledDesc,
                                              style: TextStyle(
                                                  color: AppColor.veryDarkGray1,
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 14.0.t,
                                                  height: 1.7),
                                            ), onDismissed: () {
                                          Navigator.pop(context);
                                        }, onSelected: () {
                                          Navigator.pop(context);

                                          Navigator.pushNamed(context, RoutePaths.Login);
                                        });
                                      }
                                    } else if (userData?.status == Status.ERROR) {
                                      InformationDialog.show(context,
                                          image: AssetUtils.disclaimer,
                                          title: S.of(context).biometricLoginIsDisabled,
                                          descriptionWidget: Text(
                                            S.of(context).biometricLoginIsDisabledDesc,
                                            style: TextStyle(
                                                color: AppColor.veryDarkGray1,
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 14.0.t,
                                                height: 1.7),
                                          ), onDismissed: () {
                                        Navigator.pop(context);
                                      }, onSelected: () {
                                        Navigator.pop(context);

                                        Navigator.pushNamed(context, RoutePaths.Login);
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 112.w,
                                    width: 112.w,
                                    padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 28.h),
                                    child: AppSvg.asset(AssetUtils.fingerPrintIcon),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: AppColor.softRed1, width: 2.24),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(0, 0, 0, 0.15),
                                              blurRadius: 8.96,
                                              offset: Offset(0, 4.48))
                                        ]),
                                  ),
                                );
                              });
                        }),

                    ///login and register buttons
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
                                        ? LaunchUrlUtils.launchDigitalService(AppConstantsUtils.APP_STORE_URL)
                                        : "";
                              });
                            } else if (data.appError?.type == ErrorType.LOCATION_RESTRICTED) {
                              InformationDialog.show(context,
                                  image: AssetUtils.mobile,
                                  title: S.of(context).attention,
                                  descriptionWidget: Text(
                                    S.of(context).applicationNotAvailableInRegion,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .inputDecorationTheme
                                            .focusedBorder!
                                            .borderSide
                                            .color,
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 14.0.t,
                                        height: 1.7),
                                  ), onDismissed: () {
                                exit(0);
                              }, onSelected: () {
                                exit(0);
                              });
                            }
                          } else if (data.status == Status.SUCCESS) {
                            model.initInfobipMobileMessagePlugin();
                          }
                        },
                        dataBuilder: (context, data) {
                          return AppStreamBuilder<Resource<AndroidLoginResponse>>(
                              stream: model.androidLoginStream,
                              initialData: Resource.none(),
                              onData: (data) {
                                if (data.status == Status.SUCCESS) {
                                  AppConstantsUtils.isApplePayFeatureEnabled =
                                      data.data?.androidLoginContent.applepay ?? false;
                                  model.isBiometricDialogShown = false;

                                  if (Platform.isIOS && AppConstantsUtils.isApplePayFeatureEnabled) {
                                    model.antelopSdkInitialize();
                                  }
                                  model.saveUserData();
                                  model.checkKycStatus();
                                }
                              },
                              dataBuilder: (context, snapshot) {
                                return AppStreamBuilder<Resource<CheckKycResponse>>(
                                  stream: model.kycStatusStream,
                                  initialData: Resource.none(),
                                  onData: (data) {
                                    if (data.status == Status.SUCCESS) {
                                      /* CheckKYCData kycData = (data.data?.content?.kycData?.firstWhere(
                                              (element) => (element.status ?? false),
                                              orElse: () => CheckKYCData()) ??
                                          CheckKYCData());
*/
                                      CheckKYCData kycData = data.data?.content?.kycData
                                              ?.where((element) => element.type != "MobileOTP")
                                              .firstWhere((element) => (element.status ?? false),
                                                  orElse: () => CheckKYCData()) ??
                                          CheckKYCData();

                                      if (kycData.type?.isNotEmpty ?? false) {
                                        if (kycData.type == 'IDCardC' || kycData.type == 'SelfiCheck') {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            RoutePaths.IdWiseIntialPage,
                                            (route) => false,
                                          );
                                        } else {
                                          Navigator.pushNamedAndRemoveUntil(
                                              context, RoutePaths.Registration, (route) => false,
                                              arguments: RegisterPageParams(
                                                applicationId: model.applicationId,
                                                kycData: kycData,
                                              ));
                                        }
                                      } else {
                                        Navigator.of(context).pushNamedAndRemoveUntil(
                                            RoutePaths.AppHome, (Route<dynamic> route) => false);
                                      }
                                    }
                                  },
                                  dataBuilder: (context, kycResponse) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 40.0.h),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          AppPrimaryButton(
                                            onPressed: () {
                                              Navigator.pushNamed(context, RoutePaths.Login);
                                            },
                                            text: S.of(context).loginWithEmail,
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          AppSecondaryButton(
                                            onPressed: () {
                                              ProviderScope.containerOf(context)
                                                  .read(onBoardingViewModelProvider)
                                                  .onBoardingPageController
                                                  .nextPage(
                                                      duration: Duration(milliseconds: 500),
                                                      curve: Curves.easeInOut);
                                            },
                                            text: S.of(context).openAccount,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                );
                              });
                        }),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
