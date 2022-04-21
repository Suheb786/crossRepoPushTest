import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/di/dc_setting_card_delivery/dc_setting_card_delivery_module.dart';
import 'package:neo_bank/feature/card_delivery/card_delivery_page_view.dart';
import 'package:neo_bank/feature/card_delivery/card_delivery_page_view_model.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_card_delivery_page_view.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_card_delivery_page_view_model.dart';

class DcSettingCardDeliveryPage
    extends BasePage<DcSettingCardDeliveryPageViewModel> {
  @override
  DcSettingCardDeliveryPageState createState() =>
      DcSettingCardDeliveryPageState();
}

class DcSettingCardDeliveryPageState extends BaseStatefulPage<
    DcSettingCardDeliveryPageViewModel, DcSettingCardDeliveryPage> {
  @override
  ProviderBase provideBase() {
    return dcSettingCardDeliveryViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(
      BuildContext context, DcSettingCardDeliveryPageViewModel model) {
    return DcSettingCardDeliveryPageView(provideBase());
  }
}
