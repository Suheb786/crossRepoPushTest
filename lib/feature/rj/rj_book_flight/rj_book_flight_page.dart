import 'package:flutter/material.dart';
import 'package:neo_bank/feature/rj/rj_book_flight/rj_book_flight_page_view.dart';
import 'package:neo_bank/feature/rj/rj_book_flight/rj_book_flight_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_progress.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:riverpod/src/framework.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../base/base_page.dart';
import '../../../di/rj/rj_modules.dart';
import '../../../utils/parser/error_parser.dart';

class RjFlightBookingPage extends BasePage<RjFlightBookingViewModel> {
  @override
  State<StatefulWidget> createState() => RjFlightBookingStatefulPage();
}

class RjFlightBookingStatefulPage extends BaseStatefulPage<RjFlightBookingViewModel, RjFlightBookingPage> {
  @override
  Widget buildView(BuildContext context, RjFlightBookingViewModel model) {
    return RjFlightBookingView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return rjFlightBookingPageViewModelProvide;
  }

  @override
  void onModelReady(RjFlightBookingViewModel model) {
    model.getDestination();

    model.loadingStream.listen((value) {
      if (value) {
        AppProgress(context);
      } else {
        Navigator.pop(context);
      }
    });

    model.error.listen((event) {
      _showTopError(
          ErrorParser.getLocalisedStringError(
            error: event,
            localisedHelper: S.of(context),
          ),
          context);
      // if (event.type == ErrorType.UNAUTHORIZED_USER) {
      //   _showTopError(
      //       ErrorParser.getLocalisedStringError(
      //         error: event,
      //         localisedHelper: S.of(context),
      //       ),
      //       context);
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, RoutePaths.OnBoarding, ModalRoute.withName(RoutePaths.Splash));
      // } else {
      //   _showTopError(
      //       ErrorParser.getLocalisedStringError(
      //         error: event,
      //         localisedHelper: S.of(context),
      //       ),
      //       context);
      // }
    });

    super.onModelReady(model);
  }

  _showTopError(String message, BuildContext context) {
    showTopSnackBar(
        Overlay.of(context),
        Material(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.scrim, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).error,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.onTertiary,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0.t),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0.h, right: 16.0.w),
                          child: Text(message,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0.t)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        displayDuration: Duration(milliseconds: 1500),
        reverseAnimationDuration: Duration(milliseconds: 500),
        animationDuration: Duration(milliseconds: 700));
  }
}
