import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';

import 'rj_booking_page_view.dart';
import 'rj_booking_page_view_model.dart';

class RjBookingPage extends BasePage<RjBookingPageViewModel> {
  final RjBookingPageArguments rjBookingPageArguments;

  RjBookingPage(this.rjBookingPageArguments);

  @override
  RjBookingPageState createState() => RjBookingPageState();
}

class RjBookingPageState extends BaseStatefulPage<RjBookingPageViewModel, RjBookingPage> {
  @override
  ProviderBase provideBase() {
    return rjBookingPageViewModelProvider.call(widget.rjBookingPageArguments);
  }

  @override
  void onModelReady(RjBookingPageViewModel model) {}

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  Widget buildView(BuildContext context, RjBookingPageViewModel model) {
    return RjBookingPageView(provideBase());
  }
}

class RjBookingPageArguments {
  final String? url;

  RjBookingPageArguments(
    this.url,
  );
}
