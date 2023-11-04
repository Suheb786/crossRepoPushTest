import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class IDWiseProcessingStatusWidget extends StatelessWidget {
  final String label;
  final bool isActivated;
  final bool isAhwalPassed;

  const IDWiseProcessingStatusWidget({Key? key, required this.label, this.isActivated = false,this.isAhwalPassed=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 78.0.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          isActivated
              ? AppSvg.asset(AssetUtils.bold_check_icon, color: Theme.of(context).colorScheme.secondary)
              : Container(
                  height: 24.0.h,
                  width: 24.0.w,
                ),
          SizedBox(
            width: 16.0.w,
          ),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: isAhwalPassed ? 15.0.t : 14.0.t,
                  fontWeight: isAhwalPassed ? FontWeight.w800 : FontWeight.w600,
                  color: isAhwalPassed
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.secondary.withOpacity(0.3)),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
