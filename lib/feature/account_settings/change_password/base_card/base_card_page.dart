import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page_view.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page_view_model.dart';

class BaseCardPage extends BasePage<BaseCardPageViewModel> {
  @override
  BaseCardPageState createState() => BaseCardPageState();
}

class BaseCardPageState
    extends BaseStatefulPage<BaseCardPageViewModel, BaseCardPage>
    with AutomaticKeepAliveClientMixin {
  BaseCardPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return baseCardViewModelProvider;
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
  Widget buildView(BuildContext context, BaseCardPageViewModel model) {
    return BaseCardPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
