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
import 'package:neo_bank/utils/time_utils.dart';

class DebitCardTimeLinePageView
    extends BasePageViewWidget<DebitCardTimeLineViewModel> {
  DebitCardTimeLinePageView(ProviderBase model) : super(model);
  bool isGetCardClicked = false;

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      // onVerticalDragEnd: (details) {
      //   int sensitivity = 8;
      //   if (details.primaryVelocity! > sensitivity) {
      //     Navigator.pop(context, model.willPop());
      //     print('down');
      //   } else if (details.primaryVelocity! < -sensitivity) {
      //     print('up');
      //   }
      //   // if (!details.primaryVelocity!.isNegative) {
      //   //   Navigator.pop(context, model.willPop());
      //   // }
      // },
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
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.timeLineArguments.timeLineArguments
                            .availableBalance ??
                        "0.000",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, top: 5),
                    child: Text(
                      "JOD",
                      style: TextStyle(
                          fontSize: 14,
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
                  Navigator.pushNamed(
                      context, RoutePaths.AddMoneyOptionSelector);
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color:
                            Theme.of(context).accentTextTheme.bodyText1!.color,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 17),
                      child: Text(
                        S.of(context).addMoney,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Row(
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
                                          ? AppSvg.asset(AssetUtils.timelineEnd,
                                              height: 103)
                                          : AppSvg.asset(AssetUtils.timeline2,
                                              height: 103),
                                      AppSvg.asset(AssetUtils.timeline1,
                                          height: 103)
                                    ],
                                  ),
                                ),
                                Positioned(
                                  left: -15,
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 40),
                                    child: model
                                                .timeLineArguments
                                                .timeLineArguments
                                                .timelineListArguments[index]
                                                .isCardDelivered ??
                                            false
                                        ? Column(
                                            children: [
                                              Text(
                                                model
                                                            .timeLineArguments
                                                            .timeLineArguments
                                                            .timelineListArguments[
                                                                index]
                                                            .cardType ==
                                                        CardType.DEBIT
                                                    ? S
                                                        .of(context)
                                                        .debitCardDelivered
                                                    : S
                                                        .of(context)
                                                        .creditCardDelivered,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                model
                                                        .timeLineArguments
                                                        .timeLineArguments
                                                        .timelineListArguments[
                                                            index]
                                                        .cardDeliveredDatetime!
                                                        .isNotEmpty
                                                    ? TimeUtils
                                                        .getFormattedDateForTransaction(model
                                                            .timeLineArguments
                                                            .timeLineArguments
                                                            .timelineListArguments[
                                                                index]
                                                            .cardDeliveredDatetime
                                                            .toString())
                                                    : '-',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Theme.of(context)
                                                        .inputDecorationTheme
                                                        .hintStyle!
                                                        .color,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              Text(
                                                model
                                                            .timeLineArguments
                                                            .timeLineArguments
                                                            .timelineListArguments[
                                                                index]
                                                            .cardType ==
                                                        CardType.DEBIT
                                                    ? S
                                                        .of(context)
                                                        .debitCardDeliveredQ
                                                    : S
                                                        .of(context)
                                                        .creditCardDeliveredQ,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: InkWell(
                                                  onTap: () async {
                                                    if (model
                                                            .timeLineArguments
                                                            .timeLineArguments
                                                            .timelineListArguments[
                                                                index]
                                                            .cardType ==
                                                        CardType.CREDIT) {
                                                      var result =
                                                          await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          CreditCardDeliveredPage(
                                                                            creditCard:
                                                                                model.timeLineArguments.timeLineArguments.timelineListArguments[index],
                                                                          )));
                                                      if (result != null) {
                                                        ProviderScope
                                                                .containerOf(
                                                                    context)
                                                            .read(
                                                                appHomeViewModelProvider)
                                                            .getDashboardData();
                                                      }
                                                    } else {
                                                      var result =
                                                          await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          DebitCardDeliveredPage(
                                                                            debitCard:
                                                                                model.timeLineArguments.timeLineArguments.timelineListArguments[index],
                                                                          )));
                                                      if (result != null) {
                                                        print('$result');
                                                        ProviderScope
                                                                .containerOf(
                                                                    context)
                                                            .read(
                                                                appHomeViewModelProvider)
                                                            .getDashboardData();
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 11,
                                                            vertical: 2),
                                                    decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        border: Border.all(
                                                            color: Theme.of(
                                                                    context)
                                                                .accentTextTheme
                                                                .bodyText1!
                                                                .color!)),
                                                    child: Text(
                                                      S.of(context).confirm,
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .accentTextTheme
                                                              .bodyText1!
                                                              .color,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                  ),
                                ),
                                Positioned(
                                  left: 30,
                                  top: 170,
                                  right: 0,
                                  child: Container(
                                      padding: EdgeInsets.only(bottom: 40),
                                      child: Column(
                                        children: [
                                          Text(
                                            model
                                                        .timeLineArguments
                                                        .timeLineArguments
                                                        .timelineListArguments[
                                                            index]
                                                        .cardType ==
                                                    CardType.DEBIT
                                                ? S
                                                    .of(context)
                                                    .debitCardActivated
                                                : S
                                                    .of(context)
                                                    .creditCardActivated,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
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
                                                    .timelineListArguments[
                                                        index]
                                                    .cardCardActivated!
                                                    .isNotEmpty
                                                ? TimeUtils
                                                    .getFormattedDateForTransaction(
                                                        model
                                                            .timeLineArguments
                                                            .timeLineArguments
                                                            .timelineListArguments[
                                                                index]
                                                            .cardCardActivated
                                                            .toString())
                                                : "-",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
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
                      itemCount: model.timeLineArguments.timeLineArguments
                          .timelineListArguments.length,
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
                              child: AppSvg.asset(AssetUtils.timeline0,
                                  height: 103)),
                          Positioned(
                            left: -15,
                            child: Container(
                                padding: EdgeInsets.only(bottom: 40),
                                child: Column(
                                  children: [
                                    Text(
                                      S.of(context).joinedBlink,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      TimeUtils.getFormattedDateForTransaction(
                                          model.timeLineArguments
                                              .timeLineArguments.youJoinedBlink
                                              .toString()), //'4th Jan',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
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
                          Positioned(
                            top: 170,
                            right: -10,
                            child: Container(
                                padding: EdgeInsets.only(bottom: 40),
                                child: Column(
                                  children: [
                                    Text(
                                      S.of(context).blinkBorn,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      TimeUtils.getFormattedDateForTransaction(
                                          model.timeLineArguments
                                              .timeLineArguments.blinkWasBorn
                                              .toString()),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetUtils.credit),
                        fit: BoxFit.contain),
                    borderRadius: BorderRadius.circular(16)),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 281,
                      height: 100,
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                          color: model.timeLineArguments.cardType ==
                                  CardType.CREDIT
                              ? Theme.of(context).primaryColor
                              : model.timeLineArguments.cardType ==
                                      CardType.DEBIT
                                  ? Theme.of(context).canvasColor
                                  : Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      child: Padding(
                        padding: EdgeInsets.only(top: 22, left: 27),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            model.timeLineArguments.cardType ==
                                        CardType.CREDIT ||
                                    model.timeLineArguments.cardType ==
                                        CardType.ACCOUNT
                                ? AppSvg.asset(AssetUtils.blink_updated_logo,
                                    height: 34, width: 72)
                                : AppSvg.asset(AssetUtils.blinkBlack,
                                    height: 34, width: 72),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(child: AppSvg.asset(AssetUtils.swipeUp)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
