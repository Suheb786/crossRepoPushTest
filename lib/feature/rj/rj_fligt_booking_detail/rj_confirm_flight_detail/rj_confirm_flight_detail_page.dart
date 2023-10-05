import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_confirm_flight_detail/rj_confirm_fight_detail_view_model.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_confirm_flight_detail/rj_confirm_flight_detail_view.dart';

class RjConfirmFlightDetailPage extends BasePage<RjConfirmFlightDetailViewModel> {
  @override
  RjConfirmFlightDetailPageState createState() => RjConfirmFlightDetailPageState();
}

class RjConfirmFlightDetailPageState
    extends BaseStatefulPage<RjConfirmFlightDetailViewModel, RjConfirmFlightDetailPage>
    with AutomaticKeepAliveClientMixin {
  RjConfirmFlightDetailPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return rjConfirmFlightBookingViewModelProvider;
  }

  @override
  void onModelReady(RjConfirmFlightDetailViewModel model) {
    super.onModelReady(model);
    model.getFlightDetails(
        referenceNumber: ProviderScope.containerOf(context)
                .read(rjFlightBookingDetailViewModelProvider)
                .arguments
                ?.referenceNumber ??
            '');
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Widget buildView(BuildContext context, RjConfirmFlightDetailViewModel model) {
    return RjConfirmFlightDetailView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
