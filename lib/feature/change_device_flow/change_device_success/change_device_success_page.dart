import 'package:data/di/local_module.dart';
import 'package:data/network/api_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/change_Device/change_device_modules.dart';
import 'package:neo_bank/feature/change_device_flow/change_device_success/change_device_success_page_view.dart';
import 'package:neo_bank/feature/change_device_flow/change_device_success/change_device_success_page_view_model.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';

import '../../../utils/app_constants.dart';

class ChangeDeviceSuccessPage extends BasePage<ChangeDeviceSuccessPageViewModel> {
  final ChangeDeviceParams arguments;

  ChangeDeviceSuccessPage(this.arguments);

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
  void onModelReady(ChangeDeviceSuccessPageViewModel model) {
    model.arguments = widget.arguments;
    super.onModelReady(model);
  }

  @override
  Future<bool> onBackPressed(ChangeDeviceSuccessPageViewModel model, {param}) {
    authToken = '';
    ProviderScope.containerOf(appLevelKey.currentState!.context).read(localSessionService).stopTimer();
    AppConstantsUtils.resetCacheLists();
    Navigator.pushNamedAndRemoveUntil(context, RoutePaths.OnBoarding, (route) => false);
    return super.onBackPressed(model);
  }
}

class ChangeDeviceParams {
  String journeyId;

  ChangeDeviceParams({required this.journeyId});
}
