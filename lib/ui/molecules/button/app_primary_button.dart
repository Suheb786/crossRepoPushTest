import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

@immutable
class AppPrimaryButton extends StatelessWidget {
  AppPrimaryButton({
    Key? key,
    required this.onPressed,
    this.text = 'Next',
    this.width = double.infinity,
    this.isDisabled = false,
    this.textColor,
    this.activeBackgroundColor,
    this.disableBackgroundColor,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final double width;
  final Color? textColor;
  final bool isDisabled;
  final Color? activeBackgroundColor;
  final Color? disableBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 56.h,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5);
            }
            return isDisabled
                ? disableBackgroundColor ?? Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5)
                : activeBackgroundColor ??
                    Theme.of(context).textTheme.bodyLarge?.color ??
                    AppColor.brightBlue;
          }),
        ),
        onPressed: !isDisabled ? onPressed : null,
        child: Text(
          text,
          style: TextStyle(
              fontFamily: StringUtils.appFont,
              fontSize: 14.t,
              fontWeight: FontWeight.w600,
              color: textColor ?? Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}
