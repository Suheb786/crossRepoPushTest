import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/customer_status_enum.dart';
import 'package:domain/model/account/available_time_slots.dart';
import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/model/bank_smart/get_account_response.dart';
import 'package:domain/model/user/status/customer_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/account_hold/account_hold_page.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_page.dart';
import 'package:neo_bank/feature/register/video_call/schdeule_video_call_later/schedule_video_call_later_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/date_picker.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_five/schedule_call_time_dialog/schedule_call_time_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/time_utils.dart';

class ScheduleVideoCallLaterPageView
    extends BasePageViewWidget<ScheduleVideoCallLaterPageViewModel> {
  ScheduleVideoCallLaterPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: Column(
      children: [
        Expanded(
            child: AppStreamBuilder<bool>(
                stream: model.errorDetectorStream,
                initialData: false,
                dataBuilder: (context, error) {
                  return ShakeAnimatedWidget(
                      enabled: error ?? false,
                      duration: Duration(milliseconds: 100),
                      shakeAngle: Rotation.deg(z: 1),
                      curve: Curves.easeInOutSine,
                      child: AppStreamBuilder<Resource<CreateAccountResponse>>(
                        stream: model.createAccountStream,
                        initialData: Resource.none(),
                        onData: (createAccountData) {
                          if (createAccountData.status == Status.SUCCESS) {
                            model.checkUserStatus();
                          }
                        },
                        dataBuilder: (context, data) {
                          return AppStreamBuilder<Resource<GetAccountResponse>>(
                              stream: model.getAccountStream,
                              initialData: Resource.none(),
                              onData: (getAccountData) {
                                if (getAccountData.status == Status.SUCCESS) {
                                  model.createAccount(
                                      getAccountData
                                          .data!.content!.accountDetails!,
                                      getAccountData
                                          .data!.content!.customerInformation!);
                                }
                              },
                              dataBuilder: (context, data) {
                                return AppStreamBuilder<
                                        Resource<CustomerStatus>>(
                                    initialData: Resource.none(),
                                    stream: model.customerStatusStream,
                                    onData: (userStatus) {
                                      if (userStatus.status == Status.SUCCESS) {
                                        switch (userStatus.data!.nextPage) {
                                          case CustomerStatusEnum.HOLD:
                                            Navigator.pushReplacementNamed(
                                                context, RoutePaths.AccountHold,
                                                arguments: AccountHoldArguments(
                                                    applicationId: userStatus
                                                        .data!.applicationId));
                                            break;
                                          case CustomerStatusEnum.ACCOUNT_PAGE:
                                            model.getAccount();
                                            break;
                                          case CustomerStatusEnum.SUCCESS:
                                            Navigator.pushReplacementNamed(
                                                context,
                                                RoutePaths.AccountReady,
                                                arguments:
                                                    AccountReadyArguments(
                                                        isDocumentUploaded:
                                                            false));
                                            break;
                                          case CustomerStatusEnum.DOC_UPLOAD:
                                            Future.delayed(
                                                Duration(microseconds: 100),
                                                () {
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  RoutePaths
                                                      .UploadDocumentLater);
                                            });
                                            break;
                                          case CustomerStatusEnum.VIDEO_CALL:
                                            break;
                                          case CustomerStatusEnum
                                              .REMOVE_DEBIT_LOCK:
                                            // model.removeDebitLock();
                                            break;
                                          case CustomerStatusEnum.CARD_ISSUANCE:
                                            Navigator.pushReplacementNamed(
                                                context,
                                                RoutePaths.CardDelivery);
                                            break;
                                        }
                                      }
                                    },
                                    dataBuilder: (context, userStatus) {
                                      return AppStreamBuilder<Resource<bool>>(
                                        stream: model.scheduleVideoCallStream,
                                        initialData: Resource.none(),
                                        onData: (data) {
                                          // if (data.status == Status.SUCCESS) {
                                          //   model.checkUserStatus();
                                          // } else if (data.status ==
                                          //     Status.ERROR) {
                                          //   model.showToastWithError(
                                          //       data.appError!);
                                          // }

                                          if (data.status == Status.SUCCESS) {
                                            ///TODO: navigate to schedule video call
                                          } else if (data.status ==
                                              Status.ERROR) {
                                            model.showToastWithError(
                                                data.appError!);
                                          }
                                        },
                                        dataBuilder: (context, response) {
                                          return GestureDetector(
                                            onHorizontalDragEnd: (details) {
                                              if (details.primaryVelocity!
                                                  .isNegative) {
                                                model
                                                    .validateScheduleVideoCallDetails();
                                              } else {
                                                Future.delayed(
                                                    Duration(milliseconds: 500),
                                                    () {
                                                  ProviderScope.containerOf(
                                                          context)
                                                      .read(
                                                          videoCallViewModelProvider)
                                                      .videoCallPageController
                                                      .move(0,
                                                          animation: false);
                                                });
                                              }
                                            },
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              elevation: 2,
                                              color: Theme.of(context)
                                                  .cardTheme
                                                  .copyWith(
                                                      color: AppColor.white)
                                                  .color,
                                              margin: EdgeInsets.zero,
                                              shadowColor: Theme.of(context)
                                                  .primaryColorDark
                                                  .withOpacity(0.32),
                                              child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 32,
                                                      horizontal: 24),
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            SingleChildScrollView(
                                                          physics:
                                                              ClampingScrollPhysics(),
                                                          child: Column(
                                                            children: [
                                                              AppTextField(
                                                                labelText: S
                                                                    .of(context)
                                                                    .preferredDate,
                                                                hintText: S
                                                                    .of(context)
                                                                    .pleaseSelect,
                                                                controller: model
                                                                    .preferredDateController,
                                                                readOnly: true,
                                                                key: model
                                                                    .preferredDateKey,
                                                                onPressed: () {
                                                                  DatePicker.show(
                                                                      context,
                                                                      onSelected:
                                                                          (date) {
                                                                    model.preferredDateController
                                                                            .text =
                                                                        TimeUtils.getFormattedDOB(
                                                                            date);
                                                                    model
                                                                        .isValid();
                                                                    model.fetchAvailableTimeSlots(
                                                                        TimeUtils.getFormattedDateForCheckPassword(
                                                                            date));
                                                                  }, onCancelled:
                                                                          () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                      title: S
                                                                          .of(context)
                                                                          .preferredDate);
                                                                },
                                                                suffixIcon:
                                                                    (value,
                                                                        data) {
                                                                  return Container(
                                                                      height:
                                                                          16,
                                                                      width: 16,
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              7),
                                                                      child: AppSvg.asset(
                                                                          AssetUtils
                                                                              .calendar,
                                                                          color:
                                                                              Theme.of(context).primaryColorDark));
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: 16,
                                                              ),
                                                              AppStreamBuilder<
                                                                  Resource<
                                                                      List<
                                                                          AvailableTimeSlots>>>(
                                                                stream: model
                                                                    .availableTimeSlots,
                                                                initialData:
                                                                    Resource
                                                                        .none(),
                                                                dataBuilder:
                                                                    (context,
                                                                        slots) {
                                                                  return AppTextField(
                                                                    labelText: S
                                                                        .of(context)
                                                                        .preferredTime,
                                                                    hintText: S
                                                                        .of(context)
                                                                        .pleaseSelect,
                                                                    controller:
                                                                        model
                                                                            .preferredTimeController,
                                                                    readOnly:
                                                                        true,
                                                                    key: model
                                                                        .preferredTimeKey,
                                                                    onPressed:
                                                                        () {
                                                                      ScheduleCallTimeDialog.show(
                                                                          context,
                                                                          title: S
                                                                              .of(
                                                                                  context)
                                                                              .preferredTimeSmall,
                                                                          data: slots!.data ??
                                                                              [],
                                                                          onSelected:
                                                                              (time) {
                                                                        Navigator.pop(
                                                                            context);
                                                                        model
                                                                            .preferredTimeController
                                                                            .text = time
                                                                                .slot ??
                                                                            "";
                                                                        model
                                                                            .isValid();
                                                                      }, onDismissed:
                                                                              () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      });
                                                                    },
                                                                    suffixIcon:
                                                                        (value,
                                                                            data) {
                                                                      return Container(
                                                                          height:
                                                                              16,
                                                                          width:
                                                                              16,
                                                                          padding: EdgeInsets.only(
                                                                              right:
                                                                                  8),
                                                                          child: AppSvg.asset(
                                                                              AssetUtils.downArrow,
                                                                              color: AppColor.dark_gray_1));
                                                                    },
                                                                  );
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 8),
                                                          child: AppStreamBuilder<
                                                                  bool>(
                                                              stream: model
                                                                  .allFieldValidatorStream,
                                                              initialData:
                                                                  false,
                                                              dataBuilder:
                                                                  (context,
                                                                      isValid) {
                                                                return (isValid!)
                                                                    ? AnimatedButton(
                                                                        buttonText: S
                                                                            .of(context)
                                                                            .swipeToProceed,
                                                                        buttonHeight:
                                                                            50,
                                                                      )
                                                                    : Container();
                                                              }),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                          );
                                        },
                                      );
                                    });
                              });
                        },
                      ));
                }))
      ],
    ));
  }
}
