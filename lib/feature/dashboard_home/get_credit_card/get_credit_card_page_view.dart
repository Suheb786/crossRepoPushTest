import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/get_credit_card/get_credit_card_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/credit_card_detail/credit_card_detail_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class GetCreditCardPageView extends BasePageViewWidget<GetCreditCardViewModel> {
  GetCreditCardPageView(ProviderBase model) : super(model);
  bool isGetCardClicked = false;

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          stream: model.isGetCardNowClickedStream,
          initialData: false,
          dataBuilder: (context, isValid) {
            return isValid == false
                ? GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity!.isNegative) {
                        ProviderScope.containerOf(context)
                            .read(appHomeViewModelProvider)
                            .pageController
                            .next();
                      } else {
                        ProviderScope.containerOf(context)
                            .read(appHomeViewModelProvider)
                            .pageController
                            .previous();
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 2,
                      color: Theme.of(context).primaryColor,
                      margin: EdgeInsets.zero,
                      shadowColor:
                          Theme.of(context).primaryColorDark.withOpacity(0.32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 23, right: 23, left: 23),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(AssetUtils.blink,
                                    height: 33.64, width: 72),
                                Text(
                                  S.of(context).getLater,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.4)),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 101),
                            child: Image.asset(AssetUtils.line_black_white),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 35),
                            child: Text(
                              "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.",
                              maxLines: 2,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 12, right: 23, left: 23, bottom: 29),
                            child: InkWell(
                              onTap: () {
                                model.updateIsGetCardNowClicked(!isValid!);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 17),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .accentTextTheme
                                        .bodyText1
                                        ?.color,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: Text(
                                    S.of(context).getCardNow,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity!.isNegative) {
                        ProviderScope.containerOf(context)
                            .read(appHomeViewModelProvider)
                            .pageController
                            .next();
                      } else {
                        ProviderScope.containerOf(context)
                            .read(appHomeViewModelProvider)
                            .pageController
                            .previous();
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 2,
                      color: Theme.of(context).primaryColor,
                      margin: EdgeInsets.zero,
                      shadowColor:
                          Theme.of(context).primaryColorDark.withOpacity(0.32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 23, right: 23, left: 23),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(AssetUtils.blink,
                                    height: 33.64, width: 72),
                                InkWell(
                                  onTap: () {
                                    CreditCardDetailDialog.show(context);
                                  },
                                  child: Text(
                                    "Flip Card",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.4)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 61),
                            child: Image.asset(AssetUtils.line_black_white),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 24, top: 53, right: 11),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "0.00",
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            "JOD",
                                            style: TextStyle(
                                                color: AppColor.lightRed,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "TOTAL USED LIMIT",
                                        style: TextStyle(
                                            color: AppColor.veryLightRed,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .accentTextTheme
                                        .bodyText1!
                                        .color,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 25),
                                    child: Text(
                                      "Pay back",
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 19, left: 24, right: 23),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "15000.00",
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.0),
                                          child: Text(
                                            "JOD",
                                            style: TextStyle(
                                                color: AppColor.lightRed,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "AVAILABLE AMOUNT",
                                        style: TextStyle(
                                            color: AppColor.veryLightRed,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                    onTap: () {
                                      model
                                          .updateIsGetCardNowClicked(!isValid!);
                                    },
                                    child: AppSvg.asset(AssetUtils.settingsRed,
                                        color: Theme.of(context).accentColor))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}
