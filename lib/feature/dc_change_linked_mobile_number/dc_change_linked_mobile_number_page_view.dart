import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dc_change_linked_mobile_number/dc_change_linked_mobile_number_module.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_linked_mobile_number_page.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_linked_mobile_number_view_model.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_enter_new_mobile_number/dc_enter_new_mobile_number_page.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_enter_otp/dc_enter_otp_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class DcChangeLinkedMobileNumberPageView
    extends BasePageViewWidget<DcChangeLinkedMobileNumberViewModel> {
  final DCChangeLinkedMobileNumberArguments arguments;
  final pages = [
    DcEnterNewMobileNumberPage(),
    DcEnterOtpPage(),
    BaseCardPage()
  ];

  DcChangeLinkedMobileNumberPageView(ProviderBase model, this.arguments)
      : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      color: arguments.cardType == CardType.DEBIT
          ? Theme.of(context).canvasColor
          : Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 56),
      child: Column(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 36),
            child: AppStreamBuilder<int>(
              stream: model.currentPageStream,
              initialData: 0,
              dataBuilder: (context, currentStep) {
                return Column(
                  children: [
                    Text(
                      S.of(context).changeLinkedMobileNumber,
                      style: TextStyle(
                          color: arguments.cardType == CardType.DEBIT
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
                            S.of(context).receiveOtpToNewNumber,
                            S.of(context).dcEnterOtpHeader,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: arguments.cardType == CardType.DEBIT
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
                          animationDuration: Duration(milliseconds: 750),
                          curve: Curves.bounceIn,
                          direction: Direction.vertical,
                          offset: 0.5,
                          child: Text(
                            ProviderScope.containerOf(context)
                                .read(dcEnterNewMobileNumberViewModelProvider)
                                .mobileNumberWithCode,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: arguments.cardType == CardType.DEBIT
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
                        pageController: model.pageController,
                        onIndexChanged: (index) {
                          model.changeCurrentPage(index);
                        },
                        currentStep: currentStep,
                      ),
                    )
                  ],
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}
