import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AppScrollableListViewWidget extends StatelessWidget {
  final Widget child;

  const AppScrollableListViewWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            tileMode: TileMode.mirror,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.white,
              Colors.transparent,
              Colors.transparent,
              AppColor.white,
            ],
            stops: [0.1, 0.2, 0.9, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: child,
      ),
    );
  }
}
