import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/my_debit_card/my_debit_card_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class MyDebitCardPageView extends BasePageViewWidget<MyDebitCardViewModel> {
  MyDebitCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity!.isNegative) {
          } else {
            ProviderScope.containerOf(context)
                .read(appHomeViewModelProvider)
                .pageController
                .previous();
          }
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          color: Theme.of(context).canvasColor,
          margin: EdgeInsets.zero,
          shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
          child: AppStreamBuilder<bool>(
            stream: model.isGetCardNowClickedStream,
            initialData: false,
            dataBuilder: (context, isClicked) {
              return isClicked == false
                  ? Padding(
                      padding: EdgeInsets.only(left: 27.0, top: 30, bottom: 29),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).myDebitCard,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 23.0),
                                child: InkWell(
                                  onTap: () {
                                    model
                                        .updateIsGetCardNowClicked(!isClicked!);
                                  },
                                  child: Text(
                                    S.of(context).flipCard,
                                    style: TextStyle(
                                        color: AppColor.green,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: AppSvg.asset(AssetUtils.blinkBlack),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 21),
                                  child: Text(
                                    "Zein Malhas",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 76),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: AppSvg.asset(AssetUtils.zigzagCircle),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 36,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context)
                                        .accentTextTheme
                                        .bodyText1!
                                        .color),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 17),
                                  child: Text(
                                    S.of(context).addMoney,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 33.0),
                                child: AppSvg.asset(AssetUtils.settingsRed),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 29.0, top: 38, right: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Zein Malhas",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                InkWell(
                                  onTap: () {
                                    model
                                        .updateIsGetCardNowClicked(!isClicked!);
                                  },
                                  child: Text(
                                    "Flip back",
                                    style: TextStyle(
                                        color: AppColor.green,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 63),
                              child: Text(
                                "8451 1353 1245 3421",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                "CARD NUMBER",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    color: AppColor.green),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 19),
                              child: Divider(
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 21),
                              child: Text(
                                "140591314151414",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                "LINKED ACCOUNT NUMBER",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                    color: AppColor.green),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 19),
                              child: Divider(
                                height: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 21, bottom: 128),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "08/23",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          "EXPIRY DATE",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: AppColor.green,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 59.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "688",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text(
                                            "CVV",
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: AppColor.green,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
