import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/taxation_details/taxation_details_page_view.dart';
import 'package:neo_bank/feature/register/step_four/taxation_details/taxation_details_page_view_model.dart';

class TaxationDetailsPage extends BasePage<TaxationDetailsPageViewModel> {
  @override
  TaxationDetailsPageState createState() => TaxationDetailsPageState();
}

class TaxationDetailsPageState extends BaseStatefulPage<
    TaxationDetailsPageViewModel, TaxationDetailsPage> {
  @override
  ProviderBase provideBase() {
    return taxationDetailsPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, TaxationDetailsPageViewModel model) {
    return TaxationDetailsPageView(provideBase());
  }
}
