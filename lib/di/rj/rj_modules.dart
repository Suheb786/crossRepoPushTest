import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/rj/rj_booking_in_app_web_view/rj_booking_page.dart';
import 'package:neo_bank/feature/rj/rj_booking_in_app_web_view/rj_booking_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_booking_purchase/rj_booking_purchase_page.dart';
import 'package:neo_bank/feature/rj/rj_booking_purchase/rj_booking_purchase_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_dialog/passenger_view_%20model.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_dialog/rj_flight_booking_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_to_dialog/to_dialog_view_model.dart';

///RJ Flight Booking Dialog
final rjFlightBookingDialogViewModelProvider =
    ChangeNotifierProvider.autoDispose<RjFlightBookingDialogViewModel>(
        (ref) => RjFlightBookingDialogViewModel());

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