import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_verification_success/debit_card_verification_success_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_verification_success/debit_card_verification_success_view_model.dart';

import '../../../main/navigation/route_paths.dart';

class DebitCardVerificationSuccessPage extends BasePage<DebitCardVerificationSuccessViewModel> {
  @override
  DebitCardVerificationSuccessPageState createState() => DebitCardVerificationSuccessPageState();
}

class DebitCardVerificationSuccessPageState
    extends BaseStatefulPage<DebitCardVerificationSuccessViewModel, DebitCardVerificationSuccessPage> {
  @override
  ProviderBase provideBase() {
    return debitCardVerificationSuccessViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(BuildContext context, DebitCardVerificationSuccessViewModel model) {
    return DebitCardVerificationSuccessPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(DebitCardVerificationSuccessViewModel model, {param}) {
    ProviderScope.containerOf(context)
        .read(appHomeViewModelProvider)
        .showSettingPage(false);
    Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
    ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
    return super.onBackPressed(model);
  }
}
