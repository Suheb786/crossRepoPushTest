import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../button/app_primary_button.dart';

class EfawateerLandingDialogView extends StatelessWidget {
  final Function? onDismissed;
  final bool? isSwipeToCancel;
  final Function? onSelected;
  final String? image;
  final String title;
  final Widget descriptionWidget;

  const EfawateerLandingDialogView(
      {this.onDismissed,
      this.onSelected,
      required this.image,
      required this.title,
      required this.descriptionWidget,
      this.isSwipeToCancel = true});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 56.h, top: 204.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            WillPopScope(
              onWillPop: () async => false,
              child: Container(
                  child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Column(
                  children: [
                    image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                image ?? AssetUtils.apple,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : Container(),
                    SizedBox(height: 25.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont, fontSize: 20.t, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 31.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: descriptionWidget,
                    ),
                    SizedBox(height: 30.h),
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 40.h),
                      child: AppPrimaryButton(
                        onPressed: () {
                          onSelected!.call();
                        },
                        text: S.of(context).confirm,
                      ),
                    )
                  ],
                ),
              )),
            ),
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
        ));
  }
}
