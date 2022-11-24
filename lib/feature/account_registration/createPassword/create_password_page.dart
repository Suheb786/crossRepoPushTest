import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/createPassword/create_password_model.dart';
import 'package:neo_bank/feature/account_registration/createPassword/create_password_view.dart';

class CreatePasswordPage extends BasePage<CreatePasswordViewModel> {
  @override
  CreatePasswordPageState createState() => CreatePasswordPageState();
}

class CreatePasswordPageState extends BaseStatefulPage<CreatePasswordViewModel, CreatePasswordPage>
    with AutomaticKeepAliveClientMixin {
  CreatePasswordPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return createPasswordViewModelProvider;
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
  Widget buildView(BuildContext context, CreatePasswordViewModel model) {
    return CreatePasswordView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
