import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/forgot_password/forgot_password_modules.dart';
import 'package:neo_bank/feature/forgot_password/reset_password_success/reset_password_success_page_view.dart';
import 'package:neo_bank/feature/forgot_password/reset_password_success/reset_password_success_view_model.dart';

import '../../../main/navigation/route_paths.dart';

class ResetPasswordSuccessPage extends BasePage<ResetPasswordSuccessViewModel> {
  @override
  ResetPasswordSuccessPageState createState() => ResetPasswordSuccessPageState();
}

class ResetPasswordSuccessPageState
    extends BaseStatefulPage<ResetPasswordSuccessViewModel, ResetPasswordSuccessPage> {
  @override
  ProviderBase provideBase() {
    return resetPasswordSuccessViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, ResetPasswordSuccessViewModel model) {
    return ResetPasswordSuccessPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(ResetPasswordSuccessViewModel model, {param}) {
    Navigator.popUntil(context, ModalRoute.withName(RoutePaths.Login));
    return super.onBackPressed(model);
  }
}
