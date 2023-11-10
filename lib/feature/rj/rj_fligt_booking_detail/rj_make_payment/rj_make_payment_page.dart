import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_make_payment/rj_make_payment_view.dart';
import 'package:neo_bank/feature/rj/rj_fligt_booking_detail/rj_make_payment/rj_make_payment_view_model.dart';

class RjMakePaymentPage extends BasePage<RjMakePaymentViewModel> {
  @override
  RjMakePaymentPageState createState() => RjMakePaymentPageState();
}

class RjMakePaymentPageState extends BaseStatefulPage<RjMakePaymentViewModel, RjMakePaymentPage>
    with AutomaticKeepAliveClientMixin {
  RjMakePaymentPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return rjMakePaymentViewModelProvider;
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
  Widget buildView(BuildContext context, RjMakePaymentViewModel model) {
    return RjMakePaymentView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Future<bool> onBackPressed(RjMakePaymentViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(rjFlightBookingDetailViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return false;
    }
  }
}
