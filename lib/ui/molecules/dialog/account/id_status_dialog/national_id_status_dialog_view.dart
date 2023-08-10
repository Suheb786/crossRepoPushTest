import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../button/app_primary_button.dart';

class NationalIDStatusDialogView extends StatelessWidget {
  final Function? onDismissed;
  final bool? isSwipeToCancel;
  final Function? onSelected;
  final String? image;
  final String title;
  final Widget descriptionWidget;
  final double? imageHight;
  final double? imageWidth;
  final String? doneImage;

  const NationalIDStatusDialogView(
      {this.onDismissed,
      this.onSelected,
      required this.image,
      required this.title,
      required this.descriptionWidget,
      this.isSwipeToCancel = true,
      this.imageHight = 40,
      this.imageWidth = 40,
      this.doneImage});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        alignment: Alignment.bottomCenter,
        insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 56.h, top: 56.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: WillPopScope(
          onWillPop: () async => false,
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
                            child: AppSvg.asset(
                              image!,
                              height: imageHight?.h,
                              width: imageWidth?.w,
                            ),
                          )
                        : Container(),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 28.0, end: 28.0),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                            fontFamily: StringUtils.appFont,
                            fontSize: 20.t,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15),
                      child: descriptionWidget,
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: AppPrimaryButton(
                        onPressed: () {
                          onSelected!.call();
                        },
                        text: S.of(context).done,
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
