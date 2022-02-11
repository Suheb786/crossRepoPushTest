import 'package:domain/constants/enum/employment_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/feature/register/step_two/job_and_income/job_and_income_page.dart';
import 'package:neo_bank/feature/register/step_two/register_step_two_page_view_model.dart';
import 'package:neo_bank/feature/register/step_two/student_job_income/student_job_income_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class RegisterStepTwoPageView
    extends BasePageViewWidget<RegisterStepTwoViewModel> {
  RegisterStepTwoPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    model.employmentStatusEnum = ProviderScope.containerOf(context)
        .read(profileDetailsPageViewModelProvider)
        .employeeStatusController
        .text
        .fromEmploymentValue();
    List<Widget> pages = [];
    switch (ProviderScope.containerOf(context)
        .read(profileDetailsPageViewModelProvider)
        .employeeStatusController
        .text
        .fromEmploymentValue()) {
      case EmploymentStatusEnum.STUDENT:
      case EmploymentStatusEnum.FREELANCE:
      case EmploymentStatusEnum.RETIRED:
      case EmploymentStatusEnum.UNEMPLOYED:
        pages = [StudentJobIncomePage(), BaseCardPage()];
        break;
      default:
        pages = [
          JobAndIncomePage(
            key: UniqueKey(),
          ),
          BaseCardPage()
        ];
    }
    Future.delayed(Duration(milliseconds: 1000), () {
      model.updatePages(pages);
    });
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          return Column(
            children: [
              Text(
                S.of(context).incomeDetails,
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
                    StepTextHelper.registrationTwoStepTextHelper(
                      currentStep ?? 0,
                      S.of(context).jobIncomeMsg,
                      S.of(context).tellUsHowDoMakeLiving,
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
                child: AppStreamBuilder<List<Widget>>(
                  initialData: [Container()],
                  stream: model.registrationStepTwoPage,
                  dataBuilder: (context, data) {
                    print("dataBuilder $data");
                    return AppSwiper(
                      pageController: model.registrationStepTwoPageController,
                      pages: data!,
                      currentStep: currentStep,
                      onIndexChanged: (index) {
                        model.updatePage(index);
                      },
                    );
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
