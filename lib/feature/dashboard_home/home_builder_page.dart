import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/dashboard_home/home_builder_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/home_builder_view_model.dart';

class RegisterPage extends BasePage<HomeBuilderViewModel> {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState
    extends BaseStatefulPage<HomeBuilderViewModel, RegisterPage> {
  @override
  ProviderBase provideBase() {
    return homeBuilderViewModelProvider;
  }

  @override
  void onModelReady(HomeBuilderViewModel model) {
    // model.registrationStepsController = PageController();
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, HomeBuilderViewModel model) {
    return HomeBuilderView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}
