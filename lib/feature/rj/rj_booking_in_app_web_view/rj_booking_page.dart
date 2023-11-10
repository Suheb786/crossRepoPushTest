import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/di/rj/rj_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../main/navigation/route_paths.dart';
import '../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../utils/color_utils.dart';
import '../rj_booking_success/rj_booking_success_page.dart';
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
    return rjBookingPageViewModelProvider;
  }

  @override
  void onModelReady(RjBookingPageViewModel model) {
    if (model.rjBookingPageArguments == null) {
      model.rjBookingPageArguments = widget.rjBookingPageArguments;
    }
    super.onModelReady(model);
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    RjBookingPageViewModel model = ProviderScope.containerOf(context).read(rjBookingPageViewModelProvider);
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85.h),
      child: Container(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        child: Padding(
          padding: EdgeInsetsDirectional.only(top: 52.0.h, bottom: 20.0.h),
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Align(
                alignment: AlignmentDirectional.center,
                child: AppStreamBuilder<bool>(
                    stream: model.navigationToFlightBookingDetailStream,
                    initialData: false,
                    dataBuilder: (context, data) {
                      return Text(
                        model.isNavigationOnConfirmationView()
                            ? S.current.bookingConfirmation
                            : S.current.bookYourFlight,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontFamily: StringUtils.appFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.t),
                      );
                    }),
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
                      child: AppStreamBuilder<bool>(
                          stream: model.navigationToFlightBookingDetailStream,
                          initialData: false,
                          dataBuilder: (context, data) {
                            return Center(
                              child: Icon(
                                model.isNavigationOnConfirmationView() ? Icons.check : Icons.clear,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 16,
                                weight: 1.5,
                              ),
                            );
                          }),
                    ),
                    onTap: () {
                      if (model.isNavigationOnConfirmationView()) {
                        Navigator.pushReplacementNamed(context, RoutePaths.RJBookingSuccessPage,
                            arguments: RJBookingSuccessPageArguments(
                                rjBookingSuccessState: RJBookingSuccessState.BOOKING_SUCCESS));
                      } else {
                        ProviderScope.containerOf(context).read(appViewModel).stopRefreshToken();
                        Navigator.pop(context);
                      }
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

  @override
  Future<bool> onBackPressed(RjBookingPageViewModel model, {param}) async {
    return false;
  }
}

class RjBookingPageArguments {
  final String? url;

  RjBookingPageArguments({
    this.url,
  });
}
