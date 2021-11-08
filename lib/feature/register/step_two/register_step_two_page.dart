import 'package:domain/constants/enum/employment_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_two/job_and_income/job_and_income_page.dart';
import 'package:neo_bank/feature/register/step_two/register_step_two_page_view.dart';
import 'package:neo_bank/feature/register/step_two/register_step_two_page_view_model.dart';
import 'package:neo_bank/feature/register/step_two/student_job_income/student_job_income_page.dart';

class RegisterStepTwoPage extends BasePage<RegisterStepTwoViewModel> {
  @override
  RegisterStepTwoPageState createState() => RegisterStepTwoPageState();
}

class RegisterStepTwoPageState
    extends BaseStatefulPage<RegisterStepTwoViewModel, RegisterStepTwoPage> {
  @override
  ProviderBase provideBase() {
    return registerStepTwoViewModelProvider;
  }

  @override
  void onModelReady(RegisterStepTwoViewModel model) {
    switch (ProviderScope.containerOf(context)
        .read(profileDetailsPageViewModelProvider)
        .employeeStatusController
        .text
        .fromEmploymentValue()) {
      case EmploymentStatusEnum.STUDENT:
      case EmploymentStatusEnum.FREELANCE:
      case EmploymentStatusEnum.RETIRED:
      case EmploymentStatusEnum.UNEMPLOYED:
        model.pages = [StudentJobIncomePage()];
        break;
      default:
        model.pages = [JobAndIncomePage()];
    }
  }

  @override
  Widget buildView(BuildContext context, RegisterStepTwoViewModel model) {
    return RegisterStepTwoPageView(provideBase());
  }
}
