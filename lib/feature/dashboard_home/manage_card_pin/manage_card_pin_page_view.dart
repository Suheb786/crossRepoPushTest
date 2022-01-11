import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class ManageCardPinPageView extends BasePageViewWidget<ManageCardPinViewModel> {
  ManageCardPinPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (!details.primaryVelocity!.isNegative) {
          Navigator.pop(context);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              S.of(context).manageCardPin,
              style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
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
                Card(
                  color: Theme.of(context).accentColor,
                  margin: EdgeInsets.all(24),
                  child: Column(children: [
                    AppStreamBuilder<Resource<bool>>(
                      initialData: Resource.none(),
                      stream: model.unblockCardPinStream,
                      onData: (data) {
                        if (data.data!) {
                          Navigator.pushReplacementNamed(
                              context, RoutePaths.CardPinUnBlockSuccess,
                              arguments: model.manageCardPinArguments);
                        }
                      },
                      dataBuilder: (context, data) {
                        return InkWell(
                          onTap: () {
                            InformationDialog.show(context,
                                image: AssetUtils.cardIcon,
                                title: S.of(context).unBlockPin,
                                description: S
                                    .of(context)
                                    .unBlockPinDescription, onSelected: () {
                              Navigator.pop(context);
                              model.unBlockPin();
                            }, onDismissed: () {
                              Navigator.pop(context);
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  S.of(context).unblockCardPin,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                )),
                                AppSvg.asset(AssetUtils.rightChevron,
                                    width: 20,
                                    height: 20,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1!
                                        .color)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    AppDivider(),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutePaths.ChangeCardPin);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              S.of(context).changeCardPin,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )),
                            AppSvg.asset(AssetUtils.rightChevron,
                                width: 20,
                                height: 20,
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1!
                                    .color)
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
