import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/customer_status_enum.dart';
import 'package:domain/model/account/agent_gender_status.dart';
import 'package:domain/model/account/request_call_status.dart';
import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/model/bank_smart/get_account_response.dart';
import 'package:domain/model/user/status/customer_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/account_hold/account_hold_page.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_page.dart';
import 'package:neo_bank/feature/register/video_call/video_call_agent_selection/video_call_agent_selection_page_view_model.dart';
import 'package:neo_bank/feature/video_kyc/video_kyc_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class VideoCallAgentSelectionPageView extends BasePageViewWidget<VideoCallAgentSelectionPageViewModel> {
  VideoCallAgentSelectionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, VideoCallAgentSelectionPageViewModel model) {
    return AppStreamBuilder<Resource<CreateAccountResponse>>(
      stream: model.createAccountStream,
      initialData: Resource.none(),
      onData: (createAccountData) {
        if (createAccountData.status == Status.SUCCESS) {
          model.saveUserData();
          model.checkUserStatus();
        }
      },
      dataBuilder: (context, data) {
        return AppStreamBuilder<Resource<GetAccountResponse>>(
          stream: model.getAccountStream,
          initialData: Resource.none(),
          onData: (getAccountData) {
            if (getAccountData.status == Status.SUCCESS) {
              model.createAccount(getAccountData.data!.content!.accountDetails!,
                  getAccountData.data!.content!.customerInformation!);
            }
          },
          dataBuilder: (context, data) {
            return AppStreamBuilder<Resource<CustomerStatus>>(
              initialData: Resource.none(),
              stream: model.customerStatusStream,
              onData: (userStatus) {
                if (userStatus.status == Status.SUCCESS) {
                  switch (userStatus.data!.nextPage) {
                    case CustomerStatusEnum.HOLD:
                      Navigator.pushReplacementNamed(context, RoutePaths.AccountHold,
                          arguments: AccountHoldArguments(applicationId: userStatus.data!.applicationId));
                      break;
                    case CustomerStatusEnum.ACCOUNT_PAGE:
                      model.getAccount();
                      break;
                    case CustomerStatusEnum.SUCCESS:
                      Navigator.pushReplacementNamed(context, RoutePaths.AccountReady,
                          arguments: AccountReadyArguments(isDocumentUploaded: false));
                      break;
                    case CustomerStatusEnum.DOC_UPLOAD:
                      Future.delayed(Duration(microseconds: 100), () {
                        Navigator.pushReplacementNamed(context, RoutePaths.UploadDocumentLater);
                      });
                      break;
                    case CustomerStatusEnum.VIDEO_CALL:
                      // Future.delayed(
                      //     Duration(milliseconds: 500), () {
                      //   ProviderScope.containerOf(context)
                      //       .read(
                      //       registerStepFiveViewModelProvider)
                      //       .registrationStepFivePageController
                      //       .next();
                      // });
                      break;
                    case CustomerStatusEnum.REMOVE_DEBIT_LOCK:
                      // model.removeDebitLock();
                      break;
                    case CustomerStatusEnum.CARD_ISSUANCE:
                      Navigator.pushReplacementNamed(context, RoutePaths.CardDelivery);
                      break;
                  }
                }
              },
              dataBuilder: (context, userStatus) {
                return AppStreamBuilder<Resource<RequestCallStatus>>(
                  initialData: Resource.none(),
                  stream: model.requestCallStream,
                  onData: (requestCall) async {
                    if (requestCall.status == Status.SUCCESS) {
                      final result = await Navigator.pushNamed(context, RoutePaths.VideoKyc,
                          arguments: VideKycCredentials(
                              token: requestCall.data!.conferenceLink,
                              channelName: requestCall.data!.callId));
                      if (result != null && result as bool) {
                        model.checkUserStatus();
                      }
                    } else if (requestCall.status == Status.ERROR) {
                      model.showToastWithError(requestCall.appError!);
                    }
                  },
                  dataBuilder: (context, requestCall) {
                    return AppStreamBuilder<Resource<AgentGenderStatus>>(
                      stream: model.getAgentAvailabilityStream,
                      initialData: Resource.none(),
                      onData: (availableAgent) {
                        if (availableAgent.status == Status.SUCCESS) {
                          if (availableAgent.data?.isExist ?? false) {
                            model.getAgoraCredentials();
                          }
                        }
                      },
                      dataBuilder: (context, availableAgent) {
                        return AppKeyBoardHide(
                          child: Column(
                            children: [
                              Expanded(
                                child: ShakeAnimatedWidget(
                                  enabled: false,
                                  duration: Duration(milliseconds: 100),
                                  shakeAngle: Rotation.deg(z: 1),
                                  curve: Curves.easeInOutSine,
                                  child: GestureDetector(
                                    onHorizontalDragUpdate: (details) {
                                      if (ProviderScope.containerOf(context)
                                              .read(videoCallViewModelProvider)
                                              .appSwiperController
                                              .page ==
                                          1.0) {
                                        if (StringUtils.isDirectionRTL(context)) {
                                          if (!details.primaryDelta!.isNegative) {
                                            ///don't allow user to go document page it will depend on customer status
                                            // Future.delayed(Duration(milliseconds: 500), () {
                                            //   ProviderScope.containerOf(context)
                                            //       .read(registerStepFiveViewModelProvider)
                                            //       .registrationStepFivePageController
                                            //       .move(4, animation: false);
                                            // });
                                          } else {
                                            Future.delayed(Duration(milliseconds: 500), () {
                                              ProviderScope.containerOf(context)
                                                  .read(videoCallViewModelProvider)
                                                  .previousPage();
                                              // .previous();
                                            });
                                          }
                                        } else {
                                          if (details.primaryDelta!.isNegative) {
                                            ///don't allow user to go document page it will depend on customer status
                                            // Future.delayed(Duration(milliseconds: 500), () {
                                            //   ProviderScope.containerOf(context)
                                            //       .read(registerStepFiveViewModelProvider)
                                            //       .registrationStepFivePageController
                                            //       .move(4, animation: false);
                                            // });
                                          } else {
                                            Future.delayed(Duration(milliseconds: 500), () {
                                              ProviderScope.containerOf(context)
                                                  .read(videoCallViewModelProvider)
                                                  .previousPage();
                                              // .previous();
                                            });
                                          }
                                        }
                                      }
                                    },
                                    child: Card(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 35.0.h, bottom: 32.h),
                                                    child: Container(
                                                      height: 78.h,
                                                      width: 78.w,
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 25.07.w, vertical: 22.29.h),
                                                      decoration: BoxDecoration(
                                                        color: AppColor.vividYellow,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: AppSvg.asset(AssetUtils.maleAgent,
                                                          color: Theme.of(context).primaryColorDark),
                                                    ),
                                                  ),
                                                  Text(
                                                    S.of(context).weWillConnectYouInBlink,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 20.t,
                                                        color: Theme.of(context).primaryColorDark),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 32.0.h),
                                                    child: CountdownTimer(
                                                      controller: model.countDownController,
                                                      onEnd: () {},
                                                      endTime: model.endTime,
                                                      widgetBuilder: (context, currentTimeRemaining) {
                                                        return currentTimeRemaining == null
                                                            ? TextButton(
                                                                onPressed: () {
                                                                  model.updateTime();
                                                                  model.checkAvailableAgent();
                                                                },
                                                                child: Text(
                                                                  S.of(context).searchAgain,
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontSize: 14.t,
                                                                      color: Theme.of(context)
                                                                          .textTheme
                                                                          .bodyLarge!
                                                                          .color!),
                                                                ))
                                                            : Text(
                                                                S.of(context).estimatedTime(
                                                                    '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                                style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14.t,
                                                                    color: Theme.of(context)
                                                                        .textTheme
                                                                        .bodyLarge!
                                                                        .color!),
                                                                textAlign: TextAlign.center,
                                                              );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                S.of(context).thankYouForWaitingCallWillStartAutomatically,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.t,
                                                    color: Theme.of(context).primaryColorDark),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
