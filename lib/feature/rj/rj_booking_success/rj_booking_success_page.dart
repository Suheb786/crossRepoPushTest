// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/src/widgets/framework.dart';
import 'package:riverpod/src/framework.dart';

import 'package:neo_bank/feature/rj/rj_booking_success/rj_booking_success_page_view.dart';
import 'package:neo_bank/feature/rj/rj_booking_success/rj_booking_success_page_view_model.dart';

import '../../../base/base_page.dart';
import '../../../di/rj/rj_modules.dart';

class RJBookingSuccessPage extends BasePage<RJBookingSuccessPageViewModel> {
  final RJBookingSuccessPageArguments rjBookingSuccessPageArguments;

  RJBookingSuccessPage(this.rjBookingSuccessPageArguments);
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
    return rJBookingSuccessPageViewModelProvider.call(widget.rjBookingSuccessPageArguments);
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
