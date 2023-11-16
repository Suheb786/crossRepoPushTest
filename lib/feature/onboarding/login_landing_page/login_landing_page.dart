import 'dart:async';
import 'dart:io';

import 'package:data/helper/secure_storage_helper.dart';
import 'package:data/helper/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/login/login_module.dart';
import 'package:neo_bank/feature/onboarding/login_landing_page/login_landing_page_view.dart';
import 'package:neo_bank/feature/onboarding/login_landing_page/login_landing_page_view_model.dart';
import 'package:neo_bank/utils/app_constants.dart';

class LoginLandingPage extends BasePage<LoginLandingPageViewModel> {
  @override
  LoginLandingPageState createState() => LoginLandingPageState();
}

class LoginLandingPageState extends BaseStatefulPage<LoginLandingPageViewModel, LoginLandingPage>
    with WidgetsBindingObserver {
  @override
  ProviderBase provideBase() {
    return loginLandingViewModelProvider;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (!(AppConstantsUtils.isBiometricDialogShown)) {
        var value = await SharedPreferenceHelper.getValue();
        if (value) {
          await SecureStorageHelper.instance.clearUserData();
          getViewModel().getCurrentUser();
        } else {
          getViewModel().getCurrentUser();
        }
      }
      if (Platform.isIOS) {
        getViewModel().timer = new Timer(
          const Duration(milliseconds: 1000),
          () {
            getViewModel().onResumeDynamicLink();
          },
        );
      } else {
        getViewModel().initDynamicLink();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }

  @override
  Future<void> onModelReady(LoginLandingPageViewModel model) async {
    model.getLanguageFromStorage(context);
    var value = await SharedPreferenceHelper.getValue();
    if (value) {
      await SecureStorageHelper.instance.clearUserData();
      model.getCurrentUser();
    } else {
      model.getCurrentUser();
    }
    super.onModelReady(model);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void deactivate() {
    WidgetsBinding.instance.removeObserver(this);
    super.deactivate();
  }

  @override
  Widget buildView(BuildContext context, LoginLandingPageViewModel model) {
    return LoginLandingPageView(provideBase());
  }
}
