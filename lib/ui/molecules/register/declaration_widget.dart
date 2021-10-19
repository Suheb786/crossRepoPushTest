import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class DeclarationWidget extends StatelessWidget {
  final String? title;
  final bool? isSelected;
  final Function? onTap;

  const DeclarationWidget(
      {Key? key, this.title, this.isSelected: false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
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
                  color: AppColor.dark_violet_4),
              child: (isSelected!)
                  ? AppSvg.asset(AssetUtils.tick, height: 7.33, width: 10.67)
                  : null,
            ),
          ),
          SizedBox(width: 15),
          Flexible(
            child: Text.rich(TextSpan(
                text:
                    'I confirm that my tax residency is accurate and agree to the ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                  color: AppColor.very_light_gray_white,
                ),
                children: [
                  TextSpan(
                      text: 'Terms and Conditions ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        color: AppColor.vivid_orange,
                      ),
                      children: [
                        TextSpan(
                          text: 'of the bank.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                            color: AppColor.very_light_gray_white,
                          ),
                        )
                      ])
                ])),
          ),
        ],
      ),
    );
  }
}
