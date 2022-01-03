import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/help_center/call_ended/call_ended_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CallEndedPageView extends BasePageViewWidget<CallEndedPageViewModel> {
  CallEndedPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.pushReplacementNamed(context, RoutePaths.AppHome);
        }
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 92),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AssetUtils.line),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 112.37,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.vividYellow,
                      ),
                      child: Center(child: AppSvg.asset(AssetUtils.right)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              '05 : 42',
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 32),
            ),
            Text(
              S.of(context).callHasEnded,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            ),
            SizedBox(height: 56),
            Text(
              S.of(context).thankYouForContacting,
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.5,
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            Spacer(),
            Column(
              children: [
                AnimatedButton(
                  buttonText: S.of(context).swipeToProceed,
                  textColor: Theme.of(context).accentColor,
                  borderColor: Theme.of(context).accentColor,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 14.0),
                  child: Text(
                    S.of(context).toDashboard,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
