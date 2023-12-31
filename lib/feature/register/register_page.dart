import 'package:domain/constants/enum/fatca_enum.dart';
import 'package:domain/model/kyc/check_kyc_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/register_page_model.dart';
import 'package:neo_bank/feature/register/register_page_view.dart';
import 'package:neo_bank/feature/register/step_five/account_hold/account_hold_page.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';

class RegisterPage extends BasePage<RegisterViewModel> {
  final RegisterPageParams arguments;

  RegisterPage(this.arguments);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends BaseStatefulPage<RegisterViewModel, RegisterPage> {
  @override
  ProviderBase provideBase() {
    return registerViewModelProvider;
  }

  @override
  void onModelReady(RegisterViewModel model) {
    super.onModelReady(model);
    if (widget.arguments.kycData != null) {
      switch (widget.arguments.kycData?.type ?? "") {
        case "CountryResidence":
          Future.delayed(Duration(microseconds: 100), () {
            model.navigateToPage(0);
          });
          Future.delayed(Duration(microseconds: 100), () {
            ProviderScope.containerOf(context).read(registerStepOneViewModelProvider).moveToPage(0);
          });
          break;

        case "ProfileStatus":
        case "JobDetails":
          Future.delayed(Duration(microseconds: 100), () {
            model.navigateToPage(0);
          });
          Future.delayed(Duration(microseconds: 100), () {
            ProviderScope.containerOf(context).read(registerStepOneViewModelProvider).moveToPage(3);
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

        case "W8":
          model.fatcaEnum = FatcaEnum.w8;
          Future.delayed(Duration(microseconds: 100), () {
            model.navigateToPage(3);
          });
          // ProviderScope.containerOf(context)
          //     .read(registerStepFourViewModelProvider)
          //     .fatcaEnum = FatcaEnum.w8;
          // Future.delayed(Duration(microseconds: 100), () {
          //   ProviderScope.containerOf(context)
          //       .read(registerStepFourViewModelProvider)
          //       .moveToPage(1);
          // });

          break;

        case "W9":
          model.fatcaEnum = FatcaEnum.w9;
          Future.delayed(Duration(microseconds: 100), () {
            model.navigateToPage(3);
          });
          // Future.delayed(Duration(microseconds: 100), () {
          //   ProviderScope.containerOf(context)
          //       .read(registerStepFourViewModelProvider)
          //       .moveToPage(4);
          // });

          break;

        case "ConfirmApplication":
          Future.delayed(Duration(microseconds: 100), () {
            model.navigateToPage(4);
          });

          break;

        case "UploadDocument":
          Future.delayed(Duration(microseconds: 100), () {
            Navigator.pushReplacementNamed(context, RoutePaths.UploadDocumentLater);
          });

          break;

        case "KycPortal":
          Future.delayed(Duration(microseconds: 100), () {
            Navigator.pushReplacementNamed(context, RoutePaths.VideoCall);
          });

          break;

        case "AdminPortalReview":
          Future.delayed(Duration(microseconds: 100), () {
            Navigator.pushReplacementNamed(context, RoutePaths.AccountHold,
                arguments: AccountHoldArguments(applicationId: widget.arguments.applicationId));
          });
          break;

        case "AccountInfo":
          Future.delayed(Duration(microseconds: 100), () {
            model.navigateToPage(4);
          });

          break;

        case "debitCardIssuance":
        case "SetPINdebitCard":
          Future.delayed(Duration(microseconds: 100), () {
            Navigator.pushReplacementNamed(context, RoutePaths.CardDelivery);
          });

          break;

        default:
          Navigator.pushReplacementNamed(context, RoutePaths.AppHome);
          break;
      }
    }
    // Future.delayed(Duration(microseconds: 100), () {
    //   model.navigateToPage(3);
    // });
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
  final String? applicationId;

  RegisterPageParams({this.kycData, this.applicationId = ""});
}
