import 'package:domain/model/agent/agent.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AgentSelectionListWidget extends StatelessWidget {
  final Agent item;

  const AgentSelectionListWidget({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.only(left: 28, right: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: item.isSelected! ? AppColor.very_light_gray : null),
      child: Row(
        children: <Widget>[
          Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.asset(item.icon ?? "",
                color: item.isSelected! ? AppColor.black : AppColor.white),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                item.agent ?? "",
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 14,
                    color: item.isSelected! ? AppColor.black : AppColor.white),
              ),
            ),
          ),
          Visibility(
              visible: item.isSelected!, child: AppSvg.asset(AssetUtils.check))
        ],
      ),
    );
  }
}
