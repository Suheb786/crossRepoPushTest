import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/forgot_password/forgot_password_modules.dart';
import 'package:neo_bank/feature/forgot_password/create_new_password/create_new_password_page_view.dart';
import 'package:neo_bank/feature/forgot_password/create_new_password/create_new_password_page_view_model.dart';

class CreateNewPasswordPage extends BasePage<CreateNewPasswordPageViewModel> {
  @override
  CreateNewPasswordPageState createState() => CreateNewPasswordPageState();
}

class CreateNewPasswordPageState
    extends BaseStatefulPage<CreateNewPasswordPageViewModel, CreateNewPasswordPage> {
  @override
  ProviderBase provideBase() {
    return createNewPasswordViewModelProvider;
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
  Widget buildView(BuildContext context, CreateNewPasswordPageViewModel model) {
    return CreateNewPasswordPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(CreateNewPasswordPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(forgotPasswordViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
