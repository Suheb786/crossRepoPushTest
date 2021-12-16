import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/placeholder/placeholder_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class PlaceholderPageView extends BasePageViewWidget<PlaceholderViewModel> {
  PlaceholderPageView(ProviderBase model) : super(model);
  bool isGetCardClicked = false;

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Center(
        child: AspectRatio(
          aspectRatio: 0.62,
          child: GestureDetector(
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
              color: Theme.of(context).primaryColor,
              margin: EdgeInsets.zero,
              shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetUtils.placeholder),
                        fit: BoxFit.fill)),
                child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      padding: EdgeInsets.only(top: 232),
                      child: Column(
                        children: [
                          Text(S.of(context).bornBlink,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700)),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              S.of(context).spendJod,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 30, left: 24, right: 24),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .accentTextTheme
                                      .bodyText1!
                                      .color,
                                  borderRadius: BorderRadius.circular(100)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 71, vertical: 16),
                              child: Center(
                                  child: Text(
                                S.of(context).findOutMore,
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
