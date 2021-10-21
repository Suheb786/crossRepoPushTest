import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AnimatedButton extends StatefulWidget {
  int? animationDuration;
  int? fadeAnimationDuration;
  double? animationBegin;
  double? animationEnd;
  double? fadeAnimationBegin;
  double? fadeAnimationEnd;
  Color? buttonColor;
  Color? textColor;
  Color? borderColor;
  Function()? onTap;
  String? buttonText;
  double? buttonHeight;

  AnimatedButton({Key? key,
    this.animationDuration = 900000,
    this.fadeAnimationDuration = 2,
    this.animationBegin = 20,
    this.animationEnd = 189,
    this.fadeAnimationBegin = 0,
    this.fadeAnimationEnd = 1,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    this.onTap,
    required this.buttonText,
    this.buttonHeight = 50,
  })
      : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  AnimationController? fadeAnimationController;
  Animation<double>? animation;
  Animation<double>? fadeAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: Duration(microseconds: widget.animationDuration!));
    fadeAnimationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: widget.fadeAnimationDuration!));
    animation =
        Tween<double>(begin: widget.animationBegin, end: widget.animationEnd)
            .animate(animationController!);
    fadeAnimation = Tween<double>(
        begin: widget.fadeAnimationBegin, end: widget.fadeAnimationEnd)
        .animate(fadeAnimationController!);
    animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(Duration(seconds: 1), () {
          if(mounted) {
            fadeAnimationController!.reverse();
          }
        });
      }
    });
    fadeAnimationController!.addStatusListener((fadeStatus) {
      if (fadeStatus == AnimationStatus.dismissed) {
        animationController!.reset();
        animationController!.forward();
        fadeAnimationController!.forward();
      }
    });
    startAnimation();
  }

  startAnimation() async {
    Timer(Duration(seconds: 1), () {
      if(mounted) {
        animationController!.forward();
        fadeAnimationController!.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation!,
      child: Align(
        alignment: Alignment.centerRight,
        child: AnimatedBuilder(
          animation: animationController!,
          builder: (context, child) =>
              InkWell(
                onTap: () => widget.onTap!(),
                child: Container(
                  height: widget.buttonHeight!,
                  width: animation!.value,
                  decoration: BoxDecoration(
                      color: widget.buttonColor ?? Colors.transparent,
                      borderRadius: BorderRadius.circular(widget.buttonHeight!/2),
                      border: Border.all(
                          color: widget.borderColor != null
                              ? widget.borderColor!
                              : AppColor.white)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.buttonText!,
                        style: TextStyle(
                            color: widget.textColor != null
                                ? widget.textColor
                                : AppColor.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                      ),
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController!.dispose();
    fadeAnimationController!.dispose();
    super.dispose();
  }
}

