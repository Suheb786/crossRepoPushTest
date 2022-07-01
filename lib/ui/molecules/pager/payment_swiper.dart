import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/string_utils.dart';

// class PaymentSwiper extends StatelessWidget {
//   final List pages;
//   final int? currentStep;
//   final SwiperController pageController;
//   final Function(int)? onIndexChanged;
//
//   const PaymentSwiper({
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
//       // customLayoutOption: CustomLayoutOption(
//       //         startIndex: -1, stateCount: currentStep == 1 ? 2 : 3)
//       //     .addRotate([currentStep == 0 ? 0/180 : -7.0 / 180, 0.0, 7.0 / 180]).addTranslate([
//       //   currentStep == 0 ? Offset.zero : Offset(-(MediaQuery.of(context).size.width - 55), -5.0),
//       //   Offset(0.0, 0.0),
//       //   Offset(MediaQuery.of(context).size.width - 55, -5.0)
//       // ]),
//       customLayoutOption: CustomLayoutOption(
//               startIndex: -1, stateCount: currentStep == 1 ? 2 : 3)
//           .addRotate([-7.0 / 180, 0.0, 7.0 / 180]).addTranslate([
//         Offset(-(MediaQuery.of(context).size.width - 55), -5.0),
//         Offset(0.0, 0.0),
//         Offset(MediaQuery.of(context).size.width - 55, -5.0)
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
//       itemBuilder: (context, index) {
//         return Container(margin: EdgeInsets.all(5), child: pages[index]);
//       },
//     );
//   }
// }

class PaymentSwiper extends StatefulWidget {
  final List? pages;
  final int? currentStep;
  final SwiperController? pageController;
  final PageController? appSwiperController;
  final Function(int)? onIndexChanged;

  PaymentSwiper(
      {Key? key,
      this.pages,
      this.currentStep,
      this.pageController,
      this.onIndexChanged,
      required this.appSwiperController})
      : super(key: key);

  @override
  _PaymentSwiperState createState() => _PaymentSwiperState();
}

class _PaymentSwiperState extends State<PaymentSwiper> {
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
        if (widget.currentStep == index) {
          value = 0.0;
        } else if ((widget.currentStep ?? 0) > index) {
          value = -0.01;
        } else {
          value = 0.01;
        }
        return Transform.rotate(
            angle: StringUtils.isDirectionRTL(context) ? pi * -value : pi * value,
            // transform: Matrix4.skewX(-value * 1.5),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: widget.pages![index],
            ));
      },
    );
  }
}
