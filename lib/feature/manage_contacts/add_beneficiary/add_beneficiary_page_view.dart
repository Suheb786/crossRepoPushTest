import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../../di/manage_contacts/manage_contacts_modules.dart';
import '../../../utils/navgition_type.dart';
import 'add_beneficiary_otp/add_beneficiary_otp_page.dart';
import 'add_beneficiary_page_view_model.dart';
import 'add_contacts_form/add_beneficiary_form_page.dart';

class AddBeneficiaryPageView extends BasePageViewWidget<AddBeneficiaryPageViewModel> {
  AddBeneficiaryPageView(ProviderBase model) : super(model);

  final List<Widget> pages = [
    AddBeneficiaryFormPage(),
    AddBeneficiaryOTPPage(),
  ];

  @override
  Widget build(BuildContext context, AddBeneficiaryPageViewModel model) {
    return Container(
      padding: EdgeInsets.only(top: 56.h),
      child: Column(
        children: [
          AppStreamBuilder<int>(
              stream: model.currentStep,
              initialData: 0,
              dataBuilder: (context, currentPage) {
                return DotsIndicator(
                  dotsCount: pages.length,
                  position: currentPage ?? 0,
                  mainAxisSize: MainAxisSize.max,
                  decorator: DotsDecorator(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeSize: Size(MediaQuery.of(context).size.width / 2.4, 5),
                      size: Size(MediaQuery.of(context).size.width / 2.4, 5),
                      spacing: EdgeInsets.symmetric(horizontal: 1),
                      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeColor: model.arguments.navigationType == NavigationType.SEND_MONEY
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.shadow,
                      color: model.arguments.navigationType == NavigationType.SEND_MONEY
                          ? Theme.of(context).primaryColorLight.withOpacity(0.3)
                          : Theme.of(context).colorScheme.onInverseSurface.withOpacity(0.3)),
                );
              }),
          SizedBox(height: 36.0.h),
          Expanded(
            child: AppStreamBuilder<int>(
              initialData: 0,
              stream: model.currentStep,
              dataBuilder: (context, currentPage) {
                return Column(
                  children: [
                    Text(
                      S.current.addContact.toUpperCase(),
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: model.arguments.navigationType == NavigationType.SEND_MONEY
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.shadow,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8.0.h),
                    ShowUpAnimation(
                      key: ValueKey(currentPage),
                      delayStart: Duration(milliseconds: 50),
                      animationDuration: Duration(milliseconds: 750),
                      curve: Curves.easeInOut,
                      direction: Direction.vertical,
                      offset: 0.5,
                      child: Text(
                        StepTextHelper.addContact_IBAN(
                          currentPage ?? 0,
                          S.current.pleaseEnterYourContactDetails,
                          S.of(context).enterOtpHeader,
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: model.arguments.navigationType == NavigationType.SEND_MONEY
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.shadow,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Visibility(
                      visible: currentPage == 1,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 32.h),
                        child: ShowUpAnimation(
                          delayStart: Duration(milliseconds: 500),
                          animationDuration: Duration(milliseconds: 750),
                          curve: Curves.bounceIn,
                          direction: Direction.vertical,
                          offset: 0.5,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              "${(ProviderScope.containerOf(context).read(addBeneficiaryFormPageViewModel).mobileCode.replaceAll('00', '+'))}" +
                                  " ${ProviderScope.containerOf(context).read(addBeneficiaryFormPageViewModel).mobileNumber}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: model.arguments.navigationType == NavigationType.SEND_MONEY
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).colorScheme.shadow,
                                  fontSize: 20.t,
                                  fontWeight: FontWeight.w600),
                            ),
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
                          model.updatePage(index);
                        },
                        currentStep: currentPage,
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
