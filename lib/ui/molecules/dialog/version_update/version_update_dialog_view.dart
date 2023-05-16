import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class VersionUpdateDialogView extends StatelessWidget {
  final Function? onSelected;
  final String? image;
  final String title;
  final Widget descriptionWidget;

  const VersionUpdateDialogView({
    this.onSelected,
    required this.image,
    required this.title,
    required this.descriptionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 204.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 41.h),
                    image != null ? AppSvg.asset(image!, height: 50.h, width: 50.w) : Container(),
                    SizedBox(height: 25.h),
                    Text(
                      title,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 20.t,
                          fontWeight: FontWeight.w600,
                          color: AppColor.very_dark_gray),
                    ),
                    SizedBox(height: 31.h),
                    descriptionWidget,
                    SizedBox(height: 30.h),
                    InkWell(
                      onTap: () {
                        onSelected!.call();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        height: 57.h,
                        width: 57.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyLarge?.color!),
                        child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              )),
        ));
  }
}
