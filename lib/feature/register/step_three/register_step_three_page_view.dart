import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/feature/register/step_three/purpose_of_account_opening/purpose_of_account_opening_page.dart';
import 'package:neo_bank/feature/register/step_three/register_step_three_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class RegisterStepThreePageView
    extends BasePageViewWidget<RegisterStepThreeViewModel> {
  RegisterStepThreePageView(ProviderBase model) : super(model);

  final List<Widget> pages = [
    PurposeOfAccountOpeningPage(),
    //Expanded(child: Container())
    BaseCardPage()
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          return Column(
            children: [
              Text(
                S.of(context).accountDetails,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 8.0, bottom: 32, left: 24, right: 24),
                child: ShowUpAnimation(
                  key: ValueKey(currentStep),
                  delayStart: Duration(milliseconds: 50),
                  animationDuration: Duration(milliseconds: 750),
                  curve: Curves.easeInOut,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Text(
                    StepTextHelper.registrationThreeStepTextHelper(
                      currentStep ?? 0,
                      S.of(context).accountRelatedQuestions,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: AppSwiper(
                  key: ValueKey(currentStep),
                  appSwiperController: model.appSwiperController,
                  pageController: model.registrationStepThreePageController,
                  pages: pages,
                  currentStep: currentStep,
                  onIndexChanged: (index) {
                    model.updatePage(index);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
