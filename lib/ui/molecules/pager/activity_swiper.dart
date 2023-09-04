import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../feature/activity/activity_home/activity_home_view_model.dart';
import '../../../feature/dashboard_home/app_home/app_home_view_model.dart';
import '../../../utils/device_size_helper.dart';
import '../stream_builder/app_stream_builder.dart';

class ActivitySwiper extends StatefulWidget {
  final List? pages;
  final int? currentStep;

  final Function(int)? onIndexChanged;
  PageController appSwiperController;
  AnimationController? translateSidewaysController;

  ActivitySwiper({
    Key? key,
    this.pages,
    this.currentStep,
    this.onIndexChanged,
    required this.appSwiperController,
    required this.translateSidewaysController,
  }) : super(key: key);

  @override
  _ActivitySwiperState createState() => _ActivitySwiperState();
}

class _ActivitySwiperState extends State<ActivitySwiper> {
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
    return PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.pages!.length,
        onPageChanged: (i) {
          widget.onIndexChanged!.call(i);
        },
        controller: widget.appSwiperController,
        itemBuilder: (context, index) {
          return carouselView(index);
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
                if (widget.appSwiperController.position.hasContentDimensions) {
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
