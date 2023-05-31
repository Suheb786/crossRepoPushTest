import 'dart:io';

import 'package:domain/model/user/generate_key_pair/generate_key_pair_response.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard/dashboard_page_view_model.dart';
import 'package:neo_bank/feature/register/register_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/biometric_login/biometric_login_dialog.dart';
import 'package:neo_bank/ui/molecules/information_text.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class DashboardPageView extends BasePageViewWidget<DashboardPageViewModel> {
  DashboardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (StringUtils.isDirectionRTL(context)) {
          if (!details.primaryDelta!.isNegative) {
            Navigator.pushNamedAndRemoveUntil(context, RoutePaths.Registration, (route) => false,
                arguments: RegisterPageParams());
          }
        } else {
          if (details.primaryDelta!.isNegative) {
            Navigator.pushNamedAndRemoveUntil(context, RoutePaths.Registration, (route) => false,
                arguments: RegisterPageParams());
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        AppSvg.asset(AssetUtils.dashboardSwiggle, matchTextDirection: true),
                        PositionedDirectional(
                          start: 120.w,
                          child: Text(
                            S.of(context).helloE,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 32.t,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      S.of(context).successfullyCreatedLoginAccount,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 20.t,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: InformationText(
                      image: AssetUtils.informationSave,
                      title: S.of(context).informationSave,
                      containerColor: Theme.of(context).colorScheme.secondary,
                      textColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  //   child: InformationText(
                  //     image: AssetUtils.lock,
                  //     title: S.of(context).saveEarningsDigitally,
                  //     containerColor: Theme.of(context).colorScheme.secondary,
                  //     textColor: Theme.of(context).colorScheme.secondary,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 16,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  //   child: InformationText(
                  //     image: AssetUtils.transactionHistory,
                  //     containerColor: Theme.of(context).colorScheme.secondary,
                  //     title: S.of(context).sendMoneyToFriendAndFamily,
                  //     textColor: Theme.of(context).colorScheme.secondary,
                  //   ),
                  // ),
                  SizedBox(
                    height: 92.h,
                  ),
                  Center(
                    child: AnimatedButton(
                      buttonText: S.of(context).swipeToProceed,
                      borderColor: Theme.of(context).colorScheme.secondary,
                      textColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  AppStreamBuilder<Resource<bool>>(
                    stream: model.enableBiometricStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        Navigator.pop(context);
                      }
                    },
                    dataBuilder: (context, bioMetricResponse) {
                      return AppStreamBuilder<Resource<GenerateKeyPairResponse>>(
                        stream: model.generateKeyPairStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            model.enableBiometric();
                          }
                        },
                        dataBuilder: (context, keyPair) {
                          return AppStreamBuilder<Resource<bool>>(
                            stream: model.authenticateBioMetricStream,
                            onData: (data) {
                              if (data.status == Status.SUCCESS) {
                                model.generateKeyPair();
                              }
                            },
                            initialData: Resource.none(),
                            dataBuilder: (context, data) => AppStreamBuilder<Resource<bool>>(
                              stream: model.checkBioMetricStream,
                              initialData: Resource.none(),
                              onData: (data) {
                                if (data.status == Status.SUCCESS) {
                                  if (data.data ?? false) {
                                    BiometricLoginDialog.show(context, mayBeLater: () {
                                      Navigator.pop(context);
                                    }, enableBioMetric: () {
                                      model.authenticateBioMetric(
                                          title: S.of(context).enableBiometricLoginTitle,
                                          localisedReason: Platform.isAndroid
                                              ? S.of(context).enableBiometricLoginDescriptionAndroid
                                              : S.of(context).enableBiometricLoginDescriptionIos);
                                    });
                                  }
                                }
                              },
                              dataBuilder: (context, data) {
                                return Container();
                              },
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
              SizedBox(
                height: 76.h,
              ),
              AppStreamBuilder<Resource<LogoutResponse>>(
                stream: model.logoutStream,
                initialData: Resource.none(),
                onData: (response) {
                  if (response.status == Status.SUCCESS) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RoutePaths.OnBoarding, ModalRoute.withName(RoutePaths.Splash));
                  }
                },
                dataBuilder: (context, data) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 36.0.h),
                      child: InkWell(
                        onTap: () {
                          model.logout();
                        },
                        child: Text(
                          S.of(context).logoutAndContinueLater,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 14.t,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
