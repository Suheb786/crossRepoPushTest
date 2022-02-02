import 'package:domain/model/kyc/check_kyc_data.dart';
import 'package:domain/model/kyc/check_kyc_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/login/login_module.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page.dart';
import 'package:neo_bank/feature/change_device_flow/change_device_success/change_device_success_page_view_model.dart';
import 'package:neo_bank/feature/register/register_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class ChangeDeviceSuccessPageView
    extends BasePageViewWidget<ChangeDeviceSuccessPageViewModel> {
  ChangeDeviceSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ChangeDeviceSuccessPageViewModel model) {
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
              if (kycData.type == 'MobileOTP') {
                Navigator.pushReplacementNamed(
                    context, RoutePaths.AccountRegistration,
                    arguments: AccountRegistrationParams(
                        kycData: kycData,
                        mobileCode: ProviderScope.containerOf(context)
                            .read(loginViewModelProvider)
                            .mobileCode,
                        mobileNumber: ProviderScope.containerOf(context)
                            .read(loginViewModelProvider)
                            .mobileNumber));
              } else {
                Navigator.pushReplacementNamed(context, RoutePaths.Registration,
                    arguments: RegisterPageParams(
                      kycData: kycData,
                    ));
              }
            } else {
              Navigator.pushReplacementNamed(context, RoutePaths.AppHome);
            }
          }
        },
        dataBuilder: (context, kycResponse) {
          return GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (details.primaryDelta!.isNegative) {
                model.checkKycStatus();
              }
            },
            child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 92),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  AssetUtils.line,
                                  color: AppColor.softRed,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 111.37,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    child: Center(
                                        child: AppSvg.asset(AssetUtils.right,
                                            color: Theme.of(context)
                                                .primaryColorDark)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 34.7,
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).congratulations,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: Theme.of(context).accentColor),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 48.0),
                                  child: Text(
                                    S
                                        .of(context)
                                        .newDeviceRegisteredSuccessfully,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedButton(
                          buttonText: S.of(context).swipeToProceed,
                          textColor: Theme.of(context).accentColor,
                          borderColor: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 32,
                          ),
                          child: Center(
                            child: Text(
                              S.of(context).toDashboard,
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          );
        });
  }
}
