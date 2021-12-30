import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/payment/request_money_from_contact_success/request_money_from_contact_success_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class RequestAmountFromContactSuccessPageView
    extends BasePageViewWidget<RequestAmountFromContactSuccessViewModel> {
  RequestAmountFromContactSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity!.isNegative) {
            Navigator.popUntil(
                context, ModalRoute.withName(RoutePaths.AppHome));
            ProviderScope.containerOf(context)
                .read(appHomeViewModelProvider)
                .getDashboardData();
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
                    Image.asset(AssetUtils.line,
                        color: Theme
                            .of(context)
                            .accentColor
                            .withOpacity(0.4)),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 111.37,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Center(
                            child: AppSvg.asset(AssetUtils.right,
                                color: Theme.of(context).accentColor)),
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
                        model.successValues[0],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 28),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8, left: 5.0),
                        child: Text(
                          "JOD",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.5),
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
                    S.of(context).requestedFrom,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    model.successValues[1],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    model.successValues[2],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:
                        Theme.of(context).primaryColorDark.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 64.0),
                  child: Text(
                    S.of(context).youWillBeNotified,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:
                        Theme.of(context).primaryColorDark.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 130),
                  child: AnimatedButton(
                    buttonText: S.of(context).swipeToProceed,
                    borderColor:
                    Theme.of(context).accentTextTheme.bodyText1!.color,
                    textColor:
                    Theme.of(context).accentTextTheme.bodyText1!.color,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(top: 9),
                    child: Text(
                      S.of(context).toDashboard,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context)
                              .accentTextTheme
                              .bodyText1!
                              .color),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 33),
                  child: Text(
                    S.of(context).undoRequest,
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
                    ),
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
