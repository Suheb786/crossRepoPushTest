import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_settings/credit_card_settings_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/card/settings_tile.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CreditCardSettingsPageView
    extends BasePageViewWidget<CreditCardSettingsViewModel> {
  CreditCardSettingsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.only(top: 52),
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (!details.primaryVelocity!.isNegative) {
            Navigator.pop(context);
          }
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text(
                S.of(context).creditCardSettings,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              child: Column(
                children: [
                  Container(
                    height: 4,
                    width: 64,
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColor.whiteGray),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(children: [
                        AppStreamBuilder<bool>(
                          stream: model.freezeCardStream,
                          initialData: false,
                          dataBuilder: (context, data) {
                            return SettingTile(
                              onTap: () {
                                model.toggleFreezeCardStatus(!data!);
                              },
                              title: S.of(context).freezeThisCard,
                              tileIcon: AssetUtils.freeze,
                              trailing: FlutterSwitch(
                                value: data!,
                                onToggle: (value) {
                                  model.toggleFreezeCardStatus(value);
                                },
                                width: 60,
                                height: 35,
                                padding: 4,
                                activeText: S.of(context).yes,
                                activeTextColor: AppColor.white,
                                inactiveTextColor: AppColor.darkGray,
                                activeTextFontWeight: FontWeight.w500,
                                showOnOff: true,
                                valueFontSize: 10,
                                activeToggleColor: AppColor.white,
                                inactiveText: S.of(context).no,
                                inactiveToggleColor:
                                    AppColor.lightGrayishMagenta,
                                inactiveTextFontWeight: FontWeight.w500,
                                inactiveSwitchBorder:
                                    Border.all(color: AppColor.gray_2),
                                activeColor: Theme.of(context)
                                    .accentTextTheme
                                    .bodyText1!
                                    .color!,
                                inactiveColor: Theme.of(context).accentColor,
                              ),
                            );
                          },
                        ),
                        SettingTile(
                          onTap: () {},
                          title: S.of(context).cancelThisCard,
                          tileIcon: AssetUtils.cancelCard,
                        ),
                        SettingTile(
                          onTap: () {},
                          title: S.of(context).manageCardLimits,
                          tileIcon: AssetUtils.settingBars,
                        ),
                        SettingTile(
                          onTap: () {},
                          title: S.of(context).manageCardPin,
                          tileIcon: AssetUtils.cardShield,
                        ),
                        SettingTile(
                          onTap: () {},
                          title: S.of(context).requestSupplementarycard,
                          tileIcon: AssetUtils.cardIcon,
                        ),
                        SettingTile(
                          onTap: () {},
                          title: S.of(context).changeLinkedMobileNumber,
                          tileIcon: AssetUtils.mobile,
                          isEnabled: false,
                          isNotify: true,
                        ),
                        SettingTile(
                          onTap: () {},
                          title: S.of(context).changeLinkAccount,
                          tileIcon: AssetUtils.link,
                          isEnabled: false,
                          isNotify: true,
                        ),
                        SettingTile(
                          onTap: () {},
                          title: S.of(context).reportCardIssue,
                          tileIcon: AssetUtils.report,
                          isEnabled: false,
                          isNotify: true,
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
