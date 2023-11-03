import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../../generated/l10n.dart';

class OversightDialogView extends StatelessWidget {
  final Function? onSecondaryButton;

  final Function? onPrimaryButton;
  final String? image;
  final String title;
  final String? btnTitle;
  final Widget descriptionWidget;
  final double? imageHight;
  final double? imageWidth;

  final bool onWillPop;
  final bool? imageDisabled;
  final String? secondaryButtonTitle;

  OversightDialogView({
    this.onSecondaryButton,
    this.imageDisabled = false,
    this.onPrimaryButton,
    this.image = AssetUtils.infoBlack,
    required this.title,
    this.secondaryButtonTitle,
    this.btnTitle,
    required this.descriptionWidget,
    this.imageHight = 40,
    this.imageWidth = 40,
    this.onWillPop = true,
  });

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
              Container(
                height: 24.h,
                color: Colors.transparent,
              ),
              Dialog(
                  alignment: Alignment.bottomCenter,
                  insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, top: 56.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                        child: SingleChildScrollView(
                          physics: ClampingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(height: 32.h),
                              !imageDisabled!
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: 25.0.h),
                                      child: AppSvg.asset(
                                        image ?? AssetUtils.infoBlack,
                                        height: imageHight?.h,
                                        width: imageWidth?.w,
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding: EdgeInsetsDirectional.only(start: 24.0.w, end: 24.0.w),
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
                                padding: EdgeInsetsDirectional.only(start: 24.0.w, end: 24.w),
                                child: descriptionWidget,
                              ),
                              SizedBox(height: 30.h),
                              Column(
                                children: [
                                  AppPrimaryButton(
                                    onPressed: () {
                                      onPrimaryButton?.call();
                                    },
                                    text: btnTitle ?? S.of(context).tryAgain,
                                  ),
                                  SizedBox(height: 24.h),
                                  InkWell(
                                    onTap: () {
                                      onSecondaryButton?.call();
                                    },
                                    child: Text(
                                      secondaryButtonTitle ?? S.current.logOutTryLater,
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).textTheme.bodyLarge?.color,
                                        fontSize: 14.t,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 42.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
