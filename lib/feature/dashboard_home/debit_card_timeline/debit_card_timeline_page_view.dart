import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 37),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                S.of(context).cardDelivered,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 11, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .accentTextTheme
                                              .bodyText1!
                                              .color!)),
                                  child: Text(
                                    "Confirm",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .accentTextTheme
                                            .bodyText1!
                                            .color,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 170),
                            child: Column(
                              children: [
                                Text(
                                  "You joined \nblink",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "4 Jan",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .inputDecorationTheme
                                            .hintStyle!
                                            .color,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 56, top: 22),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Image.asset(AssetUtils.progress1),
                            // Image.asset(AssetUtils.progress2a),
                            // Image.asset(AssetUtils.progress1),
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: Image.asset(AssetUtils.progress2),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: -10,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: AppColor.darkGrey,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: AppColor.darkGrey,
                                        shape: BoxShape.circle),
                                  ),
                                )
                              ],
                            ),
                            Stack(
                              children: [
                                Image.asset(AssetUtils.progress1),
                                Positioned(
                                  bottom: 0,
                                  left: -10,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: AppColor.darkGrey,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: -10,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: AppColor.darkGrey,
                                        shape: BoxShape.circle),
                                  ),
                                )
                              ],
                            ),
                            Stack(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: Image.asset(AssetUtils.progress2)),
                                Positioned(
                                  top: 0,
                                  left: -10,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: AppColor.darkGrey,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color: AppColor.darkGrey,
                                        shape: BoxShape.circle),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 19, left: 160),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "Debit Card\nactivated.",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  "4 Jan",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .inputDecorationTheme
                                          .hintStyle!
                                          .color,
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 180),
                            child: Column(
                              children: [
                                Text(
                                  "Blink was\nborn",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    "1 Jan",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .inputDecorationTheme
                                            .hintStyle!
                                            .color,
                                        fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
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
          ],
        ),
      ),
    );
  }
}
