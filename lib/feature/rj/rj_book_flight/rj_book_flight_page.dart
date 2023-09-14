import 'package:flutter/material.dart';
import 'package:neo_bank/feature/rj/rj_book_flight/rj_book_flight_page_view.dart';
import 'package:neo_bank/feature/rj/rj_book_flight/rj_book_flight_page_view_model.dart';
import 'package:neo_bank/feature/rj/rj_book_flight/widget/booking_widget.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_progress.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:riverpod/src/framework.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../base/base_page.dart';
import '../../../di/rj/rj_modules.dart';
import '../../../ui/molecules/app_svg.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/parser/error_parser.dart';

class RjFlightBookingPage extends BasePage<RjFlightBookingViewModel> {
  @override
  State<StatefulWidget> createState() => RjFlightBookingStatefulPage();
}

class RjFlightBookingStatefulPage extends BaseStatefulPage<RjFlightBookingViewModel, RjFlightBookingPage>
    with TickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  ProviderBase provideBase() {
    return rjFlightBookingPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.onPrimaryContainer;
  }

  @override
  void onModelReady(RjFlightBookingViewModel model) {

    if (!_tabController.hasListeners) {
      _tabController.addListener(() {
        if (model.tabChangeNotifier.value != _tabController.index)
          model.tabChangeNotifier.value = _tabController.index;
      });

      model.switchTabStream.listen((event) {
        // model.switchTab(_tabController, event);
      });
    }

    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, RjFlightBookingViewModel model) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 52.0.h, bottom: 0.h),
          height: 80.h,
          child: Text(
            S.of(context).bookYourFlight,
            textAlign: TextAlign.center,
            softWrap: false,
            style: TextStyle(
                fontSize: 14.t, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(top: 24.h),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w))),
                child: Column(
                  children: [
                    SizedBox(height: 47.h),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: TabBar(
                          isScrollable: true,
                          indicatorWeight: 8.0.h,
                          indicatorSize: TabBarIndicatorSize.label,
                          unselectedLabelColor: Theme.of(context).colorScheme.onInverseSurface,
                          controller: _tabController,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                width: 4.0.w,
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(3.0.w))),
                          tabs: [
                            Text(
                              S.of(context).oneWay,
                              style: TextStyle(
                                  fontSize: 14.t,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: StringUtils.appFont),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 2.w),
                              child: Text(
                                S.of(context).returnTitle,
                                style: TextStyle(
                                    fontSize: 14.t,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: StringUtils.appFont),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            RJBookingWidgetView(
                              index: 0,
                              key: ValueKey("0"),
                            ),
                            RJBookingWidgetView(
                              index: 1,
                              key: ValueKey("1"),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 0.h,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48.h,
                    width: 48.h,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0, 4))
                        ]),
                    child: AppSvg.asset(AssetUtils.down, color: AppColor.light_acccent_blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
