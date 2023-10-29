import 'package:domain/model/offer_campaign/offer/offers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/offer_campaign/offer/offer_for_you_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/time_utils.dart';

import '../../../di/dashboard/dashboard_modules.dart';
import '../../../utils/string_utils.dart';
import '../stream_builder/app_stream_builder.dart';

class OfferForYouCardWidget extends StatelessWidget {
  final List<Offers> data;
  final int myIndex;

  OfferForYouCardWidget(this.data, {Key? key, required this.myIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<int>(
        stream: ProviderScope.containerOf(context).read(appHomeViewModelProvider).currentStep,
        initialData: 0,
        dataBuilder: (context, myyCurrentStep) {
          return AnimatedOpacity(
            opacity: myyCurrentStep == myIndex ? 1 : 0.5,
            duration: const Duration(milliseconds: 400),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.w)),
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              elevation: 2,
              margin: EdgeInsets.zero,
              shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 24.0.w, top: 32.h),
                    child: Text(
                      S.of(context).forYou,
                      style: TextStyle(
                          fontSize: 20.t,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.w),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 8),
                                            blurRadius: 10,
                                            color: Color.fromRGBO(0, 0, 0, 0.16))
                                      ]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(16.w)),
                                    child: Image.memory(
                                      data[index].image,
                                      fit: BoxFit.fill,
                                      width: 104.w,
                                      height: 104.h,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[index].campaignName ?? '',
                                        style: TextStyle(
                                            fontSize: 14.t,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: StringUtils.appFont,
                                            color: Theme.of(context).scaffoldBackgroundColor),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        data[index].descriptions ?? '',
                                        style: TextStyle(
                                            fontSize: 12.t,
                                            fontFamily: StringUtils.appFont,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)),
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      Container(
                                        padding: EdgeInsetsDirectional.only(
                                            start: 8.0.w, end: 8.0.w, top: 3.5.h, bottom: 1.5.h),
                                        decoration: BoxDecoration(
                                            color: TimeUtils.differentBetweenTwoDateInDays(
                                                        data[index].campaignValidTill ?? '') <=
                                                    9
                                                ? getColor(OfferType.EARLY)
                                                : getColor(OfferType.LATER),
                                            borderRadius: BorderRadius.circular(100)),
                                        child: Text(
                                          S.of(context).daysLeft(TimeUtils.differentBetweenTwoDateInDays(
                                                  data[index].campaignValidTill ?? '')
                                              .toString()),
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              color: Theme.of(context).scaffoldBackgroundColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.0.t),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: data.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Color getColor(OfferType value) {
    switch (value) {
      case OfferType.EARLY:
        return AppColor.dark_orange;

      default:
        return AppColor.darkModerateLimeGreen;
    }
  }
}
