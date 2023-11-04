import 'package:domain/model/user/update_journey/update_journey.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/idwise_intial/idwise_intial_page_view_model.dart';
import 'package:neo_bank/feature/register/manage_idwise_status/manage_idwise_status_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../main/navigation/route_paths.dart';
import '../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../utils/resource.dart';
import '../failure_scenarios/failure_scenarios_page.dart';

class IdWiseIntialPageView extends BasePageViewWidget<IdWiseIntialPageViewModel> {
  IdWiseIntialPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, IdWiseIntialPageViewModel model) {
    return AppStreamBuilder<Resource<UpdateJourney>>(
        stream: model.updateJourneyStream,
        initialData: Resource.none(),
        onData: (updateJourney) async {
          if (updateJourney.status == Status.SUCCESS) {
            if (!(updateJourney.data?.documentStatus ?? false)) {
              Navigator.pushReplacementNamed(context, RoutePaths.OnboardingFailurScenariosPage,
                  arguments: OnboardingFailureScenarioArgument(
                      title: updateJourney.data?.documentTitle ?? '',
                      description: updateJourney.data?.documentDetail ?? ''));
            } else if (!(updateJourney.data?.selfieStatus ?? false)) {
              Navigator.pushReplacementNamed(context, RoutePaths.OnboardingFailurScenariosPage,
                  arguments: OnboardingFailureScenarioArgument(
                      title: updateJourney.data?.selfieTitle ?? '',
                      description: updateJourney.data?.selfieDetail ?? ''));
            } else {
              Navigator.pushReplacementNamed(context, RoutePaths.ManageIDWiseStatus,
                  arguments: ManageIDWiseStatusParams(
                      isAhwalCheckPassed: true, isFaceMatchScorePassed: true, journeyId: model.journeyId));
            }
          }
        },
        dataBuilder: (context, snapshot) {
          return Container(
            margin: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 5.h),
            child: Column(
              children: [
                Center(
                  child: Text(
                    S.of(context).getReadyToScanYourId,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 20.t,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 32.h),
                Expanded(
                  child: Card(
                    shadowColor: Theme.of(context).colorScheme.onBackground,
                    color: Theme.of(context).colorScheme.secondary,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 32.h, bottom: 54.h),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          height: 56.h,
                                          width: 56.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Theme.of(context).canvasColor,
                                          ),
                                          child: Image.asset(
                                            AssetUtils.CAPTURE,
                                            scale: 4,
                                          )),
                                      SizedBox(width: 16.w),
                                      Flexible(
                                        child: Text(
                                          S.current.ensureToHaveNationalId,
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            color: Theme.of(context).primaryColorDark,
                                            fontSize: 14.t,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 24.h),
                                  Row(
                                    children: [
                                      Container(
                                          height: 56.h,
                                          width: 56.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Theme.of(context).canvasColor,
                                          ),
                                          child: Image.asset(
                                            AssetUtils.BRIGHTNESS,
                                            scale: 4,
                                          )),
                                      SizedBox(width: 16.w),
                                      Flexible(
                                        child: Text(
                                          S.current.makeSureYouAreInbrightPlace,
                                          textAlign: TextAlign.start,
                                          softWrap: true,
                                          style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            color: Theme.of(context).primaryColorDark,
                                            fontSize: 14.t,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    AppStreamBuilder<bool>(
                                        initialData: false,
                                        stream: model.checkBoxStream,
                                        dataBuilder: (context, isChecked) {
                                          return InkWell(
                                            onTap: () {
                                              model.checkBoxToggle(!isChecked!);
                                            },
                                            child: Container(
                                              height: 40.h,
                                              width: 40.h,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100),
                                                  color: isChecked!
                                                      ? Theme.of(context).canvasColor
                                                      : Theme.of(context).colorScheme.secondary,
                                                  border: Border.all(
                                                      color: isChecked
                                                          ? Theme.of(context).colorScheme.onPrimaryContainer
                                                          : Theme.of(context).colorScheme.inversePrimary)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: isChecked
                                                    ? AppSvg.asset(
                                                        AssetUtils.check,
                                                        color: Theme.of(context).primaryColorDark,
                                                      )
                                                    : SizedBox(),
                                              ),
                                            ),
                                          );
                                        }),
                                    SizedBox(width: 16.w),
                                    Flexible(
                                      child: Text(
                                        S.current.termsAndConditions,
                                        textAlign: TextAlign.start,
                                        softWrap: true,
                                        style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).primaryColorDark,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 24.h),
                                AppStreamBuilder<bool>(
                                    initialData: false,
                                    stream: model.checkBoxStream,
                                    dataBuilder: (context, snapshot) {
                                      return AppPrimaryButton(
                                        onPressed: () async {
                                          model.getCurrentUser();
                                        },
                                        isDisabled: !snapshot!,
                                      );
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 56.h),
              ],
            ),
          );
        });
  }
}
