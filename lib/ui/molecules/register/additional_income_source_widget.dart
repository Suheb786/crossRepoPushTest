import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/additional_income_source/additional_income_source_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AdditionalIncomeSourceWidget extends StatelessWidget {
  final AdditionalIncomeSourceParams? additionalIncomeSourceParams;
  final Function()? onTap;

  const AdditionalIncomeSourceWidget(
      {Key? key, this.additionalIncomeSourceParams, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColor.dark_violet2,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: AppColor.mostly_desaturated_dark_violet, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    additionalIncomeSourceParams!.incomeSourceType!,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 5,
                    style: TextStyle(
                        color: AppColor.very_light_gray_white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '${additionalIncomeSourceParams!.currency} ${additionalIncomeSourceParams!.amount}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: AppColor.very_light_violet,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              onTap?.call();
            },
            child: AppSvg.asset(AssetUtils.delete),
          )
        ],
      ),
    );
  }
}
