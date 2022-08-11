import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/di/video_kyc/video_kyc_module.dart';
import 'package:neo_bank/feature/video_kyc/video_kyc_model.dart';
import 'package:neo_bank/feature/video_kyc/video_kyc_view.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:wakelock/wakelock.dart';

class VideoKycPage extends BasePage<VideoKycViewModel> {
  final VideKycCredentials credentials;

  VideoKycPage({required this.credentials});

  @override
  VideoKycPageState createState() => VideoKycPageState();
}

class VideoKycPageState extends BaseStatefulPage<VideoKycViewModel, VideoKycPage>
    with WidgetsBindingObserver {
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  ProviderBase provideBase() {
    return videoKycViewModelProvider.call(widget.credentials);
  }

  @override
  Widget buildView(BuildContext context, VideoKycViewModel model) {
    return VideoKycPageView(provideBase());
  }

  @override
  void onModelReady(VideoKycViewModel model) {
    Wakelock.enable();
    ProviderScope.containerOf(context).read(appViewModel).getToken();
    super.onModelReady(model);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      InformationDialog.show(context,
          isSwipeToCancel: false,
          image: AssetUtils.alert,
          title: S.of(context).videoCall,
          descriptionWidget: Text(
            S.of(context).callDisconnected,
            style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          onDismissed: () {}, onSelected: () {
        Navigator.of(context)
          ..pop()
          ..pop(false);
      });
    }

    if (state == AppLifecycleState.paused) {
      getViewModel().leaveChannelWhenAppInBackground();
    }
    super.didChangeAppLifecycleState(state);
  }
}

class VideKycCredentials {
  final String channelName;
  final String token;

  VideKycCredentials({this.channelName: "", this.token: ""});
}
