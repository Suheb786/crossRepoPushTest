import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/purpose_of_account_opening/purpose_of_account_opening_dialog_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class EngagementTeamDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;

  const EngagementTeamDialogView({
    this.onDismissed,
    this.onSelected,
  });

  ProviderBase providerBase() {
    return purposeOfAccountOpeningDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PurposeOfAccountOpeningDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            insetPadding:
                EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 340),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Center(
                    child: Text(
                      S.of(context).engagementTeam,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 32.0, left: 24.0, right: 24.0),
                    child: Text(
                      S.of(context).engagementTeamDescription,
                      style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          color: AppColor.very_dark_gray_black),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                InkWell (
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RoutePaths.HelpCenter);
                  },
                  child: Container(
                    height: 72,
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.brightBlue),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 18.11),
                            height: 25,
                            width: 25,
                            child: AppSvg.asset(
                              AssetUtils.voiceCall,
                              color: Theme.of(context).primaryColorDark,
                            )),
                        Text(
                          S.of(context).voiceCall,
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 72,
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.brightBlue),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 18.11),
                          height: 25,
                          width: 25,
                          child: AppSvg.asset(
                            AssetUtils.liveChat,
                            color: Theme.of(context).primaryColorDark,
                          )),
                      Text(
                        S.of(context).liveChat,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 56),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                  child: Center(
                    child: Text(
                      S.of(context).swipeDownToCancel,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColor.dark_gray_1),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        providerBase: providerBase());
  }
}
