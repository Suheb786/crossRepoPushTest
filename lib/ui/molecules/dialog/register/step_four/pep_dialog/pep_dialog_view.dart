import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PEPDialogView extends StatelessWidget {
  final Function()? onSelected;
  final Function? onDismissed;

  final bool onWillPop;

  const PEPDialogView({this.onSelected, this.onWillPop = true, this.onDismissed});

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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          S.of(context).whatIsPEP,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont, fontSize: 20.t, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 34.0.h, bottom: 16.h),
                        child: Text.rich(TextSpan(
                            text: S.of(context).politicallyExposedPerson,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14.t,
                              fontFamily: StringUtils.appFont,
                              color: AppColor.very_dark_gray_black,
                            ),
                            children: [
                              TextSpan(
                                text: S.of(context).pepDesc,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.t,
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.very_dark_gray_black,
                                ),
                              )
                            ])),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 20.w, end: 20.w),
                        child: AppPrimaryButton(
                          // isDisabled: isValid!,
                          isDisabled: false,

                          onPressed: () {
                            onSelected?.call();
                          },

                          text: S.of(context).confirm,
                        ),
                      ),
                    ],
                  ),
                ),
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
              ),
            ],
          )),
    );
  }
}
