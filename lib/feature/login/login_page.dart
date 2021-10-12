import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/login/login_module.dart';
import 'package:neo_bank/feature/login/login_page_model.dart';
import 'package:neo_bank/feature/login/login_page_view.dart';
import 'package:neo_bank/utils/color_utils.dart';

class LoginPage extends BasePage<LoginViewModel> {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends BaseStatefulPage<LoginViewModel, LoginPage> {
  @override
  ProviderBase provideBase() {
    return loginViewModelProvider;
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }

  @override
  Color scaffoldBackgroundColor() {
    return AppColor.very_dark_blue;
  }

  @override
  Widget buildView(BuildContext context, LoginViewModel model) {
    return LoginPageView(provideBase());
  }
}
