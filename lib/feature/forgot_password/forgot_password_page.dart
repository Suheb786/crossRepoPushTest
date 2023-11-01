import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/forgot_password/forgot_password_modules.dart';
import 'package:neo_bank/feature/forgot_password/forgot_password_page_view.dart';
import 'package:neo_bank/feature/forgot_password/forgot_password_page_view_model.dart';

class ForgotPasswordPage extends BasePage<ForgotPasswordPageViewModel> {
  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends BaseStatefulPage<ForgotPasswordPageViewModel, ForgotPasswordPage> {
  @override
  ProviderBase provideBase() {
    return forgotPasswordViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ForgotPasswordPageViewModel model) {
    return ForgotPasswordPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(ForgotPasswordPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(forgotPasswordViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
