import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/enter_code_for_change_email_address/enter_code_for_change_email_address_page_view.dart';
import 'package:neo_bank/feature/account_settings/change_email_address/enter_code_for_change_email_address/enter_code_for_change_email_address_page_view_model.dart';

class EnterCodeForChangeEmailAddressPage
    extends BasePage<EnterCodeForChangeEmailAddressPageViewModel> {
  @override
  EnterCodeForChangeEmailAddressPageState createState() =>
      EnterCodeForChangeEmailAddressPageState();
}

class EnterCodeForChangeEmailAddressPageState extends BaseStatefulPage<
    EnterCodeForChangeEmailAddressPageViewModel,
    EnterCodeForChangeEmailAddressPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  EnterCodeForChangeEmailAddressPageState()
      : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return enterOtpForNewEmailAddressViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(EnterCodeForChangeEmailAddressPageViewModel model) {
    model.countDownController =
        CountdownTimerController(endTime: model.endTime);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context,
      EnterCodeForChangeEmailAddressPageViewModel model) {
    return EnterCodeForChangeEmailAddressPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
