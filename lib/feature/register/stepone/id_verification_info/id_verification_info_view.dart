import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/id_card/ahwal_details_response.dart';
import 'package:domain/model/user/save_id_info_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/id_verification_info/id_verification_info_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/information_text.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class IdVerificationInfoView
    extends BasePageViewWidget<IdVerificationInfoViewModel> {
  IdVerificationInfoView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, IdVerificationInfoViewModel model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Expanded(
            child: AppStreamBuilder<bool>(
                stream: model.errorDetectorStream,
                initialData: false,
                dataBuilder: (context, isError) {
                  return ShakeAnimatedWidget(
                    enabled: isError ?? false,
                    duration: Duration(milliseconds: 100),
                    shakeAngle: Rotation.deg(z: 1),
                    curve: Curves.easeInOutSine,
                    child: AppStreamBuilder<Resource<bool>>(
                        stream: model.idVerificationResponseStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            model.fetchAllowedIssuers();
                          } else if (data.status == Status.ERROR) {
                            model.showToastWithError(AppError(
                                error: ErrorInfo(message: ''),
                                type: ErrorType.INVALID_DECLARATION_SELECTION,
                                cause: Exception()));
                          }
                        },
                        dataBuilder: (context, data) {
                          return AppStreamBuilder<Resource<SaveIdInfoResponse>>(
                            stream: model.confirmDetailResponseStream,
                            initialData: Resource.none(),
                            onData: (saveData) async {
                              if (saveData.status == Status.SUCCESS) {
                                final isImageUpload = await Navigator.pushNamed(
                                    context, RoutePaths.Capture);

                                if (isImageUpload != null &&
                                    (isImageUpload as bool)) {
                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
                                    ProviderScope.containerOf(context)
                                        .read(registerStepOneViewModelProvider)
                                        .pageController
                                        .move(2, animation: false);
                                  });
                                } else {
                                  model.showToastWithError(AppError(
                                    error: ErrorInfo(message: ''),
                                    type: ErrorType.IMAGE_UPLOAD_ERROR,
                                    cause: Exception(),
                                  ));
                                }
                              } else if (saveData.status == Status.ERROR) {
                                model.showToastWithError(saveData.appError!);
                                ProviderScope.containerOf(context)
                                    .read(registerStepOneViewModelProvider)
                                    .pageController
                                    .next();
                                Future.delayed(Duration(milliseconds: 500), () {
                                  ProviderScope.containerOf(context)
                                      .read(confirmDetailViewModelProvider)
                                      .setData(
                                          model.scannedDocumentInformation);
                                });
                              }
                            },
                            dataBuilder: (context, saveData) {
                              return AppStreamBuilder<
                                  Resource<AhwalDetailResponse>>(
                                stream: model.getAhwalDetailsStream,
                                initialData: Resource.none(),
                                onData: (ahwalData) {
                                  if (ahwalData.status == Status.SUCCESS) {
                                    if (ahwalData
                                            .data?.skipConfirmationScreen ??
                                        false) {
                                      model.setScannedData();
                                    } else {
                                      ProviderScope.containerOf(context)
                                          .read(
                                              registerStepOneViewModelProvider)
                                          .pageController
                                          .next();
                                      Future.delayed(
                                          Duration(milliseconds: 500), () {
                                        ProviderScope.containerOf(context)
                                            .read(
                                                confirmDetailViewModelProvider)
                                            .setData(model
                                                .scannedDocumentInformation);
                                      });
                                    }
                                  } else if (ahwalData.status == Status.ERROR) {
                                    model.showToastWithError(
                                        ahwalData.appError!);
                                  }
                                },
                                dataBuilder: (context, ahwalResponse) {
                                  return AppStreamBuilder<
                                      Resource<ScannedDocumentInformation>>(
                                    stream: model.scanUserDocumentStream,
                                    initialData: Resource.none(),
                                    onData: (scannedData) {
                                      if (scannedData.status ==
                                          Status.SUCCESS) {
                                        model.getAhwalResponse(
                                            scannedData.data!.idNumber!);
                                        // if (scannedData.data!.issuer == 'JOR') {
                                        //   model.getAhwalResponse(
                                        //       scannedData.data!.idNumber!);
                                        // } else {
                                        //   model.showToastWithError(AppError(
                                        //       cause: Exception(),
                                        //       error: ErrorInfo(message: ''),
                                        //       type: ErrorType.INVALID_ID_CARD));
                                        // }
                                      }
                                    },
                                    dataBuilder: (context, scannedData) {
                                      return GestureDetector(
                                        onHorizontalDragEnd: (details) {
                                          if (details
                                              .primaryVelocity!.isNegative) {
                                            model.idVerificationInfo();
                                          }
                                        },
                                        child: Card(
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 32, horizontal: 24),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Column(
                                                    children: [
                                                      InformationText(
                                                          image: AssetUtils.sun,
                                                          title: S
                                                              .of(context)
                                                              .idVerificationPlaceInfo),
                                                      SizedBox(
                                                        height: 24,
                                                      ),
                                                      InformationText(
                                                          image: AssetUtils
                                                              .scanIcon,
                                                          title: S
                                                              .of(context)
                                                              .idScanInfo),
                                                    ],
                                                  ),
                                                  // SizedBox(
                                                  //   height: 32,
                                                  // ),
                                                  // InformationText(
                                                  //     image: AssetUtils.tick,
                                                  //     iconColor: Theme.of(context)
                                                  //         .primaryColorDark,
                                                  //     title: S.of(context).onIdFit),
                                                  Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Text(
                                                          S
                                                              .of(context)
                                                              .uploadIdInstead,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              letterSpacing: 1,
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentTextTheme
                                                                  .bodyText1!
                                                                  .color),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 56,
                                                      ),
                                                      Row(
                                                        children: [
                                                          AppStreamBuilder<
                                                                  bool>(
                                                              stream: model
                                                                  .isRetrievedConditionStream,
                                                              initialData:
                                                                  false,
                                                              dataBuilder:
                                                                  (context,
                                                                      isChecked) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    if (isChecked ==
                                                                        false) {
                                                                      model.updateIsRetrievedConditionStream(
                                                                          true);
                                                                    } else {
                                                                      model.updateIsRetrievedConditionStream(
                                                                          false);
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height: 40,
                                                                    width: 40,
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: isChecked!
                                                                            ? AppColor
                                                                                .vividYellow
                                                                            : Colors
                                                                                .transparent,
                                                                        border: Border.all(
                                                                            width: !isChecked
                                                                                ? 1
                                                                                : 1,
                                                                            color: !isChecked
                                                                                ? Theme.of(context).accentTextTheme.bodyText1!.color!
                                                                                : Theme.of(context).inputDecorationTheme.hintStyle!.color!)),
                                                                    child: isChecked
                                                                        ? Container(
                                                                            height:
                                                                                16,
                                                                            width:
                                                                                16,
                                                                            padding:
                                                                                EdgeInsets.all(10),
                                                                            child:
                                                                                AppSvg.asset(
                                                                              AssetUtils.checkIcon,
                                                                              color: Theme.of(context).primaryColorDark,
                                                                            ),
                                                                          )
                                                                        : Container(),
                                                                  ),
                                                                );
                                                              }),
                                                          SizedBox(
                                                            width: 16,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              S
                                                                  .of(context)
                                                                  .termsAndConditions,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      AppStreamBuilder<bool>(
                                                          stream: model
                                                              .isRetrievedConditionStream,
                                                          initialData: false,
                                                          dataBuilder: (context,
                                                              isChecked) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 32,
                                                                      bottom:
                                                                          8),
                                                              child: Visibility(
                                                                visible:
                                                                    isChecked!,
                                                                child:
                                                                    AnimatedButton(
                                                                  buttonText: S
                                                                      .of(context)
                                                                      .swipeToProceed,
                                                                ),
                                                              ),
                                                            );
                                                          }),
                                                    ],
                                                  )
                                                ],
                                              )),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
