import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/change_Device/change_device_modules.dart';
import 'package:neo_bank/feature/change_device_flow/change_device_success/change_device_success_page_view.dart';
import 'package:neo_bank/feature/change_device_flow/change_device_success/change_device_success_page_view_model.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';

class ChangeDeviceSuccessPage extends BasePage<ChangeDeviceSuccessPageViewModel> {
  @override
  ChangeDeviceSuccessPageState createState() => ChangeDeviceSuccessPageState();
}

class ChangeDeviceSuccessPageState
    extends BaseStatefulPage<ChangeDeviceSuccessPageViewModel, ChangeDeviceSuccessPage> {
  @override
  ProviderBase provideBase() {
    return changeDeviceSuccessViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ChangeDeviceSuccessPageViewModel model) {
    return ChangeDeviceSuccessPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(ChangeDeviceSuccessPageViewModel model, {param}) {
    Navigator.pushNamedAndRemoveUntil(context, RoutePaths.OnBoarding, (route) => false);
    return super.onBackPressed(model);
  }
}
