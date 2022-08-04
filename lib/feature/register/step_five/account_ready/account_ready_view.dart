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
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AccountReadyView extends BasePageViewWidget<AccountReadyViewModel> {
  AccountReadyView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, AccountReadyViewModel model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          if (!model.arguments.isDocumentUploaded) {
            Navigator.pushReplacementNamed(context, RoutePaths.CardDelivery);
          }
        }
      },
      child: Container(
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
                                      Navigator.pushNamedAndRemoveUntil(context, RoutePaths.OnBoarding,
                                          ModalRoute.withName(RoutePaths.Splash));
                                    }
                                  },
                                  dataBuilder: (context, data) {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.only(top: 43, end: 30),
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
                              padding: EdgeInsets.only(top: 92),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(AssetUtils.line),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 111.37,
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
                              height: 34,
                            ),
                            AccountReadyHeader(
                                title: S.of(context).accountReadyMsg,
                                subTitle: model.arguments.isDocumentUploaded
                                    ? S.of(context).uploadDocWithinTendays
                                    : S.of(context).yourFreeVirtualDebitCardHasBeenIssued),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(16)),
                              margin: EdgeInsets.symmetric(horizontal: 24),
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                              child: Column(
                                children: [
                                  AccountDetails(
                                      title: S.of(context).accountNumber,
                                      value: response.data!.getAccountDetailsContent!.data!.accountNumber),
                                  SizedBox(
                                    height: 16,
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
                      Visibility(
                        visible: !model.arguments.isDocumentUploaded,
                        child: Column(
                          children: [
                            AnimatedButton(
                              buttonText: S.of(context).swipeToProceed,
                              textColor: Theme.of(context).accentColor,
                              borderColor: Theme.of(context).accentColor,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 14.0),
                              child: Text(
                                S.of(context).cardDelivery,
                                style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 32,
                            )
                          ],
                        ),
                      )
                    ],
                  );

                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
                      strokeWidth: 2,
                    ),
                  );

                default:
                  return Center(
                    child: Text('Something went wrong'),
                  );
              }
            },
          )),
    );
  }
}
