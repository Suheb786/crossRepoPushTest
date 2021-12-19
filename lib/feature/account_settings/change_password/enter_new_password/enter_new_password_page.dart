import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_password/enter_new_password/enter_new_password_page_view.dart';
import 'package:neo_bank/feature/account_settings/change_password/enter_new_password/enter_new_password_page_view_model.dart';

class EnterNewPasswordPage extends BasePage<EnterNewPasswordPageViewModel> {
  @override
  EnterNewPasswordPageState createState() => EnterNewPasswordPageState();
}

class EnterNewPasswordPageState extends BaseStatefulPage<
    EnterNewPasswordPageViewModel,
    EnterNewPasswordPage>
    with AutomaticKeepAliveClientMixin {
  EnterNewPasswordPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return enterNewPasswordViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, EnterNewPasswordPageViewModel model) {
    return EnterNewPasswordPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
