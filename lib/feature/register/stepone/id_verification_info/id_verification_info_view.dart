import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/id_card/ahwal_details_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/id_verification_info/id_verification_info_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/information_text.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
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
                            model.scanDocument();
                          } else if (data.status == Status.ERROR) {
                            model.showToastWithError(AppError(
                                error: ErrorInfo(message: ''),
                                type: ErrorType.INVALID_DECLARATION_SELECTION,
                                cause: Exception()));
                          }
                        },
                        dataBuilder: (context, data) {
                          return AppStreamBuilder<
                              Resource<AhwalDetailResponse>>(
                            stream: model.getAhwalDetailsStream,
                            initialData: Resource.none(),
                            onData: (data) {
                              if (data.status == Status.SUCCESS) {
                                ScannedDocumentInformation scannedDocument =
                                    model.scannedDocumentInformation;
                                scannedDocument.firstName = data
                                    .data!.contentData!.ahwalinfo!.firstNameEn;
                                scannedDocument.middleName = data
                                    .data!.contentData!.ahwalinfo!.thirdNameEn;
                                scannedDocument.firstNameAr = data
                                    .data!.contentData!.ahwalinfo!.firstNameAr;
                                scannedDocument.secNameAr = data
                                    .data!.contentData!.ahwalinfo!.secNameAr;
                                scannedDocument.thirdNameAr = data
                                    .data!.contentData!.ahwalinfo!.thirdNameAr;
                                scannedDocument.familyNameAr = data
                                    .data!.contentData!.ahwalinfo!.familyNameAr;
                                scannedDocument.familyName = data
                                    .data!.contentData!.ahwalinfo!.firstNameEn;
                                scannedDocument.secondNameEn = data
                                    .data!.contentData!.ahwalinfo!.secondNameEn;
                                scannedDocument.thirdNameEn = data
                                    .data!.contentData!.ahwalinfo!.thirdNameEn;
                                scannedDocument.familyName = data
                                    .data!.contentData!.ahwalinfo!.familyNameEn;
                                // scannedDocument.motherName = data.data!
                                //     .contentData!.ahwalinfo!.motherFirstName;
                                scannedDocument.placeOfBirth = data
                                    .data!.contentData!.ahwalinfo!.placeOfBirth;

                                ProviderScope.containerOf(context)
                                    .read(registerStepOneViewModelProvider)
                                    .pageController
                                    .next();
                                Future.delayed(Duration(milliseconds: 500), () {
                                  ProviderScope.containerOf(context)
                                      .read(confirmDetailViewModelProvider)
                                      .setData(scannedDocument);
                                });
                              } else if (data.status == Status.ERROR) {
                                model.showToastWithError(data.appError!);
                              }
                            },
                            dataBuilder: (context, ahwalResponse) {
                              return AppStreamBuilder<
                                  Resource<ScannedDocumentInformation>>(
                                stream: model.scanUserDocumentStream,
                                initialData: Resource.none(),
                                onData: (data) {
                                  if (data.status == Status.SUCCESS) {
                                    if (data.data!.issuer == 'JOR') {
                                      model.getAhwalResponse(
                                          data.data!.idNumber!);
                                      model.scannedDocumentInformation =
                                          data.data!;
                                    } else {
                                      model.showToastWithError(AppError(
                                          cause: Exception(),
                                          error: ErrorInfo(message: ''),
                                          type: ErrorType.INVALID_ID_CARD));
                                    }
                                  }
                                },
                                dataBuilder: (context, scannedData) {
                                  return GestureDetector(
                                    onHorizontalDragEnd: (details) {
                                      if (details.primaryVelocity!.isNegative) {
                                        model.idVerificationInfo();
                                      }
                                    },
                                    child: Card(
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 32, horizontal: 24),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                      image:
                                                          AssetUtils.scanIcon,
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
                                                              FontWeight.w600,
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
                                                      AppStreamBuilder<bool>(
                                                          stream: model
                                                              .isRetrievedConditionStream,
                                                          initialData: false,
                                                          dataBuilder: (context,
                                                              isChecked) {
                                                            return InkWell(
                                                              onTap: () {
                                                                if (isChecked ==
                                                                    false) {
                                                                  model
                                                                      .updateIsRetrievedConditionStream(
                                                                          true);
                                                                } else {
                                                                  model.updateIsRetrievedConditionStream(
                                                                      false);
                                                                }
                                                              },
                                                              child: Container(
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: isChecked!
                                                                        ? Theme.of(context)
                                                                            .accentTextTheme
                                                                            .bodyText1!
                                                                            .color!
                                                                        : Colors
                                                                            .transparent,
                                                                    border: Border.all(
                                                                        color: !isChecked
                                                                            ? Theme.of(context).accentTextTheme.bodyText1!.color!
                                                                            : Colors.transparent)),
                                                                child: isChecked
                                                                    ? Container(
                                                                        height:
                                                                            16,
                                                                        width:
                                                                            16,
                                                                        padding:
                                                                            EdgeInsets.all(10),
                                                                        child: AppSvg
                                                                            .asset(
                                                                          AssetUtils
                                                                              .checkIcon,
                                                                          color:
                                                                              Theme.of(context).accentColor,
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
                                                      dataBuilder:
                                                          (context, isChecked) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 32,
                                                                  bottom: 8),
                                                          child: Visibility(
                                                            visible: isChecked!,
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
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
