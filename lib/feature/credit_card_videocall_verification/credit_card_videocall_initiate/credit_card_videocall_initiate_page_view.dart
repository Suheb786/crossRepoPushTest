import 'dart:io';

import 'package:domain/model/account/agent_gender_status.dart';
import 'package:domain/model/account/request_call_status.dart';
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
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class CreditCardVideoCallInitiatePageView
    extends BasePageViewWidget<CreditCardVideoCallInitiatePageViewModel> {
  CreditCardVideoCallInitiatePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<Resource<AgentGenderStatus>>(
        stream: model.getAgentAvailabilityStream,
        initialData: Resource.none(),
        onData: (data) async {
          if (data.status == Status.SUCCESS) {
            if (data.data!.isExist) {
              if (Platform.isAndroid) {
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.camera,
                  Permission.microphone,
                  Permission.bluetooth,
                  Permission.bluetoothConnect
                ].request();

                if (statuses[Permission.camera] == PermissionStatus.permanentlyDenied ||
                    statuses[Permission.microphone] == PermissionStatus.permanentlyDenied ||
                    statuses[Permission.bluetooth] == PermissionStatus.permanentlyDenied ||
                    statuses[Permission.bluetoothConnect] == PermissionStatus.permanentlyDenied) {
                  openAppSettings();
                } else {
                  model.getAgoraCredentials();
                }
              } else if (Platform.isIOS) {
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.camera,
                  Permission.microphone,
                ].request();

                if (statuses[Permission.camera] == PermissionStatus.permanentlyDenied ||
                    statuses[Permission.microphone] == PermissionStatus.permanentlyDenied) {
                  openAppSettings();
                } else {
                  model.getAgoraCredentials();
                }
              }
            } else {
              InformationDialog.show(context,
                  image: AssetUtils.videocallAgent,
                  isSwipeToCancel: false,
                  title: S.of(context).videoCall,
                  descriptionWidget: Text(
                    S.of(context).agentNotAvailablePopUpDesc,
                    style:
                        TextStyle(fontFamily: StringUtils.appFont, fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  onDismissed: () {}, onSelected: () {
                Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
              });
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
                          cardId: model.creditCardVideoCallInitiateArgs.creditCard.cardId ?? ''));
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsetsDirectional.only(top: 56.0, start: 24, end: 24, bottom: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: AppSvg.asset(AssetUtils.leftArrow,
                              color: Theme.of(context).accentColor, height: 24, width: 24)),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          S.of(context).applyForCreditCard,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
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
                              fontFamily: StringUtils.appFont,
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
                                  padding: const EdgeInsets.only(top: 35.0, bottom: 24),
                                  child: Container(
                                    // height: 78,
                                    // width: 78,
                                    padding: EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: AppColor.vividYellow,
                                      shape: BoxShape.circle,
                                    ),
                                    child: AppSvg.asset(AssetUtils.ccAgent,
                                        width: 32, height: 32, color: Theme.of(context).primaryColorDark),
                                  ),
                                ),
                                Text(
                                  S.of(context).weWillConnectYouInBlink,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColorDark),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.only(start: 24, end: 24, bottom: 32),
                              child: Text(
                                S.of(context).thankYouForWaitingCallWillStartAutomatically,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
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
