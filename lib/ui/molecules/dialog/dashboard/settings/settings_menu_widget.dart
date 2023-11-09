import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SettingsMenuWidget extends StatelessWidget {
  final String title;
  final String image;
  final String mKey;
  final Widget? dynamicChild;
  final SettingsDialogViewModel model;

  const SettingsMenuWidget(
      {Key? key,
      required this.title,
      required this.image,
      required this.mKey,
      required this.model,
      this.dynamicChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<int>(
        stream: model.menuTappedIndexStream,
        initialData: -1,
        dataBuilder: (context, tappedMenuIndex) {
          return AppStreamBuilder<int>(
              stream: model.currentStep,
              initialData: 0,
              dataBuilder: (context, currentStep) {
                return Container(
                  height: 174.0.h,
                  width: 102.0.w,
                  decoration: BoxDecoration(
                      color: (/*currentStep == tappedMenuIndex &&*/
                              mKey == model.getKeyByIndex(tappedMenuIndex ?? -1))
                          ? Theme.of(context).textTheme.bodyLarge!.color!
                          : Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                          height: 64.0.h,
                          width: 64.0.h,
                          // padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 14.0.h),
                          margin: EdgeInsets.only(top: 22.h),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColor.whiteGrey, width: 1)),
                          child: dynamicChild != null
                              ? dynamicChild
                              : AppSvg.asset(image,
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.scaleDown,
                                  color: (/*currentStep == tappedMenuIndex &&*/
                                          mKey == model.getKeyByIndex(tappedMenuIndex ?? -1))
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context).textTheme.bodyLarge!.color!)),
                      Spacer(),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontWeight: FontWeight.w600,
                            color: (/*currentStep == tappedMenuIndex &&*/
                                    mKey == model.getKeyByIndex(tappedMenuIndex ?? -1))
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).primaryColorDark,
                            fontSize: 12.0.t),
                      ),
                      Spacer(),
                    ],
                  ),
                );
              });
        });
  }
}
