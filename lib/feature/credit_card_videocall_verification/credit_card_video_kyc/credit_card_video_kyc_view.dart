import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_video_kyc/credit_card_video_kyc_model.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CreditCardVideoKycPageView
    extends BasePageViewWidget<CreditCardVideoKycViewModel> {
  CreditCardVideoKycPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CreditCardVideoKycViewModel model) {
    return SafeArea(
      child: Stack(
        children: [
          model.remoteUid.isNotEmpty
              ? Container(
                  child: RtcRemoteView.SurfaceView(
                    uid: model.remoteUid.first,
                  ),
                )
              : Container(
                  color: AppColor.white,
                  child: Center(
                      child: Lottie.asset(AssetUtils.loaderAnimation,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                          width: 60,
                          height: 60)),
                ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.all(22),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 97,
                  height: 128,
                  child: RtcLocalView.SurfaceView(),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: InkWell(
              onTap: () {
                model.isJoined
                    ? model.leaveAgoraChannel()
                    : model.joinAgoraChannel();
              },
              child: Container(
                width: 57,
                height: 57,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: model.isJoined
                      ? AppColor.vivid_red
                      : AppColor.darkModerateLimeGreen,
                  shape: BoxShape.circle,
                ),
                child: model.isJoined
                    ? AppSvg.asset(AssetUtils.receiver)
                    : AppSvg.asset(AssetUtils.voiceCall, color: AppColor.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
