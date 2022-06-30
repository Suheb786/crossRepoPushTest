import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AppTiltCard extends StatelessWidget {
  final int? pageViewIndex;
  final int? currentPage;
  final Widget? child;
  final bool isEndPage;
  final int degree;

  AppTiltCard(
      {required this.pageViewIndex,
      required this.currentPage,
      this.isEndPage = false,
      this.degree: 2,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: pageViewIndex! == currentPage! ? 1 : 1,
      duration: Duration(milliseconds: 500),
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: 8),
        curve: Curves.easeIn,
        margin: EdgeInsets.symmetric(horizontal: isEndPage ? 0 : 4),
        duration: Duration(milliseconds: 500),
        transformAlignment: Alignment.center,
        transform: Matrix4.rotationZ(pageViewIndex! == currentPage!
            ? 0
            : StringUtils.isDirectionRTL(context)
                ? (pageViewIndex! < currentPage! ? degree * (math.pi / 180) : -degree * (math.pi / 180))
                : (pageViewIndex! < currentPage! ? -degree * (math.pi / 180) : degree * (math.pi / 180))),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          transform: Matrix4.diagonal3Values(
              pageViewIndex! == currentPage! ? 1 : 1, pageViewIndex! == currentPage! ? 1 : 1, 1.0),
          transformAlignment: Alignment.center,
          curve: Curves.easeIn,
          margin: EdgeInsets.only(
              bottom: pageViewIndex! == currentPage! ? 10 : 20, top: pageViewIndex! == currentPage! ? 0 : 5),
          child: child!,
        ),
      ),
    );
  }
}

// Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 15,
//                       color: Colors.black.withOpacity(0.32),
//                       offset: Offset(0, 2),
//                     )
//                   ]),
//               child: child!),
