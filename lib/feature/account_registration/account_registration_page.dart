import 'package:domain/model/kyc/check_kyc_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';

class AccountRegistrationPage
    extends BasePage<AccountRegistrationPageViewModel> {
  final AccountRegistrationParams _arguments;

  AccountRegistrationPage(this._arguments);

  @override
  AccountRegistrationPageState createState() => AccountRegistrationPageState();
}

class AccountRegistrationPageState extends BaseStatefulPage<
    AccountRegistrationPageViewModel, AccountRegistrationPage> {
  @override
  ProviderBase provideBase() {
    return accountRegistrationViewModelProvider;
  }

  @override
  void onModelReady(AccountRegistrationPageViewModel model) {
    super.onModelReady(model);
    if (widget._arguments.kycData != null) {
      switch (widget._arguments.kycData?.type ?? "") {
        case "MobileOTP":
          ProviderScope.containerOf(context)
              .read(accountRegistrationViewModelProvider)
              .updateMobileNumber(MobileNumberParams(
                  mobileCode: widget._arguments.mobileCode,
                  mobileNumber: widget._arguments.mobileNumber));
          ProviderScope.containerOf(context)
              .read(addNumberViewModelProvider)
              .getAllowedCountryCode();
          // ProviderScope.containerOf(context)
          //     .read(validateOtpViewModelProvider)
          //     .initiateSmsListener();
          Future.delayed(Duration(microseconds: 500), () {
            model.moveToPage(2);
          });
          break;

        default:
          Future.delayed(Duration(microseconds: 100), () {
            model.navigateToPage(0);
            ProviderScope.containerOf(context)
                .read(addNumberViewModelProvider)
                .getAllowedCountryCode();
          });

          break;
      }
    } else {
      Future.delayed(Duration(microseconds: 100), () {
        model.navigateToPage(0);
        ProviderScope.containerOf(context)
            .read(addNumberViewModelProvider)
            .getAllowedCountryCode();
      });
    }
  }

  @override
  Widget buildView(
      BuildContext context, AccountRegistrationPageViewModel model) {
    return AccountRegistrationPageView(provideBase());
  }
}

class AccountRegistrationParams {
  final CheckKYCData? kycData;
  final String mobileNumber;
  final String mobileCode;

  AccountRegistrationParams(
      {this.kycData, this.mobileCode: "", this.mobileNumber: ""});
}
