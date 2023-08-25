import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../feature/dashboard_home/app_home/app_home_view_model.dart';
import '../../../utils/device_size_helper.dart';
import '../stream_builder/app_stream_builder.dart';

class DashboardSwiper extends StatefulWidget {
  final List? pages;
  final int? currentStep;

  // final SwiperController? pagesController;
  final Function(int)? onIndexChanged;
  PageController appSwiperController;
  AnimationController? translateSidewaysController;
  AppHomeViewModel model;

  DashboardSwiper(
      {Key? key,
      this.pages,
      this.currentStep,
      this.onIndexChanged,
      required this.appSwiperController,
      required this.translateSidewaysController,
      required this.model})
      : super(key: key);

  @override
  _DashboardSwiperState createState() => _DashboardSwiperState();
}

class _DashboardSwiperState extends State<DashboardSwiper> {
  @override
  void initState() {
    super.initState();

    widget.appSwiperController = PageController(
      initialPage: widget.currentStep!,
      viewportFraction: 0.8,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<DashboardAnimatedPage>(
        stream: widget.model.pageSwitchStream,
        initialData: DashboardAnimatedPage.NULL,
        dataBuilder: (context, switchedPage) {
          return PageView.builder(
              physics: switchedPage != DashboardAnimatedPage.NULL
                  ? const NeverScrollableScrollPhysics()
                  : const ClampingScrollPhysics(),
              itemCount: widget.pages!.length,
              onPageChanged: (i) {
                widget.onIndexChanged!.call(i);
              },
              controller: widget.appSwiperController,
              itemBuilder: (context, index) {
                return carouselView(index);
              });
        });
  }

  Widget carouselView(int index) {
    double horizontalSpacing = MediaQuery.of(context).size.width * 0.035;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalSpacing) +
          EdgeInsets.only(
              bottom: 40,
              top: MediaQuery.of(context).size.height * (DeviceSizeHelper.isBigDevice ? 0.06 : 0.04)),
      child: AnimatedBuilder(
        animation: widget.translateSidewaysController!,
        builder: (context, child) {
          return Transform.translate(
            offset: widget.currentStep == index
                ? const Offset(0, 0)
                : widget.currentStep! < index
                    ? Offset(
                        widget.translateSidewaysController!.value *
                            100 *
                            (StringUtils.isDirectionRTL(context) ? -1 : 1),
                        0)
                    : Offset(
                        widget.translateSidewaysController!.value *
                            100 *
                            (StringUtils.isDirectionRTL(context) ? 1 : -1),
                        0),
            child: AnimatedBuilder(
              animation: widget.appSwiperController,
              child: widget.pages![index],
              builder: (context, child) {
                double value = 0;

                ///Checking if pageController is ready to use

                if (widget.appSwiperController.hasClients &&
                    widget.appSwiperController.positions
                        .isNotEmpty) if (widget.appSwiperController.position.hasContentDimensions) {
                  ///For current page value = 0, so rotation and translation value is zero
                  value = index.toDouble() - (widget.appSwiperController.page ?? 0);
                  value = (value * 0.012);
                }

                ///Tilted semicircle
                return Transform.rotate(
                  angle: (math.pi * (StringUtils.isDirectionRTL(context) ? -1 : 1) * value),
                  child: Transform.translate(
                    offset: Offset(0, value.abs() * 500),
                    child: AnimatedOpacity(
                      opacity: index == widget.currentStep ? 1 : 0.5,
                      duration: const Duration(milliseconds: 400),
                      child: child!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
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
