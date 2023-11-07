import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../utils/color_utils.dart';
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
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 90),
      child: Container(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        child: Padding(
          padding: EdgeInsetsDirectional.only(top: 57.0.h, bottom: 30.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50.w,
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
              Padding(
                padding: EdgeInsetsDirectional.only(end: 12.w),
                child: InkWell(
                    child: Container(
                      height: 25.w,
                      width: 25.w,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.black_15,
                                spreadRadius: 1.28,
                                blurRadius: 2.56,
                                offset: Offset(0, 1.30))
                          ]),
                      child: Center(
                        child: Icon(
                          Icons.clear,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 16,
                          weight: 1.5,
                        ),
                      ),
                    ),
                    onTap: () {
                      ProviderScope.containerOf(context).read(appViewModel).stopRefreshToken();
                      Navigator.pop(context);
                    }),
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
