import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/add_new_mobile_number/add_new_mobile_number_page.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/change_mobile_number_page_view_model.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

import 'enter_code_for_change_mobile_number/enter_code_for_change_mobile_number_page.dart';

class ChangeMobileNumberPageView extends BasePageViewWidget<ChangeMobileNumberPageViewModel> {
  final pages = [AddNewMobileNumberPage(), EnterCodeForChangeMobileNumberPage(), BaseCardPage()];

  ChangeMobileNumberPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 56.h),
      child: AppStreamBuilder<int>(
        stream: model.currentPageStream,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          return Column(
            children: [
              Visibility(
                visible: currentStep == 0,
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: 24.0.w),
                      child: AppSvg.asset(AssetUtils.leftArrow,
                          matchTextDirection: true, color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 36.h),
                      child: Column(
                        children: [
                          Text(
                            S.of(context).changeMobileNumber,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 10.t,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 8.0.h, bottom: currentStep == 1 ? 0 : 32.h, start: 24.w, end: 24.w),
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
                                  S.of(context).enterNewMobileNo,
                                  S.of(context).enterOtpHeader,
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 20.t,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: currentStep == 1,
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
                                    ProviderScope.containerOf(context)
                                        .read(addNewMobileNumberViewModelProvider)
                                        .mobileNumberWithCode,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).colorScheme.secondary,
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
                              pageController: model.swiperController,
                              onIndexChanged: (index) {
                                model.changeCurrentPage(index);
                              },
                              currentStep: currentStep,
                            ),
                          )
                        ],
                      ))),
            ],
          );
        },
      ),
    );
  }
}
