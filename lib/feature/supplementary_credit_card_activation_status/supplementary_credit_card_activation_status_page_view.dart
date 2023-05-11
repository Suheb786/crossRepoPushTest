import 'package:domain/model/card/supplementary_credit_card/supplementary_credit_card_application_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page.dart';
import 'package:neo_bank/feature/supplementary_credit_card_activation_status/supplementary_credit_card_activation_status_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_activation_status_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SupplementaryCreditCardActivationStatusPageView
    extends BasePageViewWidget<SupplementaryCreditCardActivationStatusPageViewModel> {
  SupplementaryCreditCardActivationStatusPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, SupplementaryCreditCardActivationStatusPageViewModel model) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        child: AppStreamBuilder<Resource<bool>>(
            stream: model.supplementaryCreditcardStepThreeStream,
            initialData: Resource.none(),
            onData: (response) {
              if (response.status == Status.SUCCESS) {
                model.getApplication();
              } else if (response.status == Status.ERROR) {
                Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
              }
            },
            dataBuilder: (context, supplementaryCreditCardStepThree) {
              return AppStreamBuilder<Resource<bool>>(
                  stream: model.supplementaryCreditCardStepTwoResponseStream,
                  initialData: Resource.none(),
                  onData: (response) {
                    if (response.status == Status.SUCCESS) {
                      model.getApplication();
                    } else if (response.status == Status.ERROR) {
                      Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                    }
                  },
                  dataBuilder: (context, supplementaryCreditCardStepTwo) {
                    return AppStreamBuilder<Resource<SupplementaryCreditCardApplicationResponse>>(
                        stream: model.getApplicationResponseStream,
                        initialData: Resource.none(),
                        onData: (response) {
                          if (response.status == Status.SUCCESS) {
                            if (!(response.data!.cardApplicationContent![model.index].step2 ?? false)) {
                              Future.delayed(Duration(seconds: 1), () {
                                model.supplementaryCreditCardStepTwoRequest(
                                  cardId: response.data!.cardApplicationContent![model.index].primaryCardId,
                                  secondaryId: response.data!.cardApplicationContent![model.index].supCardId,
                                );
                              });
                            } else if (!(response.data!.cardApplicationContent![model.index].step3!)) {
                              Future.delayed(Duration(seconds: 1), () {
                                model.supplementaryCreditCardStepThree(
                                    cardId: response.data!.cardApplicationContent![model.index].primaryCardId,
                                    secondaryId:
                                        response.data!.cardApplicationContent![model.index].supCardId,
                                    accountNumber: ProviderScope.containerOf(context)
                                            .read(appHomeViewModelProvider)
                                            .dashboardDataContent
                                            .account!
                                            .accountNo ??
                                        '');
                              });
                            } else if (response.data!.cardApplicationContent![model.index].step3!) {
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.pushNamed(context, RoutePaths.CreditCardApplySuccess,
                                    arguments: CreditCardApplySuccessArguments(
                                        creditSuccessState: CreditSuccessState.Applied_Success));
                              });
                            }
                          }
                        },
                        dataBuilder: (context, applicationResponse) {
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
                                              child: Center(child: AppSvg.asset(AssetUtils.right)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 56,
                                    ),
                                    Text(
                                      S.of(context).preparingYourCard,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24,
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    CreditCardActivationStatusWidget(
                                      label: S.of(context).creatingSuppCreditLimit,
                                      isActivated: applicationResponse!
                                              .data!.cardApplicationContent![model.index].step1 ??
                                          false,
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    CreditCardActivationStatusWidget(
                                      label: S.of(context).issuingSuppCreditCard,
                                      isActivated: applicationResponse
                                              .data!.cardApplicationContent![model.index].step2 ??
                                          false,
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    CreditCardActivationStatusWidget(
                                      label: S.of(context).activatingSuppCreditCard,
                                      isActivated: applicationResponse
                                              .data!.cardApplicationContent![model.index].step3 ??
                                          false,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        });
                  });
            }));
  }
}
