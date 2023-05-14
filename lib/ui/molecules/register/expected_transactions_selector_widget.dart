import 'package:domain/model/register/expected_Transactionss.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ExpectedTransactionsSelectorWidget extends StatelessWidget {
  final Color? textColor;
  final ExpectedTransactions expectedTransactions;
  final Function? onTap;

  const ExpectedTransactionsSelectorWidget({
    Key? key,
    required this.expectedTransactions,
    this.onTap,
    this.textColor = AppColor.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).inputDecorationTheme.enabledBorder!.borderSide.color,
                      width: 1)),
              child: expectedTransactions.isSelected ? AppSvg.asset(AssetUtils.correct) : Container(),
            ),
            SizedBox(
              width: 16.w,
            ),
            Flexible(
              child: Text(
                expectedTransactions.type!,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
