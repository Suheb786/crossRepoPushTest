import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

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
      padding: EdgeInsets.only(top: 16.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              onTap?.call();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).inputDecorationTheme.hintStyle!.color!),
                shape: BoxShape.circle,
                color: isSelected! ? Theme.of(context).canvasColor : Colors.transparent,
              ),
              child: (isSelected!)
                  ? AppSvg.asset(AssetUtils.checkIcon,
                      color: Theme.of(context).primaryColorDark, height: 7.33.h, width: 10.67.w)
                  : null,
            ),
          ),
          SizedBox(width: 15.w),
          Flexible(
            child: Text.rich(TextSpan(
                text: title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.t,
                  fontFamily: StringUtils.isDirectionRTL(context) ? 'Tajawal' : 'Montserrat',
                  color: Theme.of(context).primaryColorDark,
                ),
                children: [
                  TextSpan(
                    text: subTitle,
                    recognizer: new TapGestureRecognizer()..onTap = () => onTermsAndConditionTap?.call(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.t,
                      fontFamily: StringUtils.isDirectionRTL(context) ? 'Tajawal' : 'Montserrat',
                      color: Theme.of(context).accentTextTheme.bodyText1!.color!,
                    ),
                  ),
                ])),
          ),
        ],
      ),
    );
  }
}
