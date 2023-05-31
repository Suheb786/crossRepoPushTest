import 'dart:developer';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:riverpod/src/framework.dart';
import 'package:show_up_animation/show_up_animation.dart';

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
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 56.h),
      child: Column(
        children: [
          AppStreamBuilder<int>(
              stream: model.currentStep,
              initialData: 0,
              dataBuilder: (context, currentPage) {
                log("get currentStep :: $currentPage");
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
                      activeColor: AppColor.white,
                      color: Theme.of(context).primaryColorLight.withOpacity(0.3)),
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
                              color: Theme.of(context).colorScheme.secondary,
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
                              S.current.enterThe6DigitCodewithExtraString("+912 843 32989"),
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: 20.0.h),
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
                  })),
        ],
      ),
    );
  }
}
