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
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../register/manage_idwise_status/manage_idwise_status_page.dart';

class ChangeDeviceSuccessPageView extends BasePageViewWidget<ChangeDeviceSuccessPageViewModel> {
  ChangeDeviceSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ChangeDeviceSuccessPageViewModel model) {
    return AppStreamBuilder<Resource<CheckKycResponse>>(
        stream: model.kycStatusStream,
        initialData: Resource.none(),
        onData: (data) {
          if (data.status == Status.SUCCESS) {
            CheckKYCData kycData = data.data?.content?.kycData
                    ?.where((element) => element.type != "MobileOTP")
                    .firstWhere((element) => (element.status ?? false), orElse: () => CheckKYCData()) ??
                CheckKYCData();

            if (kycData.type?.isNotEmpty ?? false) {
              if (kycData.type == 'IDWISE') {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutePaths.IdWiseIntialPage,
                  (route) => false,
                );
              } else if (kycData.type == 'AhwalCheck' || kycData.type == 'ProcessSelfieImage') {
                Navigator.pushNamedAndRemoveUntil(context, RoutePaths.ManageIDWiseStatus, (route) => false,
                    arguments: ManageIDWiseStatusParams(
                        isAhwalCheckPassed: kycData.type == 'AhwalCheck',
                        isFaceMatchScorePassed: kycData.type == 'ProcessSelfieImage',
                        journeyId: ''));
              } else {
                Navigator.pushReplacementNamed(context, RoutePaths.Registration,
                    arguments: RegisterPageParams(
                        kycData: kycData,
                        applicationId:
                            ProviderScope.containerOf(context).read(loginViewModelProvider).applicationId));
              }
            } else {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(RoutePaths.AppHome, (Route<dynamic> route) => false);
            }
          }
        },
        dataBuilder: (context, kycResponse) {
          return Container(
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
                          padding: EdgeInsets.only(top: 92.h),
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
                                  height: 111.37.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).canvasColor,
                                  ),
                                  child: Center(
                                      child: AppSvg.asset(AssetUtils.right,
                                          color: Theme.of(context).primaryColorDark)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 34.7.h,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).congratulations,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24.t,
                                    color: Theme.of(context).colorScheme.secondary),
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                                child: Text(
                                  S.of(context).newDeviceRegisteredSuccessfully,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.t,
                                      color: Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     AnimatedButton(
                  //       buttonText: S.of(context).swipeToProceed,
                  //       textColor: Theme.of(context).colorScheme.secondary,
                  //       borderColor: Theme.of(context).colorScheme.secondary,
                  //     ),
                  //     SizedBox(
                  //       height: 5.h,
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.only(
                  //         bottom: 32.h,
                  //       ),
                  //       child: Center(
                  //         child: Text(
                  //           S.of(context).toDashboard,
                  //           style: TextStyle(
                  //             fontFamily: StringUtils.appFont,
                  //             color: Theme.of(context).colorScheme.secondary,
                  //             fontWeight: FontWeight.w400,
                  //             fontSize: 12.t,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // )
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, bottom: 56.h),
                    child: AppPrimaryButton(
                      onPressed: () {
                        model.checkKycStatus();
                      },
                      text: S.current.goToDashboard,
                      activeBackgroundColor: Theme.of(context).colorScheme.secondary,
                      textColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  )
                ],
              ));
        });
  }
}
