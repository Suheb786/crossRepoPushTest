import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/usecase/rj/rj_usecase_modules.dart';
import 'package:neo_bank/feature/rj/rj_booking_in_app_web_view/rj_booking_page.dart';
import 'package:neo_bank/feature/rj/rj_booking_in_app_web_view/rj_booking_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_booking_purchase/rj_booking_purchase_page.dart';
import 'package:neo_bank/feature/rj/rj_booking_purchase/rj_booking_purchase_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_confirm_flight_detail/rj_confirm_fight_detail_view_model.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_flight_booking_detail_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_make_payment/rj_make_payment_view_model.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_otp_validate/rj_otp_validate_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_dialog/passenger_view_%20model.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_dialog/rj_flight_booking_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_to_dialog/to_dialog_view_model.dart';

///RJ Flight Booking Dialog
final rjFlightBookingDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<RjFlightBookingDialogViewModel>((ref) =>
        RjFlightBookingDialogViewModel(ref.read(getDestinationUseCaseProvider),
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
    ChangeNotifierProvider.autoDispose.family<RjBookingPurchasePageViewModel, RjBookingPurchasePageArgument>(
  (ref, args) => RjBookingPurchasePageViewModel(args),
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
  (ref) => RjMakePaymentViewModel(),
);

///[RjOtpValidateViewModel] provider
final rjOtpValidateViewModelProvider = ChangeNotifierProvider.autoDispose<RjOtpValidateViewModel>(
  (ref) => RjOtpValidateViewModel(ref.read(makeTicketPaymentUseCaseProvider)),
);
