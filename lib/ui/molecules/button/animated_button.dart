import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AnimatedButton extends StatefulWidget {
  final int? animationDuration;
  final int? fadeAnimationDuration;
  final double? animationBegin;
  final double? animationEnd;
  final double? fadeAnimationBegin;
  final double? fadeAnimationEnd;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final String? buttonText;
  final double? buttonHeight;

  AnimatedButton({
    Key? key,
    this.animationDuration = 900000,
    this.fadeAnimationDuration = 2,
    this.animationBegin = 20,
    this.animationEnd = 189,
    this.fadeAnimationBegin = 0,
    this.fadeAnimationEnd = 1,
    this.buttonColor,
    this.textColor,
    this.borderColor,
    required this.buttonText,
    this.buttonHeight = 50,
  }) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with TickerProviderStateMixin {
  AnimationController? animationController;
  AnimationController? fadeAnimationController;
  Animation<double>? animation;
  Animation<double>? fadeAnimation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(microseconds: widget.animationDuration!));
    fadeAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: widget.fadeAnimationDuration!));
    animation =
        Tween<double>(begin: widget.animationBegin, end: widget.animationEnd).animate(animationController!);
    fadeAnimation = Tween<double>(begin: widget.fadeAnimationBegin, end: widget.fadeAnimationEnd)
        .animate(fadeAnimationController!);
    animationController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(Duration(seconds: 1), () {
          if (mounted) {
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
      if (mounted) {
        animationController!.forward();
        fadeAnimationController!.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.animationEnd,
      child: FadeTransition(
        opacity: fadeAnimation!,
        child: Align(
          alignment: Alignment.centerRight,
          child: AnimatedBuilder(
            animation: animationController!,
            builder: (context, child) => Container(
              height: widget.buttonHeight!,
              width: animation!.value,
              decoration: BoxDecoration(
                  color: widget.buttonColor ?? Colors.transparent,
                  borderRadius: BorderRadius.circular(widget.buttonHeight! / 2),
                  border: Border.all(
                      width: 2,
                      color: widget.borderColor != null
                          ? widget.borderColor!
                          : Theme.of(context).textTheme.bodyLarge!.color!)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.buttonText!,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: widget.textColor != null
                            ? widget.textColor
                            : Theme.of(context).textTheme.bodyLarge!.color!,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
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
