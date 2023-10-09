import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/sub_account/transfer/transfer_success/transfer_success_page_view_model.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../../base/base_page.dart';
import '../../../../generated/l10n.dart';
import '../../../../ui/molecules/app_svg.dart';
import '../../../../utils/asset_utils.dart';
import '../../../../utils/color_utils.dart';
import '../../../../utils/string_utils.dart';

class TransferSuccessPageView extends BasePageViewWidget<TransferSuccessPageViewModel> {
  TransferSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, TransferSuccessPageViewModel model) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 72.h),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            AssetUtils.line,
                            color: AppColor.softRed,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 111.37,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).canvasColor,
                            ),
                            child: Center(
                              child:
                                  AppSvg.asset(AssetUtils.right, color: Theme.of(context).primaryColorDark),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        model.argument.amount.toStringAsFixed(3),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontWeight: FontWeight.w700,
                            fontSize: 32.t,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      SizedBox(width: 4.w),
                      Padding(
                        padding: EdgeInsetsDirectional.only(top: 8.h),
                        child: Text(
                          S.of(context).JOD,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.t,
                              color: AppColor.very_light_red),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    S.current.sentTo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w500,
                        fontSize: 24.t,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    model.argument.accountName,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.t,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    model.argument.accountNo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.t,
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w),
                  child: AppPrimaryButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                      ProviderScope.containerOf(context)
                          .read(appHomeViewModelProvider)
                          .closeSubAccountDialogAndRefreshPage();
                    },
                    activeBackgroundColor: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).textTheme.bodyLarge?.color ?? AppColor.brightBlue,
                    text: S.current.backToDashboard,
                  ),
                ),
                SizedBox(height: 56.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}
