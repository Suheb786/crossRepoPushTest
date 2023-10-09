import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../generated/l10n.dart';
import '../../../utils/string_utils.dart';

class SelectTransferToAccountWidget extends StatelessWidget {
  final Account account;
  final Function()? onTap;
  final bool isSelected;

  SelectTransferToAccountWidget({
    Key? key,
    required this.account,
    this.onTap,
    required this.isSelected,
  }) : super(key: key);

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
                  (account.isSubAccount ?? false)
                      ? (account.nickName ?? '').isNotEmpty
                          ? S.of(context).subAccount + " - " + (account.nickName ?? '')
                          : S.of(context).subAccount
                      : (account.nickName ?? '').isNotEmpty
                          ? S.of(context).mainAccount + " - " + (account.nickName ?? '')
                          : S.of(context).mainAccount,
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
                  account.accountNo ?? '',
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
                        text: StringUtils.formatBalance(account.availableBalance ?? ""),
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
