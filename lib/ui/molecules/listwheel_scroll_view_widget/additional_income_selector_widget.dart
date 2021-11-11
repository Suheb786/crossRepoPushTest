import 'package:domain/model/register/additional_income.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AdditionalIncomeSelectorWidget extends StatelessWidget {
  final Color? textColor;
  final AdditionalIncome additionalIncome;
  final Function? onTap;

  const AdditionalIncomeSelectorWidget({
    Key? key,
    required this.additionalIncome,
    this.onTap,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 28, left: 24, right: 24),
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
                  color: additionalIncome.isSelected
                      ? AppColor.vividYellow
                      : Colors.transparent,
                  border: Border.all(
                      color: Theme.of(context)
                          .inputDecorationTheme
                          .enabledBorder!
                          .borderSide
                          .color,
                      width: 1)),
            ),
            SizedBox(
              width: 16,
            ),
            Flexible(
              child: Text(
                additionalIncome.type!,
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
