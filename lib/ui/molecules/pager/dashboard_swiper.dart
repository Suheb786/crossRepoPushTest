import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/screen_size_utils.dart';

class DashboardSwiper extends StatefulWidget {
  final int initialPage;
  final double viewportFraction;
  final List? pages;
  final int? currentStep;
  final SwiperController? pageController;
  final Function(int)? onIndexChanged;
  DashboardSwiper(
      {Key? key,
      this.initialPage = 0,
      this.viewportFraction = 0.8,
      this.pages,
      this.currentStep,
      this.pageController,
      this.onIndexChanged})
      : super(key: key);

  @override
  _DashboardSwiperState createState() => _DashboardSwiperState();
}

class _DashboardSwiperState extends State<DashboardSwiper> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage: widget.initialPage,
        viewportFraction: widget.viewportFraction);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: PageView.builder(
          itemCount: widget.pages!.length,
          onPageChanged: (i) {
            widget.onIndexChanged!.call(i);
          },
          // physics: CustomScrollPhysics(),
          controller: _pageController,
          itemBuilder: (context, index) {
            return carouselView(index);
          }),
    );
  }

  Widget carouselView(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0.0;
        (value * 0.018).clamp(-1, 1);
        if (_pageController.position.haveDimensions) {
          value = index.toDouble() - (_pageController.page ?? 0);
          value = (value * 0.018).clamp(-1, 1);
        } else {
          value = (index * 0.018).clamp(-1, 1);
        }
        return Transform.rotate(
          angle: pi * value,
          child: widget.pages![index],
        );
      },
    );
  }
}

//
// class DashboardSwiper extends StatelessWidget {
//   final List pages;
//   final int? currentStep;
//   final SwiperController pageController;
//   final Function(int)? onIndexChanged;
//
//   const DashboardSwiper({
//     Key? key,
//     required this.pages,
//     this.currentStep,
//     required this.pageController,
//     this.onIndexChanged,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     bool isSmallDevices = MediaQuery.of(context).size.height <
//             ScreenSizeBreakPoints.SMALL_DEVICE_HEIGHT ||
//         MediaQuery.of(context).size.height <
//             ScreenSizeBreakPoints.MEDIUM_DEVICE_HEIGHT;
//     return Swiper(
//       customLayoutOption: CustomLayoutOption(
//               startIndex: -1, stateCount: currentStep == 2 ? 2 : 3)
//           .addRotate([-7.0 / 180, 0.0, 7.0 / 180]).addTranslate([
//         Offset(-(MediaQuery.of(context).size.width - 60), -5.0),
//         Offset(0.0, 0.0),
//         Offset(MediaQuery.of(context).size.width - 60, -5.0)
//       ]),
//       loop: false,
//       controller: pageController,
//       itemWidth: MediaQuery.of(context).size.width - 48,
//       index: currentStep,
//       duration: 750,
//       viewportFraction: 0.88,
//       scrollDirection: Axis.horizontal,
//       physics: NeverScrollableScrollPhysics(),
//       onIndexChanged: (index) {
//         onIndexChanged?.call(index);
//       },
//       itemCount: pages.length,
//       layout: SwiperLayout.CUSTOM,
//       itemBuilder: (context, index) => Container(
//           margin: EdgeInsets.all(5),
//           child: (currentStep == 0 && index == pages.length - 1)
//               ? Container()
//               : pages[index]),
//     );
//   }
// }
