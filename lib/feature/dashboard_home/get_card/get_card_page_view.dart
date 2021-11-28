import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/dashboard_home/get_card/get_card_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class GetCardPageView extends BasePageViewWidget<GetCardViewModel> {
  GetCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          ProviderScope.containerOf(context)
              .read(appHomeViewModelProvider)
              .pageController
              .next();
        } else {
          ProviderScope.containerOf(context)
              .read(appHomeViewModelProvider)
              .pageController
              .previous();
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        color: Theme.of(context).primaryColor,
        margin: EdgeInsets.zero,
        shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 23, right: 23, left: 23),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(AssetUtils.blink, height: 33.64, width: 72),
                    Text(
                      S.of(context).getLater,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color:
                              Theme.of(context).accentColor.withOpacity(0.4)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 101),
                child: Image.asset(AssetUtils.line_black_white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 35),
                child: Text(
                  "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.",
                  maxLines: 2,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 12, right: 23, left: 23, bottom: 29),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentTextTheme.bodyText1?.color,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: Text(
                      S.of(context).getCardNow,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}