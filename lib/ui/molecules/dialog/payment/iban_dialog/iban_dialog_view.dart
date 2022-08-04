import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/iban_dialog/iban_dialog_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class IbanDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String, String)? onSelected;

  const IbanDialogView({this.onDismissed, this.onSelected});

  ProviderBase providerBase() {
    return ibanDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<IbanDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            insetPadding: EdgeInsets.only(left: 24, right: 24, bottom: 36),
            backgroundColor: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(16)),
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      S.of(context).ibanNotBlink,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Text(S.of(context).ibanOutsideBlink,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont, fontWeight: FontWeight.w400, fontSize: 14))),
                    Padding(
                      padding: EdgeInsets.only(top: 48),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          height: 57,
                          width: 57,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                          child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).accentColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        providerBase: providerBase());
  }
}
