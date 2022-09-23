import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_setting_card_delivery/dc_setting_card_delivery_module.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_create_pin/dc_setting_create_pin_page_view.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_create_pin/dc_setting_create_pin_page_view_model.dart';

class DcSettingCreatePinPage extends BasePage<DcSettingCreatePinPageViewModel> {
  @override
  DcSettingCreatePinPageState createState() => DcSettingCreatePinPageState();
}

class DcSettingCreatePinPageState
    extends BaseStatefulPage<DcSettingCreatePinPageViewModel, DcSettingCreatePinPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  DcSettingCreatePinPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return dcSettingCreatePinViewModelProvider;
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
  Widget buildView(BuildContext context, DcSettingCreatePinPageViewModel model) {
    return DcSettingCreatePinPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
