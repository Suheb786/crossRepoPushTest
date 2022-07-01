import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/feature/change_card_pin/change_card_pin_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin/enter_new_pin_for_card/enter_new_pin_for_card_page.dart';
import 'package:neo_bank/feature/change_card_pin/otp_for_change_card_pin/otp_for_change_card_pin_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class ChangeCardPinPageView
    extends BasePageViewWidget<ChangeCardPinPageViewModel> {
  final pages = [
    EnterNewPinForCardPage(),
    OtpForChangeCardPinPage(),
    BaseCardPage()
  ];

  ChangeCardPinPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.pop(context);
        }
      },
      child: Container(
        color: model.changeCardPinArguments.cardType == CardType.DEBIT
            ? Theme.of(context).canvasColor
            : Theme.of(context).primaryColor,
        padding: EdgeInsets.only(top: 56),
        child: AppStreamBuilder<int>(
          stream: model.currentPageStream,
          initialData: 0,
          dataBuilder: (context, currentStep) {
            return Column(
              children: [
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 36),
                        child: Column(
                          children: [
                            Text(
                              S.of(context).changeCardPin.toUpperCase(),
                              style: TextStyle(
                                  color:
                                      model.changeCardPinArguments.cardType ==
                                              CardType.DEBIT
                                          ? Theme.of(context).primaryColorDark
                                          : Theme.of(context).accentColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(
                                  top: 8.0,
                                  bottom: currentStep == 1 ? 0 : 32,
                                  start: 24,
                                  end: 24),
                              child: ShowUpAnimation(
                                key: ValueKey(currentStep),
                                delayStart: Duration(milliseconds: 50),
                                animationDuration: Duration(milliseconds: 750),
                                curve: Curves.easeInOut,
                                direction: Direction.vertical,
                                offset: 0.5,
                                child: Text(
                                  StepTextHelper.changeEmailAddressTextHelper(
                                    currentStep ?? 0,
                                    S.of(context).enterNewCardPinAndConfirmPin,
                                    S.of(context).enterOtpHeader,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: model.changeCardPinArguments
                                                  .cardType ==
                                              CardType.DEBIT
                                          ? Theme.of(context).primaryColorDark
                                          : Theme.of(context).accentColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: currentStep == 1,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 32),
                                child: ShowUpAnimation(
                                  delayStart: Duration(milliseconds: 500),
                                  animationDuration:
                                      Duration(milliseconds: 750),
                                  curve: Curves.bounceIn,
                                  direction: Direction.vertical,
                                  offset: 0.5,
                                  child: Text(
                                    "${ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.mobileCode != null ? (ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.mobileCode!.isNotEmpty ? ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.mobileCode!.replaceAll('00', '+') : '+') : ""}" +
                                        " ${ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.mobileNumber!}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: model.changeCardPinArguments
                                                    .cardType ==
                                                CardType.DEBIT
                                            ? Theme.of(context).primaryColorDark
                                            : Theme.of(context).accentColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: AppSwiper(
                                pages: pages,
                                appSwiperController: model.appSwiperController,
                                pageController: model.swiperController,
                                onIndexChanged: (index) {
                                  model.changeCurrentPage(index);
                                },
                                currentStep: currentStep,
                              ),
                            )
                          ],
                        ))),
              ],
            );
          },
        ),
      ),
    );
  }
}
