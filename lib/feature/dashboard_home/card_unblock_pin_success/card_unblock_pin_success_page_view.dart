import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/card_unblock_pin_success/card_unblock_pin_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CardPinUnBlockSuccessPageView extends BasePageViewWidget<CardPinUnBlockSuccessPageViewModel> {
  CardPinUnBlockSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CardPinUnBlockSuccessPageViewModel model) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta!.isNegative) {
          Navigator.pop(context);
        }
      },
      child: Container(
          height: double.infinity,
          width: double.infinity,
          color: model.manageCardPinArguments.cardType == CardType.CREDIT
              ? Theme.of(context).primaryColor
              : Theme.of(context).canvasColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 92.h),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(AssetUtils.line,
                              color: model.manageCardPinArguments.cardType == CardType.DEBIT
                                  ? Theme.of(context).accentColor.withOpacity(0.4)
                                  : AppColor.softRed),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 111.37.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: model.manageCardPinArguments.cardType == CardType.CREDIT
                                    ? Theme.of(context).canvasColor
                                    : Theme.of(context).primaryColor,
                              ),
                              child: Center(
                                  child: AppSvg.asset(
                                AssetUtils.right,
                                color: model.manageCardPinArguments.cardType == CardType.CREDIT
                                    ? Theme.of(context).primaryColorDark
                                    : Theme.of(context).accentColor,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 34.7.h,
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).cardPinSucccesFullyUnblocked,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w500,
                                fontSize: 24.t,
                                color: model.manageCardPinArguments.cardType == CardType.CREDIT
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).textTheme.bodyText1!.color),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                            child: Text(
                              S.of(context).cardPinSucccesFullyUnblockedDesc,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.t,
                                  color: model.manageCardPinArguments.cardType == CardType.CREDIT
                                      ? Theme.of(context).accentColor
                                      : Theme.of(context).textTheme.bodyText1!.color),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedButton(
                    buttonText: S.of(context).swipeToProceed,
                    textColor: model.manageCardPinArguments.cardType == CardType.CREDIT
                        ? Theme.of(context).accentColor
                        : Theme.of(context).textTheme.bodyText1!.color,
                    borderColor: model.manageCardPinArguments.cardType == CardType.CREDIT
                        ? Theme.of(context).accentColor
                        : Theme.of(context).textTheme.bodyText1!.color,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 32.h,
                    ),
                    child: Center(
                      child: Text(
                        S.of(context).toDashboard,
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: model.manageCardPinArguments.cardType == CardType.CREDIT
                              ? Theme.of(context).accentColor
                              : Theme.of(context).textTheme.bodyText1!.color,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.t,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
