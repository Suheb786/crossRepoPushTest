import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/register_page_model.dart';
import 'package:neo_bank/feature/register/step_four/register_step_four_page.dart';
import 'package:neo_bank/feature/register/step_three/register_step_three_page.dart';
import 'package:neo_bank/feature/register/stepone/register_step_one_page.dart';
import 'package:neo_bank/utils/color_utils.dart';

class RegisterPageView extends BasePageViewWidget<RegisterViewModel> {
  RegisterPageView(ProviderBase model) : super(model);

  List pages = [
    RegisterStepOnePage(),
    RegisterStepThreePage(),
    RegisterStepFourPage(),
    RegisterStepOnePage()
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.only(top: 56),
      child: Stack(
        children: [
          PageView.builder(
            itemCount: pages.length,
            physics: NeverScrollableScrollPhysics(),
            controller: model.registrationStepsController,
            itemBuilder: (context, index) {
              return pages[index];
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: DotsIndicator(
                dotsCount: pages.length,
                position: model.registrationStepsController.positions.isNotEmpty
                    ? model.registrationStepsController.page!
                    : 0,
                decorator: DotsDecorator(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    activeSize: Size(MediaQuery.of(context).size.width / 5, 4),
                    size: Size(MediaQuery.of(context).size.width / 5, 4),
                    spacing: EdgeInsets.symmetric(horizontal: 1),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    activeColor: AppColor.dark_blue,
                    color: AppColor.very_soft_violet.withOpacity(0.3)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
