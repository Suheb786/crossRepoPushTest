import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/register_page_model.dart';
import 'package:neo_bank/feature/register/step_five/register_step_five_page.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';

class RegisterPageView extends BasePageViewWidget<RegisterViewModel> {
  RegisterPageView(ProviderBase model) : super(model);

  List pages = [
    // RegisterStepOnePage(),
    // RegisterStepTwoPage(),
    // RegisterStepThreePage(),
    // RegisterStepFourPage(),
    RegisterStepFivePage()
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.only(top: 56),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: AppStreamBuilder<int>(
              initialData: 0,
              stream: model.currentPageSubject,
              dataBuilder: (context, currentPage) {
                return DotsIndicator(
                  dotsCount: pages.length,
                  position: currentPage!.toDouble(),
                  mainAxisSize: MainAxisSize.max,
                  decorator: DotsDecorator(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      activeSize:
                          Size(MediaQuery.of(context).size.width / 6, 4),
                      size: Size(MediaQuery.of(context).size.width / 6, 4),
                      spacing: EdgeInsets.symmetric(horizontal: 1),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      activeColor: Theme.of(context).accentColor,
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.3)),
                );
              },
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: pages.length,
              physics: NeverScrollableScrollPhysics(),
              controller: model.registrationStepsController,
              onPageChanged: (currentPage) {
                model.changeCurrentPage(currentPage);
              },
              itemBuilder: (context, index) {
                return pages[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
