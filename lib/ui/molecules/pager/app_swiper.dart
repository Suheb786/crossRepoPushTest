import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class AppSwiper extends StatelessWidget {
  final List pages;
  final int? currentStep;
  final SwiperController pageController;
  final Function(int)? onIndexChanged;

  const AppSwiper({
    Key? key,
    required this.pages,
    this.currentStep,
    required this.pageController,
    this.onIndexChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      key: key,
      customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
          .addRotate([-7.0 / 180, 0.0, 7.0 / 180]).addTranslate([
        Offset(-(MediaQuery.of(context).size.width - 35), -5.0),
        Offset(0.0, 0.0),
        Offset(MediaQuery.of(context).size.width - 35, -5.0)
      ]),
      loop: false,
      controller: pageController,
      itemWidth: MediaQuery.of(context).size.width - 48,
      index: currentStep,
      duration: 750,
      viewportFraction: 0.88,
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      onIndexChanged: (index) {
        onIndexChanged?.call(index);
      },
      itemCount: pages.length,
      layout: SwiperLayout.CUSTOM,
      itemBuilder: (context, index) => Container(
          margin: EdgeInsets.all(5), child: pages[index]! ?? Container()),
    );
  }
}
