import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/my_debit_card/my_debit_card_view_model.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/debit_card_detail/debit_card_detail_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class MyDebitCardPageView extends BasePageViewWidget<MyDebitCardViewModel> {
  MyDebitCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity!.isNegative) {
              } else {
                ProviderScope.containerOf(context)
                    .read(appHomeViewModelProvider)
                    .pageController
                    .previous();
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 2,
              color: Theme.of(context).canvasColor,
              margin: EdgeInsets.zero,
              shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
              child: Padding(
                padding: EdgeInsets.only(left: 27.0, top: 30, bottom: 29),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Debit Card",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 23.0),
                          child: InkWell(
                            onTap: () {
                              print("tapped");
                              DebitCardDetailDialog.show(context);
                            },
                            child: Text(
                              "Flip card",
                              style: TextStyle(
                                  color: AppColor.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: AppSvg.asset(AssetUtils.blinkBlack),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 21),
                          child: Text(
                            "Zein Malhas",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 76, left: 41),
                          child: AppSvg.asset(AssetUtils.zigzagCircle),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 36,
                          width: 105,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context)
                                  .accentTextTheme
                                  .bodyText1!
                                  .color),
                          child: Center(
                            child: Text(
                              "Add money",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 33.0),
                          child: AppSvg.asset(AssetUtils.settingsRed),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              height: 24,
              width: 125,
              decoration: BoxDecoration(
                  color: AppColor.darkGrey,
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Text(
                  "Card delivered?",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
