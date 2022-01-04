import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/feature/payment/enter_otp/enter_otp_page.dart';
import 'package:neo_bank/feature/payment/payment_to_new_recipient/payment_to_new_recipient_view_model.dart';
import 'package:neo_bank/feature/payment/send_to_new_recipient/send_to_new_recipient_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class PaymentToNewRecipientPageView
    extends BasePageViewWidget<PaymentToNewRecipientViewModel> {
  PaymentToNewRecipientPageView(ProviderBase model) : super(model);

  final pages = [
    SendToNewRecipientPage(),
    EnterOtpPage(),
    Visibility(visible: false, child: BaseCardPage())
  ];

  @override
  Widget build(BuildContext context, model) {
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
                print("got current step : $currentStep");
              } else {
                ProviderScope.containerOf(context)
                    .read(paymentToNewRecipientViewModelProvider)
                    .pageController
                    .previous();
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: DotsIndicator(
                    dotsCount: pages.length - 1,
                    position: currentStep!.toDouble(),
                    decorator: DotsDecorator(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        activeSize:
                            Size((MediaQuery.of(context).size.width) / 2.5, 4),
                        size:
                            Size((MediaQuery.of(context).size.width) / 2.5, 4),
                        spacing: EdgeInsets.symmetric(horizontal: 1),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        activeColor: Theme.of(context).accentColor,
                        color: Theme.of(context)
                            .primaryColorLight
                            .withOpacity(0.3)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 37),
                  child: ShowUpAnimation(
                    key: ValueKey(currentStep),
                    delayStart: Duration(milliseconds: 50),
                    animationDuration: Duration(milliseconds: 750),
                    curve: Curves.easeInOut,
                    direction: Direction.vertical,
                    offset: 0.5,
                    child: StepTextHelper.paymentToNewRecipientStepTextHelper(
                        currentStep,
                        Column(
                          children: [
                            Text(
                              S.of(context).sending,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 20),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    ProviderScope.containerOf(context)
                                        .read(sendMoneyViewModelProvider)
                                        .currentPinValue,
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "JOD",
                                      style: TextStyle(
                                          color: AppColor.very_light_red,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Text(
                                S.of(context).tapToEdit,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: AppColor.very_light_red),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              S.of(context).sendMoney,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                S.of(context).enterCode,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Theme.of(context).accentColor),
                              ),
                            )
                          ],
                        )),
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
