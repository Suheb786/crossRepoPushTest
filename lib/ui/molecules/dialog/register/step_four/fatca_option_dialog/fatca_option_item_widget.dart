import 'package:domain/model/fatca_crs/fatca_question_content_data.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class FatcaOptionItemWidget extends StatelessWidget {
  final AdditionalDataDropDownData item;
  final bool showFlag;

  const FatcaOptionItemWidget(
      {Key? key, required this.item, this.showFlag: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.only(left: 24, right: 20, top: 16, bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.transparent),
      child: Row(
        children: [
          Visibility(
            visible: showFlag,
            child: Container(
              height: 32,
              width: 32,
              margin: EdgeInsets.only(right: 16),
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
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: item.isSelected
                    ? Theme.of(context).primaryColorDark
                    : AppColor.gray),
          ),
        ],
      ),
    );
  }
}
