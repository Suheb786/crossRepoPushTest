import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/account_settings_page_view.dart';
import 'package:neo_bank/feature/account_settings/account_settings_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AccountSettingPage extends BasePage<AccountSettingPageViewModel> {
  @override
  AccountSettingPageState createState() => AccountSettingPageState();
}

class AccountSettingPageState extends BaseStatefulPage<AccountSettingPageViewModel, AccountSettingPage>
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
        preferredSize: Size(double.maxFinite, 85.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 24.0.w),
                child: AppSvg.asset(AssetUtils.leftArrow,
                    matchTextDirection: true, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Text(
              S.of(context).settings,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: 14.t,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 18.0.w),
              child: Container(
                width: 28.w,
              ),
            )
          ],
        ));
  }

  @override
  Widget buildView(BuildContext context, AccountSettingPageViewModel model) {
    return AccountSettingPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
