import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class CreditCardIssuanceFailureWidget extends StatelessWidget {
  const CreditCardIssuanceFailureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 135),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppSvg.asset(AssetUtils.failure),
          SizedBox(
            height: 16,
          ),
          Text(
            S.of(context).creditCardIssuanceFailure,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
