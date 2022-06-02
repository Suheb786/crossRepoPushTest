import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact_success/send_amount_to_contact_success_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class SendAmountToContactSuccessPageView
    extends BasePageViewWidget<SendAmountToContactSuccessViewModel> {
  SendAmountToContactSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
          ProviderScope.containerOf(context)
              .read(appHomeViewModelProvider)
              .getDashboardData();
          // ProviderScope.containerOf(context)
          //     .read(appHomeViewModelProvider)
          //     .triggerSentMoneyPopup();
        }
      },
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
                      model.arguments.amount.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 28),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, left: 5.0),
                      child: Text(
                        S.of(context).JOD,
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
                  model.arguments.name ?? '',
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
                  model.arguments.iban ?? '',
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
                            model.arguments.referenceNo ?? '',
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
                                  text:
                                      "${TimeUtils.getFormattedDateForCreditCard(model.arguments.transferDate.toString())} - ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "${TimeUtils.getFormattedTimeForTransaction(model.arguments.transferDate.toString())}",
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
              Visibility(
                visible: false,
                child: Padding(
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
              Visibility(
                visible: false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 33),
                      child: Text(
                        S.of(context).undoTransaction,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .accentTextTheme
                                .bodyText1!
                                .color),
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
            ],
          ),
        ),
      ),
    );
  }
}
