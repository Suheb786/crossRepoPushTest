import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/account_settings_page_view.dart';
import 'package:neo_bank/feature/account_settings/account_settings_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';

class AccountSettingPage extends BasePage<AccountSettingPageViewModel> {
  @override
  AccountSettingPageState createState() => AccountSettingPageState();
}

class AccountSettingPageState
    extends BaseStatefulPage<AccountSettingPageViewModel, AccountSettingPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AccountSettingPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return accountSettingViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 85),
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            Navigator.pop(context);
          },
          behavior: HitTestBehavior.translucent,
          child: Center(
            child: Text(
              S.of(context).settings,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).accentColor),
            ),
          ),
        ));
  }

  @override
  Widget buildView(BuildContext context, AccountSettingPageViewModel model) {
    return AccountSettingPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
