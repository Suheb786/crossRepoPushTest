import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_linked_mobile_number_view_model.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_mobile_number_success/dc_change_mobile_number_success_view_model.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact_success/send_amount_to_contact_success_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class DcChangeMobileNumberSuccessPageView
    extends BasePageViewWidget<DcChangeMobileNumberSuccessViewModel> {
  DcChangeMobileNumberSuccessPageView(ProviderBase model) : super(model);

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
        padding: EdgeInsets.only(top: 92, bottom: 56),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(AssetUtils.line,
                        color: Theme.of(context).accentColor.withOpacity(0.4)),
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
                  padding: EdgeInsets.only(top: 56.0),
                  child: Text(
                    S.of(context).cardDetailUpdated,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24.0, left: 40, right: 40),
                  child: Text(
                    S.of(context).dcMobileNumberUpdated,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                AnimatedButton(
                  buttonText: S.of(context).swipeToProceed,
                  borderColor: AppColor.brightBlue,
                  textColor: AppColor.brightBlue,
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.only(top: 9),
                    child: Text(
                      S.of(context).toDashboard,
                      style: TextStyle(
                          color: AppColor.brightBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
