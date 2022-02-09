import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class CreatePasswordHintWidget extends StatelessWidget {
  final String? label;
  final bool? isValid;

  const CreatePasswordHintWidget({Key? key, this.label, this.isValid: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isValid!
              ? Theme.of(context).primaryColorDark
              : Theme.of(context).inputDecorationTheme.hintStyle!.color,
          borderRadius: BorderRadius.circular(100)),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSvg.asset(AssetUtils.check_icon, width: 8, height: 8),
          SizedBox(
            width: 4,
          ),
          Text(
            label!,
            style: TextStyle(
                fontSize: 12, height: 1, color: Theme.of(context).accentColor),
          )
        ],
      ),
    );
  }
}
