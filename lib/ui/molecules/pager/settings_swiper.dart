import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class SettingsSwiper extends StatelessWidget {
  final List pages;
  final int? currentStep;
  final double width;
  final double height;
  final SwiperController pageController;
  final Function(int)? onIndexChanged;

  const SettingsSwiper({
    Key? key,
    required this.pages,
    this.currentStep,
    this.width = 112,
    this.height = 174,
    required this.pageController,
    this.onIndexChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      customLayoutOption: CustomLayoutOption(stateCount: 3, startIndex: -1)
        ..addRotate([-8.0 / 180, 0.0, 8.0 / 180])
        ..addTranslate([Offset(-(height - 35), -5.0), Offset(0.0, 0.0), Offset(height - 35, -5.0)]),
      loop: false,
      controller: pageController,
      itemWidth: width,
      itemHeight: height,
      index: currentStep,
      duration: 750,
      viewportFraction: 0.98,
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      onIndexChanged: (index) {
        onIndexChanged?.call(index);
      },
      itemCount: pages.length,
      layout: SwiperLayout.CUSTOM,
      itemBuilder: (context, index) => Container(margin: EdgeInsets.zero, child: pages[index]),
    );
  }
}
