import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_two/student_job_income/student_job_income_page_view.dart';
import 'package:neo_bank/feature/register/step_two/student_job_income/student_job_income_page_view_model.dart';

class StudentJobIncomePage extends BasePage<StudentJobIncomePageViewModel> {
  @override
  StudentJobIncomePageState createState() => StudentJobIncomePageState();
}

class StudentJobIncomePageState
    extends BaseStatefulPage<StudentJobIncomePageViewModel, StudentJobIncomePage> {
  @override
  ProviderBase provideBase() {
    return studentIncomePageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, StudentJobIncomePageViewModel model) {
    return StudentJobIncomePageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(StudentJobIncomePageViewModel model, {param}) async {
    return false;
  }
}
