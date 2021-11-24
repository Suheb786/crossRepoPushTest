import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/stepone/confirm_detail/confirm_detail_page.dart';
import 'package:neo_bank/feature/register/stepone/enter_address/enter_address_page.dart';
import 'package:neo_bank/feature/register/stepone/id_verification_info/id_verification_info_page.dart';
import 'package:neo_bank/feature/register/stepone/profile_details/profile_details_page.dart';
import 'package:neo_bank/feature/register/stepone/register_step_one_page_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class RegisterStepOnePageView
    extends BasePageViewWidget<RegisterStepOneViewModel> {
  RegisterStepOnePageView(ProviderBase model) : super(model);

  final pages = [
    IdVerificationInfoPage(),
    ConfirmDetailPage(),
    EnterAddressPage(),
    ProfileDetailsPage()
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
                S.of(context).personalDetails,
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
                    StepTextHelper.registrationFirstStepTextHelper(
                      currentStep ?? 0,
                      S.of(context).idVerificationInfoHeader,
                      S.of(context).pleaseConfirmYourIDDetailsBelow,
                      S.of(context).whereDoYouCurrentlyLive,
                      S.of(context).tellUsAboutYourProfile,
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
                  pages: pages,
                  pageController: model.pageController,
                  onIndexChanged: (index) {
                    model.updatePage(index);
                  },
                  currentStep: currentStep,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
