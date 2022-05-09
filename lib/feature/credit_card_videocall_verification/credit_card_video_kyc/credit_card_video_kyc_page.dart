import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/di/credit_card_videocall_verification/credit_card_videocall_verification_module.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_video_kyc/credit_card_video_kyc_model.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_video_kyc/credit_card_video_kyc_view.dart';
import 'package:wakelock/wakelock.dart';

class CreditCardVideoKycPage extends BasePage<CreditCardVideoKycViewModel> {
  final CreditCardVideKycCredentials credentials;

  CreditCardVideoKycPage({required this.credentials});

  @override
  CreditCardVideoKycPageState createState() => CreditCardVideoKycPageState();
}

class CreditCardVideoKycPageState extends BaseStatefulPage<
    CreditCardVideoKycViewModel, CreditCardVideoKycPage> {
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
}

class CreditCardVideKycCredentials {
  final String channelName;
  final String token;
  final String cardId;

  CreditCardVideKycCredentials(
      {this.channelName: "", this.token: "", this.cardId: ""});
}
