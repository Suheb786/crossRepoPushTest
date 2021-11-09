import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_two/job_and_income/job_and_income_page.dart';
import 'package:neo_bank/feature/register/step_two/register_step_two_page_view_model.dart';
import 'package:neo_bank/feature/register/step_two/student_job_income/student_job_income_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_tilt_card.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class RegisterStepTwoPageView
    extends BasePageViewWidget<RegisterStepTwoViewModel> {
  RegisterStepTwoPageView(ProviderBase model) : super(model);

  List<Widget> pages = [
    JobAndIncomePage(),
    StudentJobIncomePage(),
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
                S.of(context).jobAndIncome,
                style: TextStyle(
                    color: AppColor.dark_gray,
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
                    StepTextHelper.registrationTwoStepTextHelper(
                      currentStep ?? 0,
                      S.of(context).jobIncomeMsg,
                      S.of(context).tellUsHowDoMakeLiving,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.very_dark_gray,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: pages.length,
                  carouselController: model.registrationStepTwoPageController,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      AppTiltCard(
                          pageViewIndex: pageViewIndex,
                          currentPage: currentStep,
                          child: pages[itemIndex]),
                  options: CarouselOptions(
                      height: double.maxFinite,
                      pageSnapping: true,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.88,
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason) {
                        model.updatePage(index);
                      },
                      enlargeStrategy: CenterPageEnlargeStrategy.height),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
