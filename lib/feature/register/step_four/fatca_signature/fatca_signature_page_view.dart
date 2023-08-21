import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/fatca_crs/upload_signature_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_signature/fatca_signature_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/register/declaration_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/ui/molecules/upload_document_selection_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class FatcaSignaturePageView extends BasePageViewWidget<FatcaSignaturePageViewModel> {
  FatcaSignaturePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Expanded(
            child: AppStreamBuilder<bool>(
                initialData: false,
                stream: model.errorDetectorStream,
                dataBuilder: (context, isError) {
                  return ShakeAnimatedWidget(
                    enabled: isError ?? false,
                    duration: Duration(milliseconds: 100),
                    shakeAngle: Rotation.deg(z: 1),
                    curve: Curves.easeInOutSine,
                    child: AppStreamBuilder<Resource<bool>>(
                        stream: model.setFatcaW8Stream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            Future.delayed(Duration(milliseconds: 500), () {
                              ProviderScope.containerOf(context)
                                  .read(registerViewModelProvider)
                                  .registrationStepsController
                                  .nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                            });
                          } else if (data.status == Status.ERROR) {
                            if (data.appError!.type == ErrorType.INVALID_SIGNATURE) {
                              model.signatureKey.currentState!.isValid = false;
                            } else if ((data.appError!.type == ErrorType.INVALID_DECLARATION_SELECTION)) {
                            } else if ((data.appError!.type ==
                                ErrorType.INVALID_VERIFY_INFO_DECLARATION_SELECTION)) {}
                            model.showToastWithError(data.appError!);
                          }
                        },
                        dataBuilder: (context, snapshot) {
                          return AppStreamBuilder<Resource<UploadSignatureResponse>>(
                            stream: model.uploadSignatureStream,
                            initialData: Resource.none(),
                            onData: (data) {
                              if (data.status == Status.SUCCESS) {
                                model.fileId = data.data!.id!;
                              }
                            },
                            dataBuilder: (context, data) {
                              return GestureDetector(
                                onHorizontalDragEnd: (details) {
                                  if (ProviderScope.containerOf(context)
                                          .read(registerStepFourViewModelProvider)
                                          .appSwiperController
                                          .page ==
                                      7.0) {
                                    if (StringUtils.isDirectionRTL(context)) {
                                      if (!details.primaryVelocity!.isNegative) {
                                        model.setFatcaResponse(context);
                                      }
                                    } else {
                                      if (details.primaryVelocity!.isNegative) {
                                        model.setFatcaResponse(context);
                                      } else {
                                        ///back navigation from signature screen
                                        // ProviderScope.containerOf(context)
                                        //             .read(
                                        //                 registerStepFourViewModelProvider)
                                        //             .taxPayerType ==
                                        //         TaxPayerTypeEnum.W8
                                        //     ? Future.delayed(
                                        //         Duration(milliseconds: 500), () {
                                        //         ProviderScope.containerOf(context)
                                        //             .read(
                                        //                 registerStepFourViewModelProvider)
                                        //             .registrationStepFourPageController
                                        //             .move(3, animation: false);
                                        //       })
                                        //     : Future.delayed(
                                        //         Duration(milliseconds: 500), () {
                                        //         ProviderScope.containerOf(context)
                                        //             .read(
                                        //                 registerStepFourViewModelProvider)
                                        //             .registrationStepFourPageController
                                        //             .move(6, animation: false);
                                        //       });
                                      }
                                    }
                                  }
                                },
                                child: Card(
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context).viewInsets.bottom - 50.h <= 0
                                              ? 0
                                              : MediaQuery.of(context).viewInsets.bottom - 48.h),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                              physics: ClampingScrollPhysics(),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    S.of(context).yourSignature,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 14.t,
                                                        fontWeight: FontWeight.w600,
                                                        color: Theme.of(context).primaryColorDark),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(top: 8.0.h, bottom: 16.h),
                                                    child: Text(
                                                      S.of(context).signatureUploadDes,
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          fontSize: 12.t,
                                                          fontWeight: FontWeight.w400,
                                                          color: Theme.of(context).primaryColorDark),
                                                    ),
                                                  ),
                                                  AppStreamBuilder<String>(
                                                    stream: model.getDocumentStream,
                                                    initialData: '',
                                                    onData: (documentResponse) {
                                                      if (documentResponse.isNotEmpty) {
                                                        model.updateSignatureField(documentResponse);
                                                        model.isValid();
                                                      }
                                                    },
                                                    dataBuilder: (context, document) {
                                                      return AppStreamBuilder<bool>(
                                                        stream: model.signatureUploadedStream,
                                                        initialData: false,
                                                        dataBuilder: (context, isUploaded) {
                                                          return AppTextField(
                                                            labelText: '',
                                                            hintText: S.of(context).uploadSignature,
                                                            controller: model.signatureController,
                                                            key: model.signatureKey,
                                                            readOnly: true,
                                                            hintTextColor: Theme.of(context).primaryColorDark,
                                                            textFieldBorderColor: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .color!,
                                                            textColor: Theme.of(context).primaryColorDark,
                                                            fontSize: 12.t,
                                                            containerPadding: EdgeInsets.symmetric(
                                                                horizontal: 16.w, vertical: 12.h),
                                                            suffixIcon: (value, data) {
                                                              return InkWell(
                                                                onTap: !(isUploaded!)
                                                                    ? () async {
                                                                        UploadDocumentSelectionWidget.show(
                                                                            context, onCameraTap: () {
                                                                          Navigator.pop(context);
                                                                          model.getDocument(
                                                                              DocumentTypeEnum.CAMERA);
                                                                        }, onUploadDocumentTap: () {
                                                                          Navigator.pop(context);
                                                                          model.getDocument(
                                                                              DocumentTypeEnum.GALLERY);
                                                                        }, onCancelled: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                            title: S
                                                                                .of(context)
                                                                                .pleaseSelectYourAction);
                                                                      }
                                                                    : () {
                                                                        model.signatureController.clear();
                                                                        model.updateSignatureUploadedStream(
                                                                            false);
                                                                        model.isSignatureUploaded = false;
                                                                        model.selectedFile = '';
                                                                        model.fileId = '';
                                                                        model.isValid();
                                                                      },
                                                                child: Container(
                                                                    height: 16.h,
                                                                    width: 16.w,
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal: 7.w, vertical: 7.h),
                                                                    child: isUploaded
                                                                        ? AppSvg.asset(
                                                                            AssetUtils.delete,
                                                                            color: Theme.of(context)
                                                                                .primaryColorDark,
                                                                          )
                                                                        : Icon(
                                                                            Icons.add,
                                                                            color: Theme.of(context)
                                                                                .primaryColorDark,
                                                                          )),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 24.h),
                                                    child: Container(
                                                      height: 1,
                                                      color: AppColor.white_gray,
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      AppStreamBuilder<bool>(
                                                        stream: model.declarationSelectedStream,
                                                        initialData: false,
                                                        dataBuilder: (context, isSelected) {
                                                          ///TODO:Navigate to fatca Certification
                                                          return DeclarationWidget(
                                                            isSelected: isSelected,
                                                            title1: S.of(context).iConfirmThatMy,
                                                            title2: S.of(context).fatca,
                                                            title3: S.of(context).declarationIsTrueAndCorrect,
                                                            onTap: () {
                                                              model
                                                                  .updateDeclarationSelection(!(isSelected!));
                                                              model.isValid();
                                                            },
                                                          );
                                                        },
                                                      ),
                                                      AppStreamBuilder<bool>(
                                                        stream: model.verifyInfoDeclarationSelectedStream,
                                                        initialData: false,
                                                        dataBuilder: (context, isSelected) {
                                                          return DeclarationWidget(
                                                            isSelected: isSelected,
                                                            title1: S
                                                                .of(context)
                                                                .verifyInformationDirectlyOrUsingThirdPartyAgentDesc,
                                                            onTap: () {
                                                              model.updateVerifyInfoDeclarationSelection(
                                                                  !(isSelected!));
                                                              model.isValid();
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: AppStreamBuilder<bool>(
                                              stream: model.showAnimatedButtonStream,
                                              initialData: false,
                                              dataBuilder: (context, isValid) {
                                                return Padding(
                                                  padding: EdgeInsets.only(top: 16.0.h, bottom: 16.h),
                                                  child: Visibility(
                                                    visible: isValid!,
                                                    child: AnimatedButton(
                                                        buttonText: S.of(context).swipeToProceed),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      )),
                                ),
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
