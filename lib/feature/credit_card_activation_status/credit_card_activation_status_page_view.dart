import 'package:domain/model/card/get_card_applications/get_card_application_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/credit_card_activation_status/credit_card_activation_status_page_view_model.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/card/credit_card_activation_status_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CreditCardActivationStatusPageView extends BasePageViewWidget<CreditCardActivationStatusPageViewModel> {
  CreditCardActivationStatusPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CreditCardActivationStatusPageViewModel model) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        child: AppStreamBuilder<Resource<bool>>(
            stream: model.processLoanStepStream,
            initialData: Resource.none(),
            onData: (response) {
              if (response.status == Status.SUCCESS) {
                model.getApplication();
              } else if (response.status == Status.ERROR) {
                Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
              }
            },
            dataBuilder: (context, processLoanStepResponse) {
              return AppStreamBuilder<Resource<bool>>(
                  stream: model.linkCardStepStream,
                  initialData: Resource.none(),
                  onData: (response) {
                    if (response.status == Status.SUCCESS) {
                      model.getApplication();
                    } else if (response.status == Status.ERROR) {
                      Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                    }
                  },
                  dataBuilder: (context, linkCardStepResponse) {
                    return AppStreamBuilder<Resource<bool>>(
                        stream: model.creditCardReqResponseStream,
                        initialData: Resource.none(),
                        onData: (response) {
                          if (response.status == Status.SUCCESS) {
                            model.getApplication();
                          } else if (response.status == Status.ERROR) {
                            Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                          }
                        },
                        dataBuilder: (context, applicationResponse) {
                          return AppStreamBuilder<Resource<GetCardApplicationResponse>>(
                            stream: model.getApplicationResponseStream,
                            initialData: Resource.none(),
                            onData: (response) {
                              if (response.status == Status.SUCCESS) {
                                if (!(response.data!.cardApplicationContent!.first.processLoanStep!)) {
                                  model.processLoanStep(
                                      response.data!.cardApplicationContent!.first.cardId ?? '',
                                      response.data!.cardApplicationContent!.first.loanValueId ?? 0);
                                } else if (!(response.data!.cardApplicationContent!.first.issueCardOnNI!)) {
                                  Future.delayed(Duration(seconds: 1), () {
                                    model.creditCardRequest(
                                        response.data!.cardApplicationContent!.first.cardId!);
                                  });
                                } else if (!(response.data!.cardApplicationContent!.first.finalStep!)) {
                                  Future.delayed(Duration(seconds: 1), () {
                                    model.linkCardStep(
                                        response.data!.cardApplicationContent!.first.cardId!,
                                        ProviderScope.containerOf(context)
                                            .read(appHomeViewModelProvider)
                                            .dashboardDataContent
                                            .account!
                                            .accountNo!);
                                  });
                                } else if (response.data!.cardApplicationContent!.first.finalStep!) {
                                  ///LOGGING EVENT TO APP FLYER
                                  model.logEventsForAppFlyer(
                                      eventName: 'credit_card_request',
                                      eventValue: {"credit_card_requested": true});
                                  Future.delayed(Duration(seconds: 1), () {
                                    Navigator.pushNamed(context, RoutePaths.CreditCardApplySuccess,
                                        arguments: CreditCardApplySuccessArguments(
                                            creditSuccessState: CreditSuccessState.Applied_Success));
                                  });
                                }
                              }
                            },
                            dataBuilder: (context, applicationResponse) {
                              switch (applicationResponse!.status) {
                                case Status.SUCCESS:
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
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
                                              height: 56.h,
                                            ),
                                            Text(
                                              S.of(context).preparingYourCard,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 24.t,
                                                  color: Theme.of(context).colorScheme.secondary),
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            CreditCardActivationStatusWidget(
                                              label: S.of(context).creatingCreditCardLimit,
                                              isActivated: applicationResponse
                                                      .data!.cardApplicationContent!.first.processLoanStep ??
                                                  false,
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            CreditCardActivationStatusWidget(
                                              label: S.of(context).issuingYourCreditCard,
                                              isActivated: applicationResponse
                                                      .data!.cardApplicationContent!.first.issueCardOnNI ??
                                                  false,
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            CreditCardActivationStatusWidget(
                                              label: S.of(context).activatingCreditCard,
                                              isActivated: applicationResponse
                                                      .data!.cardApplicationContent!.first.finalStep ??
                                                  false,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );

                                default:
                                  return Container();
                              }
                            },
                          );
                        });
                  });
            }));
  }
}
