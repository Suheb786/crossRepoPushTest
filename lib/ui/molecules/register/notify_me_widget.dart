import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class NotifyMeWidget extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  final String? labelText;

  const NotifyMeWidget({Key? key, this.onTap, this.title, this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 24.0.h),
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Text(
              title!,
              style:
                  TextStyle(fontFamily: StringUtils.appFont, fontSize: 14.0.t, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 16.0.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
              decoration: BoxDecoration(
                  color: Theme.of(context).textTheme.bodyMedium!.color!,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColor.veryLightGray1, width: 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    labelText!,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 14.t,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Container(
                      height: 16.h,
                      width: 16.w,
                      child: AppSvg.asset(AssetUtils.message, color: Theme.of(context).colorScheme.secondary))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
