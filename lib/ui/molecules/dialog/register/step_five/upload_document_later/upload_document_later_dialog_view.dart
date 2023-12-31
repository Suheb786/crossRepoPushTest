import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class UploadDocumentLaterDialogView extends StatelessWidget {
  final Function()? onSelected;
  final ScrollController scrollController = ScrollController();
  final bool onWillPop;

  UploadDocumentLaterDialogView({this.onSelected, this.onWillPop = true});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => onWillPop,
      child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 56.h, top: 204.h),
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
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
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                            children: [
                              TextSpan(
                                text: S.of(context).uploadDocumentDesc1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.t,
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).textTheme.bodyLarge!.color!,
                                ),
                              )
                            ])),
                      ),

                      AppPrimaryButton(
                        isDisabled: false,
                        onPressed: () {
                          onSelected!.call();
                        },
                        text: S.of(context).confirm,
                      ),
                      SizedBox(height: 40.h),

                      // InkWell(
                      //   onTap: () {
                      //     onSelected!.call();
                      //   },
                      //   child: Container(
                      //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      //     height: 57.h,
                      //     width: 57.w,
                      //     decoration: BoxDecoration(
                      //         shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyLarge!.color!),
                      //     child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).colorScheme.secondary),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 8.0.h),
                      //   child: Center(
                      //     child: Text(
                      //       S.of(context).swipeDownToCancel,
                      //       style: TextStyle(
                      //           fontFamily: StringUtils.appFont,
                      //           fontSize: 10.t,
                      //           fontWeight: FontWeight.w400,
                      //           color: AppColor.dark_gray_1),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -24.h,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
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
          )),
    );
  }
}
