import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/stepone/confirm_detail/confirm_detail_page.dart';
import 'package:neo_bank/feature/register/stepone/enter_address/enter_address_page.dart';
import 'package:neo_bank/feature/register/stepone/id_verification_info/id_verification_info_page.dart';
import 'package:neo_bank/feature/register/stepone/profile_details/profile_details_page.dart';
import 'package:neo_bank/feature/register/stepone/register_step_one_page_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_tilt_card.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class RegisterStepOnePageView
    extends BasePageViewWidget<RegisterStepOneViewModel> {
  RegisterStepOnePageView(ProviderBase model) : super(model);

  List<Widget> pages = [
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
                    color: AppColor.dark_gray,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 8.0, bottom: 32, left: 24, right: 24),
                child: ShowUpAnimation(
                  key: ValueKey(currentStep),
                  delayStart: Duration(milliseconds: 500),
                  animationDuration: Duration(milliseconds: 750),
                  curve: Curves.bounceIn,
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
                        color: AppColor.very_dark_gray,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: pages.length,
                  carouselController: model.pageController,
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
                      viewportFraction: 0.94,
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason) {
                        model.updatePage(index);
                      },
                      enlargeStrategy: CenterPageEnlargeStrategy.scale),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
