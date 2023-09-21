import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/rj/rj_book_flight/rj_book_flight_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../base/base_page.dart';

class RjFlightBookingView extends BasePageViewWidget<RjFlightBookingViewModel> {
  final Function? onDismissed;
  final Function(String)? onSelected;

  RjFlightBookingView(
    ProviderBase model, {
    this.onDismissed,
    this.onSelected,
  }) : super(model);

  @override
  Widget build(BuildContext context, RjFlightBookingViewModel model) {
    return Container(
      color: Theme.of(context).colorScheme.onSurface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(top: 57.h),
            child: Text(
              S.of(context).bookYourFlight,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: StringUtils.appFont,
                  fontSize: 14.t,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(top: 35.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 8.h, bottom: 24.h),
                      height: 4.h,
                      width: 64.w,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: model.scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(top: 40.0.h, bottom: 10.h),
                              child: Container(
                                height: 33.h,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (index == 0) {
                                          /// selection of one-way tab
                                          model.selectedTab(0);
                                          model.isValid();
                                        } else {
                                          /// selection of return tab
                                          model.selectedTab(1);
                                          model.isValid();
                                        }
                                      },
                                      child: Container(
                                        width: 60.w,
                                        child: Column(
                                          children: [
                                            AppStreamBuilder<int>(
                                              initialData: 0,
                                              stream: model.selectedTabStream,
                                              dataBuilder: (BuildContext context, data) {
                                                /// changing tab indicator color based on data variable
                                                return data == index
                                                    ? Column(
                                                        children: [
                                                          Text(
                                                            model.rjBookingFlightTabOptionList[index].option,
                                                            style: TextStyle(
                                                                fontFamily: StringUtils.appFont,
                                                                fontWeight: FontWeight.w600,
                                                                color: Theme.of(context).primaryColorDark,
                                                                fontSize: 14.t),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Container(
                                                            height: 2.h,
                                                            color: Theme.of(context).primaryColor,
                                                          )
                                                        ],
                                                      )
                                                    : Column(
                                                        children: [
                                                          Text(
                                                            model.rjBookingFlightTabOptionList[index].option,
                                                            style: TextStyle(
                                                                fontFamily: StringUtils.appFont,
                                                                fontWeight: FontWeight.w600,
                                                                color: Theme.of(context)
                                                                    .colorScheme
                                                                    .onInverseSurface,
                                                                fontSize: 14.t),
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Container(),
                                                        ],
                                                      );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, int) {
                                    return SizedBox(
                                      width: 20.w,
                                    );
                                  },
                                  itemCount: model.rjBookingFlightTabOptionList.length,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
