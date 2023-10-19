import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/id_verification_info/id_verification_info_model.dart';
import 'package:neo_bank/feature/register/stepone/id_verification_info/id_verification_info_view.dart';

class IdVerificationInfoPage extends BasePage<IdVerificationInfoViewModel> {
  @override
  IdVerificationInfoPageState createState() => IdVerificationInfoPageState();
}

class IdVerificationInfoPageState
    extends BaseStatefulPage<IdVerificationInfoViewModel, IdVerificationInfoPage> {
  @override
  ProviderBase provideBase() {
    return idVerificationInfoViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, IdVerificationInfoViewModel model) {
    return IdVerificationInfoView(provideBase());
  }

  @override
  Future<bool> onBackPressed(IdVerificationInfoViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(registerStepOneViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
