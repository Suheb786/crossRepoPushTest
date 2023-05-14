import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:domain/constants/enum/video_kyc_status_enum.dart';
import 'package:domain/model/account/video_kyc_status.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/feature/video_kyc/video_kyc_model.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';

class VideoKycPageView extends BasePageViewWidget<VideoKycViewModel> {
  VideoKycPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, VideoKycViewModel model) {
    return SafeArea(
      child: Stack(
        children: [
          model.remoteUid.isNotEmpty
              ? Container(
                  child: AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: model.engine,
                      canvas: VideoCanvas(uid: model.remoteUid.first),
                      connection: RtcConnection(channelId: model.channelId),
                    ),
                  ),
                )
              : Container(
                  color: AppColor.white,
                  child: Center(
                      child: Lottie.asset(AssetUtils.loaderAnimation,
                          fit: BoxFit.cover, alignment: Alignment.center, width: 60.w, height: 60.h)),
                ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 97.w,
                  height: 128.h,
                  child: AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: model.engine,
                      canvas: VideoCanvas(uid: 0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          PositionedDirectional(
            start: 0,
            end: 0,
            bottom: 50.h,
            child: AppStreamBuilder<Resource<LogoutResponse>>(
                stream: model.logoutStream,
                initialData: Resource.none(),
                onData: (response) {
                  if (response.status == Status.SUCCESS) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RoutePaths.OnBoarding, ModalRoute.withName(RoutePaths.Splash));
                  }
                },
                dataBuilder: (context, data) {
                  return AppStreamBuilder<Resource<VideoKycStatus>>(
                    stream: model.callStatusStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        ProviderScope.containerOf(context).read(appViewModel).stopRefreshToken();
                        switch (data.data!.status) {
                          case VideoKycStatusEnum.APPROVED:
                            Navigator.pop(context, true);
                            // Future.delayed(Duration(milliseconds: 500), () {
                            //
                            // });
                            break;
                          case VideoKycStatusEnum.REJECTED:
                            model.logOutUser();
                            break;
                          default:
                            model.getCallStatus();
                            break;
                        }
                      }
                    },
                    dataBuilder: (context, data) {
                      return InkWell(
                        onTap: () {
                          model.leaveAgoraChannel();
                        },
                        child: Container(
                          width: 57.w,
                          height: 57.h,
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                          decoration: BoxDecoration(
                            color: AppColor.vivid_red,
                            shape: BoxShape.circle,
                          ),
                          child: AppSvg.asset(AssetUtils.receiver),
                        ),
                      );
                    },
                  );
                }),
          )
        ],
      ),
    );
  }
}
