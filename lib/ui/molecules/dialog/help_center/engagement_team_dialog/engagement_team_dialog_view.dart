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
  final bool onWillPop;

  const EngagementTeamDialogView({this.onDismissed, this.onSelected, this.onWillPop = true});

  ProviderBase providerBase() {
    return engagementTeamDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => onWillPop,
      child: BaseWidget<EngagementTeamDialogViewModel>(
          builder: (context, model, child) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 56.h, top: 340.h),
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Column(
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
                      InkWell(
                        onTap: () {
                          model!.showChat();
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
                    ],
                  ),
                  Positioned(
                    bottom: -24.h,
                    child: InkWell(
                      onTap: () {
                        onDismissed?.call();
                      },
                      child: Container(
                          height: 48.h,
                          width: 48.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.secondary),
                          child: Image.asset(
                            AssetUtils.close_bold,
                            scale: 3.5,
                          )),
                    ),
                  )
                ],
              ),
            );
          },
          providerBase: providerBase()),
    );
  }
}
