import 'package:domain/constants/enum/primary_secondary_enum.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/supplementary_debit_card_pin_set_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ApplyDebitCardWidget extends StatelessWidget {
  final bool isSmallDevice;
  final bool isPinSet;
  final PrimarySecondaryEnum primarySecondaryEnum;
  final String cardHolderName;
  final String cardNo;
  final DebitRoutes debitRoutes;

  const ApplyDebitCardWidget(
      {Key? key, this.isSmallDevice = false, this.isPinSet = true, this.primarySecondaryEnum = PrimarySecondaryEnum.PRIMARY, this.cardHolderName = "", this.cardNo = "", this.debitRoutes = DebitRoutes.DASHBOARD})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.035, vertical: 44),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                padding: EdgeInsetsDirectional.only(top: 23.0.h, end: 23.0.w, start: 23.0.w),
                child: AppSvg.asset(AssetUtils.blink_updated_logo, matchTextDirection: true, height: 33.64.h, width: 72.0.w),
              ),
              Padding(
                padding: EdgeInsets.only(top: 78.0.h),
                child: Align(
                  alignment: Alignment.center,
                  child: AppSvg.asset(AssetUtils.cardCircle, height: 96.0.h),
                ),
              ),
              Padding(
                  padding: EdgeInsetsDirectional.only(top: 12.0.h, start: 10.0.w, end: 10.0.w),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      S.of(context).toEnjoyCardLessPaymentDebit,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 12.0.t, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
                    ),
                  )),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    top: 88.0.h,
                    // bottom: isSmallDevice ? 30 : 50,
                    start: 24.0.w,
                    end: 24.0.w),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      primarySecondaryEnum == PrimarySecondaryEnum.PRIMARY
                          ? Navigator.pushNamed(context, RoutePaths.DebitCardReplacement, arguments: DebitCardReplacementArguments(debitRoutes: debitRoutes, isPinSet: isPinSet, type: DebitReplacementEnum.Normal))
                          : Navigator.pushNamed(context, RoutePaths.SupplementaryDebitCardPinSet,
                              arguments: SupplementaryDebitCardPinSetArguments(type: DebitReplacementEnum.Normal, nameOnCard: cardHolderName, cardNo: cardNo));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 17.0.h),
                      decoration: BoxDecoration(color: Theme.of(context).textTheme.bodyLarge!.color!, borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Text(
                          S.of(context).requestNewDebitcard,
                          style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 12.0.t, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
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
    );
  }
}

enum DebitRoutes { DASHBOARD, DEBIT_SETTING }
