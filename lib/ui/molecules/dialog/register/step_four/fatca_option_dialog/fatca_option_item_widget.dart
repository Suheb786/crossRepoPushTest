import 'package:domain/model/fatca_crs/fatca_question_content_data.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class FatcaOptionItemWidget extends StatelessWidget {
  final AdditionalDataDropDownData item;
  final bool showFlag;

  const FatcaOptionItemWidget({Key? key, required this.item, this.showFlag: false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsetsDirectional.only(start: 24.w, end: 20.w, top: 16.h, bottom: 16.h),
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.transparent),
      child: Row(
        children: [
          Visibility(
            visible: showFlag,
            child: Container(
              height: 32.w,
              width: 32.w,
              margin: EdgeInsetsDirectional.only(end: 16.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColorDark,
              ),
              child: AppSvg.asset(
                "${AssetUtils.flags}${item.value?.toLowerCase() ?? ""}.svg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            '${item.name}',
            softWrap: true,
            maxLines: 2,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontSize: 14.t,
                fontWeight: FontWeight.w400,
                color: item.isSelected ? Theme.of(context).primaryColorDark : AppColor.gray),
          ),
        ],
      ),
    );
  }
}
