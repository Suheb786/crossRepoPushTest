import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../../base/base_page.dart';
import '../../../../generated/l10n.dart';
import '../../../../ui/molecules/account_ready/account_details.dart';
import '../../../../ui/molecules/account_ready/account_ready_header.dart';
import '../../../../ui/molecules/app_svg.dart';
import '../../../../ui/molecules/button/app_primary_button.dart';
import '../../../../utils/asset_utils.dart';
import '../../../../utils/color_utils.dart';
import 'open_sub_account_success_page_view_model.dart';

class OpenSubAccountSuccessPageView extends BasePageViewWidget<OpenSubAccountSuccessPageViewModel> {
  OpenSubAccountSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, OpenSubAccountSuccessPageViewModel model) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(top: 92.h),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width.w,
                              child: Image.asset(
                                AssetUtils.line,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.center,
                              child: Container(
                                height: 111.37.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.vividYellow,
                                ),
                                child: Center(child: AppSvg.asset(AssetUtils.right)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 34.h),
                      AccountReadyHeader(
                          descriptionVisibility: true,
                          title: S.of(context).successExclmn,
                          subTitle: S.of(context).openAccountSucessDescription),
                      SizedBox(height: 40.h),
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(16)),
                        margin: EdgeInsets.symmetric(horizontal: 24.w),
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                        child: Column(
                          children: [
                            AccountDetails(
                              title: S.of(context).accountNumber,
                              value: model.argument.accountNo ?? "",
                            ),
                            SizedBox(height: 16.h),
                            AccountDetails(
                              title: S.of(context).iban,
                              value: model.argument.iban ?? "",
                              // showIcon: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w,vertical: 24.h) +
                      EdgeInsetsDirectional.only(bottom: 24.h),
                  child: AppPrimaryButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    activeBackgroundColor: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).textTheme.bodyLarge?.color ?? AppColor.brightBlue,
                    text: S.current.backToDashboard,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
