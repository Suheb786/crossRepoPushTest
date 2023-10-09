import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../main/navigation/route_paths.dart';
import '../../../../ui/molecules/card/settings_tile.dart';
import '../../../../utils/asset_utils.dart';

class AppHomePageWidgets {
  /// TOP TOTAL WIDGET ...
  static Widget totalBalance(
    String availableBalance,
  ) {
    return Builder(builder: (context) {
      return Column(
        children: [
          Text(
            S.of(context).totalBalance,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w400,
                fontSize: 18.0.t,
                color: AppColor.black),
          ),
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '$availableBalance ',
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 24.0.t,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColorDark)),
                TextSpan(
                  text: S.of(context).JOD,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0.t,
                      color: AppColor.verLightGray4),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

///------------------------------Transfer Between Account Tile-------------------------///

class TransferBetweenAccountTile extends StatelessWidget {
  bool? isVisible;
  bool isEnabled;
  bool isCardActivated;
  dynamic Function() onTap;

  TransferBetweenAccountTile({
    Key? key,
    this.isVisible,
    required this.isEnabled,
    required this.isCardActivated,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible ?? true,
      child: SettingTile(
        isEnabled: isEnabled,
        isCardActivated: isCardActivated,
        tileIcon: AssetUtils.transferBetweenAccountIcon,
        title: S.current.transferBetweenAccount,
        onTap: onTap,
      ),
    );
  }
}

///------------------------------Share Account Tile-------------------------///

SettingTile ShareAccountTile(
    {required BuildContext context,
    required AppHomeViewModel model,
    bool isCardActivated = true,
    bool isEnabled = true}) {
  void _shareFiles(BuildContext context, Account? account) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
        'Hello! Here are my Blink account details: \n\n${account?.accountTitle ?? ''} \n${account?.accountNo ?? ''} \n${account?.iban ?? '-'}\n\nOpen your Blink account today.',
        subject: 'Share account info',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  return SettingTile(
    isCardActivated: isCardActivated,
    isEnabled: isEnabled,
    tileIcon: AssetUtils.shareAccountInfoIcon,
    title: S.current.shareAccountInformation,
    onTap: () {
      _shareFiles(context, model.selectedAccount);
    },
  );
}

///------------------------------Open Sub Account Tile-------------------------///

class OpenSubAccountTile extends StatelessWidget {
  bool isEnabled;
  bool isCardActivated;
  AppHomeViewModel model;

  OpenSubAccountTile({
    Key? key,
    required this.isCardActivated,
    required this.isEnabled,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingTile(
      isEnabled: isEnabled,
      isCardActivated: isCardActivated,
      tileIcon: AssetUtils.openSubAccountIcon,
      title: S.current.openSubAccount,
      onTap: () {
        return InformationDialog.show(context,
            title: S.current.openSubAccount,
            descriptionWidget: Text(S.current.openSubAccountDescription),
            image: AssetUtils.openSubAccountIcon,
            imageHight: 40.h,
            imageWidth: 40.w, onSelected: () {
          Navigator.pop(context);
          model.getAccount();
        }, onDismissed: () {
          Navigator.pop(context);
        });
      },
    );
  }
}

///------------------------------Add Money Tile-------------------------///

class AddMoneyTile extends StatelessWidget {
  const AddMoneyTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingTile(
      tileIcon: AssetUtils.addMoneyIcon,
      title: S.current.addMoney,
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.AddMoneyOptionSelector);
      },
    );
  }
}

///------------------------------Close Sub Account Tile-------------------------///

class CloseSubAccount extends StatelessWidget {
  bool isEnabled;
  bool isCardActivated;
  AppHomeViewModel model;

  CloseSubAccount({Key? key, this.isCardActivated = true, this.isEnabled = true, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingTile(
      isEnabled: isEnabled,
      isCardActivated: isCardActivated,
      tileIcon: AssetUtils.closeSubAccountIcon,
      title: S.current.closeSubAccount,
      onTap: () {
        if (num.parse(model.selectedAccount?.availableBalance ?? '0') > 0) {
          model.showToastWithError(AppError(
              cause: Exception(),
              error: ErrorInfo(message: ''),
              type: ErrorType.TRANSFER_REMAINING_BALANCE_TO_CLOSE_ACCOUNT));
        } else {
          InformationDialog.show(context,
              title: S.current.closeSubAccount,
              descriptionWidget: Text(S.current.closeSubAccountDescription),
              image: AssetUtils.closeSubAccountIcon,
              imageHight: 40.h,
              imageWidth: 40.w, onSelected: () {
            Navigator.pop(context);
            model.closeSubAccount(
                iban: model.selectedAccount?.iban ?? "",
                subAccountNo: model.selectedAccount?.accountNo ?? "");
          }, onDismissed: () {
            Navigator.pop(context);
          });
        }
      },
    );
  }
}
