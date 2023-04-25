import 'package:data/helper/secure_storage_helper.dart';
import 'package:data/helper/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/login/login_module.dart';
import 'package:neo_bank/feature/login/login_page_model.dart';
import 'package:neo_bank/feature/login/login_page_view.dart';

class LoginPage extends BasePage<LoginViewModel> {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends BaseStatefulPage<LoginViewModel, LoginPage> with WidgetsBindingObserver {
  @override
  ProviderBase provideBase() {
    return loginViewModelProvider;
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (!(getViewModel().isBiometricDialogShown)) {
        var value = await SharedPreferenceHelper.getValue();
        if (value) {
          await SecureStorageHelper.instance.clearUserData();
          getViewModel().getCurrentUser();
        } else {
          getViewModel().getCurrentUser();
        }
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }

  @override
  Future<void> onModelReady(LoginViewModel model) async {
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
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void deactivate() {
    WidgetsBinding.instance!.removeObserver(this);
    super.deactivate();
  }

  @override
  Widget buildView(BuildContext context, LoginViewModel model) {
    return LoginPageView(provideBase());
  }
}
