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
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
        preferredSize: Size(double.maxFinite, 85),
        child: Padding(
          padding: const EdgeInsets.only(top: 56.0, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(
                      context,
                      getViewModel().rjBookingPageArguments.webViewRoute == WebViewRoute.confirmationScreen
                          ? true
                          : null);
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 24.0),
                  child: Icon(Icons.clear, color: Theme.of(context).primaryColorDark),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget buildView(BuildContext context, RjBookingPageViewModel model) {
    return RjBookingPageView(provideBase());
  }
}

class RjBookingPageArguments {
  final String url;
  final WebViewRoute webViewRoute;

  RjBookingPageArguments({required this.url, required this.webViewRoute});
}

enum WebViewRoute { confirmationScreen, bookingDialog }
