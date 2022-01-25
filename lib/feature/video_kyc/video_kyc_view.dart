import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/video_kyc/video_kyc_model.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class VideoKycPageView extends BasePageViewWidget<VideoKycViewModel> {
  VideoKycPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, VideoKycViewModel model) {
    return SafeArea(
      child: Stack(
        children: [
          RtcLocalView.SurfaceView(),
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.of(model.remoteUid.map(
                  (e) => GestureDetector(
                    onTap: model.switchAgoraRender,
                    child: Container(
                      margin: EdgeInsets.all(22),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 97,
                          height: 128,
                          child: RtcRemoteView.SurfaceView(
                            uid: e,
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: InkWell(
              onTap: model.leaveAgoraChannel(),
              child: Container(
                width: 57,
                height: 57,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColor.vivid_red,
                  shape: BoxShape.circle,
                ),
                child: AppSvg.asset(AssetUtils.receiver),
              ),
            ),
          )
        ],
      ),
    );
  }
}
