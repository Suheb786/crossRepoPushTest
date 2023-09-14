import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../button/app_primary_button.dart';

class RjDialogView extends StatelessWidget {
  final Function? onDismissed;
  final bool? isSwipeToCancel;
  final Function? onSelected;
  final String image;
  final String title;
  final Widget descriptionWidget;

  const RjDialogView(
      {this.onDismissed,
      this.onSelected,
      required this.image,
      required this.title,
      required this.descriptionWidget,
      this.isSwipeToCancel = true});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 56.h),
        child: Dialog(
            insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, top: 204.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
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
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 166,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0.0),
                              topRight: Radius.circular(0.0),
                            ),
                          ),
                          child: Image.asset(
                            image,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColor.very_dark_gray),
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: descriptionWidget,
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 40.h),
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
            )),
      ),
    );
  }
}
