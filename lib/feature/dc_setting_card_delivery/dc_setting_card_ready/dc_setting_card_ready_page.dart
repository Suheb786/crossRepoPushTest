import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_setting_card_delivery/dc_setting_card_delivery_module.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_card_ready/dc_setting_card_ready_page_view.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_card_ready/dc_setting_card_ready_view_model.dart';

import '../../../di/dashboard/dashboard_modules.dart';
import '../../../main/navigation/route_paths.dart';

class DcSettingCardReadyPage extends BasePage<DcSettingCardReadyViewModel> {
  @override
  DcSettingCardReadyPageState createState() => DcSettingCardReadyPageState();
}

class DcSettingCardReadyPageState
    extends BaseStatefulPage<DcSettingCardReadyViewModel, DcSettingCardReadyPage> {
  @override
  ProviderBase provideBase() {
    return dcSettingCardReadyViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, DcSettingCardReadyViewModel model) {
    return DcSettingCardReadyPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(DcSettingCardReadyViewModel model, {param}) {
    Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
    ProviderScope.containerOf(context)
        .read(appHomeViewModelProvider)
        .showSettingPage(false);
    ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
    return super.onBackPressed(model);
  }
}
