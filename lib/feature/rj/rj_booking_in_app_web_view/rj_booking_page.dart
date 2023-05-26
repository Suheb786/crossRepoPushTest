import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

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
      child: Container(
        color: Theme.of(context).colorScheme.onSurface,
        child: Padding(
          padding: const EdgeInsets.only(top: 56.0, bottom: 35),
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        padding: EdgeInsetsDirectional.only(start: 20.w),
                        icon: Icon(
                          Icons.clear,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          // Navigator.pushNamed(context, RoutePaths.RjFlightBookingPage);
                        }),
                    Spacer(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  S.current.bookYourFlight,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.t),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildView(BuildContext context, RjBookingPageViewModel model) {
    return RjBookingPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.onSurface;
  }
}

class RjBookingPageArguments {
  final String? url;

  RjBookingPageArguments({
    this.url,
  });
}
