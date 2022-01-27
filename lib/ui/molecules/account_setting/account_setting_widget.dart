import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AccountSettingWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;
  final Function()? onTap;

  const AccountSettingWidget(
      {Key? key, this.image, this.title, this.subtitle: '', this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Row(
        children: [
          AppSvg.asset(image!),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                SizedBox(
                  height: 2,
                ),
                subtitle!.isNotEmpty
                    ? Text(
                        subtitle ?? '',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColor.gray),
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
              height: 24,
              width: 24,
              child: AppSvg.asset(AssetUtils.rightChevron,
                  color:
                      Theme.of(context).inputDecorationTheme.hintStyle!.color))
        ],
      ),
    );
  }
}
