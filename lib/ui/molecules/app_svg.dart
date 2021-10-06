import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as SvgProvider;
import 'package:neo_bank/di/app/app_modules.dart';
import 'package:neo_bank/main/app_viewmodel.dart';

class AppSvg {
  AppSvg._();

  static Widget asset(String assetName,
      {double? width,
      String? darkAssetName,
      double? height,
      BoxFit fit = BoxFit.contain,
      Color? color,
      alignment = Alignment.center,
      BlendMode colorBlendMode = BlendMode.srcIn,
      String? semanticsLabel}) {
    if (kIsWeb) {
      return Consumer(
        builder: (context, watch, child) => Image.network(
          darkAssetName != null
              ? (watch(appViewModel).appTheme == AppTheme.dark
                  ? "$darkAssetName"
                  : "$assetName")
              : "$assetName",
          width: width,
          height: height,
          fit: fit,
          color: color,
          alignment: alignment,
        ),
      );
    }
    return Consumer(
      builder: (context, watch, child) => SvgPicture.asset(
          darkAssetName != null
              ? (watch(appViewModel).appTheme == AppTheme.dark
                  ? darkAssetName
                  : assetName)
              : assetName,
          width: width,
          height: height,
          fit: fit,
          color: color,
          alignment: alignment,
          colorBlendMode: colorBlendMode,
          semanticsLabel: semanticsLabel),
    );
  }

  static ImageProvider provider(String assetName, {Color? color}) {
    return SvgProvider.Svg(assetName, color: color);
  }
}
