import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
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
    return AppKeyBoardHide(
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
                    "0.00",
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
                                      child: Column(
                                        children: [
                                          Text(
                                            'card\nDelivered',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            TimeUtils
                                                .getFormattedDateForTransaction(
                                                    model
                                                        .timeLineArguments
                                                        .timelineListArguments![
                                                            index]
                                                        .cardDeliveredDatetime
                                                        .toString()),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )),
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
                                            'card\n Activated',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            TimeUtils
                                                .getFormattedDateForTransaction(
                                                    model
                                                        .timeLineArguments
                                                        .timelineListArguments![
                                                            index]
                                                        .cardCardActivated
                                                        .toString()),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
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
                          model.timeLineArguments.timelineListArguments!.length,
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
                                      'You Joined \nBlink',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      TimeUtils.getFormattedDateForTransaction(
                                          model.timeLineArguments.youJoinedBlink
                                              .toString()), //'4th Jan',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
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
                                      'Blink was\n born',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      TimeUtils.getFormattedDateForTransaction(
                                          model.timeLineArguments.blinkWasBorn
                                              .toString()),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
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
            Stack(
              children: [
                Center(
                  child: Container(
                    width: 281,
                    height: 100,
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        color: model.currentStep == 1 || model.currentStep == 3
                            ? Theme.of(context).primaryColor
                            : model.currentStep == 2
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
                          model.currentStep == 1 || model.currentStep == 0
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
          ],
        ),
      ),
    );
  }
}
