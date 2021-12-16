import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/locate_atm/locate_atm_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/locate_atm/locate_atm_page_view_model.dart';

class LocateATMPage extends BasePage<LocateATMPageViewModel> {
  @override
  LocateATMPageState createState() => LocateATMPageState();
}

class LocateATMPageState
    extends BaseStatefulPage<LocateATMPageViewModel, LocateATMPage> {
  @override
  ProviderBase provideBase() {
    return locatePinViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, LocateATMPageViewModel model) {
    return LocateATMPageView(provideBase());
  }
}
