import 'package:domain/model/kyc/check_kyc_data.dart';
import 'package:domain/model/user/check_journey_status/check_journey_status.dart';
import 'package:domain/model/user/process_journey_via_mobile/process_journey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import '../../../base/base_page.dart';
import '../../../di/login/login_module.dart';
import '../../../generated/l10n.dart';
import '../../../main/navigation/route_paths.dart';
import '../../../ui/molecules/account/idwise_processing_status_widget.dart';
import '../../../ui/molecules/app_svg.dart';
import '../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/resource.dart';
import '../../../utils/status.dart';
import '../../../utils/string_utils.dart';
import '../register_page.dart';
import 'manage_idwise_status_model.dart';

class ManageIDWiseStatusView extends BasePageViewWidget<ManageIDWiseStatusViewModel> {
  ManageIDWiseStatusView(ProviderBase providerBase) : super(providerBase);

  @override
  Widget build(BuildContext context, ManageIDWiseStatusViewModel model) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 92.h),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AssetUtils.line,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 111.37.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.vividYellow,
                    ),
                    child: Center(child: AppSvg.asset(AssetUtils.right)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 56.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 48.w),
                        child: Text(
                          S.of(context).bareWithUsProcessing,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w500,
                              fontSize: 24.t,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 48.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                S.of(context).yourInformation,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24.t,
                                    color: Theme.of(context).colorScheme.secondary),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: JumpingDots(
                                color: AppColor.white,
                                radius: 4,
                                numberOfDots: 3,
                                verticalOffset: -5,
                                animationDuration: Duration(milliseconds: 500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 64.h,
                      ),
                      AppStreamBuilder<Resource<ProcessJourney>>(
                          initialData: Resource.none(),
                          stream: model.processJourneyViaMobileStream,
                          dataBuilder: (context, snapshot) {
                            return IDWiseProcessingStatusWidget(
                              label: S.of(context).verifyingYourNationalID,
                              isActivated: !model.arguments.isAhwalCheckPassed
                                  ? true
                                  : snapshot?.data?.isAllowPooling ?? false,
                            );
                          }),
                      SizedBox(
                        height: 16.h,
                      ),
                      AppStreamBuilder<Resource<CheckJourneyStatus>>(
                          initialData: Resource.none(),
                          stream: model.checkJourneyStatusStream,
                          onData: (value) {
                            if (value.status == Status.SUCCESS) {
                              if (!value.data!.keepPooling) {
                                Navigator.pushReplacementNamed(context, RoutePaths.Registration,
                                    arguments: RegisterPageParams(
                                        kycData: CheckKYCData(type: 'CountryResidence'),
                                        applicationId: ProviderScope.containerOf(context)
                                            .read(loginViewModelProvider)
                                            .applicationId));
                              }
                            } else if (value.status == Status.ERROR) {
                              if (value.appError!.error.code == "IDWISE-001") {
                              } else {}
                            }
                          },
                          dataBuilder: (context, snapshot) {
                            return IDWiseProcessingStatusWidget(
                              label: S.of(context).validatingYourSelfie,
                              isAhwalPassed : model.isAllowPooling,
                              isActivated: !(snapshot?.data?.keepPooling ?? true),
                            );
                          }),
                    ],
                  ),
                ), // Spacer(),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 56.h),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppSvg.asset(AssetUtils.info,
                                color: Theme.of(context).colorScheme.secondary, width: 24.w),
                            SizedBox(
                              width: 14,
                            ),
                            Flexible(
                              child: Text(
                                S.current.donotLeavePage,
                                maxLines: 2,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.t,
                                    color: Theme.of(context).colorScheme.secondary),
                              ),
                            ),
                          ]),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
