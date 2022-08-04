import 'package:flutter/material.dart';

import '../../utils/color_utils.dart';

class AppSecondaryButton extends StatelessWidget {
  final bool? busy;
  final String? label;
  final Function()? onTap;
  final double? width;
  final double? height;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;
  final String? fontFamily;
  final double? borderRadius;
  final Color? borderSideColor;
  final double? borderSideWidth;
  final bool? autofocus;

  AppSecondaryButton(
      {this.busy: false,
      @required this.label,
      this.onTap,
      this.textColor,
      this.backgroundColor,
      this.width: 327,
      this.height: 56,
      this.fontSize: 16,
      this.fontFamily,
      this.autofocus: false,
      this.borderRadius: 18,
      this.borderSideColor: AppColor.very_light_gray1,
      this.borderSideWidth: 1});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        autofocus: autofocus!,
        onPressed: onTap ?? null,
        child: busy!
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.dark_moderate_magenta),
                  strokeWidth: 2,
                ),
              )
            : Text(
                label!,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: fontSize,
                    fontFamily: fontFamily ?? 'Montserrat',
                    color: textColor != null
                        ? textColor
                        : (onTap != null)
                            ? textColor
                            : AppColor.light_grayish_violet1),
              ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(2),
          shadowColor: MaterialStateProperty.all<Color>(
            AppColor.black.withOpacity(0.32),
          ),
          minimumSize: MaterialStateProperty.resolveWith<Size>(
            (Set<MaterialState> states) {
              return Size(width!, height!); // Use the component's default.
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius!) : BorderRadius.zero,
              side: borderSideWidth != null && borderSideColor != null
                  ? BorderSide(width: borderSideWidth!, color: borderSideColor!)
                  : BorderSide.none)),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) return AppColor.white;
              if (states.contains(MaterialState.focused)) return AppColor.light_grayish_violet;
              if (states.contains(MaterialState.hovered)) return AppColor.light_grayish_violet;
              if (states.contains(MaterialState.pressed)) return AppColor.light_grayish_violet;

              return AppColor.white; // Use the component's default.
            },
          ),
        ));
  }
}
