import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/feature/payment/request_from_new_recipient/request_from_new_recipient_page.dart';
import 'package:neo_bank/feature/payment/request_payment_from_new_recipient/request_payment_from_new_recipient_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class RequestPaymentFromNewRecipientPageView
    extends BasePageViewWidget<RequestPaymentFromNewRecipientViewModel> {
  RequestPaymentFromNewRecipientPageView(ProviderBase model) : super(model);

  final pages = [
    RequestFromNewRecipientPage(),
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
              } else {
                Navigator.pop(context);
              }
            },
            onTap: () {},
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
                        activeSize: Size(
                            (MediaQuery.of(context).size.width - 50) / 1, 4),
                        size: Size(
                            (MediaQuery.of(context).size.width - 50) / 1, 4),
                        spacing: EdgeInsets.symmetric(horizontal: 1),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        activeColor: Theme.of(context).primaryColorDark,
                        color: Theme.of(context)
                            .primaryColorDark
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
                              S.of(context).requesting,
                              style: TextStyle(fontSize: 20),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 6),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppStreamBuilder<bool>(
                                      stream: model.editAmountStream,
                                      initialData: false,
                                      dataBuilder: (context, isEdit) {
                                        return isEdit!
                                            ? Container(
                                                height: 28,
                                                width: 100,
                                                child: TextField(
                                                  autofocus: true,
                                                  style: TextStyle(
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  cursorColor: Theme.of(context)
                                                      .accentColor,
                                                  controller: model
                                                      .editAmountController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 10),
                                                  ),
                                                  onSubmitted: (value) {
                                                    model.sendValue = value;
                                                    print(
                                                        "got model send value:  ${model.sendValue!}");
                                                    ProviderScope.containerOf(
                                                                context)
                                                            .read(
                                                                requestMoneyViewModelProvider)
                                                            .currentPinValue =
                                                        model.sendValue!;
                                                    model.updateEditAmount(
                                                        false);
                                                  },
                                                ),
                                              )
                                            : Text(
                                                double.parse(model.sendValue!)
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                    fontSize: 28,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              );
                                      }),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "JOD",
                                      style: TextStyle(
                                          color: AppColor.very_dark_gray1,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: AppStreamBuilder<bool>(
                                  stream: model.editAmountStream,
                                  initialData: false,
                                  dataBuilder: (context, value) {
                                    return InkWell(
                                      onTap: () {
                                        if (!value!) {
                                          model.updateEditAmount(true);
                                        }
                                      },
                                      child: Text(
                                        S.of(context).tapToEdit,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColor.very_dark_gray1),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              S.of(context).requestMoney,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 10),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                S.of(context).enterCode,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
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
