import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/biometric_login/biometric_login_dialog_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class BiometricLoginDialogView extends StatelessWidget {
  final Function? mayBeLater;
  final Function? enableBioMetric;

  const BiometricLoginDialogView({this.mayBeLater, this.enableBioMetric});

  ProviderBase providerBase() {
    return biometricLoginViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<BiometricLoginDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)),
              insetPadding:
                  EdgeInsets.only(left: 24, right: 24, bottom: 36, top: 204),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 56),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppSvg.asset(AssetUtils.biometricIcon,
                        color: AppColor.dark_gray_1),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 41),
                        child: Text(
                          S.of(context).enableBiometricLogin,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 24, bottom: 90),
                        child: Text(
                          S.of(context).biometricLoginDesc,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        enableBioMetric?.call();
                      },
                      child: Container(
                        padding: EdgeInsets.all(18),
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context)
                              .accentTextTheme
                              .bodyText1!
                              .color!,
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.black.withOpacity(0.32),
                                blurRadius: 12,
                                spreadRadius: -4,
                                offset: Offset(0, 12)),
                          ],
                        ),
                        child: Center(
                          child: Text(S.of(context).allowBiometric,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.white)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            mayBeLater?.call();
                          },
                          child: Text(
                            S.of(context).mayBeLater,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.brightBlue),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
        },
        providerBase: providerBase());
  }
}
