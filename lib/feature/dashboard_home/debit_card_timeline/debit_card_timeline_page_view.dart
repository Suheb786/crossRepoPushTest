import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
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
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentTextTheme.bodyText1!.color,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 17),
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
            Container(
              height: 103,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      index % 2 == 0
                          ? Image.asset(
                              AssetUtils.progress1,
                              fit: BoxFit.fitHeight,
                              height: 103,
                            )
                          : Image.asset(
                              AssetUtils.progress2,
                              fit: BoxFit.contain,
                              height: 103,
                            ),
                      index % 2 != 0
                          ? Positioned(
                              top: 0,
                              left: -10,
                              //right: 10,
                              child: Container(
                                height: 21,
                                width: 21,
                                decoration: BoxDecoration(
                                    color: AppColor.vividYellow,
                                    shape: BoxShape.circle),
                              ),
                            )
                          : Positioned(
                              bottom: 0,
                              left: -10,
                              child: Container(
                                height: 21,
                                width: 21,
                                decoration: BoxDecoration(
                                    color: AppColor.vividYellow,
                                    shape: BoxShape.circle),
                              ),
                            ),
                      index % 2 == 0
                          ? Positioned(
                              top: 0,
                              right: -10,
                              //right: 10,
                              child: Container(
                                height: 21,
                                width: 21,
                                decoration: BoxDecoration(
                                    color: AppColor.vividYellow,
                                    shape: BoxShape.circle),
                              ),
                            )
                          : Positioned(
                              bottom: 0,
                              right: -10,
                              child: Container(
                                height: 21,
                                width: 21,
                                decoration: BoxDecoration(
                                    color: AppColor.vividYellow,
                                    shape: BoxShape.circle),
                              ),
                            ),

                      index % 2 == 0
                          ? Positioned(
                              right: 0,
                              top: 0,
                              child: Column(
                                children: [
                                  Text('Delivered date'),
                                  Text(
                                    TimeUtils.getFormattedDateForTransaction(
                                        model
                                            .timeLineArguments1
                                            .timelineListArguments![index]
                                            .cardCardActivated
                                            .toString()),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ))
                          : Positioned(
                              right: 0,
                              bottom: 0,
                              // right: -10,
                              child: Column(
                                children: [
                                  Text('Activated Date'),
                                  Text(TimeUtils.getFormattedDateForTransaction(
                                      model
                                          .timeLineArguments1
                                          .timelineListArguments![index]
                                          .cardDeliveredDatetime
                                          .toString()))
                                ],
                              ))

                      ///logic implement for start and end circle colour
                      // index == 5
                      //     ? Positioned(
                      //         bottom: 0,
                      //         right: -5,
                      //         child: Container(
                      //           height: 22,
                      //           width: 22,
                      //           decoration: BoxDecoration(
                      //               color: AppColor.pure_blue,
                      //               shape: BoxShape.circle),
                      //         ),
                      //       )
                      //     : Container(),
                    ],
                  );
                },
                itemCount:
                    model.timeLineArguments1.timelineListArguments!.length,
                shrinkWrap: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 48),
              child: Container(
                height: 93,
                width: 280,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 31, right: 26, bottom: 31, left: 19),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AssetUtils.blink,
                        width: 60,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .accentTextTheme
                                .bodyText1!
                                .color,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          child: Text(
                            S.of(context).getCardNow,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 95),
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: Container(
            //       width: 280,
            //       height: 67,
            //       decoration: BoxDecoration(
            //         color: Theme.of(context).primaryColor,
            //         borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
