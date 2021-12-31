import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/debit_card_settings/debit_card_settings_page_view_model.dart';

class DebitCardSettingsPageView
    extends BasePageViewWidget<DebitCardSettingsPageViewModel> {
  DebitCardSettingsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        // AppStreamBuilder<Resource<bool>>(
        //   initialData: Resource.none(),
        //   stream: model.freezeCardResponseStream,
        //   dataBuilder: (context, data) {
        //     return AppStreamBuilder<bool>(
        //       stream: model.freezeCardStream,
        //       initialData: false,
        //       onData: (value) {
        //         if (value) {
        //           InformationDialog.show(context,
        //               image: AssetUtils.cardIcon,
        //               title: S.of(context).freezeTheCard,
        //               description: S.of(context).freezeDebitCardDescription,
        //               onSelected: () {
        //             Navigator.pop(context);
        //             model.freezeCard();
        //           });
        //         }
        //       },
        //       dataBuilder: (context, data) => SettingTile(
        //         tileIcon: AssetUtils.freezeIcon,
        //         title: S.of(context).freezeThisCard,
        //         onTap: () {},
        //         trailing: CustomSwitch(
        //           activeColor: Theme.of(context).textTheme.bodyText1!.color,
        //           value: data,
        //           onChanged: (value) {
        //             model.toggleFreezeCardStatus(value);
        //           },
        //         ),
        //       ),
        //     );
        //   },
        // ),
        // AppDivider(),
        // AppStreamBuilder<Resource<bool>>(
        //   stream: model.cancelCardResponseStream,
        //   initialData: Resource.none(),
        //   onData: (value) {
        //     Navigator.pop(context);
        //   },
        //   dataBuilder: (context, data) => SettingTile(
        //     tileIcon: AssetUtils.cancelIcon,
        //     title: S.of(context).cancelThisCard,
        //     onTap: () {
        //       CardCancelDialog.show(context,
        //           onSelected: (reasonValue, termSelected) {
        //         model.cancelCard(reasonValue);
        //       });
        //     },
        //   ),
        // ),
        // AppDivider(),
        // SettingTile(
        //     tileIcon: AssetUtils.cardLimitsIcon,
        //     title: S.of(context).manageCardLimits,
        //     onTap: () {
        //       // Navigator.pushNamed(context, RoutePaths.ManageCardLimitsPage);
        //     }),
        // AppDivider(),
        // SettingTile(
        //     tileIcon: AssetUtils.cardPinIcon,
        //     title: S.of(context).manageCardPin,
        //     onTap: () {
        //       // Navigator.pushNamed(context, RoutePaths.ManageCardPin);
        //     }),
        // AppDivider(),
        // SettingTile(
        //     tileIcon: AssetUtils.supplementaryCardIcon,
        //     title: S.of(context).requestSupplementaryCard,
        //     onTap: () {
        //       //Navigator.pushNamed(context, RoutePaths.ApplyCardPage);
        //     }),
        // AppDivider(),
        // SettingTile(
        //     tileIcon: AssetUtils.changeMobileNoIcon,
        //     title: S.of(context).changeLinkedMobileNo,
        //     fontWeight: FontWeight.bold,
        //     textColor: AppColor.gray_1,
        //     onTap: () {}),
        // AppDivider(),
        // SettingTile(
        //     tileIcon: AssetUtils.changeLinkedAccountIcon,
        //     title: S.of(context).changeLinkedAccount,
        //     fontWeight: FontWeight.bold,
        //     textColor: AppColor.gray_1,
        //     onTap: () {}),
        // AppDivider(),
        // SettingTile(
        //     tileIcon: AssetUtils.reportIssueIcon,
        //     title: S.of(context).reportCardIssue,
        //     fontWeight: FontWeight.bold,
        //     textColor: AppColor.gray_1,
        //     onTap: () {}),
        // AppDivider(),
        // SizedBox(height: 10),
        // Text(
        //   S.of(context).actionComeToYouSoon,
        //   style: TextStyle(
        //     color: AppColor.gray_1,
        //     fontWeight: FontWeight.bold,
        //     fontSize: 11,
        //   ),
        // ),
        // SizedBox(height: 10),
      ]),
    );
  }
}
