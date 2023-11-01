import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../../generated/l10n.dart';
import '../../../button/app_primary_button.dart';

class InformationDialogView extends StatelessWidget {
  final Function? onDismissed;
  final bool? isSwipeToCancel;
  final Function? onSelected;
  final String? image;
  final String title;
  final String? btnTitle;
  final Widget descriptionWidget;
  final double? imageHight;
  final double? imageWidth;
  final String? doneImage;
  final bool onWillPop;

  InformationDialogView(
      {this.onDismissed,
      this.onSelected,
      required this.image,
      required this.title,
      this.btnTitle,
      required this.descriptionWidget,
      this.isSwipeToCancel = true,
      this.imageHight = 40,
      this.imageWidth = 40,
      this.onWillPop = true,
      this.doneImage});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => onWillPop,
      child: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: 56.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Dialog(
                  alignment: Alignment.bottomCenter,
                  insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, top: 56.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
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
                                SizedBox(height: 30.h),
                                doneImage != null
                                    ? InkWell(
                                        onTap: () {
                                          onSelected!.call();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(16),
                                          height: 57.h,
                                          width: 57.w,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context).textTheme.bodyLarge!.color!),
                                          child: AppSvg.asset(doneImage!,
                                              color: Theme.of(context).colorScheme.secondary),
                                        ),
                                      )
                                    : AppPrimaryButton(
                                        onPressed: () {
                                          onSelected?.call();
                                        },
                                        text: btnTitle ?? S.of(context).confirm,
                                      ),
                                SizedBox(height: 42.h),
                              ],
                            ),
                          )),
                      Positioned(
                        bottom: -24.h,
                        child: InkWell(
                          onTap: () {
                            onDismissed?.call();
                          },
                          child: Container(
                              height: 48.h,
                              width: 48.h,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.secondary),
                              child: Image.asset(
                                AssetUtils.close_bold,
                                scale: 3.5,
                              )),
                        ),
                      )
                    ],
                  )),
              GestureDetector(
                onTap: () {
                  onDismissed?.call();
                },
                child: Container(
                  height: 24.h,
                  color: Colors.transparent,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
