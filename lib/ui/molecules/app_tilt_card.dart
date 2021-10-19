import 'package:flutter/material.dart';

class AppTiltCard extends StatelessWidget {
  int? pageViewIndex;
  int? currentPage;
  Widget? child;

  AppTiltCard(
      {required this.pageViewIndex,
      required this.currentPage,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: pageViewIndex! == currentPage! ? 1 : 0.4,
      child: Transform.rotate(
        angle: pageViewIndex! == currentPage!
            ? 0
            : pageViewIndex! < currentPage!
                ? -0.03491
                : 0.03491,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child!,
        ),
      ),
    );
  }
}
