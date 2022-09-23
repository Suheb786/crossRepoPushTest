import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class AppIconButton extends StatelessWidget {
  final String icon;
  final Function? onTap;
  final double? iconSize;
  final double? height;

  const AppIconButton({Key? key, required this.icon, this.onTap, this.iconSize: 28, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap?.call(),
      child: Container(
        height: height ?? 56.h,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColor.veryLightGray2, width: 1),
        ),
        alignment: Alignment.center,
        child: AppSvg.asset(icon,
            color: Theme.of(context).primaryColorDark,
            width: iconSize?.w,
            height: iconSize?.h,
            fit: BoxFit.contain),
      ),
    );
  }
}
