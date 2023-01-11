import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CliqTermConditionSelectionWidget extends StatelessWidget {
  final Function? markSelected;
  final Function? unMarkSelected;
  final String subDescription;
  final bool? isSelected;

  const CliqTermConditionSelectionWidget(
      {Key? key,
      required this.subDescription,
      this.markSelected,
      this.unMarkSelected,
      required this.isSelected,
      required})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (isSelected!)
          InkWell(
            onTap: () {
              unMarkSelected?.call();
              //  model.isSelected(false);
            },
            child: Container(
              height: 42.w,
              width: 42.w,
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, bottom: 10.h, top: 10.h),
                child: AppSvg.asset(AssetUtils.tick, color: AppColor.black),
              ),
              decoration: BoxDecoration(
                color: AppColor.vividYellow,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          )
        else
          InkWell(
            onTap: () {
              markSelected?.call();
              //  model.isSelected(true);
            },
            child: Container(
              width: 42.0.w,
              height: 42.0.w,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.gray1),
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
              ),
            ),
          ),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
          child: Text(
            subDescription,
            // textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.veryDarkGray2,
              fontFamily: StringUtils.appFont,
              fontSize: 12.t,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
