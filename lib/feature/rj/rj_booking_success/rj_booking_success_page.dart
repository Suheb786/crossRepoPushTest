// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:neo_bank/feature/rj/rj_booking_success/rj_booking_success_page_view.dart';
import 'package:neo_bank/feature/rj/rj_booking_success/rj_booking_success_page_view_model.dart';

import '../../../base/base_page.dart';
import '../../../di/dashboard/dashboard_modules.dart';
import '../../../di/rj/rj_modules.dart';
import '../../../main/navigation/route_paths.dart';

class RJBookingSuccessPage extends BasePage<RJBookingSuccessPageViewModel> {
  // final RJBookingSuccessPageArguments rjBookingSuccessPageArguments;

  // RJBookingSuccessPage(this.rjBookingSuccessPageArguments);
  @override
  State<StatefulWidget> createState() => RJBookingSuccessPageState();
}

class RJBookingSuccessPageState
    extends BaseStatefulPage<RJBookingSuccessPageViewModel, RJBookingSuccessPage> {
  @override
  Widget buildView(BuildContext context, RJBookingSuccessPageViewModel model) {
    return RJBookingSuccessPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return rJBookingSuccessPageViewModelProvider;
  }

  @override
  Future<bool> onBackPressed(RJBookingSuccessPageViewModel model, {param}) {
    Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
    model.animateBackToDashboard(context);
    ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
    return super.onBackPressed(model);
  }
}

enum RJBookingSuccessState {
  BOOKING_SUCCESS,
  Payment_made,
}

class RJBookingSuccessPageArguments {
  final RJBookingSuccessState rjBookingSuccessState;

  RJBookingSuccessPageArguments({
    required this.rjBookingSuccessState,
  });
}
