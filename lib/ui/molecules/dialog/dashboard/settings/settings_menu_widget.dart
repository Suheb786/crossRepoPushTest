import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SettingsMenuWidget extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String image;
  final String mKey;
  final Widget? dynamicChild;
  final SettingsDialogViewModel model;

  const SettingsMenuWidget(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.image,
      required this.mKey,
      required this.model,
      this.dynamicChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<bool>(
        stream: model.onClickStream,
        initialData: false,
        dataBuilder: (context, onClick) {
          return AppStreamBuilder<int>(
              stream: model.currentStep,
              initialData: 0,
              dataBuilder: (context, currentStep) {
                return InkWell(
                  onTap: (onClick ?? false) ? onTap : null,
                  child: Container(
                    height: 174.0.h,
                    width: 112.0.w,
                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                    decoration: BoxDecoration(
                        color: /*mKey == model.getKeyByIndex(currentStep ?? 0)
                            ? Theme.of(context).textTheme.bodyLarge!.color!
                            :*/ Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 64.0.h,
                            width: 64.0.w,
                            padding: EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 14.0.h),
                            margin: EdgeInsets.only(bottom: 16.0.h),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColor.whiteGrey, width: 1)),
                            child: dynamicChild != null
                                ? dynamicChild
                                : AppSvg.asset(image,
                                    color: /*mKey == model.getKeyByIndex(currentStep ?? 0)
                                        ? Theme.of(context).colorScheme.secondary
                                        : */Theme.of(context).primaryColorDark)),
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w600,
                              color: /*mKey == model.getKeyByIndex(currentStep ?? 0)
                                  ? Theme.of(context).colorScheme.secondary
                                  :*/ Theme.of(context).primaryColorDark,
                              fontSize: 12.0.t),
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
