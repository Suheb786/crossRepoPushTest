import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/dialog/evoucher/evoucher_landing_page_dialog/evoucher_landing_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class EVoucherMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text(
              'EVoucher',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Montserrat',
              ),
            ),
            onPressed: () {
              EvoucherDialog.show(context,
                  image: AssetUtils.mobile,
                  title: S.of(context).eVouchersAreHere,
                  descriptionWidget: Text(
                    S.of(context).eVoucherLandingDialogDescption,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ), onDismissed: () {
                Navigator.pop(context);
              }, onSelected: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, RoutePaths.Evoucher);
                // model.sendOtpTokenMobile();
              });
            },
          ),
        ),
      ),
    );
  }
}
