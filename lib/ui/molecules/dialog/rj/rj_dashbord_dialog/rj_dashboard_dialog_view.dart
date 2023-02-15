import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RjDialogView extends StatelessWidget {
  final Function? onDismissed;
  final bool? isSwipeToCancel;
  final Function? onSelected;
  final String image;
  final String title;
  final Widget descriptionWidget;

  const RjDialogView(
      {this.onDismissed,
      this.onSelected,
      required this.image,
      required this.title,
      required this.descriptionWidget,
      this.isSwipeToCancel: true});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18.0),
          bottomRight: Radius.circular(18.0),
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        )),
        child: WillPopScope(
          onWillPop: () async => false,
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                onDismissed?.call();
              }
            },
            child: Container(
                child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 166,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                      ),
                    ),
                    child: Image.asset(
                      image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppColor.very_dark_gray),
                    ),
                  ),
                  SizedBox(height: 31),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: descriptionWidget,
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      onSelected!.call();
                    },
                    child: Container(
                      padding: EdgeInsetsDirectional.all(16),
                      height: 57,
                      width: 57,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                      child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).accentColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 8.0, bottom: 16),
                    child: Visibility(
                      visible: isSwipeToCancel ?? true,
                      child: InkWell(
                        onTap: () {
                          onDismissed!.call();
                        },
                        child: Center(
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
                  ),
                ],
              ),
            )),
          ),
        ));
  }
}
