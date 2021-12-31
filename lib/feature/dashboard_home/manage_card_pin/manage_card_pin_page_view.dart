import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ManageCardPinPageView extends BasePageViewWidget<ManageCardPinViewModel> {
  ManageCardPinPageView(ProviderBase model) : super(model);

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text(
                  S.of(context).manageCardPin,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
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
                  Card(
                    color: Theme.of(context).accentColor,
                    margin: EdgeInsets.all(24),
                    child: Column(children: [
                      InkWell(
                        onTap: () {},
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
                      ),
                      AppDivider(),
                      InkWell(
                        onTap: () {},
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
      ),
    );
  }
}
