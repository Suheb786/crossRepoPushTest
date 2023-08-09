import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGImage extends StatelessWidget {
  final String assetPath;
  final String? semanticLabel;
  final Color? color;
  final double? height;
  final double? width;

  const SVGImage({required this.assetPath, this.semanticLabel, this.color, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      height: null,
      width: null,
      color: color,
      semanticsLabel: semanticLabel,
    );
  }
}
