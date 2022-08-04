import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_delivered/debit_card_delivered_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class DebitCardTimeLinePageView extends BasePageViewWidget<DebitCardTimeLineViewModel> {
  DebitCardTimeLinePageView(ProviderBase model) : super(model);
  bool isGetCardClicked = false;

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: 85),
        child: Column(
          children: [
            Text(
              S.of(context).totalBalance,
              style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w400, fontSize: 18),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.timeLineArguments.timeLineArguments.availableBalance ?? "0.000",
                    style:
                        TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 5, top: 5),
                    child: Text(
                      S.of(context).JOD,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColor.verLightGray4),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutePaths.AddMoneyOptionSelector);
                },
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentTextTheme.bodyText1!.color,
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      S.of(context).addMoney,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 60),
                child: model.timeLineArguments.timeLineArguments.timelineListArguments.length > 0
                    ? Row(
                        children: [
                          Container(
                            height: 220,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: 220,
                                          child: Row(
                                            children: [
                                              index == 0
                                                  ? AppSvg.asset(AssetUtils.timelineEndUpdated,
                                                      matchTextDirection: true, height: 103)
                                                  : AppSvg.asset(AssetUtils.timeline2Updated,
                                                      matchTextDirection: true, height: 103),
                                              AppSvg.asset(AssetUtils.timeline1Updated,
                                                  matchTextDirection: true, height: 103)
                                            ],
                                          ),
                                        ),
                                        PositionedDirectional(
                                          start: -15,
                                          child: Container(
                                            padding: EdgeInsets.only(bottom: 40),
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
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
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
                                                            fontSize: 12,
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
                                                            ? S.of(context).debitCardDeliveredQ
                                                            : S.of(context).creditCardDeliveredQ,
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 5),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            if (model.timeLineArguments.timeLineArguments
                                                                    .timelineListArguments[index].cardType ==
                                                                CardType.CREDIT) {
                                                              var result = await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          CreditCardDeliveredPage(
                                                                            creditCard: model
                                                                                .timeLineArguments
                                                                                .timeLineArguments
                                                                                .timelineListArguments[index],
                                                                          )));
                                                              if (result != null) {
                                                                ProviderScope.containerOf(context)
                                                                    .read(appHomeViewModelProvider)
                                                                    .getDashboardData();
                                                              }
                                                            } else {
                                                              var result = await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          DebitCardDeliveredPage(
                                                                            debitCard: model
                                                                                .timeLineArguments
                                                                                .timeLineArguments
                                                                                .timelineListArguments[index],
                                                                          )));
                                                              if (result != null) {
                                                                print('$result');
                                                                ProviderScope.containerOf(context)
                                                                    .read(appHomeViewModelProvider)
                                                                    .getDashboardData();
                                                              }
                                                            }
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: 8, vertical: 2),
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(context).accentColor,
                                                                borderRadius: BorderRadius.circular(14),
                                                                border: Border.all(
                                                                    color: Theme.of(context)
                                                                        .accentTextTheme
                                                                        .bodyText1!
                                                                        .color!)),
                                                            child: Text(
                                                              S.of(context).confirm,
                                                              style: TextStyle(
                                                                  fontFamily: StringUtils.appFont,
                                                                  color: Theme.of(context)
                                                                      .accentTextTheme
                                                                      .bodyText1!
                                                                      .color,
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.w600),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                          ),
                                        ),
                                        PositionedDirectional(
                                          start: 30,
                                          top: 170,
                                          end: 0,
                                          child: Container(
                                              padding: EdgeInsets.only(bottom: 40),
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
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
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
                                                        fontSize: 12,
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
                                      height: 220,
                                      child: AppSvg.asset(AssetUtils.timelinec1,
                                          matchTextDirection: true, height: 103)),
                                  PositionedDirectional(
                                    start: -15,
                                    child: Container(
                                        padding: EdgeInsets.only(bottom: 40),
                                        child: Column(
                                          children: [
                                            Text(
                                              S.of(context).joinedBlink,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              TimeUtils.getFormattedDateForTransaction(model
                                                  .timeLineArguments.timeLineArguments.youJoinedBlink
                                                  .toString()), //'4th Jan',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 12,
                                                  color:
                                                      Theme.of(context).inputDecorationTheme.hintStyle!.color,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        )),
                                  ),
                                  PositionedDirectional(
                                    top: 170,
                                    end: -10,
                                    child: Container(
                                        padding: EdgeInsets.only(bottom: 40),
                                        child: Column(
                                          children: [
                                            Text(
                                              S.of(context).blinkBorn,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              TimeUtils.getFormattedDateForTransaction(model
                                                  .timeLineArguments.timeLineArguments.blinkWasBorn
                                                  .toString()),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 12,
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
                                  height: 220,
                                  child: AppSvg.asset(AssetUtils.timelineEnd,
                                      matchTextDirection: true, height: 105)),
                              PositionedDirectional(
                                start: -15,
                                child: Container(
                                    padding: EdgeInsets.only(bottom: 40),
                                    child: Column(
                                      children: [
                                        Text(
                                          S.of(context).joinedBlink,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          TimeUtils.getFormattedDateForTransaction(model
                                              .timeLineArguments.timeLineArguments.youJoinedBlink
                                              .toString()), //'4th Jan',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12,
                                              color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )),
                              ),
                              PositionedDirectional(
                                top: 170,
                                end: -10,
                                child: Container(
                                    padding: EdgeInsets.only(bottom: 40),
                                    child: Column(
                                      children: [
                                        Text(
                                          S.of(context).blinkBorn,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          TimeUtils.getFormattedDateForTransaction(model
                                              .timeLineArguments.timeLineArguments.blinkWasBorn
                                              .toString()),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 12,
                                              color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    )),
                              ),
                              PositionedDirectional(
                                top: 57,
                                child: Container(
                                  //padding: EdgeInsets.only(right: 20),
                                  height: 22.78,
                                  width: 22.78,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle, color: Theme.of(context).canvasColor),
                                ),
                              ),
                              PositionedDirectional(
                                top: 139,
                                end: -15,
                                child: Container(
                                  //padding: EdgeInsets.only(right: 20),
                                  height: 22.78,
                                  width: 22.78,
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
                    padding: EdgeInsets.only(top: 20),
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
            Spacer(),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Center(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
                      width: 281,
                      height: 90,
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: model.timeLineArguments.cardType == CardType.CREDIT
                              ? Theme.of(context).primaryColor
                              : model.timeLineArguments.cardType == CardType.DEBIT
                                  ? Theme.of(context).canvasColor
                                  : Theme.of(context).primaryColorDark,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top: 22, start: 27),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            model.timeLineArguments.cardType == CardType.CREDIT ||
                                    model.timeLineArguments.cardType == CardType.ACCOUNT
                                ? AppSvg.asset(AssetUtils.blink_updated_logo,
                                    height: 34, width: 72, matchTextDirection: true)
                                : AppSvg.asset(AssetUtils.blinkBlack,
                                    height: 34, width: 72, matchTextDirection: true),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                PositionedDirectional(
                    top: -3,
                    child: AppSvg.asset(
                      AssetUtils.swipeUp,
                      matchTextDirection: true,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
