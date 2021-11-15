import 'package:domain/model/register/expected_Transactionss.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ExpectedTransactionsSelectorWidget extends StatelessWidget {
  final Color? textColor;
  final ExpectedTransactions expectedTransactions;
  final Function? onTap;

  const ExpectedTransactionsSelectorWidget({
    Key? key,
    required this.expectedTransactions,
    this.onTap,
    this.textColor: AppColor.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppColor.mostly_desaturated_dark_violet,
                      width: 1)),
              child: expectedTransactions.isSelected
                  ? AppSvg.asset(AssetUtils.correct)
                  : Container(),
            ),
            SizedBox(
              width: 16,
            ),
            Flexible(
              child: Text(
                expectedTransactions.type!,
                style: TextStyle(
                    color: textColor ?? AppColor.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
