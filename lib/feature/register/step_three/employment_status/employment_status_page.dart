import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/employment_status/employment_status_page_view.dart';
import 'package:neo_bank/feature/register/step_three/employment_status/employment_status_page_view_model.dart';

class EmploymentStatusPage extends BasePage<EmploymentStatusPageViewModel> {
  @override
  EmploymentStatusPageState createState() => EmploymentStatusPageState();
}

class EmploymentStatusPageState extends BaseStatefulPage<
    EmploymentStatusPageViewModel, EmploymentStatusPage> {
  @override
  ProviderBase provideBase() {
    return employmentStatusPageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, EmploymentStatusPageViewModel model) {
    return EmploymentStatusPageView(provideBase());
  }
}
