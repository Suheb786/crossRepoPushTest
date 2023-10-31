import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/idwise_intial/idwise_intial_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../main/navigation/route_paths.dart';
import '../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../utils/resource.dart';
import '../../../utils/status.dart';
import '../../account_registration/manage_idwise_status/manage_idwise_status_page.dart';

class IdWiseIntialPageView extends BasePageViewWidget<IdWiseIntialPageViewModel> {
  IdWiseIntialPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, IdWiseIntialPageViewModel model) {
    return AppStreamBuilder<Resource<bool>>(
        stream: model.updateJourneyStream,
        initialData: Resource.none(),
        onData: (data) async {
          if (data.status == Status.SUCCESS) {
            Navigator.pushReplacementNamed(context, RoutePaths.ManageIDWiseStatus,
                arguments: ManageIDWiseStatusParams(journeyId: model.journeyId));
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
                                AppPrimaryButton(
                                  onPressed: () async {
                                    model.getCurrentUser();
                                  },
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  S.current.byContinuingYouAgree,
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).colorScheme.surfaceTint,
                                    fontSize: 14.t,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    S.current.privacyPolicy,
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: Theme.of(context).colorScheme.onSecondaryContainer,
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
