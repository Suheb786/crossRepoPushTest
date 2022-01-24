import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/change_card_pin/otp_for_change_card_pin/otp_for_change_card_pin_page_view.dart';
import 'package:neo_bank/feature/change_card_pin/otp_for_change_card_pin/otp_for_change_card_pin_page_view_model.dart';

class OtpForChangeCardPinPage
    extends BasePage<OtpForChangeCardPinPageViewModel> {
  @override
  OtpForChangeCardPinPageState createState() => OtpForChangeCardPinPageState();
}

class OtpForChangeCardPinPageState extends BaseStatefulPage<
        OtpForChangeCardPinPageViewModel, OtpForChangeCardPinPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  OtpForChangeCardPinPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return otpForChangeCardPinViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(OtpForChangeCardPinPageViewModel model) {
    model.countDownController =
        CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return ProviderScope.containerOf(context)
                .read(changeCardPinViewModelProvider)
                .cardType ==
            CardType.DEBIT
        ? Theme.of(context).canvasColor
        : Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(
      BuildContext context, OtpForChangeCardPinPageViewModel model) {
    return OtpForChangeCardPinPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
