import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class InformationDialogView extends StatelessWidget {
  final Function? onDismissed;
  final bool? isSwipeToCancel;
  final Function? onSelected;
  final String? image;
  final String title;
  final Widget descriptionWidget;

  const InformationDialogView(
      {this.onDismissed,
      this.onSelected,
      required this.image,
      required this.title,
      required this.descriptionWidget,
      this.isSwipeToCancel: true});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 204.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: WillPopScope(
          onWillPop: () async => false,
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                onDismissed?.call();
              }
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 32.h),
                      image != null
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 25.0.h),
                              child: AppSvg.asset(image!, height: 50.h, width: 50.w),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 28.0, end: 28.0),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 20.t, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15),
                        child: descriptionWidget,
                      ),
                      SizedBox(height: 30.h),
                      InkWell(
                        onTap: () {
                          onSelected!.call();
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          height: 57.h,
                          width: 57.w,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                          child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).accentColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 16.h),
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
                                    fontSize: 10.t,
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
