import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/change_country_restriction/change_country_restriction_page_view.dart';
import 'package:neo_bank/feature/change_country_restriction/change_country_restriction_page_view_model.dart';

class ChangeCountryRestrictionPage extends BasePage<ChangeCountryRestrictionPageViewModel> {
  @override
  ChangeCountryRestrictionPageState createState() => ChangeCountryRestrictionPageState();
}

class ChangeCountryRestrictionPageState
    extends BaseStatefulPage<ChangeCountryRestrictionPageViewModel, ChangeCountryRestrictionPage> {
  @override
  ProviderBase provideBase() {
    return changeCountryRestrictionPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, ChangeCountryRestrictionPageViewModel model) {
    return ChangeCountryRestrictionPageView(provideBase());
  }
}
