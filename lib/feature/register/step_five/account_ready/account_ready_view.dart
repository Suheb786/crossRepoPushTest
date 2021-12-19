import 'package:domain/model/bank_smart/get_account_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class AccountReadyView extends BasePageViewWidget<AccountReadyViewModel> {
  AccountReadyView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, AccountReadyViewModel model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.pushReplacementNamed(context, RoutePaths.CardDelivery);
        }
      },
      child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme
              .of(context)
              .primaryColor,
          child: AppStreamBuilder<Resource<GetAccountDetailsResponse>>(
            stream: model.getAccountDetailsStream,
            initialData: Resource.none(),
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
                                      child: Center(
                                          child:
                                          AppSvg.asset(AssetUtils.right)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 34,
                            ),
                            AccountReadyHeader(
                                title: S
                                    .of(context)
                                    .accountCreated,
                                subTitle: S
                                    .of(context)
                                    .accountReady),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              height: 104,
                              width: 327,
                              decoration: BoxDecoration(
                                  color: Theme
                                      .of(context)
                                      .cardColor,
                                  borderRadius: BorderRadius.circular(16)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 24),
                              child: Column(
                                children: [
                                  AccountDetails(
                                      title: S
                                          .of(context)
                                          .refTitle,
                                      value: response
                                          .data!
                                          .getAccountDetailsContent!
                                          .data!
                                          .accountNumber),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  AccountDetails(
                                    title: S
                                        .of(context)
                                        .iban,
                                    value: response.data!
                                        .getAccountDetailsContent!.data!.iban,
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
                          AnimatedButton(
                            buttonText: S
                                .of(context)
                                .swipeToProceed,
                            textColor: Theme
                                .of(context)
                                .accentColor,
                            borderColor: Theme
                                .of(context)
                                .accentColor,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 14.0),
                            child: Text(
                              S
                                  .of(context)
                                  .cardDelivery,
                              style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .accentColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          )
                        ],
                      )
                    ],
                  );

                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme
                              .of(context)
                              .accentColor),
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
