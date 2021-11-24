import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/my_dashboard/get_card/get_card_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class GetCardPageView extends BasePageViewWidget<GetCardViewModel> {
  GetCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: Container(
      height: double.infinity,
      color: Theme.of(context).accentColor,
      child: Padding(
        padding: EdgeInsets.only(left: 47, right: 47, top: 85),
        child: Column(
          children: [
            Text(
              "Total Balance",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: AppColor.black),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("0.00",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColorDark)),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text("JOD",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColor.verLightGray4)),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: AppSvg.asset(AssetUtils.swipeDown),
            ),
            Padding(
              padding: EdgeInsets.only(top: 13),
              child: Container(
                height: 451,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 23, right: 23, left: 23),
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
                                color: Theme.of(context).accentColor),
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
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 17),
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
