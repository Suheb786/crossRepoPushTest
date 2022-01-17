import 'package:domain/model/kyc/check_kyc_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/register_page_model.dart';
import 'package:neo_bank/feature/register/register_page_view.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';

class RegisterPage extends BasePage<RegisterViewModel> {
  final RegisterPageParams arguments;

  RegisterPage(this.arguments);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState
    extends BaseStatefulPage<RegisterViewModel, RegisterPage> {
  @override
  ProviderBase provideBase() {
    return registerViewModelProvider;
  }

  @override
  void onModelReady(RegisterViewModel model) {
    super.onModelReady(model);
    switch (widget.arguments.kycData?.type ?? "") {
      case "IDCardC":
      case "SelfiCheck":
        model.navigateToPage(0);
        break;
      case "CountryResidence":
        model.navigateToPage(0);
        Future.delayed(Duration(milliseconds: 500), () {
          ProviderScope.containerOf(context)
              .read(registerStepOneViewModelProvider)
              .pageController
              .move(2, animation: false);
        });
        break;
      case "ProfileStatus":
      case "JobDetails":
        model.navigateToPage(0);
        Future.delayed(Duration(milliseconds: 500), () {
          ProviderScope.containerOf(context)
              .read(registerStepOneViewModelProvider)
              .pageController
              .move(3, animation: false);
        });
        break;
      case "AccountOpeningPurpose":
        model.navigateToPage(2);
        break;
      case "FatcaCrs":
        model.navigateToPage(3);
        break;
      case "AccountInfo":
        model.navigateToPage(4);
        break;

      default:
        Navigator.pushReplacementNamed(context, RoutePaths.AppHome);
        break;
    }
  }

  @override
  Widget buildView(BuildContext context, RegisterViewModel model) {
    return RegisterPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}

class RegisterPageParams {
  final CheckKYCData? kycData;

  RegisterPageParams({this.kycData});
}
