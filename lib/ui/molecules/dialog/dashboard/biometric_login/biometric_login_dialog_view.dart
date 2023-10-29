import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/biometric_login/biometric_login_dialog_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class BiometricLoginDialogView extends StatelessWidget {
  final Function? mayBeLater;
  final Function? enableBioMetric;
  final bool onWillPop;

  const BiometricLoginDialogView({this.mayBeLater, this.enableBioMetric, this.onWillPop = true});

  ProviderBase providerBase() {
    return biometricLoginViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => onWillPop,
      child: BaseWidget<BiometricLoginDialogViewModel>(
          builder: (context, model, child) {
            return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 204.h),
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 56.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppSvg.asset(AssetUtils.biometricIcon, color: AppColor.dark_gray_1),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 41.h),
                          child: Text(
                            S.of(context).enableBiometricLogin,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 20.t,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 24.h, bottom: 90.h),
                          child: Text(
                            S.of(context).biometricLoginDesc,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 14.t,
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
                            color: Theme.of(context).textTheme.bodyLarge!.color!,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColor.black.withOpacity(0.32),
                                  blurRadius: 12,
                                  spreadRadius: -4,
                                  offset: Offset(0, 12)),
                            ],
                          ),
                          child: Center(
                            child: Text(S.of(context).enable,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 14.t,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1,
                                    color: AppColor.white)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25.0.h),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              mayBeLater?.call();
                            },
                            child: Text(
                              S.of(context).mayBeLater,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 14.t,
                                  letterSpacing: 1,
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
          providerBase: providerBase()),
    );
  }
}
