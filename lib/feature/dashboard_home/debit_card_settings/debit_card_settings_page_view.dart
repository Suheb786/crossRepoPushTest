import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/error/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_page.dart';
import 'package:neo_bank/feature/manage_debit_card_limits/manage_debit_card_limits_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/card/settings_tile.dart';
import 'package:neo_bank/ui/molecules/custom_bullet_with_title_widget.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/card_cancel_dialog/card_cancel_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class DebitCardSettingsPageView
    extends BasePageViewWidget<DebitCardSettingsViewModel> {
  DebitCardSettingsPageView(ProviderBase model) : super(model);

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
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 48),
                  height: 50,
                  decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16))),
                ),
                Positioned(
                    bottom: -8, child: AppSvg.asset(AssetUtils.swipeDown)),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                S.of(context).backToDashboard,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColor.dark_gray_1),
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
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(children: [
                        AppStreamBuilder<bool>(
                          stream: model.freezeCardStream,
                          initialData: false,
                          onData: (value) {
                            if (value) {
                              InformationDialog.show(context,
                                  image: AssetUtils.cardFreeze,
                                  title: S.of(context).freezeTheCard,
                                  descriptionWidget: Column(
                                    children: [
                                      Text(
                                          S
                                              .of(context)
                                              .acknowledgeBeforeFreezingCard,
                                          style: TextStyle(
                                              fontSize: 14, height: 1.7)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: CustomBulletWithTitle(
                                          title: S
                                              .of(context)
                                              .cardcantBeUsedForTransactions,
                                          fontSize: 14,
                                          lineHeight: 1.7,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: CustomBulletWithTitle(
                                          title: S
                                              .of(context)
                                              .directDebitsWontBeMade,
                                          fontSize: 14,
                                          lineHeight: 1.7,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: CustomBulletWithTitle(
                                          title: S
                                              .of(context)
                                              .freezeAndActiveAtAnyTime,
                                          fontSize: 14,
                                          lineHeight: 1.7,
                                        ),
                                      ),
                                    ],
                                  ), onSelected: () {
                                Navigator.pop(context);
                                model.freezeCard();
                              }, onDismissed: () {
                                Navigator.pop(context);
                              });
                            }
                          },
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
                        AppStreamBuilder<Resource<bool>>(
                          initialData: Resource.none(),
                          stream: model.cancelCardResponseStream,
                          onData: (data) {},
                          dataBuilder: (context, data) {
                            return SettingTile(
                              onTap: () {
                                CardCancelDialog.show(context,
                                    onSelected: (reasonValue) {
                                  Navigator.pop(context);
                                  model.cancelCard(reasonValue);
                                }, onDismissed: () {
                                  Navigator.pop(context);
                                }, onError: (AppError error) {
                                  model.showToastWithError(error);
                                });
                              },
                              title: S.of(context).cancelThisCard,
                              tileIcon: AssetUtils.cancelCard,
                            );
                          },
                        ),
                        SettingTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutePaths.manageDebitLimit,
                                arguments: ManageCardLimitsArguments(
                                    cardType: CardType.DEBIT));
                          },
                          title: S.of(context).manageCardLimits,
                          tileIcon: AssetUtils.settingBars,
                        ),
                        SettingTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RoutePaths.ManageCardPin,
                                arguments: ManageCardPinArguments(
                                    cardType: CardType.DEBIT));
                          },
                          title: S.of(context).manageCardPin,
                          tileIcon: AssetUtils.cardShield,
                        ),
                        SettingTile(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, RoutePaths.SupplementaryDebitCard);
                          },
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
                        Text(
                          S.of(context).actionComeToYouSoon,
                          style: TextStyle(
                            color: AppColor.gray_1,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(height: 10),
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
