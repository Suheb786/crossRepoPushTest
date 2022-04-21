import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_linked_mobile_number_view_model.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_enter_new_mobile_number/dc_enter_new_mobile_number_page.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_enter_otp/dc_enter_otp_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class DcChangeLinkedMobileNumberPageView
    extends BasePageViewWidget<DcChangeLinkedMobileNumberViewModel> {
  NavigationType? navigationType;

  DcChangeLinkedMobileNumberPageView(ProviderBase model, this.navigationType)
      : super(model);

  // final List pages = [
  // ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.only(bottom: 47),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          print("current step : $currentStep");
          return GestureDetector(
            onVerticalDragEnd: (details) {
              int sensitivity = 8;
              if (details.primaryVelocity! > sensitivity) {
                Navigator.pop(context);
              } else if (details.primaryVelocity! < -sensitivity) {}
            },
            behavior: HitTestBehavior.translucent,
            child: Padding(
              padding: EdgeInsets.only(top: 72),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).changeLinkedMobileNumber,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 9),
                    child: ShowUpAnimation(
                      key: ValueKey(currentStep),
                      delayStart: Duration(milliseconds: 50),
                      animationDuration: Duration(milliseconds: 750),
                      curve: Curves.easeInOut,
                      direction: Direction.vertical,
                      offset: 0.5,
                      child: Text(
                        StepTextHelper.changeEmailAddressTextHelper(
                          currentStep!,
                          S.of(context).receiveOtpToNewNumber,
                          S.of(context).dcEnterOtpHeader + "\n+962 79 421 5580",
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: AppSwiper(
                          pages: [
                            DcEnterNewMobileNumberPage(),
                            DcEnterOtpPage(),
                            Container()
                          ],
                          pageController: model.pageController,
                          onIndexChanged: (index) {
                            model.updatePage(index);
                            model.updatePageControllerStream(index);
                          },
                          currentStep: currentStep,
                          appSwiperController: model.appSwiperController,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
