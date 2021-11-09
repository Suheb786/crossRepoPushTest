import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_two/job_and_income/job_and_income_page_view.dart';
import 'package:neo_bank/feature/register/step_two/job_and_income/job_and_income_page_view_model.dart';

class JobAndIncomePage extends BasePage<JobAndIncomePageViewModel> {
  @override
  JobAndIncomePageState createState() => JobAndIncomePageState();
}

class JobAndIncomePageState
    extends BaseStatefulPage<JobAndIncomePageViewModel, JobAndIncomePage> {
  @override
  ProviderBase provideBase() {
    return jobAndIncomePageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, JobAndIncomePageViewModel model) {
    return JobAndIncomePageView(provideBase());
  }
}
