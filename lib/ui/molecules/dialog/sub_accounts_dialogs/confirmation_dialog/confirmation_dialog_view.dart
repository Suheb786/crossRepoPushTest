import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../utils/asset_utils.dart';
import '../../../app_svg.dart';
import '../../../button/app_primary_button.dart';

class ConfirmationDialogView extends StatelessWidget {
  final Function? onDismissed;
  final bool? isSwipeToCancel;
  final Function? onConfirmed;
  final String? image;
  final String title;
  final Widget descriptionWidget;
  final double? imageHight;
  final double? imageWidth;
  final String? doneImage;
  ConfirmationDialogView(
      {Key? key,
      this.onDismissed,
      this.isSwipeToCancel,
      this.onConfirmed,
      this.image,
      required this.title,
      required this.descriptionWidget,
      this.imageHight,
      this.imageWidth,
      this.doneImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Dialog(
              alignment: Alignment.bottomCenter,
              insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 56.h, top: 56.h),
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
                            AppPrimaryButton(
                              text: S.current.confirm,
                              onPressed: () {
                                onConfirmed?.call();
                              },
                            ),
                            SizedBox(height: 56.h),
                          ],
                        ),
                      )),
                ),
              )),
          Positioned(
            bottom: 32.h,
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
          ),
        ],
      ),
    );
  }
}
