import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_setting_card_delivery/dc_setting_card_delivery_module.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_visa_card/dc_setting_visa_card_page_view.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_visa_card/dc_setting_visa_card_page_view_model.dart';

import '../../../di/dashboard/dashboard_modules.dart';

class DcSettingVisaCardPage extends BasePage<DcSettingVisaCardPageViewModel> {
  @override
  DcSettingVisaCardPageState createState() => DcSettingVisaCardPageState();
}

class DcSettingVisaCardPageState
    extends BaseStatefulPage<DcSettingVisaCardPageViewModel, DcSettingVisaCardPage>
    with TickerProviderStateMixin {
  @override
  ProviderBase provideBase() {
    return dcSettingVisaCardViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, DcSettingVisaCardPageViewModel model) {
    return DcSettingVisaCardPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(DcSettingVisaCardPageViewModel model, {param}) {
    ProviderScope.containerOf(context).read(appHomeViewModelProvider).showSettingPage(false);
    ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
    return super.onBackPressed(model);
  }
}
