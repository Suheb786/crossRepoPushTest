import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../generated/l10n.dart';
import '../../../utils/string_utils.dart';

class SelectTransferToAccountWidget extends StatelessWidget {
  final String accountName;
  final String accountNumber;
  final String availableAmount;
  final Function()? onTap;
  final bool isSelected;
  SelectTransferToAccountWidget({
    Key? key,
    required this.accountName,
    required this.accountNumber,
    required this.availableAmount,
    this.onTap,
    required this.isSelected,
  }) : super(key: key);
  // String formatBalance(double availableBalance) {
  //   return NumberFormat('#,###.###').format(availableBalance);
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap?.call(),
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 48.w),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 17.h),
                Text(
                  accountName,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.0.t,
                      color: isSelected
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).colorScheme.surfaceTint,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.h),
                Text(
                  accountNumber,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 10.0.t,
                      color: isSelected
                          ? Theme.of(context).colorScheme.shadow
                          : Theme.of(context).colorScheme.surfaceTint,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 15.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: availableAmount,
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 14.0.t,
                          color: isSelected
                              ? Theme.of(context).primaryColorDark
                              : Theme.of(context).colorScheme.surfaceTint,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: " " + S.current.JOD.toUpperCase(),
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 12.0.t,
                          color: isSelected
                              ? Theme.of(context).primaryColorDark
                              : Theme.of(context).colorScheme.surfaceTint,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
