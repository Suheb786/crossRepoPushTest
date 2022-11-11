import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/apple_pay/apple_pay_success/apple_pay_success_and_error_page.dart';
import 'package:neo_bank/feature/apple_pay/selected_card_for_apple_pay/selected_card_for_apple_pay_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SelectedCardForApplePayPageView extends BasePageViewWidget<SelectedCardForApplePayPageViewModel> {
  SelectedCardForApplePayPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, SelectedCardForApplePayPageViewModel model) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 56.0, right: 24, left: 24),
      child: Column(
        children: [
          Text(
            S.of(context).addToApplePay.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontFamily: StringUtils.appFont,
                fontSize: 10.t,
                fontWeight: FontWeight.w600),
          ),
          Text(
            S.of(context).selectOneCardToAddApplePay,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontFamily: StringUtils.appFont,
                fontSize: 20.t,
                fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 32.h,
              ),
              child: Card(
                margin: EdgeInsets.zero,
                child: Column(children: [
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.only(top: 32.h, left: 24.w, right: 24.w),
                        child: FadingEdgeScrollView.fromSingleChildScrollView(
                          gradientFractionOnStart: 0.2,
                          gradientFractionOnEnd: 0.2,
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            controller: model.scrollController,
                            child: Column(
                              children: [
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model.list[index].cardType ?? '',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 14.t,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 124.w,
                                                height: 190.h,
                                                child: AppSvg.asset(model.list[index].cardImage!),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    model.list[index].cardTypeInformation ?? '',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 16.t,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  AppSvg.asset(AssetUtils.addAppleWalletIcon)
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, int) {
                                      return SizedBox(
                                        height: 32.h,
                                      );
                                    },
                                    itemCount: model.list.length),
                              ],
                            ),
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePaths.ApplePaySuccessAndErrorPage,
                          arguments: ApplePaySuccessAndErrorPageArguments(
                              title: S.of(context).yourNowSetWithApplePay,
                              titleDescription: S.of(context).yourAddOtherCardFromCardSettings,
                              successOrErrorIcon: AssetUtils.right));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 32.0.h),
                      child: Text(
                        S.of(context).backToDashboard,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.brightBlue,
                            fontFamily: StringUtils.appFont,
                            fontSize: 14.t,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
