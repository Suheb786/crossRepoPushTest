import 'package:domain/model/user/additional_income_type.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AdditionalIncomeSourceWidget extends StatelessWidget {
  final AdditionalIncomeType? additionalIncomeSourceParams;
  final Function()? onTap;

  const AdditionalIncomeSourceWidget({Key? key, this.additionalIncomeSourceParams, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColor.white_gray, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0.w),
                  child: Text(
                    StringUtils.isDirectionRTL(context)
                        ? additionalIncomeSourceParams?.additionalIncomeSourceAr ?? ''
                        : additionalIncomeSourceParams!.additionalIncomeSource!,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 5,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 14.t,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  '${S.of(context).JOD} ${additionalIncomeSourceParams!.totalIncome}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 12.t,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              onTap?.call();
            },
            child: AppSvg.asset(
              AssetUtils.delete,
              color: Theme.of(context).primaryColorDark,
            ),
          )
        ],
      ),
    );
  }
}
