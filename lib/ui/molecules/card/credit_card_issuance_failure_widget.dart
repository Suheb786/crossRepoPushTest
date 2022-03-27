import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class CreditCardIssuanceFailureWidget extends StatelessWidget {
  final double? fontSize;
  final bool isSmallDevices;

  CreditCardIssuanceFailureWidget(
      {this.fontSize, this.isSmallDevices: false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          color: Theme.of(context).primaryColor,
          margin: EdgeInsets.zero,
          shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(AssetUtils.creditBlurCard),
              fit: BoxFit.fill,
              scale: isSmallDevices ? 1.3 : 1,
            )),
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
                      fontSize: isSmallDevices ? 12 : 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
