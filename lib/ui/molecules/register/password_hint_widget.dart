import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class PasswordHintWidget extends StatelessWidget {
  final String? label;
  final Color? backgroundColor;
  final bool? isValid;

  const PasswordHintWidget(
      {Key? key, this.label, this.isValid, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(100)),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isValid! ? AppSvg.asset(AssetUtils.check_icon) : Container(),
          SizedBox(
            width: 6,
          ),
          Text(
            label!,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).accentColor),
          )
        ],
      ),
    );
  }
}
