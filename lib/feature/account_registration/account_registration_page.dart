import 'package:domain/model/kyc/check_kyc_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';

class AccountRegistrationPage extends BasePage<AccountRegistrationPageViewModel> {
  final AccountRegistrationParams _arguments;

  AccountRegistrationPage(this._arguments);

  @override
  AccountRegistrationPageState createState() => AccountRegistrationPageState();
}

class AccountRegistrationPageState
    extends BaseStatefulPage<AccountRegistrationPageViewModel, AccountRegistrationPage> {
  @override
  ProviderBase provideBase() {
    return accountRegistrationViewModelProvider;
  }

  @override
  void onModelReady(AccountRegistrationPageViewModel model) {
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, AccountRegistrationPageViewModel model) {
    return AccountRegistrationPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(AccountRegistrationPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(accountRegistrationViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      if (parentModel.appSwiperController.page! > 1) {
        return false;
      } else {
        parentModel.previousPage();
        return false;
      }
    } else {
      return super.onBackPressed(model);
    }
  }
}

class AccountRegistrationParams {
  final CheckKYCData? kycData;
  final String mobileNumber;
  final String mobileCode;

  AccountRegistrationParams({this.kycData, this.mobileCode = "", this.mobileNumber = ""});
}
