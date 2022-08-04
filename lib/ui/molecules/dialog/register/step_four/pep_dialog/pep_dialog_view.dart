import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PEPDialogView extends StatelessWidget {
  final Function()? onSelected;

  const PEPDialogView({this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        insetPadding: EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              onSelected?.call();
            }
          },
          child: Container(
            padding: EdgeInsets.only(left: 24, right: 24, top: 32, bottom: 36),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      S.of(context).whatIsPEP,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont, fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 34.0, bottom: 16),
                    child: Text.rich(TextSpan(
                        text: S.of(context).politicallyExposedPerson,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: StringUtils.appFont,
                          color: AppColor.very_dark_gray_black,
                        ),
                        children: [
                          TextSpan(
                            text: S.of(context).pepDesc,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: StringUtils.appFont,
                              color: AppColor.very_dark_gray_black,
                            ),
                          )
                        ])),
                  ),
                  InkWell(
                    onTap: () {
                      onSelected!.call();
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      height: 57,
                      width: 57,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).accentTextTheme.bodyText1!.color,
                      ),
                      child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).accentColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          onSelected?.call();
                        },
                        child: Text(
                          S.of(context).swipeDownToCancel,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColor.dark_gray_1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
