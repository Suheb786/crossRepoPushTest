import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/account/agent_gender_status.dart';
import 'package:domain/model/account/request_call_status.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_video_kyc/credit_card_video_kyc_page.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_videocall_initiate/credit_card_videocall_initiate_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class CreditCardVideoCallInitiatePageView
    extends BasePageViewWidget<CreditCardVideoCallInitiatePageViewModel> {
  CreditCardVideoCallInitiatePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<Resource<AgentGenderStatus>>(
        stream: model.getAgentAvailabilityStream,
        initialData: Resource.none(),
        onData: (data) {
          if (data.status == Status.SUCCESS) {
            if (data.data!.isExist) {
              model.getAgoraCredentials();
            } else {
              model.showToastWithError(AppError(
                  cause: Exception(),
                  error: ErrorInfo(message: ''),
                  type: ErrorType.AGENT_NOT_AVAILABLE));
              Navigator.popUntil(
                  context, ModalRoute.withName(RoutePaths.AppHome));
              ProviderScope.containerOf(context)
                  .read(appHomeViewModelProvider)
                  .getDashboardData();
            }
          }
        },
        dataBuilder: (context, snapshot) {
          return AppStreamBuilder<Resource<RequestCallStatus>>(
              initialData: Resource.none(),
              stream: model.requestCallStream,
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  Navigator.pushNamed(context, RoutePaths.CreditCardVideoKyc,
                      arguments: CreditCardVideKycCredentials(
                          token: data.data!.conferenceLink,
                          channelName: data.data!.callId,
                          cardId: model.creditCardVideoCallInitiateArgs
                                  .creditCard.cardId ??
                              ''));
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.only(
                      top: 56.0, left: 24, right: 24, bottom: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: AppSvg.asset(AssetUtils.leftArrow,
                              color: Theme.of(context).accentColor,
                              height: 24,
                              width: 24)),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          S.of(context).applyForCreditCard,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          S.of(context).timeForQuickVideoCall,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Expanded(
                          child: Card(
                        elevation: 10,
                        shadowColor: Theme.of(context).primaryColorDark,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 35.0, bottom: 24),
                                  child: Container(
                                    // height: 78,
                                    // width: 78,
                                    padding: EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: AppColor.vividYellow,
                                      shape: BoxShape.circle,
                                    ),
                                    child: AppSvg.asset(AssetUtils.ccAgent,
                                        width: 32,
                                        height: 32,
                                        color:
                                            Theme.of(context).primaryColorDark),
                                  ),
                                ),
                                Text(
                                  S.of(context).weWillConnectYouInBlink,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color:
                                          Theme.of(context).primaryColorDark),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, bottom: 32),
                              child: Text(
                                S
                                    .of(context)
                                    .thankYouForWaitingCallWillStartAutomatically,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: AppColor.very_dark_gray1),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                );
              });
        });
  }
}
