import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';

import '../../../base/base_page_view_model.dart';

class RJBookingSuccessPageViewModel extends BasePageViewModel {
  void animateBackToDashboard(BuildContext context) {
    final dashboardProvider = ProviderScope.containerOf(context).read(
      appHomeViewModelProvider,
    );

    dashboardProvider.animateReverseTransactionPage();
  }
}
