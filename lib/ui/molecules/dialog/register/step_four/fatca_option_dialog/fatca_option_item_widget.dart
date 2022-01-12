import 'package:domain/model/fatca_crs/fatca_question_content_data.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class FatcaOptionItemWidget extends StatelessWidget {
  final AdditionalDataDropDownData item;

  const FatcaOptionItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.only(left: 24, right: 20, top: 16, bottom: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: Colors.transparent),
      child: Text(
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
    );
  }
}
