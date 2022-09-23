import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/help_center/help_center_modules.dart';
import 'package:neo_bank/feature/help_center/help_center_page_view.dart';
import 'package:neo_bank/feature/help_center/help_center_page_view_model.dart';

class HelpCenterPage extends BasePage<HelpCenterPageViewModel> {
  @override
  HelpCenterPagePageState createState() => HelpCenterPagePageState();
}

class HelpCenterPagePageState extends BaseStatefulPage<HelpCenterPageViewModel, HelpCenterPage> {
  @override
  ProviderBase provideBase() {
    return helpCenterViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, HelpCenterPageViewModel model) {
    return HelpCenterPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}
