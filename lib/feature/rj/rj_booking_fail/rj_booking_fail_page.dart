// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/feature/rj/rj_booking_fail/rj_booking_fail_page_view.dart';
import 'package:neo_bank/feature/rj/rj_booking_fail/rj_booking_fail_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

import '../../../base/base_page.dart';
import '../../../di/rj/rj_modules.dart';

class RJBookingFailurePage extends BasePage<RJBookingFailurePageViewModel> {
  // final RJBookingFailurePageArguments _rjBookingFailurePageArguments;

  // RJBookingFailurePage(this._rjBookingFailurePageArguments);
  @override
  State<StatefulWidget> createState() => RJBookingFailurePageState();
}

class RJBookingFailurePageState
    extends BaseStatefulPage<RJBookingFailurePageViewModel, RJBookingFailurePage> {
  @override
  Widget buildView(BuildContext context, RJBookingFailurePageViewModel model) {
    return RJBookingFailurePageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return rJBookingFailurePageViewModelProvider;
  }
}

enum RJBookingFailureState {
  BOOKING_SUCCESS,
  Payment_made,
}

class RJBookingFailurePageArguments {
  final String rjBookingFailureState;
  RJBookingFailurePageArguments({
    required this.rjBookingFailureState,
  });
}
