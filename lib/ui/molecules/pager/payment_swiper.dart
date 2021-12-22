import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class PaymentSwiper extends StatelessWidget {
  final List pages;
  final int? currentStep;
  final SwiperController pageController;
  final Function(int)? onIndexChanged;

  const PaymentSwiper({
    Key? key,
    required this.pages,
    this.currentStep,
    required this.pageController,
    this.onIndexChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      // customLayoutOption: CustomLayoutOption(
      //         startIndex: -1, stateCount: currentStep == 1 ? 2 : 3)
      //     .addRotate([currentStep == 0 ? 0/180 : -7.0 / 180, 0.0, 7.0 / 180]).addTranslate([
      //   currentStep == 0 ? Offset.zero : Offset(-(MediaQuery.of(context).size.width - 55), -5.0),
      //   Offset(0.0, 0.0),
      //   Offset(MediaQuery.of(context).size.width - 55, -5.0)
      // ]),
      customLayoutOption: CustomLayoutOption(
              startIndex: -1, stateCount: currentStep == 1 ? 2 : 3)
          .addRotate([-7.0 / 180, 0.0, 7.0 / 180]).addTranslate([
        Offset(-(MediaQuery.of(context).size.width - 55), -5.0),
        Offset(0.0, 0.0),
        Offset(MediaQuery.of(context).size.width - 55, -5.0)
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
      itemBuilder: (context, index) {
        return Container(margin: EdgeInsets.all(5), child: pages[index]);
      },
    );
  }
}
