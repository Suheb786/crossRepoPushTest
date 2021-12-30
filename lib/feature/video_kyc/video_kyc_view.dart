import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/video_kyc/video_kyc_model.dart';

class VideoKycPageView extends BasePageViewWidget<VideoKycViewModel> {
  VideoKycPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, VideoKycViewModel model) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: model.isJoined
                          ? model.leaveAgoraChannel
                          : model.joinAgoraChannel,
                      child:
                          Text('${model.isJoined ? 'Leave' : 'Join'} channel'),
                    ),
                  )
                ],
              ),
              Expanded(
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
                                width: 120,
                                height: 120,
                                child: RtcRemoteView.SurfaceView(
                                  uid: e,
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: model.switchAgoraCamera,
                  child:
                      Text('Camera ${model.switchCamera ? 'front' : 'rear'}'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
