import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_setting_card_delivery/dc_setting_card_delivery_module.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_confirm_pin/dc_setting_confirm_pin_page_view.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_confirm_pin/dc_setting_confirm_pin_page_view_model.dart';

class DcSettingConfirmPinPage extends BasePage<DcSettingConfirmPinPageViewModel> {
  @override
  DcSettingConfirmPinPageState createState() => DcSettingConfirmPinPageState();
}

class DcSettingConfirmPinPageState
    extends BaseStatefulPage<DcSettingConfirmPinPageViewModel, DcSettingConfirmPinPage> {
  @override
  ProviderBase provideBase() {
    return dcSettingConfirmPinViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, DcSettingConfirmPinPageViewModel model) {
    return DcSettingConfirmPinPageView(provideBase());
  }
}
