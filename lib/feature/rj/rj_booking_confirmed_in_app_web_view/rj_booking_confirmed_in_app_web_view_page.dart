import 'package:flutter/material.dart';
import 'package:neo_bank/feature/rj/rj_booking_confirmed_in_app_web_view/rj_booking_confirmed_in_app_web_view_page_view.dart';
import 'package:neo_bank/feature/rj/rj_booking_confirmed_in_app_web_view/rj_booking_confirmed_in_app_web_view_page_view_model.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:riverpod/src/framework.dart';

import '../../../base/base_page.dart';
import '../../../di/rj/rj_modules.dart';
import '../../../generated/l10n.dart';
import '../../../main/navigation/route_paths.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/string_utils.dart';
import '../rj_booking_success/rj_booking_success_page.dart';

class RJBookingConfirmedInAppWebViewPage extends BasePage<RJBookingConfirmedInAppWebViewPageViewModel> {
  final RJBookingConfirmedInAppWebViewPageArguments arguments;

  RJBookingConfirmedInAppWebViewPage(this.arguments);

  @override
  State<StatefulWidget> createState() => RJBookingConfirmedInAppWebViewPageState();
}

class RJBookingConfirmedInAppWebViewPageState extends BaseStatefulPage<
    RJBookingConfirmedInAppWebViewPageViewModel, RJBookingConfirmedInAppWebViewPage> {
  @override
  Widget buildView(BuildContext context, RJBookingConfirmedInAppWebViewPageViewModel model) =>
      RJBookingConfirmedInAppWebViewPageView(provideBase());

  @override
  ProviderBase provideBase() => rjBookingConfirmedInAppWebViewPageViewModel.call(widget.arguments);

  @override
  void onModelReady(RJBookingConfirmedInAppWebViewPageViewModel model) {}

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
          padding: EdgeInsetsDirectional.only(top: 52.0.h, bottom: 30.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 50.w,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  S.current.bookingConfirmation,
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
                                offset: Offset(0, 1.28))
                          ]),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 16,
                          weight: 1.5,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, RoutePaths.RJBookingSuccessPage,
                          arguments: RJBookingSuccessPageArguments(
                              rjBookingSuccessState: RJBookingSuccessState.BOOKING_SUCCESS));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.onPrimaryContainer;
  }
}

class RJBookingConfirmedInAppWebViewPageArguments {
  final String url;

  RJBookingConfirmedInAppWebViewPageArguments({required this.url});
}
