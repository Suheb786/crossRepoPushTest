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
    if (widget.arguments.kycData != null) {
      switch (widget.arguments.kycData?.type ?? "") {
        case "IDCardC":
        case "SelfiCheck":
          Future.delayed(Duration(microseconds: 100), () {
            model.navigateToPage(0);
          });

          break;
        case "CountryResidence":
          Future.delayed(Duration(microseconds: 100), () {
            model.navigateToPage(0);
          });
          Future.delayed(Duration(microseconds: 100), () {
            ProviderScope.containerOf(context)
                .read(registerStepOneViewModelProvider)
                .pageController
                .move(2, animation: false);
          });
          break;
        case "ProfileStatus":
        case "JobDetails":
          Future.delayed(Duration(microseconds: 100), () {
            model.navigateToPage(0);
          });
          Future.delayed(Duration(microseconds: 100), () {
            ProviderScope.containerOf(context)
                .read(registerStepOneViewModelProvider)
                .pageController
                .move(3, animation: false);
          });
          break;
        case "AccountOpeningPurpose":
          Future.delayed(Duration(microseconds: 100), () {
            model.navigateToPage(2);
          });

          break;
        case "FatcaCrs":
          Future.delayed(Duration(microseconds: 100), () {
            model.navigateToPage(3);
          });

          break;
        case "AccountInfo":
          Future.delayed(Duration(microseconds: 100), () {
            model.navigateToPage(4);
          });

          break;

        default:
          Navigator.pushReplacementNamed(context, RoutePaths.AppHome);
          break;
      }
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
