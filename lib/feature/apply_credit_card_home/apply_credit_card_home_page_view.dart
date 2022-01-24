import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/feature/apply_credit_card_home/apply_credit_card_home_view_model.dart';
import 'package:neo_bank/feature/set_credit_limit/set_credit_limit_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';

class ApplyCreditCardHomePageView
    extends BasePageViewWidget<ApplyCreditCardHomeViewModel> {
  ApplyCreditCardHomePageView(ProviderBase model) : super(model);

  final pages = [
    SetCreditLimitPage(),
    Visibility(visible: true, child: BaseCardPage())
  ];

  @override
  Widget build(BuildContext context, ApplyCreditCardHomeViewModel model) {
    return Padding(
      padding: EdgeInsets.only(top: 56, bottom: 56),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          print("got current step : $currentStep");
          return GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity!.isNegative) {
              } else {
                Navigator.pop(context);
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 96),
                  child: Text(
                    S.of(context).applyCreditCardTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: Theme.of(context).accentColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, left: 10, right: 10),
                  child: Text(
                    S.of(context).personalizeCreditCard,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Theme.of(context).accentColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 22),
                    child: AppSwiper(
                      pages: pages,
                      pageController: model.pageController,
                      onIndexChanged: (index) {
                        // model.changeCurrentPage(index);
                        model.updatePage(index);
                      },
                      currentStep: currentStep,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
