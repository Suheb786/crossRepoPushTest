import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/video_kyc/video_kyc_module.dart';
import 'package:neo_bank/feature/video_kyc/video_kyc_model.dart';
import 'package:neo_bank/feature/video_kyc/video_kyc_view.dart';

class VideoKycPage extends BasePage<VideoKycViewModel> {
  final VideKycCredentials credentials;

  VideoKycPage({required this.credentials});

  @override
  VideoKycPageState createState() => VideoKycPageState();
}

class VideoKycPageState
    extends BaseStatefulPage<VideoKycViewModel, VideoKycPage> {
  @override
  ProviderBase provideBase() {
    return videoKycViewModelProvider.call(widget.credentials);
  }

  @override
  Widget buildView(BuildContext context, VideoKycViewModel model) {
    return VideoKycPageView(provideBase());
  }
}

class VideKycCredentials {
  final String channelName;
  final String token;

  VideKycCredentials({this.channelName: "", this.token: ""});
}
