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
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!(getViewModel().isBiometricDialogShown)) {
        getViewModel().getCurrentUser();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }

  @override
  void onModelReady(LoginViewModel model) {
    //model.checkVersionUpdate();
    model.getLanguageFromStorage(context);
    model.getCurrentUser();
    super.onModelReady(model);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget buildView(BuildContext context, LoginViewModel model) {
    return LoginPageView(provideBase());
  }
}
