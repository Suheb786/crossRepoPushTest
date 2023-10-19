import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/purpose_of_account_opening/purpose_of_account_opening_page_view.dart';
import 'package:neo_bank/feature/register/step_three/purpose_of_account_opening/purpose_of_account_opening_page_view_model.dart';

class PurposeOfAccountOpeningPage extends BasePage<PurposeOfAccountOpeningPageViewModel> {
  @override
  PurposeOfAccountOpeningPageState createState() => PurposeOfAccountOpeningPageState();
}

class PurposeOfAccountOpeningPageState
    extends BaseStatefulPage<PurposeOfAccountOpeningPageViewModel, PurposeOfAccountOpeningPage> {
  @override
  ProviderBase provideBase() {
    return purposeOfAccountOpeningViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, PurposeOfAccountOpeningPageViewModel model) {
    return PurposeOfAccountOpeningPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(PurposeOfAccountOpeningPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(registerStepThreeViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
