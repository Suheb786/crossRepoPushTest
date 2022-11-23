import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/placeholder/placeholder_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/placeholder/placeholder_view_model.dart';

class PlaceholderPage extends BasePage<PlaceholderViewModel> {
  @override
  PlaceholderPageState createState() => PlaceholderPageState();
}

class PlaceholderPageState extends BaseStatefulPage<PlaceholderViewModel, PlaceholderPage> {
  @override
  ProviderBase provideBase() {
    return placeholderViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, PlaceholderViewModel model) {
    return PlaceholderPageView(provideBase());
  }
}
