import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class AppSwiper extends StatefulWidget {
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
  State<AppSwiper> createState() => _AppSwiperState();
}

class _AppSwiperState extends State<AppSwiper> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final startDx = MediaQuery.of(context).size.width - 20;
    final midDx = MediaQuery.of(context).size.width - 40;
    final endDx = MediaQuery.of(context).size.width - 45;

    final dy = -5.0;

    final isStartItem = currentIndex == 0;
    final isEndItem = currentIndex == widget.pages.length - 1;

    return Swiper(
      key: widget.key,
      customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
          .addRotate([0.0 / 180, 0.0, 0.0 / 180]).addTranslate([
        if (isStartItem)
          Offset(-startDx, dy)
        else if (isEndItem)
          Offset(-endDx, dy)
        else
          Offset(-midDx, dy),
        Offset(0.0, 0.0),
        if (isEndItem)
          Offset(startDx, dy)
        else if (isStartItem)
          Offset(endDx, dy)
        else
          Offset(midDx, dy),
      ]),
      loop: false,
      controller: widget.pageController,
      itemWidth: MediaQuery.of(context).size.width - 48,
      index: widget.currentStep,
      duration: 750,
      viewportFraction: 0.88,
      scrollDirection: Axis.horizontal,
      physics: NeverScrollableScrollPhysics(),
      onIndexChanged: (index) {
        widget.onIndexChanged?.call(index);
        setState(() {
          currentIndex = index;
        });
      },
      itemCount: widget.pages.length,
      layout: SwiperLayout.CUSTOM,
      itemBuilder: (context, index) => Container(
          margin: EdgeInsets.all(5),
          child: widget.pages[index]! ?? Container()),
    );
  }
}
