import 'package:data/helper/secure_storage_helper.dart';
import 'package:domain/model/bank_smart/get_account_details_response.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infobip_mobilemessaging/infobip_mobilemessaging.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/account_ready/account_details.dart';
import 'package:neo_bank/ui/molecules/account_ready/account_ready_header.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';

import '../../../../ui/molecules/button/app_primary_button.dart';
import '../../../../utils/app_constants.dart';

class AccountReadyView extends BasePageViewWidget<AccountReadyViewModel> {
  AccountReadyView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, AccountReadyViewModel model) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: AppStreamBuilder<Resource<GetAccountDetailsResponse>>(
          stream: model.getAccountDetailsStream,
          initialData: Resource.none(),
          onData: (data) {
            var event = {
              "definitionId": "UserAccountDetails",
              "properties": {
                "accountNumber": data.data!.getAccountDetailsContent!.data!.accountNumber.toString(),
              }
            };
            InfobipMobilemessaging.submitEventImmediately(event);
          },
          dataBuilder: (context, response) {
            switch (response!.status) {
              case Status.SUCCESS:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: model.arguments.isDocumentUploaded,
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: AppStreamBuilder<Resource<LogoutResponse>>(
                                stream: model.logoutStream,
                                initialData: Resource.none(),
                                onData: (response) {
                                  if (response.status == Status.SUCCESS) {
                                    SecureStorageHelper.instance.clearToken();
                                    AppConstantsUtils.resetCacheLists();
                                    Navigator.pushNamedAndRemoveUntil(context, RoutePaths.OnBoarding,
                                        ModalRoute.withName(RoutePaths.Splash));
                                  }
                                },
                                dataBuilder: (context, data) {
                                  return Padding(
                                    padding: EdgeInsetsDirectional.only(top: 43.h, end: 30.w),
                                    child: InkWell(
                                      onTap: () {
                                        model.logOutUser();
                                      },
                                      child: AppSvg.asset(AssetUtils.logout, matchTextDirection: true),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 92.h),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(AssetUtils.line),
                                Align(
                                  alignment: Alignment.center,
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
                          SizedBox(
                            height: 34.h,
                          ),
                          AccountReadyHeader(
                              descriptionVisibility: false,
                              title: S.of(context).accountReadyMsg,
                              subTitle: model.arguments.isDocumentUploaded
                                  ? S.of(context).uploadDocWithinTendays
                                  : S.of(context).yourFreeVirtualDebitCardHasBeenIssued),
                          SizedBox(
                            height: 40.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(16)),
                            margin: EdgeInsets.symmetric(horizontal: 24.w),
                            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                            child: Column(
                              children: [
                                AccountDetails(
                                    title: S.of(context).accountNumber,
                                    value: response.data!.getAccountDetailsContent!.data!.accountNumber),
                                SizedBox(
                                  height: 16.h,
                                ),
                                AccountDetails(
                                  title: S.of(context).iban,
                                  value: response.data!.getAccountDetailsContent!.data!.iban,
                                  showIcon: true,
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
                          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                          child: AppPrimaryButton(
                            text: S.of(context).next,
                            onPressed: () {
                              if (!model.arguments.isDocumentUploaded) {
                                Navigator.pushReplacementNamed(context, RoutePaths.CardDelivery);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        )
                      ],
                    )
                  ],
                );

              case Status.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
                    strokeWidth: 2,
                  ),
                );

              default:
                return Container();
            }
          },
        ));
  }
}
