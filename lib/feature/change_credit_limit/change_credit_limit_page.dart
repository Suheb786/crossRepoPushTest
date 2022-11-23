import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/change_credit_limit/change_credit_limit_page_view.dart';
import 'package:neo_bank/feature/change_credit_limit/change_credit_limit_page_view_model.dart';

class ChangeCreditLimitPage extends BasePage<ChangeCreditLimitPageViewModel> {
  @override
  ChangeCreditLimitPageState createState() => ChangeCreditLimitPageState();
}

class ChangeCreditLimitPageState
    extends BaseStatefulPage<ChangeCreditLimitPageViewModel, ChangeCreditLimitPage> {
  @override
  ProviderBase provideBase() {
    return changeCreditLimitPageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ChangeCreditLimitPageViewModel model) {
    return ChangeCreditLimitPageView(provideBase());
  }

  @override
  void onModelReady(ChangeCreditLimitPageViewModel model) {
    model.updateSliderValue(SliderLimitValues(divisions: 100, minValue: 200.0, maxValue: 1200.0));
    model.updateValue(1200);
    super.onModelReady(model);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}
