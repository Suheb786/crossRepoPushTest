import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CreditCardActivationStatusWidget extends StatelessWidget {
  final String label;
  final bool isActivated;

  const CreditCardActivationStatusWidget({Key? key, required this.label, this.isActivated: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              isActivated
                  ? AppSvg.asset(AssetUtils.tick, color: Theme.of(context).accentColor)
                  : Container(
                      height: 24,
                      width: 24,
                    ),
              SizedBox(
                width: 16,
              ),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isActivated
                          ? Theme.of(context).accentColor
                          : Theme.of(context).accentColor.withOpacity(0.3)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
