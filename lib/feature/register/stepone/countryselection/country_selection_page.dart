import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/countryselection/country_selection_model.dart';
import 'package:neo_bank/feature/register/stepone/countryselection/country_selection_view.dart';

class CountrySelectionPage extends BasePage<CountrySelectionViewModel> {
  @override
  CountrySelectionPageState createState() => CountrySelectionPageState();
}

class CountrySelectionPageState
    extends BaseStatefulPage<CountrySelectionViewModel, CountrySelectionPage> {
  @override
  ProviderBase provideBase() {
    return countrySelectionViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, CountrySelectionViewModel model) {
    return CountrySelectionPageView(provideBase());
  }
}
