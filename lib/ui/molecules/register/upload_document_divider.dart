import 'package:flutter/cupertino.dart';
import 'package:neo_bank/utils/color_utils.dart';

class UploadDocumentDivider extends StatelessWidget {
  final String? text;
  const UploadDocumentDivider({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
                color: AppColor.white.withOpacity(0.3),
                border: Border.all(
                    color: AppColor.very_light_gray_1.withOpacity(0.3),
                    width: 1)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text!,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColor.dark_grayish_violet1),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
                color: AppColor.white.withOpacity(0.3),
                border: Border.all(
                    color: AppColor.very_light_gray_1.withOpacity(0.3),
                    width: 1)),
          ),
        ),
      ],
    );
  }
}
