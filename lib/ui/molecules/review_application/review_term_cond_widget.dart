import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ReviewTCWidget extends StatelessWidget {
  final String title;
  final String? subTitle;
  final bool? isSelected;
  final Function? onTap;
  final Function? onTermsAndConditionTap;

  const ReviewTCWidget(
      {Key? key,
      required this.title,
      this.subTitle,
      this.isSelected: false,
      this.onTermsAndConditionTap,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              onTap?.call();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColor.mostly_desaturated_dark_violet),
                  shape: BoxShape.circle,
                  color: isSelected!
                      ? AppColor.dark_violet_4
                      : Colors.transparent),
              child: (isSelected!)
                  ? AppSvg.asset(AssetUtils.tick, height: 7.33, width: 10.67)
                  : null,
            ),
          ),
          SizedBox(width: 15),
          Flexible(
            child: Text.rich(TextSpan(
                text: title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                  color: Theme.of(context).primaryColorDark,
                ),
                children: [
                  WidgetSpan(
                    child: InkWell(
                      onTap: () {
                        onTermsAndConditionTap?.call();
                      },
                      child: Text(
                        subTitle!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          color: AppColor.vivid_orange,
                        ),
                      ),
                    ),
                  )
                ])),
          ),
        ],
      ),
    );
  }
}
