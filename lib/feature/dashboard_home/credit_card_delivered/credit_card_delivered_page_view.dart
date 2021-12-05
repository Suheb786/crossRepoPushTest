import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_verification_success/credit_card_verification_success_page.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CreditCardDeliveredPageView
    extends BasePageViewWidget<CreditCardDeliveredViewModel> {
  CreditCardDeliveredPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsets.only(top: 40, right: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () {
                        ProviderScope.containerOf(context)
                            .read(homeViewModelProvider)
                            .homeController
                            .jumpToPage(2);
                      },
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: AppSvg.asset(AssetUtils.close)))),
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 106.0, left: 24),
                    child: GestureDetector(
                      onHorizontalDragEnd: (details) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CreditCardVerificationSuccessPage()));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        color: Theme.of(context).accentColor,
                        margin: EdgeInsets.zero,
                        shadowColor: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.32),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 226),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    "NUMBER ON CARD",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.gray4),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 9),
                                  child: Text(
                                    "9010",
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 78, left: 30, right: 24),
                                  child: Text(
                                    "Yay! Your card has been delivered. Check the number on the back of plastic card and swipe to confirm if its matched with above.",
                                    maxLines: 4,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.gray4),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 75, bottom: 31),
                                  child: AnimatedButton(
                                      buttonText: "Swipe to confirm",
                                      borderColor: Theme.of(context)
                                          .accentTextTheme
                                          .bodyText1!
                                          .color),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 40,
                      right: 16,
                      top: 72,
                      child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.vividYellow,
                              borderRadius: BorderRadius.circular(10.43)),
                          child: Padding(
                              padding: EdgeInsets.only(top: 67, bottom: 26.54),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child:
                                      Image.asset(AssetUtils.ellipseWhite)))))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 36),
                child: Text(
                  "I have delivery issue",
                  style: TextStyle(
                      color: Theme.of(context).accentTextTheme.bodyText1!.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
