import 'package:domain/model/kyc/check_kyc_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/register_page_model.dart';
import 'package:neo_bank/feature/register/register_page_view.dart';

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

  // @override
  // void onModelReady(RegisterViewModel model) {
  //   super.onModelReady(model);
  //   if (widget.arguments.kycData != null) {
  //     switch (widget.arguments?.kycData?.type ?? "") {
  //       case "IDCardC":
  //       case "SelfiCheck":
  //         Future.delayed(Duration(microseconds: 100), () {
  //           model.navigateToPage(0);
  //         });
  //
  //         break;
  //       case "CountryResidence":
  //         Future.delayed(Duration(microseconds: 100), () {
  //           model.navigateToPage(0);
  //         });
  //         Future.delayed(Duration(microseconds: 100), () {
  //           ProviderScope.containerOf(context)
  //               .read(registerStepOneViewModelProvider)
  //               .pageController
  //               .move(2, animation: false);
  //         });
  //         break;
  //       case "ProfileStatus":
  //       case "JobDetails":
  //         Future.delayed(Duration(microseconds: 100), () {
  //           model.navigateToPage(0);
  //         });
  //         Future.delayed(Duration(microseconds: 100), () {
  //           ProviderScope.containerOf(context)
  //               .read(registerStepOneViewModelProvider)
  //               .pageController
  //               .move(3, animation: false);
  //         });
  //         break;
  //       case "AccountOpeningPurpose":
  //         Future.delayed(Duration(microseconds: 100), () {
  //           model.navigateToPage(2);
  //         });
  //
  //         break;
  //       case "FatcaCrs":
  //         Future.delayed(Duration(microseconds: 100), () {
  //           model.navigateToPage(3);
  //         });
  //
  //         break;
  //
  //       case "W8":
  //         Future.delayed(Duration(microseconds: 100), () {
  //           model.navigateToPage(3);
  //         });
  //         Future.delayed(Duration(microseconds: 100), () {
  //           ProviderScope.containerOf(context)
  //               .read(registerStepFourViewModelProvider)
  //               .registrationStepFourPageController
  //               .move(1, animation: false);
  //         });
  //
  //         break;
  //
  //       case "W9":
  //         Future.delayed(Duration(microseconds: 100), () {
  //           model.navigateToPage(3);
  //         });
  //         Future.delayed(Duration(microseconds: 100), () {
  //           ProviderScope.containerOf(context)
  //               .read(registerStepFourViewModelProvider)
  //               .registrationStepFourPageController
  //               .move(4, animation: false);
  //         });
  //
  //         break;
  //
  //       case "UploadDocument":
  //         // print('iamhere');
  //         // Future.delayed(Duration(microseconds: 100), () {
  //         //   model.navigateToPage(4);
  //         // });
  //         // print('i am here 1');
  //         // Future.delayed(Duration(microseconds: 100), () {
  //         //   print('i am here 2');
  //         //   ProviderScope.containerOf(context)
  //         //       .read(registerStepFiveViewModelProvider)
  //         //       .registrationStepFivePageController
  //         //       .move(4, animation: false);
  //         // });
  //         // Navigator.pushReplacementNamed(
  //         //     context, RoutePaths.UploadDocumentLater);
  //         Future.delayed(Duration(microseconds: 100), () {
  //           Navigator.pushReplacementNamed(
  //               context, RoutePaths.UploadDocumentLater);
  //         });
  //
  //         break;
  //
  //       case "AccountInfo":
  //         Future.delayed(Duration(microseconds: 100), () {
  //           model.navigateToPage(4);
  //         });
  //
  //         break;
  //
  //       case "debitCardIssuance":
  //       case "SetPINdebitCard":
  //         Future.delayed(Duration(microseconds: 100), () {
  //           Navigator.pushReplacementNamed(context, RoutePaths.CardDelivery);
  //         });
  //
  //         break;
  //
  //       default:
  //         Navigator.pushReplacementNamed(context, RoutePaths.AppHome);
  //         break;
  //     }
  //   }
  //   // Future.delayed(Duration(microseconds: 100), () {
  //   //   model.navigateToPage(3);
  //   // });
  // }

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
