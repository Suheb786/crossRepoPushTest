import 'package:domain/constants/enum/infobip_call_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/help_center/help_center_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

class HelpCenterPageView extends BasePageViewWidget<HelpCenterPageViewModel> {
  HelpCenterPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<Resource<bool>>(
        stream: model.initInfobipStream,
        initialData: Resource.none(),
        onData: (value) {
          if (value.data!) {
            model.obtainTokenForCall();
          }
        },
        dataBuilder: (context, data) {
          return AppStreamBuilder<Resource<String>>(
              stream: model.obtainTokenResponseSubject,
              initialData: Resource.none(),
              onData: (value) {
                if (value.data != null) {
                  model.establishCall(value.data!);
                }
              },
              dataBuilder: (context, currentStep) {
                return AppStreamBuilder<Resource<bool>>(
                    stream: model.establishCallResponseSubject,
                    initialData: Resource.none(),
                    onData: (value) {
                      // Navigator.pushReplacementNamed(
                      //     context, RoutePaths.ActiveCallPage);
                    },
                    dataBuilder: (context, currentStep) {
                      return AppStreamBuilder<InfobipCallStatusEnum>(
                          stream: model.callStatusStream,
                          initialData: InfobipCallStatusEnum.ON_RINGING,
                          onData: (value) {
                            if (value == InfobipCallStatusEnum.ON_ESTABLISHED) {
                              Navigator.pushReplacementNamed(context, RoutePaths.ActiveCallPage);
                            }
                          },
                          dataBuilder: (context, currentStep) {
                            return Padding(
                              padding: EdgeInsets.only(top: 56.h),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 36.h),
                                        child: Column(
                                          children: [
                                            Text(
                                              S.of(context).voiceChat,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: Theme.of(context).colorScheme.secondary,
                                                  fontSize: 10.t,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional.only(
                                                  top: 8.0.h, bottom: 32.h, start: 24.w, end: 24.w),
                                              child: ShowUpAnimation(
                                                key: ValueKey(currentStep),
                                                delayStart: Duration(milliseconds: 50),
                                                animationDuration: Duration(milliseconds: 750),
                                                curve: Curves.easeInOut,
                                                direction: Direction.vertical,
                                                offset: 0.5,
                                                child: Text(
                                                  S.of(context).engagementTeamGettingReady,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      color: Theme.of(context).colorScheme.secondary,
                                                      fontSize: 20.t,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(16)),
                                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                                  elevation: 2,
                                                  color: Theme.of(context)
                                                      .cardTheme
                                                      .copyWith(color: AppColor.white)
                                                      .color,
                                                  margin: EdgeInsets.zero,
                                                  shadowColor: AppColor.black.withOpacity(0.32),
                                                  child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                                                      child: Column(
                                                        children: [
                                                          SizedBox(height: 59.h),
                                                          GestureDetector(
                                                            onTap: () {
                                                              // model.onCallEstablish();
                                                            },
                                                            child: Align(
                                                              alignment: Alignment.center,
                                                              child: Container(
                                                                height: 80.37.h,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: AppColor.vividYellow,
                                                                ),
                                                                child: Center(
                                                                    child:
                                                                        AppSvg.asset(AssetUtils.helpAgent)),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(height: 24.0.h),
                                                          Text(
                                                            S.of(context).weWillConnectYou,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontFamily: StringUtils.appFont,
                                                                color: Theme.of(context).primaryColorDark,
                                                                fontSize: 20.t,
                                                                fontWeight: FontWeight.w600),
                                                          ),
                                                          SizedBox(height: 24.0.h),
                                                          Text(
                                                            S.of(context).thankYouForWaiting,
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontFamily: StringUtils.appFont,
                                                                color: AppColor.very_dark_gray1,
                                                                fontSize: 12.t,
                                                                fontWeight: FontWeight.w400),
                                                          ),
                                                          Spacer(),
                                                          Padding(
                                                            padding: EdgeInsets.only(bottom: 26.h),
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                              },
                                                              child: Center(
                                                                child: Text(
                                                                  S.of(context).backToDashboard,
                                                                  style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    color: AppColor.brightBlue,
                                                                    fontSize: 14.t,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            );
                          });
                    });
              });
        });
  }
}
