import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class DebitCardTimeLinePageView extends BasePageViewWidget<DebitCardTimeLineViewModel> {
  DebitCardTimeLinePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: 85.h),
        child: Column(
          children: [
            Text(
              S.of(context).totalBalance,
              style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w400, fontSize: 18.t),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.timeLineArguments.timeLineArguments.availableBalance ?? "0.000",
                    style: TextStyle(
                        fontFamily: StringUtils.appFont, fontWeight: FontWeight.w700, fontSize: 24.t),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 5.w, top: 5.h),
                    child: Text(
                      S.of(context).JOD,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 12.t,
                          fontWeight: FontWeight.w700,
                          color: AppColor.verLightGray4),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.h),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutePaths.AddMoneyOptionSelector);
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    decoration: BoxDecoration(
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                        borderRadius: BorderRadius.circular(20.w)),
                    child: Text(
                      S.of(context).addMoney,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.t,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 60.w),
                child: model.timeLineArguments.timeLineArguments.timelineListArguments.length > 0
                    ? Row(
                        children: [
                          Container(
                            height: 220.h,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: 220.h,
                                          child: Row(
                                            children: [
                                              index == 0
                                                  ? AppSvg.asset(AssetUtils.timelineEndUpdated,
                                                      matchTextDirection: true, height: 103.h)
                                                  : AppSvg.asset(AssetUtils.timeline2Updated,
                                                      matchTextDirection: true, height: 103.h),
                                              AppSvg.asset(AssetUtils.timeline1Updated,
                                                  matchTextDirection: true, height: 103.h)
                                            ],
                                          ),
                                        ),
                                        PositionedDirectional(
                                          start: -15.w,
                                          child: Container(
                                            padding: EdgeInsets.only(bottom: 40.h),
                                            child: model.timeLineArguments.timeLineArguments
                                                        .timelineListArguments[index].isCardDelivered ??
                                                    false
                                                ? Column(
                                                    children: [
                                                      Text(
                                                        model.timeLineArguments.timeLineArguments
                                                                    .timelineListArguments[index].cardType ==
                                                                CardType.DEBIT
                                                            ? S.of(context).debitCardDelivered
                                                            : S.of(context).creditCardDelivered,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            fontSize: 12.t,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text(
                                                        model
                                                                .timeLineArguments
                                                                .timeLineArguments
                                                                .timelineListArguments[index]
                                                                .cardDeliveredDatetime!
                                                                .isNotEmpty
                                                            ? TimeUtils.getFormattedDateForTransaction(model
                                                                .timeLineArguments
                                                                .timeLineArguments
                                                                .timelineListArguments[index]
                                                                .cardDeliveredDatetime
                                                                .toString())
                                                            : '-',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            fontSize: 12.t,
                                                            color: Theme.of(context)
                                                                .inputDecorationTheme
                                                                .hintStyle!
                                                                .color,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ],
                                                  )
                                                : Column(
                                                    children: [
                                                      Text(
                                                        model.timeLineArguments.timeLineArguments
                                                                    .timelineListArguments[index].cardType ==
                                                                CardType.DEBIT
                                                            ? ''
                                                            : S.of(context).creditCardOnDelivery,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 12.t),
                                                      ),
                                                      Visibility(
                                                        visible: false,
                                                        child: Padding(
                                                          padding: EdgeInsets.only(top: 5.h),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              if (model
                                                                      .timeLineArguments
                                                                      .timeLineArguments
                                                                      .timelineListArguments[index]
                                                                      .cardType ==
                                                                  CardType.DEBIT) {}
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets.symmetric(
                                                                  horizontal: 8, vertical: 2),
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      Theme.of(context).colorScheme.secondary,
                                                                  borderRadius: BorderRadius.circular(14.w),
                                                                  border: Border.all(
                                                                      color: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .color!)),
                                                              child: Text(
                                                                S.of(context).confirm,
                                                                style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    color: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .color!,
                                                                    fontSize: 12.t,
                                                                    fontWeight: FontWeight.w600),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                          ),
                                        ),
                                        PositionedDirectional(
                                          start: 30.w,
                                          top: 170.h,
                                          end: 0,
                                          child: Container(
                                              padding: EdgeInsets.only(bottom: 40.h),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    model.timeLineArguments.timeLineArguments
                                                                .timelineListArguments[index].cardType ==
                                                            CardType.DEBIT
                                                        ? S.of(context).debitCardActivated
                                                        : S.of(context).creditCardActivated,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 12.t,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Text(
                                                    model
                                                            .timeLineArguments
                                                            .timeLineArguments
                                                            .timelineListArguments[index]
                                                            .cardCardActivated!
                                                            .isNotEmpty
                                                        ? TimeUtils.getFormattedDateForTransaction(model
                                                            .timeLineArguments
                                                            .timeLineArguments
                                                            .timelineListArguments[index]
                                                            .cardCardActivated
                                                            .toString())
                                                        : "-",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 12.t,
                                                        color: Theme.of(context)
                                                            .inputDecorationTheme
                                                            .hintStyle!
                                                            .color,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                              shrinkWrap: true,
                              itemCount:
                                  model.timeLineArguments.timeLineArguments.timelineListArguments.length,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                      height: 220.h,
                                      child: AppSvg.asset(AssetUtils.timelinec1,
                                          matchTextDirection: true, height: 103.h)),
                                  PositionedDirectional(
                                    start: -15.w,
                                    child: Container(
                                        padding: EdgeInsets.only(bottom: 40.h),
                                        child: Column(
                                          children: [
                                            Text(
                                              S.of(context).joinedBlink,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 12.t,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              TimeUtils.getFormattedDateForTransaction(model
                                                  .timeLineArguments.timeLineArguments.youJoinedBlink
                                                  .toString()), //'4th Jan',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 12.t,
                                                  color:
                                                      Theme.of(context).inputDecorationTheme.hintStyle!.color,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )),
                                  ),
                                  PositionedDirectional(
                                    top: 170.h,
                                    end: -10.w,
                                    child: Container(
                                        padding: EdgeInsets.only(bottom: 40.h),
                                        child: Column(
                                          children: [
                                            Text(
                                              S.of(context).blinkBorn,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12.t, fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              TimeUtils.getFormattedDateForTransaction(model
                                                  .timeLineArguments.timeLineArguments.blinkWasBorn
                                                  .toString()),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 12.t,
                                                  color:
                                                      Theme.of(context).inputDecorationTheme.hintStyle!.color,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                  height: 220.h,
                                  child: AppSvg.asset(AssetUtils.timelineEnd,
                                      matchTextDirection: true, height: 105.h)),
                              PositionedDirectional(
                                start: -15.w,
                                child: Container(
                                    padding: EdgeInsets.only(bottom: 40.h),
                                    child: Column(
                                      children: [
                                        Text(
                                          S.of(context).joinedBlink,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12.t,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          TimeUtils.getFormattedDateForTransaction(model
                                              .timeLineArguments.timeLineArguments.youJoinedBlink
                                              .toString()), //'4th Jan',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12.t,
                                              color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )),
                              ),
                              PositionedDirectional(
                                top: 170.h,
                                end: -10.w,
                                child: Container(
                                    padding: EdgeInsets.only(bottom: 40.h),
                                    child: Column(
                                      children: [
                                        Text(
                                          S.of(context).blinkBorn,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12.t,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          TimeUtils.getFormattedDateForTransaction(model
                                              .timeLineArguments.timeLineArguments.blinkWasBorn
                                              .toString()),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12.t,
                                              color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )),
                              ),
                              PositionedDirectional(
                                top: 57.h,
                                child: Container(
                                  //padding: EdgeInsets.only(right: 20),
                                  height: 22.78.h,
                                  width: 22.78.w,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: Theme.of(context).canvasColor),
                                ),
                              ),
                              PositionedDirectional(
                                top: 139.h,
                                end: -15.w,
                                child: Container(
                                  //padding: EdgeInsets.only(right: 20),
                                  height: 22.78.h,
                                  width: 22.78.w,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: Theme.of(context).canvasColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
            model.timeLineArguments.timeLineArguments.placeholderData!.status ?? false
                ? Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Image.memory(
                      model.timeLineArguments.timeLineArguments.placeholderData!.image,
                      fit: BoxFit.fill,
                    )
                    /*Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: Image.memory(model.timeLineArguments
                                      .timeLineArguments.placeholderData!.image)
                                  .image,
                              fit: BoxFit.contain),
                          borderRadius: BorderRadius.circular(16)),
                    )*/
                    ,
                  )
                : Container(),

          ],
        ),
      ),
    );
  }
}
