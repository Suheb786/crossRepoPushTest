import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/cliq_list_action_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'otp_for_cliq_id_page_view_model.dart';

class OtpForCliqIdListPageView extends BasePageViewWidget<OtpForCliqIdListPageViewModel> {
  OtpForCliqIdListPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 96.0.h, start: 24.w, end: 24.w, bottom: 36.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).manageCliqId.toUpperCase(),
              style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 10.t,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "${S.of(context).enterOtpHeader} \n ${model.arguments.mobileCode.replaceAll('00', '+') + " " + model.arguments.mobileNumber}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 20.t,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            Expanded(
              child: AppStreamBuilder<bool>(
                stream: model.errorDetectorStream,
                initialData: false,
                dataBuilder: (context, isValid) {
                  return ShakeAnimatedWidget(
                    enabled: isValid ?? false,
                    duration: Duration(milliseconds: 100),
                    shakeAngle: Rotation.deg(z: 1),
                    curve: Curves.easeInOutSine,
                    child: AppStreamBuilder<Resource<bool>>(
                        stream: model.linkCliqIdStream,
                        initialData: Resource.none(),
                        onData: (addLinkAccount) {
                          if (addLinkAccount.status == Status.SUCCESS) {
                            Navigator.popUntil(context, ModalRoute.withName(RoutePaths.CliqIdList));
                            model.showSuccessTitleandDescriptionToast(
                              ToastwithTitleandDescription(
                                title: S.current.cliqIdUpdate,
                                description: S.current.accountSuccessfullyLinked,
                              ),
                            );

                            ProviderScope.containerOf(context)
                                .read(cliqIdListViewModelProvider)
                                .getAlias(true);
                          }
                        },
                        dataBuilder: (context, addLinkAccountResponse) {
                          return AppStreamBuilder<Resource<bool>>(
                              stream: model.deleteCliqIdStream,
                              initialData: Resource.none(),
                              onData: (isDelete) {
                                if (isDelete.status == Status.SUCCESS) {
                                  Navigator.popUntil(context, ModalRoute.withName(RoutePaths.CliqIdList));
                                  model.showSuccessTitleandDescriptionToast(
                                    ToastwithTitleandDescription(
                                      title: S.current.cliqIdUpdate,
                                      description: S.current.hasBeenDeleted(model.arguments.aliasName),
                                    ),
                                  );

                                  ProviderScope.containerOf(context)
                                      .read(cliqIdListViewModelProvider)
                                      .getAlias(true);
                                }
                              },
                              dataBuilder: (context, isDeleteResponse) {
                                return AppStreamBuilder<Resource<bool>>(
                                    stream: model.reactivateCliqIDStream,
                                    initialData: Resource.none(),
                                    onData: (isReActivated) {
                                      if (isReActivated.status == Status.SUCCESS) {
                                        Navigator.popUntil(
                                            context, ModalRoute.withName(RoutePaths.CliqIdList));
                                        model.showSuccessTitleandDescriptionToast(
                                          ToastwithTitleandDescription(
                                            title: S.current.cliqIdUpdate,
                                            description:
                                                S.current.hasBeenActivated(model.arguments.aliasName),
                                          ),
                                        );

                                        ProviderScope.containerOf(context)
                                            .read(cliqIdListViewModelProvider)
                                            .getAlias(true);
                                      }
                                    },
                                    dataBuilder: (context, isReActivatedResponse) {
                                      return AppStreamBuilder<Resource<bool>>(
                                          stream: model.changeDefaultCliqIdStream,
                                          initialData: Resource.none(),
                                          onData: (isDefault) {
                                            if (isDefault.status == Status.SUCCESS) {
                                              Navigator.popUntil(
                                                  context, ModalRoute.withName(RoutePaths.CliqIdList));
                                              model.showSuccessTitleandDescriptionToast(
                                                ToastwithTitleandDescription(
                                                  title: S.current.cliqIdUpdate,
                                                  description: S.current.defaultAccountUpdated,
                                                ),
                                              );

                                              ProviderScope.containerOf(context)
                                                  .read(cliqIdListViewModelProvider)
                                                  .getAlias(true);
                                            }
                                          },
                                          dataBuilder: (context, isDefaultResponse) {
                                            return AppStreamBuilder<Resource<bool>>(
                                                stream: model.suspandCliqIDStream,
                                                initialData: Resource.none(),
                                                onData: (isSuspended) {
                                                  if (isSuspended.status == Status.SUCCESS) {
                                                    Navigator.popUntil(
                                                        context, ModalRoute.withName(RoutePaths.CliqIdList));
                                                    model.showSuccessTitleandDescriptionToast(
                                                      ToastwithTitleandDescription(
                                                        title: S.current.cliqIdUpdate,
                                                        description: S.current
                                                            .hasbeenSuspended(model.arguments.aliasName),
                                                      ),
                                                    );

                                                    ProviderScope.containerOf(context)
                                                        .read(cliqIdListViewModelProvider)
                                                        .getAlias(true);
                                                  }
                                                },
                                                dataBuilder: (context, isSuspendedResponse) {
                                                  return AppStreamBuilder<Resource<bool>>(
                                                      stream: model.unlinkCliqIdStream,
                                                      initialData: Resource.none(),
                                                      onData: (isUnLink) {
                                                        if (isUnLink.status == Status.SUCCESS) {
                                                          Navigator.popUntil(context,
                                                              ModalRoute.withName(RoutePaths.CliqIdList));
                                                          model.showSuccessTitleandDescriptionToast(
                                                            ToastwithTitleandDescription(
                                                              title: S.current.cliqIdUpdate,
                                                              description:
                                                                  S.current.accountSuccessfullyUnlinked,
                                                            ),
                                                          );

                                                          ProviderScope.containerOf(context)
                                                              .read(cliqIdListViewModelProvider)
                                                              .getAlias(true);
                                                        }
                                                      },
                                                      dataBuilder: (context, isUnLinkResponse) {
                                                        return AppStreamBuilder<Resource<bool>>(
                                                            stream: model.enterOtpForCliqIdValidationStream,
                                                            initialData: Resource.none(),
                                                            onData: (data) {
                                                              if (data.status == Status.SUCCESS) {
                                                                if (model.arguments.cliqListActionTypeEnum ==
                                                                    CliqListActionTypeEnum.DEFAULT) {
                                                                  model.confirmChangeDefaultCliqId(
                                                                      acc: model.arguments.accountId,
                                                                      aliasId: model.arguments.aliasId,
                                                                      otpCode: model.otpController.text);
                                                                } else if (model
                                                                        .arguments.cliqListActionTypeEnum ==
                                                                    CliqListActionTypeEnum.UNLINKCLIQ) {
                                                                  model.unlinkCliqId(
                                                                      getToken: true,
                                                                      aliasId: model.arguments.aliasId,
                                                                      accountId: model.arguments.accountId,
                                                                      otpCode: model.otpController.text);
                                                                } else if (model
                                                                        .arguments.cliqListActionTypeEnum ==
                                                                    CliqListActionTypeEnum.DELETECLIQ) {
                                                                  model.deleteCliqId(
                                                                      true,
                                                                      model.arguments.aliasId,
                                                                      model.otpController.text);
                                                                } else if (model
                                                                        .arguments.cliqListActionTypeEnum ==
                                                                    CliqListActionTypeEnum.SUSPENDEDCLIQ) {
                                                                  model.suspandCliqID(
                                                                      getToken: true,
                                                                      otpCode: model.otpController.text,
                                                                      aliasId: model.arguments.aliasId);
                                                                } else if (model
                                                                        .arguments.cliqListActionTypeEnum ==
                                                                    CliqListActionTypeEnum.REACTIVATED) {
                                                                  model.reactivatetCliqID(
                                                                      getToken: true,
                                                                      aliasId: model.arguments.aliasId,
                                                                      otpCode: model.otpController.text);
                                                                } else if (model
                                                                        .arguments.cliqListActionTypeEnum ==
                                                                    CliqListActionTypeEnum.LINKACCOUNT) {
                                                                  model.linkCliqId(
                                                                      getToken: true,
                                                                      aliasId: model.arguments.aliasId,
                                                                      linkType: model.arguments.linkType,
                                                                      accountNumber:
                                                                          model.arguments.accountId,
                                                                      isAlias: model.arguments.isAlias,
                                                                      aliasValue: model.arguments.aliasName,
                                                                      otpCode: model.otpController.text);
                                                                }

                                                                //    Navigator.pushReplacementNamed(context, RoutePaths.CliqIdCreationSuccess);

                                                              }
                                                            },
                                                            dataBuilder: (context, enterOtpForCliqResponse) {
                                                              return GestureDetector(
                                                                onHorizontalDragEnd: (details) {
                                                                  if (details.primaryVelocity!.isNegative) {
                                                                    model.validateOtp();
                                                                    //  Navigator.pushNamed(context, RoutePaths.OtpForEditAliasAndMobileNoPage);
                                                                  } else {
                                                                    Navigator.pop(context);
                                                                  }
                                                                },
                                                                child: Card(
                                                                  child: Container(
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical: 32.h, horizontal: 24.w),
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Column(
                                                                          children: [
                                                                            AppOtpFields(
                                                                              length: 6,
                                                                              controller: model.otpController,
                                                                              onChanged: (val) {
                                                                                model.validate(val);
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            CountdownTimer(
                                                                              controller:
                                                                                  model.countDownController,
                                                                              onEnd: () {},
                                                                              endTime: model.endTime,
                                                                              textStyle: TextStyle(
                                                                                  fontFamily:
                                                                                      StringUtils.appFont,
                                                                                  fontSize: 16.t,
                                                                                  color: Theme.of(context).textTheme.bodyMedium!.color!),
                                                                              widgetBuilder: (context,
                                                                                  currentTimeRemaining) {
                                                                                return currentTimeRemaining ==
                                                                                        null
                                                                                    ? TextButton(
                                                                                        onPressed: () {
                                                                                          if (model.arguments
                                                                                                  .cliqListActionTypeEnum ==
                                                                                              CliqListActionTypeEnum
                                                                                                  .DEFAULT) {
                                                                                            model.confirmChangeDefaultCliqIdOtp(
                                                                                                acc: model
                                                                                                    .arguments
                                                                                                    .accountId,
                                                                                                aliasId: model
                                                                                                    .arguments
                                                                                                    .aliasId);
                                                                                          } else if (model
                                                                                                  .arguments
                                                                                                  .cliqListActionTypeEnum ==
                                                                                              CliqListActionTypeEnum
                                                                                                  .UNLINKCLIQ) {
                                                                                            model.unlinkCliqIdOtp(
                                                                                                getToken:
                                                                                                    true,
                                                                                                aliasId: model
                                                                                                    .arguments
                                                                                                    .aliasId,
                                                                                                accountId: model
                                                                                                    .arguments
                                                                                                    .accountId);
                                                                                          } else if (model
                                                                                                  .arguments
                                                                                                  .cliqListActionTypeEnum ==
                                                                                              CliqListActionTypeEnum
                                                                                                  .DELETECLIQ) {
                                                                                            model.deleteCliqIdOtp(
                                                                                                true,
                                                                                                model
                                                                                                    .arguments
                                                                                                    .aliasId);
                                                                                          } else if (model
                                                                                                  .arguments
                                                                                                  .cliqListActionTypeEnum ==
                                                                                              CliqListActionTypeEnum
                                                                                                  .SUSPENDEDCLIQ) {
                                                                                            model.suspandCliqIDOtp(
                                                                                                getToken:
                                                                                                    true,
                                                                                                aliasId: model
                                                                                                    .arguments
                                                                                                    .aliasId);
                                                                                          } else if (model
                                                                                                  .arguments
                                                                                                  .cliqListActionTypeEnum ==
                                                                                              CliqListActionTypeEnum
                                                                                                  .REACTIVATED) {
                                                                                            model.reactivatetCliqIDOtp(
                                                                                                getToken:
                                                                                                    true,
                                                                                                aliasId: model
                                                                                                    .arguments
                                                                                                    .aliasId);
                                                                                          } else if (model
                                                                                                  .arguments
                                                                                                  .cliqListActionTypeEnum ==
                                                                                              CliqListActionTypeEnum
                                                                                                  .LINKACCOUNT) {
                                                                                            model
                                                                                                .linkCliqIdOtp(
                                                                                              getToken: true,
                                                                                              aliasId: model
                                                                                                  .arguments
                                                                                                  .aliasId,
                                                                                              linkType: model
                                                                                                  .arguments
                                                                                                  .linkType,
                                                                                              accountNumber: model
                                                                                                  .arguments
                                                                                                  .accountId,
                                                                                              isAlias: model
                                                                                                  .arguments
                                                                                                  .isAlias,
                                                                                              aliasValue: model
                                                                                                  .arguments
                                                                                                  .aliasName,
                                                                                            );
                                                                                          }
                                                                                        },
                                                                                        child: Text(
                                                                                          S
                                                                                              .of(context)
                                                                                              .resendCode,
                                                                                          style: TextStyle(
                                                                                              fontFamily:
                                                                                                  StringUtils
                                                                                                      .appFont,
                                                                                              fontSize: 14.t,
                                                                                              fontWeight:
                                                                                                  FontWeight
                                                                                                      .w600,
                                                                                              color: Theme.of(context).textTheme.bodyMedium!.color!),
                                                                                        ))
                                                                                    : Text(
                                                                                        S.of(context).resendIn(
                                                                                            '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                                                        style: TextStyle(
                                                                                            fontFamily:
                                                                                                StringUtils
                                                                                                    .appFont,
                                                                                            fontSize: 14.t,
                                                                                            fontWeight:
                                                                                                FontWeight
                                                                                                    .w600,
                                                                                            color: Theme.of(context).textTheme.bodyMedium!.color!),
                                                                                      );
                                                                              },
                                                                            ),
                                                                            AppStreamBuilder<bool>(
                                                                              stream: model.showButtonStream,
                                                                              initialData: false,
                                                                              dataBuilder:
                                                                                  (BuildContext context,
                                                                                      isValid) {
                                                                                return Padding(
                                                                                  padding: EdgeInsets.only(
                                                                                    top: 26.0.h,
                                                                                  ),
                                                                                  child: Visibility(
                                                                                    visible: isValid!,
                                                                                    child: AnimatedButton(
                                                                                        buttonText: S
                                                                                            .of(context)
                                                                                            .swipeToProceed),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      });
                                                });
                                          });
                                    });
                              });
                        }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
