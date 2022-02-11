import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class AppSwiper extends StatefulWidget {
  // final int initialPage;
  // final double viewportFraction;
  final List? pages;
  final int? currentStep;
  final SwiperController? pageController;
  final PageController? appSwiperController;
  final Function(int)? onIndexChanged;
  final bool? swipeEnable;

  AppSwiper(
      {Key? key,
      // this.initialPage = 0,
      // this.viewportFraction = 0.8,
      this.pages,
      this.currentStep,
      this.pageController,
      this.onIndexChanged,
      this.swipeEnable,
      this.appSwiperController})
      : super(key: key);

  @override
  _AppSwiperState createState() => _AppSwiperState();
}

class _AppSwiperState extends State<AppSwiper> {
  // late PageController _pageController;

  // @override
  // void initState() {
  //   super.initState();
  //   _pageController = PageController(
  //       initialPage: widget.initialPage,
  //       viewportFraction: widget.viewportFraction);
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _pageController.dispose();
  // }

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
        (value * 0.018).clamp(-1, 1);
        if (widget.appSwiperController!.position.haveDimensions) {
          value = index.toDouble() - (widget.appSwiperController!.page ?? 0);
          value = (value * 0.01).clamp(-1, 1);
        } else {
          value = (index * 0.01).clamp(-1, 1);
        }
        return Transform.rotate(
            angle: pi * value,
            // transform: Matrix4.skewX(-value * 1.5),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                  // behavior: HitTestBehavior.deferToChild,
                  // onHorizontalDragEnd: (details) {
                  //   print(widget.swipeEnable);
                  //   if (details.primaryVelocity!.isNegative) {
                  //     if (widget.swipeEnable!) {
                  //       _pageController.animateToPage(widget.currentStep! + 1,
                  //           duration: const Duration(seconds: 1),
                  //           curve: Curves.linear);
                  //     }
                  //   } else {
                  //     _pageController.animateToPage(widget.currentStep! - 1,
                  //         duration: const Duration(seconds: 1),
                  //         curve: Curves.linear);
                  //   }
                  // },
                  child: widget.pages![index]),
            ));
      },
    );
  }
}

// class CustomScrollPhysics extends ScrollPhysics {
//   CustomScrollPhysics({ScrollPhysics? parent, this.swipeEnable})
//       : super(parent: parent);
//   //   // super(parent: parent);
//   //   print("Swipe FINAL: $swipeEnable");
//   //   this.swipeEnable = swipeEnable;
//   //   print("Swipe NEW: ${this.swipeEnable}");
//   // }
//
//   final swipeEnable;
//   bool isGoingLeft = false;
//   bool isGoingRight = false;
//
//   @override
//   CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
//     return CustomScrollPhysics(parent: buildParent(ancestor));
//   }
//
//   @override
//   double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
//     isGoingLeft = offset.sign < 0;
//     isGoingRight = offset.sign > 0;
//     print("SWIPE IN PHYSICTS: $swipeEnable");
//     return offset;
//   }
//
//   @override
//   double applyBoundaryConditions(ScrollMetrics position, double value) {
//     //print("applyBoundaryConditions");
//     assert(() {
//       if (value == position.pixels) {
//         throw FlutterError(
//             '$runtimeType.applyBoundaryConditions() was called redundantly.\n'
//             'The proposed new position, $value, is exactly equal to the current position of the '
//             'given ${position.runtimeType}, ${position.pixels}.\n'
//             'The applyBoundaryConditions method should only be called when the value is '
//             'going to actually change the pixels, otherwise it is redundant.\n'
//             'The physics object in question was:\n'
//             '  $this\n'
//             'The position object in question was:\n'
//             '  $position\n');
//       }
//       return true;
//     }());
//     if (value < position.pixels &&
//         position.pixels <= position.minScrollExtent) {
//       return value - position.pixels;
//     }
//     if (position.maxScrollExtent <= position.pixels &&
//         position.pixels < value) {
//       return value - position.pixels;
//     }
//     if (value < position.minScrollExtent &&
//         position.minScrollExtent < position.pixels) {
//       return value - position.minScrollExtent;
//     }
//
//     if (position.pixels < position.maxScrollExtent &&
//         position.maxScrollExtent < value) {
//       return value - position.maxScrollExtent;
//     }
//
//     print("swipeEnable $swipeEnable");
//     if (!isGoingRight && !swipeEnable) {
//       return value - position.pixels;
//     }
//     return 0.0;
//   }
// }

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
