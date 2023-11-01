import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/forgot_password/forgot_password_modules.dart';
import 'package:neo_bank/feature/forgot_password/add_id_number_for_reset_password/add_id_number_for_reset_password_page_view.dart';
import 'package:neo_bank/feature/forgot_password/add_id_number_for_reset_password/add_id_number_for_reset_password_page_view_model.dart';

class AddIDNumberForResetPasswordPage extends BasePage<AddIDNumberForResetPasswordPageViewModel> {
  @override
  AddIDNumberForResetPasswordPageState createState() => AddIDNumberForResetPasswordPageState();
}

class AddIDNumberForResetPasswordPageState
    extends BaseStatefulPage<AddIDNumberForResetPasswordPageViewModel, AddIDNumberForResetPasswordPage>
    with AutomaticKeepAliveClientMixin {
  AddIDNumberForResetPasswordPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return addIdNumberForResetPasswordViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, AddIDNumberForResetPasswordPageViewModel model) {
    return AddIDNumberForResetPasswordPageView(provideBase());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<bool> onBackPressed(AddIDNumberForResetPasswordPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(forgotPasswordViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
