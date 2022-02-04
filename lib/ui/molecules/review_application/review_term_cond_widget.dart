import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

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
                    color: Theme.of(context)
                        .inputDecorationTheme
                        .hintStyle!
                        .color!),
                shape: BoxShape.circle,
                color: isSelected!
                    ? Theme.of(context).canvasColor
                    : Colors.transparent,
              ),
              child: (isSelected!)
                  ? AppSvg.asset(AssetUtils.checkIcon,
                      color: Theme.of(context).primaryColorDark,
                      height: 7.33,
                      width: 10.67)
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
                  TextSpan(
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () => onTermsAndConditionTap?.call(),
                      children: [
                        TextSpan(
                          text: subTitle,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            fontFamily: 'Montserrat',
                            color: Theme.of(context)
                                .accentTextTheme
                                .bodyText1!
                                .color!,
                          ),
                        )
                      ]),
                ])),
          ),
        ],
      ),
    );
  }
}
