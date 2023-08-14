import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../feature/payment/payment_home/payment_home_view_model.dart';
import 'dart:math' as math;

import '../../../utils/device_size_helper.dart';
import '../stream_builder/app_stream_builder.dart';

class PaymentSwiper extends StatefulWidget {
  final List? pages;
  final int? currentStep;
  final SwiperController? pageController;
  PageController? appSwiperController;
  final Function(int)? onIndexChanged;
  final AnimationController? translateSidewaysController;
  final PaymentHomeViewModel model;

  PaymentSwiper({
    Key? key,
    this.pages,
    this.currentStep,
    this.pageController,
    this.onIndexChanged,
    required this.appSwiperController,
    required this.model,
    this.translateSidewaysController,
  }) : super(key: key);

  @override
  _PaymentSwiperState createState() => _PaymentSwiperState();
}

class _PaymentSwiperState extends State<PaymentSwiper> {
  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<AnimatedPage>(
        stream: widget.model.pageSwitchStream,
        initialData: AnimatedPage.NULL,
        dataBuilder: (context, switchedPage) {
          return PageView.builder(
              itemCount: widget.pages!.length,
              onPageChanged: (i) {
                widget.onIndexChanged!.call(i);
              },
              physics: switchedPage == AnimatedPage.NULL ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics(),
              controller: widget.appSwiperController,
              itemBuilder: (context, index) {
                return carouselView(index);
              });
        });
  }

  Widget carouselView(int index) {
    double horizontalSpacing = MediaQuery.of(context).size.width * 0.035;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalSpacing) + EdgeInsets.only(bottom: 40, top: MediaQuery.of(context).size.height * (DeviceSizeHelper.isBigDevice ? 0.06 : 0.04)),
      child: AnimatedBuilder(
        animation: widget.translateSidewaysController!,
        builder: (context, child) {
          return Transform.translate(
            offset: widget.currentStep == index
                ? const Offset(0, 0)
                : widget.currentStep! < index
                    ? Offset(widget.translateSidewaysController!.value * 100 * (StringUtils.isDirectionRTL(context) ? -1 : 1), 0)
                    : Offset(widget.translateSidewaysController!.value * 100 * (StringUtils.isDirectionRTL(context) ? 1 : -1), 0),
            child: AnimatedBuilder(
              animation: widget.appSwiperController!,
              child: widget.pages![index],
              builder: (context, child) {
                double value = 0;

                ///Checking if pageController is ready to use
                if (widget.appSwiperController!.position.hasContentDimensions) {
                  ///For current page value = 0, so rotation and translation value is zero
                  value = index.toDouble() - (widget.appSwiperController!.page ?? 0);
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
