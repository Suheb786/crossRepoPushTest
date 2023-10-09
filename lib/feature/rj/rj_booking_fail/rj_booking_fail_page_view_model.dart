import 'package:flutter/material.dart';
import 'package:neo_bank/feature/rj/rj_booking_fail/rj_booking_fail_page.dart';

import '../../../base/base_page_view_model.dart';
import '../../../generated/l10n.dart';

class RJBookingFailurePageViewModel extends BasePageViewModel {
  // final RJBookingFailurePageArguments rjBookingFailurePageArguments;

  // RJBookingFailurePageViewModel(this.rjBookingFailurePageArguments);

  /// get String Title according to Enum
  String getTitle(BuildContext context, RJBookingFailureState rjBookingFailureState) {
    switch (rjBookingFailureState) {
      case RJBookingFailureState.BOOKING_SUCCESS:
        return S.current.AccountIsLinkedToTheAlias;

      default:
        return "";
    }
  }

  /// get String Description according to Enum
  String getDescription(BuildContext context, RJBookingFailureState rjBookingFailureState) {
    switch (rjBookingFailureState) {
      case RJBookingFailureState.BOOKING_SUCCESS:
        return "";

      default:
        return "";
    }
  }
}
