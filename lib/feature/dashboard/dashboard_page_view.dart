import 'dart:io';

import 'package:domain/model/user/logout/logout_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard/dashboard_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/biometric_login/biometric_login_dialog.dart';
import 'package:neo_bank/ui/molecules/information_text.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class DashboardPageView extends BasePageViewWidget<DashboardPageViewModel> {
  DashboardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta!.isNegative) {
          Navigator.pushReplacementNamed(context, RoutePaths.Registration);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  AppSvg.asset(AssetUtils.welcomeIcon),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      S.of(context).successfullyCreatedLoginAccount,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: InformationText(
                      image: AssetUtils.lock,
                      title: S.of(context).saveEarningsDigitally,
                      containerColor: Theme.of(context).accentColor,
                      textColor: Theme.of(context).accentColor,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: InformationText(
                      image: AssetUtils.transactionHistory,
                      containerColor: Theme.of(context).accentColor,
                      title: S.of(context).sendMoneyToFriendAndFamily,
                      textColor: Theme.of(context).accentColor,
                    ),
                  ),
                  SizedBox(
                    height: 46,
                  ),
                  AnimatedButton(
                    buttonText: S.of(context).swipeToProceed,
                    borderColor: Theme.of(context).accentColor,
                    textColor: Theme.of(context).accentColor,
                  ),
                  AppStreamBuilder<Resource<bool>>(
                    stream: model.authenticateBioMetricStream,
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        print('success');
                      }
                    },
                    initialData: Resource.none(),
                    dataBuilder: (context, data) =>
                        AppStreamBuilder<Resource<bool>>(
                      stream: model.checkBioMetricStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          if (data.data ?? false) {
                            BiometricLoginDialog.show(context, mayBeLater: () {
                              Navigator.pop(context);
                            }, enableBioMetric: () {
                              model.authenticateBioMetric(
                                  title:
                                      S.of(context).enableBiometricLoginTitle,
                                  localisedReason: Platform.isAndroid
                                      ? S
                                          .of(context)
                                          .enableBiometricLoginDescriptionAndroid
                                      : S
                                          .of(context)
                                          .enableBiometricLoginDescriptionIos);
                            });
                          }
                        }
                      },
                      dataBuilder: (context, data) {
                        return Container();
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 76,
              ),
              AppStreamBuilder<Resource<LogoutResponse>>(
                stream: model.logoutStream,
                initialData: Resource.none(),
                onData: (response) {
                  if (response.status == Status.SUCCESS) {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutePaths.OnBoarding,
                        ModalRoute.withName(RoutePaths.Splash));
                  }
                },
                dataBuilder: (context, data) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 36.0),
                      child: InkWell(
                        onTap: () {
                          model.logout();
                        },
                        child: Text(
                          S.of(context).logoutAndContinueLater,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).accentColor),
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
