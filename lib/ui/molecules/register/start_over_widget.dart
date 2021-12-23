import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class StartOverWidget extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  final String? labelText;

  const StartOverWidget({Key? key, this.onTap, this.title, this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
          color: AppColor.vividYellow,
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(
            title!,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
                color: Theme
                    .of(context)
                    .primaryColorDark),
          ),
          // SizedBox(
          //   height: 24,
          // ),
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(8),
          //       border: Border.all(color: AppColor.veryLightGray1, width: 1)),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         labelText!,
          //         style: TextStyle(
          //             fontSize: 14,
          //             fontWeight: FontWeight.w600,
          //             fontFamily: 'Montserrat',
          //             color: AppColor.vivid_orange),
          //       ),
          //       InkWell(
          //         onTap: () {
          //           onTap?.call();
          //         },
          //         child: Container(
          //             height: 16,
          //             width: 16,
          //             child: AppSvg.asset(AssetUtils.restart)),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
