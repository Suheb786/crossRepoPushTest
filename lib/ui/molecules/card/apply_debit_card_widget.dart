import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class ApplyDebitCardWidget extends StatelessWidget {
  final bool isSmallDevice;
  final bool isPinSet;

  const ApplyDebitCardWidget(
      {Key? key, this.isSmallDevice: false, this.isPinSet: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(15),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          color: Theme.of(context).canvasColor,
          margin: EdgeInsets.zero,
          shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AssetUtils.zigzagDebit),
              scale: isSmallDevice ? 1.3 : 1,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 23, right: 23, left: 23),
                  child: AppSvg.asset(AssetUtils.blink_updated_logo,
                      height: isSmallDevice ? 26 : 33.64,
                      width: isSmallDevice ? 52 : 72),
                ),
                Padding(
                  padding: EdgeInsets.only(top: isSmallDevice ? 50 : 78),
                  child: Align(
                    alignment: Alignment.center,
                    child: AppSvg.asset(AssetUtils.cardCircle,
                        height: isSmallDevice ? 72 : 96),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 12, left: 10, right: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).toEnjoyCardLessPaymentDebit,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: isSmallDevice ? 10 : 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor),
                      ),
                    )),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: isSmallDevice ? 50 : 88,
                      // bottom: isSmallDevice ? 30 : 50,
                      start: isSmallDevice ? 34 : 24,
                      end: isSmallDevice ? 34 : 24),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RoutePaths.DebitCardReplacement,
                            arguments: DebitCardReplacementArguments(
                                isPinSet: isPinSet,
                                type: DebitReplacementEnum.Normal));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .accentTextTheme
                                .bodyText1
                                ?.color,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Text(
                            S.of(context).requestNewDebitcard,
                            style: TextStyle(
                                fontSize: isSmallDevice ? 10 : 12,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
