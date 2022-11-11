import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/dialog/apple_pay/apple_pay_landing_page_dialog/apple_pay_landing_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'apple_pay_launcher_page_view_model.dart';

class ApplePayLauncherPageView extends BasePageViewWidget<ApplePayLauncherPageViewModel> {
  ApplePayLauncherPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ApplePayLauncherPageViewModel model) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ApplePayDialog.show(context,
              image: AssetUtils.applePayLogo,
              title: S.of(context).blinkWithApplePay,
              descriptionWidget: Text(
                S.of(context).blinkWithApplePayLandingDialogDescription,
                style:
                    TextStyle(fontFamily: StringUtils.appFont, fontSize: 14.t, fontWeight: FontWeight.w400),
              ), onDismissed: () {
            Navigator.pop(context);
          }, onSelected: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RoutePaths.SelectedCardForApplePayPage);
            // model.sendOtpTokenMobile();
          });
        },
        child: const Text('ApplePay Launcher Screen'),
      ),
    );
  }
}
