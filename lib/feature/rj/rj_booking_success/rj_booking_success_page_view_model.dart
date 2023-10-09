import 'package:flutter/material.dart';
import 'package:neo_bank/feature/rj/rj_booking_success/rj_booking_success_page.dart';

import '../../../base/base_page_view_model.dart';
import '../../../generated/l10n.dart';

class RJBookingSuccessPageViewModel extends BasePageViewModel {
  // final RJBookingSuccessPageArguments rjBookingSuccessPageArguments;

  // RJBookingSuccessPageViewModel(this.rjBookingSuccessPageArguments);

  /// get String Title according to Enum
  String getTitle(BuildContext context, RJBookingSuccessState rjBookingSuccessState) {
    switch (rjBookingSuccessState) {
      case RJBookingSuccessState.BOOKING_SUCCESS:
        return S.current.AccountIsLinkedToTheAlias;

      default:
        return "";
    }
  }

  /// get String Description according to Enum
  String getDescription(BuildContext context, RJBookingSuccessState rjBookingSuccessState) {
    switch (rjBookingSuccessState) {
      case RJBookingSuccessState.BOOKING_SUCCESS:
        return "";

      default:
        return "";
    }
  }
}
