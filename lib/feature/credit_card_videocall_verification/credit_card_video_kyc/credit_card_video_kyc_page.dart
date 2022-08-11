import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/di/credit_card_videocall_verification/credit_card_videocall_verification_module.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_video_kyc/credit_card_video_kyc_model.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_video_kyc/credit_card_video_kyc_view.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:wakelock/wakelock.dart';

class CreditCardVideoKycPage extends BasePage<CreditCardVideoKycViewModel> {
  final CreditCardVideKycCredentials credentials;

  CreditCardVideoKycPage({required this.credentials});

  @override
  CreditCardVideoKycPageState createState() => CreditCardVideoKycPageState();
}

class CreditCardVideoKycPageState
    extends BaseStatefulPage<CreditCardVideoKycViewModel, CreditCardVideoKycPage>
    with WidgetsBindingObserver {
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  ProviderBase provideBase() {
    return creditCardVideoKycViewModelProvider.call(widget.credentials);
  }

  @override
  Widget buildView(BuildContext context, CreditCardVideoKycViewModel model) {
    return CreditCardVideoKycPageView(provideBase());
  }

  @override
  void onModelReady(CreditCardVideoKycViewModel model) {
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
          image: AssetUtils.alert,
          isSwipeToCancel: false,
          title: S.of(context).videoCall,
          descriptionWidget: Text(
            "Your call was disconnected. Please try again.",
            style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 14, fontWeight: FontWeight.w400),
          ),
          onDismissed: () {}, onSelected: () {
        Navigator.of(context)
          ..pop()
          ..pop()
          ..pop();
        ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
      });
    }

    if (state == AppLifecycleState.paused) {
      getViewModel().leaveChannelWhenAppInBackground();
    }
    super.didChangeAppLifecycleState(state);
  }
}

class CreditCardVideKycCredentials {
  final String channelName;
  final String token;
  final String cardId;

  CreditCardVideKycCredentials({this.channelName: "", this.token: "", this.cardId: ""});
}
