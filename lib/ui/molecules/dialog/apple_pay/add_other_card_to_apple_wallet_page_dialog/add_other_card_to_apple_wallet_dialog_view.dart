import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AddOtherCardToAppleWalletDialogView extends StatelessWidget {
  final Function? onDismissed;
  final bool? isSwipeToCancel;
  final Function? onSelected;
  final String? image;
  final String title;
  final Widget descriptionWidget;
  final bool onWillPop;

  const AddOtherCardToAppleWalletDialogView(
      {this.onDismissed,
      this.onSelected,
      required this.image,
      required this.title,
      required this.descriptionWidget,
      this.isSwipeToCancel = true,
      this.onWillPop = true});

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
                  insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, top: 204.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                          child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 32.h,
                            ),
                            image != null
                                ? Container(
                                    margin: EdgeInsets.only(bottom: 16.h),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(15.0),
                                      ),
                                    ),
                                    child: AppSvg.asset(
                                      image ?? AssetUtils.applePayIcon,
                                    ))
                                : Container(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                              child: Text(
                                title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 20.t,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(height: 31.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                              child: descriptionWidget,
                            ),
                            SizedBox(height: 30.h),
                            Padding(
                              padding: EdgeInsets.only(left: 16.0.w, right: 16.w, bottom: 42.h),
                              child: AppPrimaryButton(
                                text: S.of(context).confirm,
                                onPressed: () {
                                  onSelected!.call();
                                },
                              ),
                            ),
                          ],
                        ),
                      ))
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
