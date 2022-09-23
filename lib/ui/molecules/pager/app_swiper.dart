import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AppSwiper extends StatefulWidget {
  final List? pages;
  final int? currentStep;
  final SwiperController? pageController;
  final PageController? appSwiperController;
  final Function(int)? onIndexChanged;

  AppSwiper(
      {Key? key,
      this.pages,
      this.currentStep,
      this.pageController,
      this.onIndexChanged,
      required this.appSwiperController})
      : super(key: key);

  @override
  _AppSwiperState createState() => _AppSwiperState();
}

class _AppSwiperState extends State<AppSwiper> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: PageView.builder(
          itemCount: widget.pages!.length,
          onPageChanged: (i) {
            widget.onIndexChanged!.call(i);
          },
          physics: NeverScrollableScrollPhysics(),
          controller: widget.appSwiperController,
          itemBuilder: (context, index) {
            return carouselView(index);
          }),
    );
  }

  Widget carouselView(int index) {
    return AnimatedBuilder(
      animation: widget.appSwiperController!,
      builder: (context, child) {
        double value = 0.0;
        if (widget.appSwiperController!.positions.last.haveDimensions) {
          value = index.toDouble() - (widget.appSwiperController!.page ?? 0);
          value = (value * 0.01).clamp(-1, 1);
        } else {
          value = (index * 0.01).clamp(-1, 1);
        }
        return Transform.rotate(
            angle: StringUtils.isDirectionRTL(context) ? pi * -value : pi * value,
            // transform: Matrix4.skewX(-value * 1.5),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
              child: widget.pages![index],
            ));
      },
    );
  }
}

// class AppSwiper extends StatelessWidget {
//   final List pages;
//   final int? currentStep;
//   final SwiperController pageController;
//   final Function(int)? onIndexChanged;
//
//   AppSwiper({
//     Key? key,
//     required this.pages,
//     this.currentStep,
//     required this.pageController,
//     this.onIndexChanged,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Swiper(
//       key: key,
//       customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
//           .addRotate([-7.0 / 180, 0.0, 7.0 / 180]).addTranslate(getOffSet(
//               context: context,
//               currentStep: currentStep!,
//               totalStep: pages.length)),
//       loop: false,
//       controller: pageController,
//       itemWidth: MediaQuery.of(context).size.width - 48,
//       index: currentStep,
//       duration: 750,
//       viewportFraction: 0.88,
//       physics: NeverScrollableScrollPhysics(),
//       onIndexChanged: (index) {
//         onIndexChanged?.call(index);
//       },
//       itemCount: pages.length,
//       layout: SwiperLayout.CUSTOM,
//       itemBuilder: (context, index) => Container(
//         margin: EdgeInsets.all(5),
//         child: (currentStep == 0 && index == pages.length - 1)
//             ? Container()
//             : pages[index]! ?? Container(),
//       ),
//     );
//   }
//
//   List<Offset> getOffSet(
//       {required int currentStep,
//       required int totalStep,
//       required BuildContext context}) {
//     final width = MediaQuery.of(context).size.width;
//
//     final end = (totalStep - currentStep);
//
//     return [
//       Offset(-(width - 35 - currentStep - 1), -5.0),
//       Offset(0.0, 0.0),
//       Offset(width - 35 - end, -5.0)
//     ];
//   }
// }
