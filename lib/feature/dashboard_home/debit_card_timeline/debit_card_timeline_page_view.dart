import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
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
                  padding: EdgeInsets.only(left: 5),
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
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(AssetUtils.progress2),
                  Container(
                    height: 20,
                    width: 20,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.vividYellow),
                  ),
                  Image.asset(AssetUtils.progress1),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColor.vividYellow),
                    ),
                  ),
                  Image.asset(AssetUtils.progress2),
                  Image.asset(AssetUtils.progress1),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(top: 19, left: 57),
          //   child: Text(
          //     "Debit Card\nactivated.",
          //     style: TextStyle(
          //       fontSize: 12,
          //       color: AppColor.black,
          //       fontWeight: FontWeight.w600
          //     ),
          //   ),
          // )
          // Padding(
          //   padding: EdgeInsets.only(top: 50),
          //   child: Container(
          //     height: 93,
          //     width: 280,
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).primaryColor,
          //       borderRadius: BorderRadius.circular(16)
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.only(top: 31, right: 26, bottom: 31, left: 19),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Image.asset(AssetUtils.blink, width: 60,),
          //           Container(
          //             decoration: BoxDecoration(
          //                 color: Theme.of(context).accentTextTheme.bodyText1!.color,
          //                 borderRadius: BorderRadius.circular(20)
          //             ),
          //             child: Padding(
          //               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          //               child: Text(
          //                 S.of(context).getCardNow,
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.w600,
          //                     fontSize: 14,
          //                     color: Theme.of(context).accentColor
          //                 ),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 22),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: AppColor.very_light_gray1,
                padding: EdgeInsets.only(top: 17, left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My friends",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 18),
                      child: Row(
                        children: [
                          AppSvg.asset(AssetUtils.addCircle),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Let’s make some friends",
                              style: TextStyle(
                                  color: AppColor.very_light_gray5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 5, right: 48, left: 48),
                        child: Container(
                          height: double.infinity,
                          width: 280,
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 27, top: 22),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AppSvg.asset(AssetUtils.blinkBlack,
                                      width: 72, height: 33),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
