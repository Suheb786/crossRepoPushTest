import 'dart:io';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/account/check_existing_call_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/video_call/video_call_information/video_call_information_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallInformationPageView extends BasePageViewWidget<VideoCallInformationPageViewModel> {
  VideoCallInformationPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, VideoCallInformationPageViewModel model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<Resource<CheckExistingCallStatus>>(
          stream: model.checkExistingCall,
          initialData: Resource.none(),
          onData: (data) {
            if (data.status == Status.SUCCESS) {
              if (data.data!.isExist) {
                ///TODO:check scheduled Videocall
                // Navigator.pushNamed(context, RoutePaths.CheckScheduledVideoCall,
                //     arguments: CheckVideoCallScheduledArguments(
                //         scheduledDate: data.data!.scheduledDate,
                //         scheduledTime: data.data!.scheduledTime,
                //         isExist: data.data!.isExist,
                //         isExpire: data.data!.isExpire));
              }
            }
          },
          dataBuilder: (context, snapshot) {
            return Column(
              children: [
                Expanded(
                  child: ShakeAnimatedWidget(
                    enabled: false,
                    duration: Duration(milliseconds: 100),
                    shakeAngle: Rotation.deg(z: 1),
                    curve: Curves.easeInOutSine,
                    child: GestureDetector(
                      onHorizontalDragEnd: (details) async {
                        if (ProviderScope.containerOf(context)
                                .read(videoCallViewModelProvider)
                                .appSwiperController
                                .page ==
                            0.0) {
                          if (StringUtils.isDirectionRTL(context)) {
                            if (!details.primaryVelocity!.isNegative) {
                              checkPermission(context);
                            }
                          } else {
                            if (details.primaryVelocity!.isNegative) {
                              checkPermission(context);
                            }
                          }
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        color: Theme.of(context).cardTheme.copyWith(color: AppColor.white).color,
                        margin: EdgeInsets.zero,
                        shadowColor: AppColor.black.withOpacity(0.32),
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 35.0.h, bottom: 24.h),
                                          child: Container(
                                            height: 78.h,
                                            width: 78.w,
                                            padding:
                                                EdgeInsets.symmetric(horizontal: 25.07.w, vertical: 22.29.h),
                                            decoration: BoxDecoration(
                                              color: AppColor.vividYellow,
                                              shape: BoxShape.circle,
                                            ),
                                            child: AppSvg.asset(AssetUtils.maleAgent,
                                                color: Theme.of(context).primaryColorDark),
                                          ),
                                        ),
                                        Text(
                                          S.of(context).videoCallInfoDescription,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 20.t,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).primaryColorDark),
                                        ),
                                        SizedBox(
                                          height: 43.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Future.delayed(Duration(milliseconds: 500), () {
                                              ProviderScope.containerOf(context)
                                                  .read(videoCallViewModelProvider)
                                                  .moveToPage(2);
                                              // .move(2, animation: false);
                                            });
                                          },
                                          child: Text(S.of(context).scheduleLater,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: Theme.of(context).accentTextTheme.bodyText1!.color,
                                                  fontSize: 14.t,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.0.h),
                                  child: AnimatedButton(
                                    buttonText: S.of(context).swipeToProceed,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  checkPermission(BuildContext context) async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.microphone,
        Permission.bluetooth,
        Permission.bluetoothConnect
      ].request();

      if (statuses[Permission.camera] == PermissionStatus.permanentlyDenied ||
          statuses[Permission.microphone] == PermissionStatus.permanentlyDenied ||
          statuses[Permission.bluetooth] == PermissionStatus.permanentlyDenied ||
          statuses[Permission.bluetoothConnect] == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      } else {
        Future.delayed(Duration(milliseconds: 100), () {
          ProviderScope.containerOf(context).read(videoCallViewModelProvider).nextPage();
          // .next();
        });
        Future.delayed(Duration(milliseconds: 500), () {
          ProviderScope.containerOf(context)
              .read(videoCallAgentSelectionViewModelProvider)
              .checkAvailableAgent();
          // .next();
        });
      }
    } else if (Platform.isIOS) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.microphone,
      ].request();

      if (statuses[Permission.camera] == PermissionStatus.permanentlyDenied ||
          statuses[Permission.microphone] == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      } else {
        Future.delayed(Duration(milliseconds: 100), () {
          ProviderScope.containerOf(context).read(videoCallViewModelProvider).nextPage();
          // .next();
        });
        Future.delayed(Duration(milliseconds: 500), () {
          ProviderScope.containerOf(context)
              .read(videoCallAgentSelectionViewModelProvider)
              .checkAvailableAgent();
          // .next();
        });
      }
    }
  }
}
