import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_via_qr_success/send_money_via_qr_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SendMoneyViaQrSuccessPageView extends BasePageViewWidget<SendMoneyViaQrSuccessPageViewModel> {
  SendMoneyViaQrSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
          ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: 92),
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
              padding: EdgeInsets.only(top: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    num.parse(model.arguments.amount).toStringAsFixed(3),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 32),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 8, start: 5.0),
                    child: Text(
                      S.of(context).JOD,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: AppColor.very_light_red,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.0),
              child: Text(
                S.of(context).sentTo,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 24),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24.0),
              child: Text(
                model.arguments.user,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(top: 43, end: 24, start: 24),
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).refno,
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      model.arguments.referenceNo,
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
                    AppSvg.asset(AssetUtils.share, color: Theme.of(context).accentTextTheme.bodyText1!.color),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 11),
                      child: Text(
                        S.of(context).shareMyReceipt,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Theme.of(context).accentTextTheme.bodyText1!.color),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            AnimatedButton(
              buttonText: S.of(context).swipeToProceed,
              borderColor: Theme.of(context).accentColor,
              textColor: Theme.of(context).accentColor,
            ),
            Padding(
              padding: EdgeInsets.only(top: 9, bottom: 24),
              child: Text(
                S.of(context).toDashboard,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).accentColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
