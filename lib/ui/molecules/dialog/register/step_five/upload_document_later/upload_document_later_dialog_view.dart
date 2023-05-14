import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class UploadDocumentLaterDialogView extends StatelessWidget {
  final Function()? onSelected;
  final ScrollController scrollController = ScrollController();

  UploadDocumentLaterDialogView({this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 204.h),
        child: GestureDetector(
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              Navigator.pop(context);
            }
          },
          child: Container(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 32.h, bottom: 36.h),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      S.of(context).uploadDocumentLaterQues,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont, fontSize: 20.t, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 34.0.h, bottom: 157.h),
                    child: Text.rich(TextSpan(
                        text: S.of(context).uploadDocLaterDesc,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.t,
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).primaryTextTheme.bodyLarge?.color,
                        ),
                        children: [
                          TextSpan(
                            text: S.of(context).uploadDocumentDesc1,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.t,
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).textTheme.bodyMedium!.color!,
                            ),
                          )
                        ])),
                  ),
                  InkWell(
                    onTap: () {
                      onSelected!.call();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      height: 57.h,
                      width: 57.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyMedium!.color!),
                      child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0.h),
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
                ],
              ),
            ),
          ),
        ));
  }
}
