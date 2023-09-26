import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/rj/rj_usecase_modules.dart';
import 'package:neo_bank/feature/rj/rj_book_flight/passenger/passenger_view_%20model.dart';
import 'package:neo_bank/feature/rj/rj_booking_in_app_web_view/rj_booking_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_booking_purchase/rj_booking_purchase_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_confirm_flight_detail/rj_confirm_fight_detail_view_model.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_flight_booking_detail_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_make_payment/rj_make_payment_view_model.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_otp_validate/rj_otp_validate_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_to_dialog/to_dialog_view_model.dart';

import '../../feature/rj/rj_book_flight/rj_book_flight_page_view_model.dart';
import '../../feature/rj/rj_booking_confirmed_in_app_web_view/rj_booking_confirmed_in_app_web_view_page_view_model.dart';
import '../../feature/rj/rj_booking_fail/rj_booking_fail_page_view_model.dart';
import '../../feature/rj/rj_booking_in_app_web_view/rj_booking_page.dart';
import '../../feature/rj/rj_booking_success/rj_booking_success_page_view_model.dart';
import '../../ui/molecules/dialog/rj/rj_flight_booking_dialog/rj_flight_booking_dialog_view_model.dart';

///RJ Flight Booking Dialog
final rjFlightBookingDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<RjFlightBookingDialogViewModel>((ref) =>
        RjFlightBookingDialogViewModel(ref.read(getDestinationUseCaseProvider),
            ref.read(getOneWayTripLinkUseCaseProvider), ref.read(getTwoWayTripLinkUseCaseProvider)));

final rjFlightBookingPageViewModelProvider = ChangeNotifierProvider.autoDispose<RjFlightBookingViewModel>(
    (ref) => RjFlightBookingViewModel(ref.read(getDestinationUseCaseProvider),
        ref.read(getOneWayTripLinkUseCaseProvider), ref.read(getTwoWayTripLinkUseCaseProvider)));

class PassengerViewModelProvider {
  provide() {
    final passengerViewModelProvider = ChangeNotifierProvider.autoDispose<PassengerViewModel>(
      (ref) => PassengerViewModel(),
    );
    return passengerViewModelProvider;
  }
}

final toDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<ToDialogViewModel>((ref) => ToDialogViewModel());

final rjBookingPageViewModelProvider =
    ChangeNotifierProvider.autoDispose.family<RjBookingPageViewModel, RjBookingPageArguments>(
  (ref, args) => RjBookingPageViewModel(args),
);

final rjBookingPurchasePageViewModelProvider =
    ChangeNotifierProvider.autoDispose<RjBookingPurchasePageViewModel >(
  (ref, ) => RjBookingPurchasePageViewModel(),
);

final rjFlightBookingDetailViewModelProvider =
    ChangeNotifierProvider.autoDispose<RjFlightBookingDetailPageViewModel>(
  (ref) => RjFlightBookingDetailPageViewModel(),
);

final rjConfirmFlightBookingViewModelProvider =
    ChangeNotifierProvider.autoDispose<RjConfirmFlightDetailViewModel>(
  (ref) => RjConfirmFlightDetailViewModel(ref.read(getFlightDetailUseCaseProvider)),
);

final rjMakePaymentViewModelProvider = ChangeNotifierProvider.autoDispose<RjMakePaymentViewModel>(
  (ref) => RjMakePaymentViewModel(ref.read(rjOtpValidateUseCaseProvider)),
);

///[rjSuccessViewModelProvider]
final rJBookingSuccessPageViewModelProvider =
    ChangeNotifierProvider.autoDispose<RJBookingSuccessPageViewModel>((
  ref,
) =>
        RJBookingSuccessPageViewModel());

///[rjFailureViewModelProvider]
final rJBookingFailurePageViewModelProvider =
    ChangeNotifierProvider.autoDispose<RJBookingFailurePageViewModel>(
        (ref) => RJBookingFailurePageViewModel());

///[RjOtpValidateViewModel] provider
final rjOtpValidateViewModelProvider = ChangeNotifierProvider.autoDispose<RjOtpValidateViewModel>(
  (ref) => RjOtpValidateViewModel(
      ref.read(makeTicketPaymentUseCaseProvider), ref.read(rjOtpValidateUseCaseProvider)),
);

///[rjBookingConfirmedInAppWebViewPageViewModel] provider
final rjBookingConfirmedInAppWebViewPageViewModel =
    ChangeNotifierProvider.autoDispose<RJBookingConfirmedInAppWebViewPageViewModel>(
  (ref) => RJBookingConfirmedInAppWebViewPageViewModel(),
);
