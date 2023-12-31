import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class BottomBarWidgetItem extends StatelessWidget {
  final String image;
  final String label;
  final Function() onTap;

  const BottomBarWidgetItem({Key? key, required this.image, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap.call();
      },
      child: Container(
        width: 72.w,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppSvg.asset(image, height: 32.h, width: 32.w),
            SizedBox(
              height: 8.h,
            ),
            StringUtils.isDirectionRTL(context)
                ? Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.displayMedium?.color,
                        fontSize: 14.t,
                        fontWeight: FontWeight.w600,
                        fontFamily: StringUtils.appFont),
                  )
                : FittedBox(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.displayMedium?.color,
                          fontSize: 14.t,
                          fontWeight: FontWeight.w600,
                          fontFamily: StringUtils.appFont),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
