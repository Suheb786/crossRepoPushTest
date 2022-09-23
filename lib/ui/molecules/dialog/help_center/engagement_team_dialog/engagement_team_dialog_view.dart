// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/help_center/help_center_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/help_center/engagement_team_dialog/engagement_team_dialog_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EngagementTeamDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;

  const EngagementTeamDialogView({
    this.onDismissed,
    this.onSelected,
  });

  ProviderBase providerBase() {
    return engagementTeamDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<EngagementTeamDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 340.h),
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  onDismissed?.call();
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 32.0.h),
                    child: Center(
                      child: Text(
                        S.of(context).engagementTeam,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont, fontSize: 20.t, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(top: 32.0.h, start: 24.0.w, end: 24.0.w),
                      child: Text(
                        S.of(context).engagementTeamDescription,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 14.t,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                            color: AppColor.very_dark_gray_black),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, RoutePaths.HelpCenter);
                    },
                    child: Container(
                      height: 72.h,
                      margin: EdgeInsets.symmetric(horizontal: 24.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.brightBlue),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 18.11.w),
                              height: 25.h,
                              width: 25.w,
                              child: AppSvg.asset(
                                AssetUtils.voiceCall,
                                color: Theme.of(context).primaryColorDark,
                              )),
                          Text(
                            S.of(context).voiceCall,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 14.0.t,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  // AppStreamBuilder<Resource<bool>>(
                  //   stream: model!.initInfobipMessageResponseStream,
                  //   onData: (value) {},
                  //   initialData: Resource.success(data: false),
                  //   dataBuilder: (context, value) =>
                  InkWell(
                    onTap: () {
                      // if (value?.data != null && value!.data!) {

                      // ProviderScope.containerOf(context)
                      //     .read(appViewModel)
                      //     .saveUserData();
                      model!.showChat();
                      // }
                    },
                    child: Container(
                      height: 72.h,
                      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.0.h),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.brightBlue),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 18.11.w),
                              height: 25.h,
                              width: 25.w,
                              child: AppSvg.asset(
                                AssetUtils.liveChat,
                                color: Theme.of(context).primaryColorDark,
                              )),
                          Text(
                            S.of(context).liveChat,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 14.0.t,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  // ),
                  SizedBox(height: 56.h),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0.h, bottom: 16.h),
                    child: Center(
                      child: Text(
                        S.of(context).swipeDownToCancel,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 10.t,
                            fontWeight: FontWeight.w400,
                            color: AppColor.dark_gray_1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        providerBase: providerBase());
  }
}
