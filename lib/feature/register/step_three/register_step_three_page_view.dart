import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_three/employment_status/employment_status_page.dart';
import 'package:neo_bank/feature/register/step_three/profile_details/profile_details_page.dart';
import 'package:neo_bank/feature/register/step_three/register_step_three_page_view_model.dart';

class RegisterStepThreePageView
    extends BasePageViewWidget<RegisterStepThreeViewModel> {
  RegisterStepThreePageView(ProviderBase model) : super(model);

  List<Widget> pages = [
    ///TODO: Add pages here
    ProfileDetailsPage(),
    EmploymentStatusPage(),
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36),
      child: CarouselSlider.builder(
        itemCount: pages.length,
        carouselController: model.pageController,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            pages[itemIndex],
        options: CarouselOptions(
            height: double.maxFinite,
            pageSnapping: true,
            enableInfiniteScroll: false,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            scrollPhysics: NeverScrollableScrollPhysics(),
            onPageChanged: (index, reason) {
              model.currentPage = index;
            },
            enlargeStrategy: CenterPageEnlargeStrategy.scale),
      ),
    );
  }
}
