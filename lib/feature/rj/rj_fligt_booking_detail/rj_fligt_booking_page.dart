import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_flight_booking_detail_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_flight_detail_page_view.dart';

class RjFlightBookingDetailPage extends BasePage<RjFlightBookingDetailPageViewModel> {

final RJFlightDetailsPageArguments arguments;

  RjFlightBookingDetailPage(this.arguments);


  @override
  RjFlightBookingDetailPageState createState() => RjFlightBookingDetailPageState();
}

class RjFlightBookingDetailPageState
    extends BaseStatefulPage<RjFlightBookingDetailPageViewModel, RjFlightBookingDetailPage> {
  @override
  ProviderBase provideBase() {
    return rjFlightBookingDetailViewModelProvider;
  }

  @override
  void onModelReady(RjFlightBookingDetailPageViewModel model) {
    model.arguments = widget.arguments;
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, RjFlightBookingDetailPageViewModel model) {
    return RjFlightBookingDetailPageView(provideBase());
  }
}

class RJFlightDetailsPageArguments {
  final String referenceNumber;

  RJFlightDetailsPageArguments({required this.referenceNumber});
}
