import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact_success/send_amount_to_contact_success_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class SendAmountToContactSuccessPageView
    extends BasePageViewWidget<SendAmountToContactSuccessViewModel> {
  SendAmountToContactSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: GestureDetector(
        child: Padding(
          padding: EdgeInsets.only(top: 92),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(AssetUtils.line),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 111.37,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.vividYellow,
                        ),
                        child: Center(child: AppSvg.asset(AssetUtils.right)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 11.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "35.00",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 28),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8, left: 5.0),
                        child: Text(
                          "JOD",
                          style: TextStyle(
                              color: AppColor.very_light_red,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: Text(
                    S.of(context).sentTo,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Rose",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    "ABC000012341234123819241213",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.very_light_red,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 43, right: 24, left: 24),
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).refno,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "984893922",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).date,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: "16 Dec 2021 - ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "3:30 pm",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.dark_gray_1),
                                  )
                                ]),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 23),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppSvg.asset(AssetUtils.share,
                          color: Theme.of(context)
                              .accentTextTheme
                              .bodyText1!
                              .color),
                      Padding(
                        padding: EdgeInsets.only(left: 11),
                        child: Text(
                          S.of(context).shareMyReceipt,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Theme.of(context)
                                  .accentTextTheme
                                  .bodyText1!
                                  .color),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 76),
                  child: AnimatedButton(
                    buttonText: S.of(context).swipeToProceed,
                    borderColor: Theme.of(context).accentColor,
                    textColor: Theme.of(context).accentColor,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(top: 9),
                    child: Text(
                      S.of(context).toDashboard,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 33),
                  child: Text(
                    S.of(context).undoTransaction,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color:
                            Theme.of(context).accentTextTheme.bodyText1!.color),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    "0:07",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
